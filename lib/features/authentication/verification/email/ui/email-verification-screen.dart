import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/auth/auth.dart';
import '../../../../../core/utils/constants/asset_paths.dart';
import '../../../../../core/utils/helper_functions/helper_functions.dart';
import '../controller/email_verif_controller.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key, this.userEmail});

  final String? userEmail;

  @override
  Widget build(BuildContext context) {
    final emailVerificationController = Get.put(EmailVerificationController());
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => AuthenticationRepo.instance.logOutUser(),
          icon: const Icon(Icons.clear, size: 32),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(verifyEmailSvg),
                30.h,

                Text("Verify Your Email address!", style: textTheme.titleLarge),
                12.h,

                Text(
                  "We sent a verification link to ${userEmail ?? ""}, Check your email and click on the link to verify your email address",
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                50.h,

                FilledButton(
                  onPressed: () => emailVerificationController.checkEmailVerificationStatus(),
                  style: FilledButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Continue"),
                ),
                18.h,

                //   RESEND VERIFICATION LINK BTN
                TextButton.icon(
                  icon: SvgPicture.asset(
                    refreshSvg,
                    color: theme.primary,
                  ),
                  onPressed: () =>
                      emailVerificationController.sendEmailVerificationLink(),
                  label: Text(
                    "Resend Verification Link",
                    style: TextStyle(
                      color: theme.primary,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
