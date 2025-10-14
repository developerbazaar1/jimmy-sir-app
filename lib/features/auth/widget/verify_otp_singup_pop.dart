import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/apptext/poppins_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/constants/enum.dart';
import 'updated_sheet_popup.dart';
import '../../../core/validators/validators.dart';

class VerifyOtpSingupPop {
  static void show(BuildContext context, TextEditingController otpController) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final width = MediaQuery.sizeOf(context).width;
        final height = MediaQuery.sizeOf(context).height;
        final hasError = ValueNotifier<bool>(false);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: AppColor.textColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              // Drag Handle
              PoppinsApptext(
                text: AppText.verifyYourEmailAddress,
                fontSize: width * 0.051,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: width * 0.0612),
              // Success Icon
              PinCodeTextField(
                appContext: context,
                length: 4,
                autoFocus: true,
                controller: otpController,
                onChanged: (value) {
                  // controller.ValidateOtp(value);
                  if (value.length == 4) {
                    hasError.value = false;
                  } else {
                    hasError.value = true;
                  }
                },
                keyboardType: TextInputType.number,
                textStyle: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w600,
                ),
                errorTextSpace: height * 0.04,
                errorTextMargin: EdgeInsets.only(top: height * 0.01),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,

                  borderRadius: BorderRadius.circular(width * 0.03),
                  fieldHeight: width * 0.15,

                  fieldWidth: width * 0.15,
                  activeFillColor: AppColor.white,
                  inactiveFillColor: AppColor.white,
                  selectedFillColor: AppColor.white,
                  activeColor: hasError.value
                      ? AppColor.redColor
                      : AppColor.primaryColor,
                  inactiveColor: hasError.value
                      ? AppColor.redColor
                      : AppColor.border,
                  selectedColor: hasError.value
                      ? AppColor.redColor
                      : AppColor.primaryColor,
                ),
                cursorColor: AppColor.primaryColor,
                enableActiveFill: true,
                animationType: AnimationType.fade,
                validator: Validator.validateOtp,
              ),

              SizedBox(height: width * 0.0612),
              CustomButton(
                text: AppText.verify,
                color: AppColor.primaryColor,
                textColor: AppColor.white,
                fontSize: width * 0.046,
                height: width * 0.16,
                width: width,
                borderRadius: 10,
                borderColor: AppColor.primaryColor,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  if (hasError.value) {
                    return;
                  }
                  if (Validator.validateOtp(otpController.text) != null) {
                    hasError.value = true;
                  } else {
                    hasError.value = false;
                  }
                  context.pop();

                  BottomSheetPopUp.show(context, VerifyOtpType.signup);
                },
              ),
              SizedBox(height: width * 0.0612),
            ],
          ),
        );
      },
    );
  }
}
