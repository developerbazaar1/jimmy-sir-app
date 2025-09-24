import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';

import '../../../core/components/apptext/inter_apptext.dart';
import '../../../core/components/apptext/poppins_apptext.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_svg.dart';
import '../../../core/routes/route_constant.dart';
import '../../../core/constants/enum.dart';

class BottomSheetPopUp {
  static Timer? _timer;

  static void show(BuildContext context, VerifyOtpType verifyOtpType) {
    // Cancel any existing timer
    _timer?.cancel();

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: AppColor.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final width = MediaQuery.sizeOf(context).width;

        // Start the auto-dismiss timer
        _timer = Timer(const Duration(seconds: 5), () {
          if (context.mounted) {
            context.pop();
            // Navigate to login if it's a change password flow
            if (verifyOtpType == VerifyOtpType.changePasswordOtp) {
              context.pushReplacementNamed(RouteNames.login);
            } else {
              context.pushReplacementNamed(RouteNames.dashboard);
            }
          }
        });

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              PoppinsApptext(
                text: verifyOtpType == VerifyOtpType.changePasswordOtp
                    ? AppText.passwordUpdatedSuccessfully
                    : AppText.emailVerified,
                fontSize: width * 0.051,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: width * 0.0612),
              // Success Icon
              SvgPicture.asset(
                AppSvg.imgChangePSfully,
                width: width * 0.31,
                height: width * 0.31,
              ),

              SizedBox(height: width * 0.0612),

              // Subtitle
              InterApptext(
                text: verifyOtpType == VerifyOtpType.changePasswordOtp
                    ? AppText.passwordUpdatedSuccessfullyDescription
                    : AppText.emailVerifiedDescription,
                fontSize: width * 0.046,
                color: AppColor.textColor,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                maxLines: 5,
              ),

              SizedBox(height: width * 0.0612),

              // Auto-dismiss countdown indicator (optional)
              InterApptext(
                text: "Auto-dismissing in 5 seconds...",
                fontSize: width * 0.035,
                color: AppColor.textGreyColor,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: width * 0.0612),

              // Sign In Link (for change password flow)
              if (verifyOtpType == VerifyOtpType.changePasswordOtp) ...{
                GestureDetector(
                  onTap: () {
                    _timer?.cancel(); // Cancel the timer
                    context.pop();
                    context.pushReplacementNamed(RouteNames.login);
                  },
                  child: InterApptext(
                    text: AppText.signIn,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.046,
                    textAlign: TextAlign.center,
                    textDecoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: width * 0.0612),
              },
            ],
          ),
        );
      },
    ).then((_) {
      // Clean up timer when modal is dismissed
      _timer?.cancel();
    });
  }
}
