import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/constants/enum.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';

import '../../../../../../core/components/apptext/inter_apptext.dart';
import '../../../../../../core/constants/app_svg.dart';

class ProfileSavePopUp {
  static Timer? _timer;

  static void show(BuildContext context) {
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

            context.pushReplacementNamed(RouteNames.tabBar);
          }
        });

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title

              // Success Icon
              SvgPicture.asset(
                AppSvg.imgChangePSfully,
                width: width * 0.31,
                height: width * 0.31,
              ),

              SizedBox(height: width * 0.0612),

              // Subtitle
              InterApptext(
                text: AppText.profileInfoUpdatedSuccessfully,
                fontSize: width * (20 / width),
                color: AppColor.textColor,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                maxLines: 5,
              ),

              SizedBox(height: width * 0.0612, width: width),
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
