import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:playo/core/error/failure.dart';
import 'package:playo/init_dependecies.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  final supabase = serviceLocator<SupabaseClient>();
  return AuthRemoteRepository(supabase);
}

class AuthRemoteRepository {
  final SupabaseClient supabase;

  AuthRemoteRepository(this.supabase);

  Future<Either<Failure, void>> signUpWithPhoneOtp({
    required String mobileNumber,
  }) async {
    try {
      debugPrint(mobileNumber);
      await supabase.auth.signInWithOtp(
        phone: mobileNumber,
        channel: OtpChannel.sms,
        shouldCreateUser: true,
      );
      return Right(null);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      debugPrint(e.toString());
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, ResendResponse>> resendPhoneOtp({
    required String mobileNumber,
  }) async {
    try {
      debugPrint(mobileNumber);
      final res = await supabase.auth.resend(
        phone: mobileNumber,
        type: OtpType.sms,
      );
      return Right(res);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      debugPrint(e.toString());
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, AuthResponse>> verifyWithPhoneOtp({
    required String mobileNumber,
    required String token,
  }) async {
    try {
      debugPrint(mobileNumber);
      final res = await supabase.auth.verifyOTP(
        phone: mobileNumber,
        type: OtpType.sms,
        token: token,
      );
      return Right(res);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      debugPrint(e.toString());
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, void>> signUpWithEmailOtp({
    required String email,
  }) async {
    try {
      debugPrint(email);
      await supabase.auth.signInWithOtp(
        email: email,
        shouldCreateUser: true,
        emailRedirectTo: null,
      );
      return Right(null);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      debugPrint(e.toString());
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, ResendResponse>> resendEmailOtp({
    required String email,
  }) async {
    try {
      debugPrint(email);
      final res = await supabase.auth.resend(email: email, type: OtpType.email);
      return Right(res);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      debugPrint(e.toString());
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  Future<Either<Failure, AuthResponse>> verifyWithEmailOtp({
    required String email,
    required String token,
  }) async {
    try {
      debugPrint(email);
      final res = await supabase.auth.verifyOTP(
        email: email,
        type: OtpType.email,
        token: token,
      );
      return Right(res);
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      debugPrint(e.toString());
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }
}
