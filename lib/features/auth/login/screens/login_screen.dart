import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';

import '../../../../core/components/TextFeild/text_feild.dart';
import '../../../../core/components/apptext/inter_apptext.dart';
import '../../../../core/components/apptext/plus_jakarta_sans.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/routes/route_constant.dart';
import '../../widget/header_widget.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  String emailOrPhone = '';
  String password = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final authNotifier = ref.watch(authProvider.notifier);

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: width * 0.0815),
                HeaderWidget(
                  title: AppText.welcomeBack,
                  description: AppText.welcomeBackDescription,
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email or Phone
                      AppTextField(
                        controller: _emailController,
                        prefixIconImg: AppSvg.emailIcon,
                        labelText: "Email Address / Phone Number",
                        focusNode: _emailFocusNode,
                        fontSize: width * 0.036,
                        labelFontSize: width * 0.036,
                        validator: (val) => val!.isEmpty
                            ? 'Please enter your email address and phone number'
                            : null,
                      ),
                      SizedBox(height: width * 0.0612),
                      // Password
                      AppTextField(
                        controller: _passwordController,
                        prefixIconImg: AppSvg.password,
                        labelText: "Password",
                        isPassword: true,
                        focusNode: _passwordFocusNode,
                        fontSize: width * 0.036,
                        labelFontSize: width * 0.036,
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter your password' : null,
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: width * 0.016),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: forgot password
                      context.goNamed(RouteNames.forgotPassword);
                    },
                    child: InterApptext(
                      text: AppText.forgotPassword,
                      fontSize: width * 0.036,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor,
                    ),
                  ),
                ),
                SizedBox(height: width * 0.14),
                CustomButton(
                  text: AppText.signIn,
                  color: AppColor.primaryColor,
                  textColor: AppColor.white,
                  fontSize: width * 0.046,
                  height: width * 0.13,
                  width: width,
                  borderRadius: 10,
                  borderColor: AppColor.primaryColor,
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      authNotifier.login(
                        _emailController.text,
                        _passwordController.text,
                      );
                      // TODO: Call login logic here
                    }
                  },
                ),
                SizedBox(height: width * 0.0204),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: AppText.newHere,
                      style: GoogleFonts.inter(
                        fontSize: width * 0.032,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textGreyColor2,
                      ),
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              context.goNamed(RouteNames.signup);
                            },
                            child: Text(
                              AppText.signUp,
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
