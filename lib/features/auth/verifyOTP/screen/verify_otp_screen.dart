import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/components/Button/custom_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/routes/route_constant.dart';
import '../../../../core/validators/validators.dart';
import '../../widget/header_widget.dart';
import '../controller/verify_otp.dart';

class VerifyOTPScreen extends ConsumerWidget {
  VerifyOTPScreen({super.key});
  final otpController = TextEditingController();
  final hasError = ValueNotifier(false);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final verifyOtpNotifier = ref.watch(verifyOtpProvider.notifier);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: width * 0.0815),
                HeaderWidget(
                  title: AppText.verifyYourIdentity,
                  description: AppText.verifyYourIdentityDescription,
                ),

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
                SizedBox(height: width * 0.082),

                CustomButton(
                  text: AppText.verifyOTP,
                  color: AppColor.primaryColor,
                  textColor: AppColor.white,
                  fontSize: width * 0.046,
                  fontWeight: FontWeight.w600,
                  borderRadius: 10,
                  borderColor: AppColor.primaryColor,
                  onPressed: () {
                    if (hasError.value) {
                      hasError.value = false;
                    } else {
                      hasError.value = true;
                    }
                    if (otpController.text.length == 4) {
                      hasError.value = false;
                    } else {
                      hasError.value = true;
                    }
                    context.pushNamed(RouteNames.changePassword);
                    // TODO: Implement OTP verification logic here
                  },
                  height: width * 0.13,
                  width: width,
                ),
                SizedBox(height: width * 0.0204),
                Text.rich(
                  TextSpan(
                    text: AppText.didNotReceiveTheCode,
                    style: GoogleFonts.inter(
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w500,
                      color: AppColor.placeholderColor,
                    ),
                    children: [
                      TextSpan(
                        text: AppText.resend,
                        style: GoogleFonts.inter(
                          fontSize: width * 0.032,
                          fontWeight: FontWeight.w500,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
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
