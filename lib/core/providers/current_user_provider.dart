import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:playo/core/models/user.dart';
import 'package:playo/core/repositories/user_repository.dart';
import 'package:playo/init_dependecies.dart';
import 'package:playo/core/database/database_helper.dart';
import 'dart:convert';

part 'current_user_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  /// Deletes the current user's account from backend and local cache
  Future<void> deleteAccount() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('No authenticated user found');

    try {
      // Delete user from backend (Supabase)
      final result = await _userRepository.deleteUser(userId);
      result.fold(
        (failure) {
          debugPrint('Failed to delete user from backend: ${failure.message}');
          throw Exception('Failed to delete user: ${failure.message}');
        },
        (_) {
          debugPrint('User deleted from backend');
        },
      );

      // Remove user from local cache
      await _removeUserFromCache(userId);

      // Sign out and clear state
      await _supabase.auth.signOut();
      state = null;
      debugPrint('Account deleted and signed out');
    } catch (e) {
      debugPrint('Error deleting account: $e');
      rethrow;
    }
  }

  late UserRepository _userRepository;
  late SupabaseClient _supabase;
  late DatabaseHelper _databaseHelper;

  @override
  User? build() {
    _userRepository = ref.watch(userRepositoryProvider);
    _supabase = serviceLocator<SupabaseClient>();
    _databaseHelper = serviceLocator<DatabaseHelper>();

    // Listen to Supabase auth state changes
    _listenToAuthChanges();

    // Try to load user from session and cache
    _initializeUser();

    return null;
  }

  void _listenToAuthChanges() {
    _supabase.auth.onAuthStateChange.listen((data) async {
      final session = data.session;
      final event = data.event;

      debugPrint('Auth state changed: $event');

      if (session?.user != null && event == AuthChangeEvent.signedIn) {
        // User signed in, fetch user data
        await _loadUserData(session!.user.id);
      } else if (event == AuthChangeEvent.signedOut) {
        // User signed out, clear state and cache
        if (state?.userId != null) {
          _removeUserFromCache(state!.userId);
        }
        state = null;
      }
    });
  }

  void _initializeUser() async {
    final session = _supabase.auth.currentSession;
    if (session?.user != null) {
      final userId = session!.user.id;

      // Try to load from cache first
      final cachedUser = await loadUserFromCache(userId);
      if (cachedUser != null) {
        state = cachedUser;
        debugPrint(
          'User loaded from cache: ${_composeFullName(cachedUser.firstName, cachedUser.lastName)}',
        );
      }

      // Then load fresh data from remote
      await _loadUserData(userId);
    }
  }

  Future<User?> loadUserFromCache(String userId) async {
    try {
      final userMap = await _databaseHelper.getUserById(userId);
      if (userMap != null) {
        // Map legacy local DB fields to new User model
        final preferredSportsRaw = userMap['preferred_sports'];
        final favoriteSports = preferredSportsRaw is String
            ? List<String>.from(jsonDecode(preferredSportsRaw))
            : (preferredSportsRaw is List
                  ? preferredSportsRaw.cast<String>()
                  : null);

        final roleStr = (userMap['role'] as String?)?.toLowerCase();
        final user = User(
          userId: userMap['id'] as String,
          firstName: (userMap['first_name'] as String),
          lastName: userMap['last_name'] as String?,
          emailAddress: userMap['email'] as String,
          mobileNumber: userMap['phone'] as String?,
          avatarUrl: userMap['profile_picture_url'] as String?,
          locationArea: userMap['city'] as String?,
          latitude: (userMap['latitude'] as num?)?.toDouble(),
          longitude: (userMap['longitude'] as num?)?.toDouble(),
          favoriteSports: favoriteSports,
          karmaScore: 0,
          gamesPlayedCount: 0,
          gender: userMap['gender'] as String?,
          bio: userMap['bio'] as String?,
          city: userMap['city'] as String?,
          state: userMap['state'] as String?,
          country: userMap['country'] as String?,
          createdAt: _tryParseDateTime(userMap['created_at'] as String?),
          updatedAt: _tryParseDateTime(userMap['updated_at'] as String?),
          isEmailVerified: (userMap['is_email_verified'] ?? 0) == 1,
          isMobileVerified: (userMap['is_phone_verified'] ?? 0) == 1,
          userRole: _parseUserRole(roleStr),
        );
        debugPrint(
          'User loaded from cache: ${_composeFullName(user.firstName, user.lastName)}',
        );
        return user;
      }
    } catch (e) {
      debugPrint('Error loading user from cache: $e');
    }
    return null;
  }

  Future<void> _saveUserToCache(User user) async {
    try {
      // Map new model to legacy local DB schema
      final map = <String, dynamic>{
        'id': user.userId,
        'email': user.emailAddress,
        'phone': user.mobileNumber,
        'full_name': _composeFullName(user.firstName, user.lastName),
        'first_name': user.firstName,
        'last_name': user.lastName,
        'profile_picture_url': user.avatarUrl,
        'role': user.userRole.name,
        'bio': user.bio,
        'gender': user.gender,
        'city': user.city,
        'state': user.state,
        'country': user.country,
        'latitude': user.latitude,
        'longitude': user.longitude,
        'preferred_sports': jsonEncode(user.favoriteSports ?? const []),
        'is_active': 1,
        'is_email_verified': user.isEmailVerified ? 1 : 0,
        'is_phone_verified': user.isMobileVerified ? 1 : 0,
        'is_profile_completed': user.firstName.isEmpty || user.firstName == ""
            ? 1
            : 0,
        'is_online': 0,
        'created_at': user.createdAt?.toIso8601String(),
        'updated_at': user.updatedAt?.toIso8601String(),
      };

      await _databaseHelper.insertUser(map);
      debugPrint(
        'User saved to cache: ${_composeFullName(user.firstName, user.lastName)}',
      );
    } catch (e) {
      debugPrint('Error saving user to cache: $e');
    }
  }

  Future<void> _removeUserFromCache(String userId) async {
    try {
      await _databaseHelper.deleteUser(userId);
      debugPrint('User removed from cache');
    } catch (e) {
      debugPrint('Error removing user from cache: $e');
    }
  }

  Future<User?> _loadUserData(String userId) async {
    try {
      final result = await _userRepository.getUserById(userId);
      User? loadedUser;
      result.fold(
        (failure) {
          debugPrint('Failed to load user data: ${failure.message}');
          loadedUser = null;
        },
        (user) {
          loadedUser = user;
        },
      );
      if (loadedUser == null) {
        debugPrint(
          "No user loaded, redirecting to onboarding or complete profile",
        );
        // Optionally, set state to null or handle accordingly
        // You can trigger navigation here if needed
      }
      state = loadedUser;
      return loadedUser;
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
    return null;
  }

  Future<void> createOrUpdateUser({
    required String emailAddress,
    String? firstName,
    String? lastName,
    String? mobileNumber,
    String? avatarUrl,
    UserRole? userRole,
    String? bio,
    String? gender,
    String? city,
    String? userState,
    String? country,
    String? locationArea,
    double? latitude,
    double? longitude,
    List<String>? favoriteSports,
  }) async {
    try {
      // Get current auth user
      final authUser = _supabase.auth.currentUser;
      if (authUser == null) {
        throw Exception('No authenticated user found');
      }

      final user = await _loadUserData(authUser.id);

      debugPrint(user?.toJson().toString() ?? "Loaded User from SPB null");

      // Create user with auth user ID
      final userToSave = User(
        userId: authUser.id,
        firstName: firstName ?? user?.firstName ?? "",
        lastName: lastName ?? user?.lastName,
        emailAddress: emailAddress,
        mobileNumber: mobileNumber,
        avatarUrl: avatarUrl,
        gender: gender,
        bio: bio,
        city: city,
        state: userState,
        country: country,
        latitude: latitude,
        longitude: longitude,
        locationArea: locationArea,
        favoriteSports: favoriteSports ?? const [],
        userRole: userRole ?? UserRole.user,
        isEmailVerified: false,
        isMobileVerified: false,
      );

      final result = await _userRepository.createOrUpdateUser(userToSave);

      result.fold(
        (failure) {
          debugPrint('Failed to save user data: ${failure.message}');
          throw Exception('Failed to save user data: ${failure.message}');
        },
        (savedUser) {
          state = savedUser;
          debugPrint(
            'User data saved successfully: ${_composeFullName(savedUser.firstName, savedUser.lastName)}',
          );
        },
      );
    } catch (e) {
      debugPrint('Error saving user data: $e');
      rethrow;
    }
  }

  Future<void> updateUserProfile({
    String? firstName,
    String? lastName,
    String? avatarUrl,
    String? bio,
    String? gender,
    String? city,
    String? userState,
    String? country,
    double? latitude,
    double? longitude,
    List<String>? favoriteSports,
    String? mobileNumber,
  }) async {
    try {
      if (state == null) {
        throw Exception('No current user to update');
      }

      final currentUser = state!;

      final updatedUser = User(
        userId: currentUser.userId,
        emailAddress: currentUser.emailAddress,
        mobileNumber: mobileNumber ?? currentUser.mobileNumber,
        firstName: firstName ?? currentUser.firstName,
        lastName: lastName ?? currentUser.lastName,
        avatarUrl: avatarUrl ?? currentUser.avatarUrl,
        userRole: currentUser.userRole,
        bio: bio ?? currentUser.bio,
        gender: gender ?? currentUser.gender,
        city: city ?? currentUser.city,
        state: userState ?? currentUser.state,
        country: country ?? currentUser.country,
        latitude: latitude ?? currentUser.latitude,
        longitude: longitude ?? currentUser.longitude,
        // Preserve favorites unless explicitly set
        favoriteSports: favoriteSports ?? currentUser.favoriteSports,
        isEmailVerified: currentUser.isEmailVerified,
        isMobileVerified: currentUser.isMobileVerified,
        createdAt: currentUser.createdAt,
        updatedAt: DateTime.now(),
      );

      final result = await _userRepository.updateUser(updatedUser);

      result.fold(
        (failure) {
          debugPrint('Failed to update user: ${failure.message}');
          throw Exception('Failed to update user: ${failure.message}');
        },
        (user) {
          state = user;
          _saveUserToCache(user); // Cache the updated user data
          debugPrint(
            'User updated successfully: ${_composeFullName(user.firstName, user.lastName)}',
          );
        },
      );
    } catch (e) {
      debugPrint('Error updating user profile: $e');
      rethrow;
    }
  }

  // Update only favorite sports permanently in Supabase, accepting UUIDs or names
  Future<void> logout() async {
    try {
      // Clear local cache before signing out
      if (state?.userId != null) {
        _removeUserFromCache(state!.userId);
      }

      await _supabase.auth.signOut();
      state = null;
      debugPrint('User logged out successfully');
    } catch (e) {
      debugPrint('Error during logout: $e');
      throw Exception('Logout failed: $e');
    }
  }

  Future<void> refreshUser() async {
    if (state?.userId != null) {
      await _loadUserData(state!.userId);
    }
  }

  /// Fetch any user profile by user ID (not just current user)
  Future<User?> getUserProfile(String userId) async {
    try {
      final result = await _userRepository.getUserById(userId);
      return result.fold(
        (failure) {
          debugPrint('Failed to load user profile: ${failure.message}');
          return null;
        },
        (user) {
          debugPrint(
            'User profile loaded: ${_composeFullName(user.firstName, user.lastName)}',
          );
          return user;
        },
      );
    } catch (e) {
      debugPrint('Error loading user profile: $e');
      return null;
    }
  }

  // Getters
  bool get isLoggedIn => _supabase.auth.currentUser != null && state != null;
  bool get isAuthenticated => _supabase.auth.currentUser != null;
  bool get isProfileCompleted => state != null && state!.firstName.isNotEmpty;
  String? get userId => _supabase.auth.currentUser?.id;
  String? get userEmail => _supabase.auth.currentUser?.email;
  String? get userPhone => _supabase.auth.currentUser?.phone;

  // Helpers
  String _composeFullName(String firstName, String? lastName) =>
      lastName == null || lastName.isEmpty ? firstName : '$firstName $lastName';

  DateTime? _tryParseDateTime(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  UserRole _parseUserRole(String? role) {
    switch (role) {
      case 'trainer':
        return UserRole.trainer;
      case 'admin':
        return UserRole.admin;
      case 'venue_partner':
        return UserRole.venuePartner;
      case 'user':
      case 'player': // legacy value
      default:
        return UserRole.user;
    }
  }
}
