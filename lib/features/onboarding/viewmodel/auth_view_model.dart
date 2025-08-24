import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:playo/features/onboarding/repository/auth_remote_repository.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;

  @override
  AsyncValue<void>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
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
    } else if (res case Right(value: final _)) {
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
    } else if (res case Right(value: final _)) {
      state = const AsyncValue.data(null);
    }
  }
}
