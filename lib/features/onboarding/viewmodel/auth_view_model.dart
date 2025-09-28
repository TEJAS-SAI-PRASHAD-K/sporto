import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:playo/features/onboarding/repository/auth_remote_repository.dart';
import 'package:playo/core/providers/current_user_provider.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<void>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> signUpWithOtp({required String mobileNumber}) async {
    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.signUpWithPhoneOtp(
      mobileNumber: mobileNumber,
    );

    if (res case Left(value: final failure)) {
      state = AsyncValue.error(failure.message, StackTrace.current);
    } else if (res case Right(value: final _)) {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> verifyPhoneOtp({
    required String mobileNumber,
    required String token,
  }) async {
    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.verifyWithPhoneOtp(
      mobileNumber: mobileNumber,
      token: token,
    );

    if (res case Left(value: final failure)) {
      state = AsyncValue.error(failure.message, StackTrace.current);
    } else if (res case Right(value: final authResponse)) {
      // Auth successful, create/update user profile
      await _handleSuccessfulAuth(authResponse, mobileNumber);
      state = const AsyncValue.data(null);
    }
  }

  Future<void> signUpWithEmailOtp({required String email}) async {
    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.signUpWithEmailOtp(email: email);

    if (res case Left(value: final failure)) {
      state = AsyncValue.error(failure.message, StackTrace.current);
    } else if (res case Right(value: final _)) {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> verifyEmailOtp({
    required String email,
    required String token,
  }) async {
    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.verifyWithEmailOtp(
      email: email,
      token: token,
    );

    if (res case Left(value: final failure)) {
      state = AsyncValue.error(failure.message, StackTrace.current);
    } else if (res case Right(value: final authResponse)) {
      // Auth successful, create/update user profile
      await _handleSuccessfulAuth(authResponse, email);
      state = const AsyncValue.data(null);
    }
  }

  Future<void> _handleSuccessfulAuth(
    AuthResponse authResponse,
    String emailOrPhone,
  ) async {
    try {
      final user = authResponse.user;
      if (user != null) {
        // Determine if it's email or phone
        final isEmail = emailOrPhone.contains('@');
        debugPrint(user.userMetadata.toString());
        debugPrint(authResponse.user?.toJson().toString());

        await _currentUserNotifier.createOrUpdateUser(
          emailAddress: isEmail ? emailOrPhone : (user.email ?? ''),
          mobileNumber: !isEmail ? emailOrPhone : user.phone,
        );
      }
    } catch (e) {
      // Log error but don't fail the authentication
      debugPrint('Error creating user profile: $e');
    }
  }

  Future<void> updateUserNames({
    required String firstName,
    required String lastName,
  }) async {
    try {
      await _currentUserNotifier.updateUserProfile(
        firstName: firstName,
        lastName: lastName,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserAvatar({required String profilePictureUrl}) async {
    try {
      await _currentUserNotifier.updateUserProfile(
        avatarUrl: profilePictureUrl,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserSports({required List<String> preferredSports}) async {
    try {
      // Persist favorite_sports using the central createOrUpdateUser method
      // which will create or update the user record and persist favorites.
      await _currentUserNotifier.createOrUpdateUser(
        emailAddress: _currentUserNotifier.userEmail ?? '',
        favoriteSports: preferredSports,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> completeProfile({
    required String firstName,
    required String lastName,
    required String gender,
    required List<String> preferredSports,
    String? bio,
    String? city,
    String? state,
    String? country,
  }) async {
    try {
      await _currentUserNotifier.updateUserProfile(
        firstName: firstName,
        lastName: lastName,
        bio: bio,
        gender: gender,
        city: city,
        userState: state,
        country: country,
        favoriteSports: preferredSports,
      );
    } catch (e) {
      // Handle error appropriately
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _currentUserNotifier.logout();
    } catch (e) {
      // Handle error appropriately
      rethrow;
    }
  }
}
