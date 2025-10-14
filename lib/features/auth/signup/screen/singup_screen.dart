import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/components/Button/custom_button.dart';
import '../../../../core/components/apptext/inter_apptext.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../widget/header_widget.dart';
import '../provider/singup_provider.dart';
import '../../../../core/components/TextFeild/text_feild.dart';
import '../../../../core/constants/app_svg.dart';
import '../../../../core/components/Checkbox/custom_checkbox.dart';
import '../../../../core/routes/route_constant.dart';

class SingupScreen extends ConsumerWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final signupNotifier = ref.watch(signupProvider.notifier);

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: width * 0.05,
              children: [
                SizedBox(height: width * 0.0815),
                HeaderWidget(
                  title: AppText.createAccountTitle,
                  description: AppText.createAccountDescription,
                ),
                Form(
                  key: signupNotifier.formKey,
                  child: Column(
                    spacing: width * 0.05,
                    children: [
                      AppTextField(
                        controller: signupNotifier.emailController,
                        prefixIconImg: AppSvg.emailIcon,
                        validator: (value) =>
                            signupNotifier.validateEmail(value),
                        labelText: AppText.emailAddress,
                        focusNode: signupNotifier.emailFocusNode,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      AppTextField(
                        controller: signupNotifier.phoneController,
                        prefixIconImg: AppSvg.phoneIcon,
                        validator: (value) =>
                            signupNotifier.validatePhone(value),
                        labelText: AppText.phoneNumber,
                        focusNode: signupNotifier.phoneFocusNode,
                        keyboardType: TextInputType.number,
                      ),
                      AppTextField(
                        controller: signupNotifier.passwordController,
                        prefixIconImg: AppSvg.password,
                        isPassword: true,
                        validator: (value) =>
                            signupNotifier.validatePassword(value),
                        labelText: AppText.password,
                        focusNode: signupNotifier.passwordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      AppTextField(
                        controller: signupNotifier.confirmPasswordController,
                        isPassword: true,
                        prefixIconImg: AppSvg.password,
                        validator: (value) => signupNotifier.matchPassword(
                          value,
                          signupNotifier.passwordController.text,
                        ),
                        labelText: AppText.confirmPassword,
                        focusNode: signupNotifier.confirmPasswordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
                ),

                CustomCheckboxListTile(
                  value: signupNotifier.isAccepted,
                  onChanged: (value) {
                    signupNotifier.isAccepted = value ?? false;
                  },
                  // title: AppText.iAcceptThe,
                  subtitleWidget: InterApptext(
                    text: AppText.iAcceptTheDescription,
                    fontSize: width * 0.03,
                    fontWeight: FontWeight.w500,
                    color: AppColor.textGreyColor2,
                  ),
                  activeColor: AppColor.primaryColor,
                  checkColor: AppColor.white,
                  borderColor: AppColor.border,
                  borderRadius: 6,
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),

                CustomButton(
                  text: AppText.signUp,
                  color: AppColor.primaryColor,
                  textColor: AppColor.white,
                  fontSize: width * 0.046,
                  height: width * 0.16,
                  width: width,
                  borderRadius: 10,
                  borderColor: AppColor.primaryColor,
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    if (signupNotifier.formKey.currentState!.validate()) {
                      signupNotifier.formKey.currentState!.save();
                    }
                    context.pushNamed(RouteNames.aboutYourself);
                    //signupNotifier.signup();
                    // VerifyOtpSingupPop.show(
                    //   context,
                    //   signupNotifier.otpController,
                    // );
                  },
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColor.border,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: InterApptext(
                              text: AppText.or,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textGreyColor2,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColor.border,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: width * 0.05),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: width * 0.065,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // TODO: Google signup
                              //signupNotifier.googleSignup();
                            },
                            child: SvgPicture.asset(AppSvg.googleIcon),
                          ),
                          GestureDetector(
                            onTap: () {
                              // TODO: Apple signup
                            },
                            child: SvgPicture.asset(AppSvg.appleIcon),
                          ),
                          // SvgPicture.asset(AppSvg.appleIcon),
                        ],
                      ),
                    ],
                  ),
                ),

                Center(
                  child: Text.rich(
                    TextSpan(
                      text: AppText.alreadyHaveAnAccount,
                      style: GoogleFonts.inter(
                        fontSize: width * 0.032,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textGreyColor2,
                      ),
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              context.goNamed(RouteNames.login);
                            },
                            child: Text(
                              AppText.signIn,
                              style: GoogleFonts.inter(
                                fontSize: width * 0.032,
                                fontWeight: FontWeight.w500,
                                color: AppColor.primaryColor3,
                              ),
                            ),
                          ),
                        ),
                      ],
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
