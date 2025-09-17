import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'package:playo/core/models/trainer.dart';
import 'package:playo/features/train/model/service_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:playo/features/train/repository/trainer_remote_repository.dart';
import 'package:playo/core/providers/current_user_provider.dart';

part 'train_view_model.g.dart';

@riverpod
class TrainViewModel extends _$TrainViewModel {
  late TrainerRemoteRepository _trainerRemoteRepository;
  late CurrentUserNotifier _currentUserNotifier;
  final List<ServiceCategory> _categories = [
    ServiceCategory(
      id: 'badminton',
      name: 'Badminton',
      imageAsset: 'assets/images/girl_9.png',
      background: const Color(0xFFEADCF8),
    ),
    ServiceCategory(
      id: 'swimming',
      name: 'Swimming',
      imageAsset: 'assets/images/boy_4.png',
      background: const Color(0xFFC9F1F0),
    ),
    ServiceCategory(
      id: 'pickleball',
      name: 'Pickleball',
      imageAsset: 'assets/images/girl_12.png',
      background: const Color(0xFFF9E9CC),
    ),
    ServiceCategory(
      id: 'football',
      name: 'Football',
      imageAsset: 'assets/images/boy_8.png',
      background: const Color(0xFFC7F1EE),
    ),
    ServiceCategory(
      id: 'cricket',
      name: 'Cricket',
      imageAsset: 'assets/images/boy_7.png',
      background: const Color(0xFFD4EBFF),
    ),
    ServiceCategory(
      id: 'tennis',
      name: 'Tennis',
      imageAsset: 'assets/images/boy_6.png',
      background: const Color(0xFFEEDCF2),
    ),
    ServiceCategory(
      id: 'physio',
      name: 'Physio',
      imageAsset: 'assets/images/girl_1.png',
      background: const Color(0xFFDDF1EC),
    ),
    ServiceCategory(
      id: 'nutrition',
      name: 'Nutrition',
      imageAsset: 'assets/images/default.png',
      background: ServiceCategory.generateColorForCategory('Nutrition'),
    ),
    ServiceCategory(
      id: 'yoga',
      name: 'Yoga',
      imageAsset: 'assets/images/boy_1.png',
      background: ServiceCategory.generateColorForCategory('Yoga'),
    ),
    ServiceCategory(
      id: 'fitness',
      name: 'Fitness Trainer',
      imageAsset: 'assets/images/boy_5.png',
      background: ServiceCategory.generateColorForCategory('Fitness Trainer'),
    ),
  ];
  // Public read-only view of the built-in service categories used by the UI
  List<ServiceCategory> get categories => List.unmodifiable(_categories);
  @override
  AsyncValue<Trainer>? build() {
    _trainerRemoteRepository = ref.watch(trainerRemoteRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);

    return null;
  }

  Future<void> fetchTrainers() async {
    state = const AsyncValue.loading();

    final res = await _trainerRemoteRepository.fetchTrainerModels();

    state = res.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (trainers) => AsyncValue.data(trainers),
    );
  }

  /// Send an instant message email to the trainer using SMTP.
  /// Returns true on success, throws on fatal error.
  Future<bool> sendInstantMessageEmail({
    required Datum datum,
    required String? sport,
    required String? message,
    // Optional SMTP config can be passed; otherwise read from environment
    String? smtpHost,
    int? smtpPort,
    String? smtpUsername,
    String? smtpPassword,
    bool useSsl = true,
  }) async {
    final trainer = datum.trainer;

    // Build message body with user details from current user notifier
    final currentUser = _currentUserNotifier.state;
    final senderName = currentUser?.firstName ?? 'User';
    final senderEmail =
        currentUser?.emailAddress ??
        _currentUserNotifier.userEmail ??
        'no-reply@example.com';
    final senderPhone =
        currentUser?.mobileNumber ?? _currentUserNotifier.userPhone ?? '';

    final bodyMessage = StringBuffer();
    bodyMessage.writeln('Hi ${trainer.firstName} ${trainer.lastName},');
    bodyMessage.writeln();
    if (message != null && message.trim().isNotEmpty) {
      bodyMessage.writeln(message.trim());
    } else {
      bodyMessage.writeln(
        'I am interested in connecting with you regarding ${sport ?? 'your services'}. Please let me know your availability.',
      );
    }
    bodyMessage.writeln();
    bodyMessage.writeln('---');
    bodyMessage.writeln('Sender details:');
    bodyMessage.writeln('Name: $senderName');
    bodyMessage.writeln('Email: $senderEmail');
    if (senderPhone.isNotEmpty) bodyMessage.writeln('Phone: $senderPhone');

    // SMTP config fallback to environment variables via flutter_dotenv
    final host = smtpHost ?? dotenv.env['SMTP_HOST'] ?? '';
    final portEnv =
        smtpPort ?? int.tryParse(dotenv.env['SMTP_PORT'] ?? '') ?? 0;
    final username = smtpUsername ?? dotenv.env['SMTP_USERNAME'] ?? '';
    final password = smtpPassword ?? dotenv.env['SMTP_PASSWORD'] ?? '';

    if (host.isEmpty || username.isEmpty || password.isEmpty) {
      throw Exception(
        'SMTP configuration is missing. Set SMTP_HOST, SMTP_USERNAME and SMTP_PASSWORD in environment.',
      );
    }

    final effectivePort = portEnv > 0 ? portEnv : (useSsl ? 465 : 587);

    final smtpServer = SmtpServer(
      host,
      port: effectivePort,
      username: username,
      password: password,
      ssl: useSsl,
    );

    // Prefer the email provided on the datum/trainer object (fetched from Strapi).
    // Only attempt to resolve the trainer's user profile when that email is empty.
    final recipientEmail = trainer.email;

    if (recipientEmail.isEmpty) {
      throw Exception('Trainer email not available');
    }


    // Construct message. Use the configured SMTP username as the envelope From by default,
    // but include sender's name and email in the body for clarity.
    final fromAddress = Address(username, senderName);

    final mailMessage = Message()
      ..from = fromAddress
      ..recipients.add(recipientEmail)
      ..subject =
          'Sporto: ${senderName} wants to connect about ${sport ?? 'your services'}'
      ..text = bodyMessage.toString();

    try {
      final sendReport = await send(mailMessage, smtpServer);
      // mailer returns a SendReport; if no exception, assume success
      debugPrint('Email sent: $sendReport');
      return true;
    } on MailerException catch (e) {
      debugPrint('MailerException: ${e.message}');
      // Re-throw to let caller show error
      throw Exception('Failed to send email: ${e.message}');
    } catch (e) {
      debugPrint('Error sending email: $e');
      throw Exception('Failed to send email: $e');
    }
  }
}
