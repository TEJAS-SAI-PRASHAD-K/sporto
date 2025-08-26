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
        if (state?.id != null) {
          _removeUserFromCache(state!.id);
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
        debugPrint('User loaded from cache: ${cachedUser.fullName}');
      }

      // Then load fresh data from remote
      await _loadUserData(userId);
    }
  }

  Future<User?> loadUserFromCache(String userId) async {
    try {
      final userMap = await _databaseHelper.getUserById(userId);
      if (userMap != null) {
        // Convert stored JSON strings back to proper types
        final userJson = Map<String, dynamic>.from(userMap);

        // Handle preferred_sports JSON array
        if (userJson['preferred_sports'] is String) {
          userJson['preferred_sports'] = jsonDecode(
            userJson['preferred_sports'],
          );
        }

        // Handle boolean conversions (SQLite stores as int)
        userJson['is_active'] = userJson['is_active'] == 1;
        userJson['is_email_verified'] = userJson['is_email_verified'] == 1;
        userJson['is_phone_verified'] = userJson['is_phone_verified'] == 1;
        userJson['is_profile_completed'] =
            userJson['is_profile_completed'] == 1;
        userJson['is_online'] = userJson['is_online'] == 1;

        final user = User.fromJson(userJson);
        debugPrint('User loaded from cache: ${user.fullName}');
        return user;
      }
    } catch (e) {
      debugPrint('Error loading user from cache: $e');
    }
    return null;
  }

  Future<void> _saveUserToCache(User user) async {
    try {
      final userJson = user.toJson();

      // Convert arrays to JSON strings for SQLite storage
      userJson['preferred_sports'] = jsonEncode(user.preferredSports);

      // Convert booleans to integers for SQLite
      userJson['is_active'] = user.isActive ? 1 : 0;
      userJson['is_email_verified'] = user.isEmailVerified ? 1 : 0;
      userJson['is_phone_verified'] = user.isPhoneVerified ? 1 : 0;
      userJson['is_profile_completed'] = user.isProfileCompleted ? 1 : 0;
      userJson['is_online'] = user.isOnline ? 1 : 0;

      // Convert enums to strings
      userJson['role'] = user.role?.name;
      userJson['auth_provider'] = user.authProvider?.name;
      userJson['subscription_status'] = user.subscriptionStatus?.name;

      await _databaseHelper.insertUser(userJson);
      debugPrint('User saved to cache: ${user.fullName}');
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

  Future<void> _loadUserData(String userId) async {
    try {
      final result = await _userRepository.getUserById(userId);
      result.fold(
        (failure) {
          debugPrint('Failed to load user data: ${failure.message}');
        },
        (user) {
          state = user;
          _saveUserToCache(user); // Cache the user data locally
          debugPrint('User data loaded: ${user.fullName}');
        },
      );
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }

  Future<void> createOrUpdateUser({
    required String email,
    required String fullName,
    String? phone,
    String? firstName,
    String? lastName,
    String? profilePictureUrl,
    UserRole? role,
    AuthProvider? authProvider,
    String? bio,
    DateTime? dateOfBirth,
    String? gender,
    String? city,
    String? userState,
    String? country,
    double? latitude,
    double? longitude,
    List<String>? preferredSports,
    SubscriptionStatus? subscriptionStatus,
  }) async {
    try {
      // Get current auth user
      final authUser = _supabase.auth.currentUser;
      if (authUser == null) {
        throw Exception('No authenticated user found');
      }

      // Create user with auth user ID
      final userToSave = User(
        id: authUser.id,
        email: email,
        fullName: fullName,
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        profilePictureUrl: profilePictureUrl,
        role: role ?? UserRole.player,
        authProvider: authProvider ?? AuthProvider.email,
        bio: bio,
        dateOfBirth: dateOfBirth,
        gender: gender,
        city: city,
        state: userState,
        country: country,
        latitude: latitude,
        longitude: longitude,
        preferredSports: preferredSports ?? [],
        subscriptionStatus: subscriptionStatus ?? SubscriptionStatus.free,
        isProfileCompleted: _isProfileComplete(
          firstName: firstName,
          lastName: lastName,
          dateOfBirth: dateOfBirth,
          gender: gender,
          preferredSports: preferredSports,
        ),
      );

      final result = await _userRepository.createOrUpdateUser(userToSave);

      result.fold(
        (failure) {
          debugPrint('Failed to save user data: ${failure.message}');
          throw Exception('Failed to save user data: ${failure.message}');
        },
        (savedUser) {
          state = savedUser;
          debugPrint('User data saved successfully: ${savedUser.fullName}');
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
    String? fullName,
    String? profilePictureUrl,
    String? bio,
    DateTime? dateOfBirth,
    String? gender,
    String? city,
    String? userState,
    String? country,
    double? latitude,
    double? longitude,
    List<String>? preferredSports,
    String? phone,
  }) async {
    try {
      if (state == null) {
        throw Exception('No current user to update');
      }

      final currentUser = state!;

      final updatedUser = User(
        id: currentUser.id,
        email: currentUser.email,
        phone: phone ?? currentUser.phone,
        fullName: fullName ?? currentUser.fullName,
        firstName: firstName ?? currentUser.firstName,
        lastName: lastName ?? currentUser.lastName,
        profilePictureUrl: profilePictureUrl ?? currentUser.profilePictureUrl,
        role: currentUser.role ?? UserRole.player,
        authProvider: currentUser.authProvider ?? AuthProvider.email,
        bio: bio ?? currentUser.bio,
        dateOfBirth: dateOfBirth ?? currentUser.dateOfBirth,
        gender: gender ?? currentUser.gender,
        city: city ?? currentUser.city,
        state: userState ?? currentUser.state,
        country: country ?? currentUser.country,
        latitude: latitude ?? currentUser.latitude,
        longitude: longitude ?? currentUser.longitude,
        preferredSports: preferredSports ?? currentUser.preferredSports,
        subscriptionStatus:
            currentUser.subscriptionStatus ?? SubscriptionStatus.free,
        subscriptionExpiresAt: currentUser.subscriptionExpiresAt,
        isActive: currentUser.isActive,
        isEmailVerified: currentUser.isEmailVerified,
        isPhoneVerified: currentUser.isPhoneVerified,
        isProfileCompleted: _isProfileComplete(
          firstName: firstName ?? currentUser.firstName,
          lastName: lastName ?? currentUser.lastName,
          dateOfBirth: dateOfBirth ?? currentUser.dateOfBirth,
          gender: gender ?? currentUser.gender,
          preferredSports: preferredSports ?? currentUser.preferredSports,
        ),
        fcmToken: currentUser.fcmToken,
        lastActiveAt: currentUser.lastActiveAt,
        isOnline: currentUser.isOnline,
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
          debugPrint('User updated successfully: ${user.fullName}');
        },
      );
    } catch (e) {
      debugPrint('Error updating user profile: $e');
      rethrow;
    }
  }

  bool _isProfileComplete({
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? gender,
    List<String>? preferredSports,
  }) {
    return firstName?.isNotEmpty == true &&
        lastName?.isNotEmpty == true &&
        dateOfBirth != null &&
        gender?.isNotEmpty == true &&
        (preferredSports?.isNotEmpty == true);
  }

  Future<void> logout() async {
    try {
      // Clear local cache before signing out
      if (state?.id != null) {
        _removeUserFromCache(state!.id);
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
    if (state?.id != null) {
      await _loadUserData(state!.id);
    }
  }

  // Getters
  bool get isLoggedIn => _supabase.auth.currentUser != null && state != null;
  bool get isAuthenticated => _supabase.auth.currentUser != null;
  bool get isProfileCompleted => state?.isProfileCompleted == true;
  String? get userId => _supabase.auth.currentUser?.id;
  String? get userEmail => _supabase.auth.currentUser?.email;
  String? get userPhone => _supabase.auth.currentUser?.phone;
}
