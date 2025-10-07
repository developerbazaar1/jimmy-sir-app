import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import '../../../../../../core/components/apptext/inter_apptext.dart';

//-----------------------------------------this is an submitted popup-----------------------------------------

class BankPopup {
  // static Timer? _timer;

  static void show(
    BuildContext context,
    String title,
    String description,
    String notes,
    Function? onCancle,
    Function? onWithdraw,
  ) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    // Cancel any existing timer
    // _timer?.cancel();

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
        // _timer = Timer(const Duration(seconds: 5), () {
        //   if (context.mounted) {
        //     context.pop();
        //     // context.pushReplacementNamed(RouteNames.tabBar);
        //   }
        // });

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.04,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              UrbanistApptext(
                text: title,
                fontSize: width * (20 / width),
                color: AppColor.black,
                fontWeight: FontWeight.w800,
                textAlign: TextAlign.start,
                maxLines: 1,
              ),

              SizedBox(height: width * 0.0412),
              UrbanistApptext(
                text: description,
                fontSize: width * (15 / width),
                color: AppColor.black,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                maxLines: 3,
              ),
              SizedBox(height: width * 0.0212),

              // Subtitle
              InterApptext(
                text: notes,

                fontSize: width * (14 / width),
                color: AppColor.textGreyColor3,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                maxLines: 5,
              ),

              SizedBox(height: width * 0.0612, width: width),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    text: AppText.cancelButton,
                    borderRadius: 10,
                    color: AppColor.white,
                    textColor: AppColor.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.036,
                    height: width * 0.13,
                    width: width / 3,
                    borderColor: AppColor.primaryColor,
                    onPressed: () {
                      if (onCancle != null) {
                        onCancle();
                      }
                    },
                  ),

                  CustomButton(
                    text: AppText.withdraw,
                    borderRadius: 10,
                    color: AppColor.primaryColor,
                    textColor: AppColor.white,
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.036,
                    height: width * 0.12,
                    width: width / 3,
                    borderColor: AppColor.primaryColor,
                    onPressed: () {
                      if (onWithdraw != null) {
                        onWithdraw();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).then((_) {});
  }
}

//-----------------------------------------this is an submitted popup-----------------------------------------

class SubmittedBankPopup {
  static Timer? _timer;

  static void show(BuildContext context, String title, String description) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
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
        _timer = Timer(const Duration(seconds: 5), () {
          if (context.mounted) {
            context.pop();
          }
        });

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.05,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              UrbanistApptext(
                text: title,
                fontSize: width * (20 / width),
                color: AppColor.black,
                fontWeight: FontWeight.w800,
                textAlign: TextAlign.start,
                maxLines: 1,
              ),

              SizedBox(height: width * 0.0412),
              UrbanistApptext(
                text: description,
                fontSize: width * (13 / width),
                color: AppColor.textGreyColor3,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                maxLines: 3,
              ),
              SizedBox(height: width * 0.0212),
            ],
          ),
        );
      },
    ).then((_) {
      _timer?.cancel();
    });
  }
}
