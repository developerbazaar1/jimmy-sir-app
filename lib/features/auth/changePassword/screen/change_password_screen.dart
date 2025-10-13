import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/features/auth/widget/header_widget.dart';
import '../../../../core/components/Button/custom_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_svg.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/components/TextFeild/text_feild.dart';
import '../../../../core/constants/enum.dart';
import '../../widget/updated_sheet_popup.dart';
import '../providers/change_password_providers.dart';

class ChangePasswordScreen extends ConsumerWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final changePasswordNotifier = ref.watch(changePasswordProvider.notifier);

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

                AppTextField(
                  controller: changePasswordNotifier.newPasswordController,
                  labelText: AppText.newPassword,
                  prefixIconImg: AppSvg.password,
                  isPassword: true,
                  fontSize: width * 0.036,
                  labelFontSize: width * 0.036,
                  validator: (value) =>
                      changePasswordNotifier.validateNewPassword(value),
                ),
                SizedBox(height: height * 0.02),
                AppTextField(
                  controller: changePasswordNotifier.confirmPasswordController,
                  labelText: AppText.confirmPassword,
                  prefixIconImg: AppSvg.password,
                  isPassword: true,
                  fontSize: width * 0.036,
                  labelFontSize: width * 0.036,
                  validator: (value) =>
                      changePasswordNotifier.validateConfirmPassword(value),
                ),
                SizedBox(height: height * 0.06),
                CustomButton(
                  text: AppText.updatePassword,
                  fontSize: width * 0.046,
                  height: width * 0.14,
                  width: width,
                  fontWeight: FontWeight.w600,
                  borderRadius: 10,
                  borderColor: AppColor.primaryColor,
                  onPressed: () => {
                    changePasswordNotifier.changePassword(
                      changePasswordNotifier.newPassword,
                    ),
                    BottomSheetPopUp.show(
                      context,
                      VerifyOtpType.changePasswordOtp,
                    ),
                  },

                  color: AppColor.primaryColor,
                  textColor: AppColor.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
