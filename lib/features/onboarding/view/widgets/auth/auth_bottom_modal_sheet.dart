import 'package:flutter/material.dart';
import 'package:playo/features/onboarding/view/widgets/auth/otp_modal_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:playo/features/onboarding/view/widgets/auth/login_modal_sheet.dart';
import 'package:playo/features/onboarding/view/widgets/auth/email_input_modal_sheet.dart';

void showAuthBottomModalSheet(BuildContext context) {
  WoltModalSheet.show<void>(
    context: context,
    pageListBuilder: (modalSheetContext) {
      return [
        loginModalPage(modalSheetContext),
        emailInputModalPage(modalSheetContext),
        otpModalPage(context, medium: OtpMedium.phone),
        otpModalPage(context, medium: OtpMedium.email),
      ];
    },
    modalTypeBuilder: (context) {
      final size = MediaQuery.sizeOf(context).width;
      if (size < 768) {
        return WoltModalType.bottomSheet();
      } else {
        return WoltModalType.dialog();
      }
    },
    onModalDismissedWithBarrierTap: () {
      Navigator.of(context).pop();
    },
  );
}
