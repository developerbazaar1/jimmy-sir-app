import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/components/Button/custom_button.dart';
import '../../../../../core/components/TextFeild/text_feild.dart';
import '../../../../../core/components/apptext/urbanist_apptext.dart';
import '../../../../../core/components/customAppbar/CustomAppBar.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_svg.dart';
import '../../../../../core/constants/app_text.dart';
import '../provider/change_password2_provider.dart';

class ChangePasswordScreen2 extends ConsumerWidget {
  ChangePasswordScreen2({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final state = ref.watch(changePasswordProvider);
    final changePasswordNotifier = ref.watch(changePasswordProvider.notifier);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar2(
        title: AppText.changePassword,
        onBackTap: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
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
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: CustomButton(
            text: state.isLoading ? "Please wait..." : AppText.save,

            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(width * 0.055),
                    ),
                  ),
                  builder: (context) {
                    Future.delayed(const Duration(seconds: 2), () {
                      if (context.mounted) {
                        Navigator.pop(context); // Close BottomSheet
                        context.pop(); // Close the page
                      }
                    });

                    return SafeArea(
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.06),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppSvg.imgChangePSfully,
                              width: width * 0.31,
                              height: width * 0.31,
                            ),
                            SizedBox(height: width * 0.04),
                            const UrbanistApptext(
                              text: 'Account details updated successfully',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                // ❌ Invalid fields — show error feedback
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please fix the errors before saving."),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
            color: AppColor.primaryColor,
            textColor: AppColor.white,
            borderRadius: 15,
          ),
        ),
      ),
    );
  }
}
