import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/components/Button/custom_button.dart';
import '../../../../core/components/TextFeild/text_feild.dart';
import '../../../../core/components/apptext/inter_apptext.dart';
import '../../../../core/components/apptext/plus_jakarta_sans.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_svg.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/routes/route_constant.dart';
import '../../widget/header_widget.dart';
import '../providers/forgot_password_providers.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  ForgotPasswordScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final forgotPasswordNotifier = ref.watch(forgotPasswordProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: width * 0.0815),
                HeaderWidget(
                  title: AppText.forgotPasswordTitle,
                  description: AppText.forgotPasswordDescription,
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
                    ],
                  ),
                ),
                SizedBox(height: width * 0.142),
                CustomButton(
                  text: AppText.sendOTP,
                  color: AppColor.primaryColor,
                  textColor: AppColor.white,
                  height: width * 0.13,
                  width: width,
                  borderRadius: 10,
                  borderColor: AppColor.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: width * 0.046,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // _formKey.currentState!.save();
                      context.pushNamed(RouteNames.verifyOTP);
                      // forgotPasswordNotifier.forgetPassword(
                      //   _emailController.text,
                      // );
                      // forgotPasswordNotifier.state.isLoading
                      //     ? const Center(child: CircularProgressIndicator())
                      //     : forgotPasswordNotifier.state.error != null
                      //     ? Center(
                      //         child: Text(forgotPasswordNotifier.state.error!),
                      //       )
                      //     : context.pushNamed(RouteNames.verifyOTP);
                      // TODO: Call send OTP logic here
                    }
                  },
                ),
                // SizedBox(height: width * 0.0204),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // context.canPop();
                      context.pushNamed(RouteNames.login);
                    },
                    child: InterApptext(
                      text: AppText.backToLogin,
                      fontSize: width * 0.036,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textGreyColor2,
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
