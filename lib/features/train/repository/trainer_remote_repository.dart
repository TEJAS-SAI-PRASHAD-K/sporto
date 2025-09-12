import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:playo/core/constants/server_constants.dart';
import 'package:playo/core/models/trainer.dart';
import 'package:playo/init_dependecies.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:playo/core/error/failure.dart';

part 'trainer_remote_repository.g.dart';

@riverpod
TrainerRemoteRepository trainerRemoteRepository(Ref ref) {
  return TrainerRemoteRepository(httpClient: serviceLocator<http.Client>());
}

class TrainerRemoteRepository {
  final http.Client httpClient;

  TrainerRemoteRepository({required this.httpClient});

  Future<Either<Failure, Trainer>> fetchTrainerModels() async {
    try {
      final uri = Uri.parse("${ServerConstants.strapiBaseUrl}/trainer-models");
      final res = await httpClient.get(uri);

      if (res.statusCode == 200) {
        final trainer = trainerFromJson(res.body);

        return Right(trainer);
      } else {
        return Left(Failure("Error: ${res.statusCode}"));
      }
    } on SocketException {
      return Left(Failure("No internet connection"));
    } catch (e) {
      debugPrint("fetchTrainerModels error: $e");
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }
}

