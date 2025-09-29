import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';

class DeleteAccountProfilePopup {
  static Widget show(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,

      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UrbanistApptext(
                text: AppText.deleteAccountTitle,
                color: AppColor.black,
                fontWeight: FontWeight.w700,
                fontSize: width * (20 / width),
              ),
              SizedBox(height: width * 0.02),
              UrbanistApptext(
                text: AppText.deleteAccountDescription,
                fontSize: width * (16 / width),
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
            ],
          ),
          content: UrbanistApptext(
            text: AppText.deleteAccountDescription2,
            fontSize: width * (16 / width),
            fontWeight: FontWeight.w600,
            color: AppColor.placeholderColor,
          ),
          actions: [
            CustomButton(
              text: AppText.cancelButton,
              borderRadius: 10,
              color: AppColor.white,
              textColor: AppColor.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: width * 0.046,
              height: width * 0.13,
              width: width / 3,
              borderColor: AppColor.primaryColor,
              onPressed: () {
                // TODO: Add your delete account logic here
                Navigator.of(dialogContext).pop();
                //context.pop();
              },
            ),
            // SizedBox(width: width * 0.02),
            CustomButton(
              text: AppText.deleteAccountButton,
              borderRadius: 10,
              color: AppColor.primaryColor,
              textColor: AppColor.white,
              fontWeight: FontWeight.bold,
              fontSize: width * 0.046,
              height: width * 0.13,
              width: width / 3,
              borderColor: AppColor.primaryColor,

              onPressed: () {
                // TODO: Add your delete account logic here
                Navigator.of(dialogContext).pop();
                //context.pop();
              },
            ),
          ],
        );
      },
    );
    return const SizedBox.shrink();
  }
}
