import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth State Provider for managing state across pages
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((
  ref,
) {
  return AuthStateNotifier();
});

class AuthState {
  final String? mobileNumber;
  final String? email;
  final String? otpCode;
  final bool receiveWhatsappUpdates;

  AuthState({
    this.mobileNumber,
    this.email,
    this.otpCode,
    this.receiveWhatsappUpdates = false,
  });

  AuthState copyWith({
    String? mobileNumber,
    String? email,
    String? otpCode,
    bool? receiveWhatsappUpdates,
  }) {
    return AuthState(
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      otpCode: otpCode ?? this.otpCode,
      receiveWhatsappUpdates:
          receiveWhatsappUpdates ?? this.receiveWhatsappUpdates,
    );
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(AuthState());

  void setMobileNumber(String mobileNumber) {
    state = state.copyWith(mobileNumber: mobileNumber);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setOtpCode(String otpCode) {
    state = state.copyWith(otpCode: otpCode);
  }

  void setReceiveWhatsappUpdates(bool value) {
    state = state.copyWith(receiveWhatsappUpdates: value);
  }

  void reset() {
    state = AuthState();
  }
}
