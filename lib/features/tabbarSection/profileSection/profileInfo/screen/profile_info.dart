import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/TextFeild/text_feild.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/features/tabbarSection/profileSection/profileInfo/screen/widget/profile_save_pop.dart';

import '../../../../../../core/components/button/custom_button.dart';
import '../../../../../../core/components/apptext/poppins_apptext.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_text.dart';
import '../../../../../../core/constants/app_svg.dart';
import '../provider/profile_info_provider.dart';
import 'widget/delete_account_profile.dart';

class ProfileInfoScreen extends ConsumerWidget {
  const ProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    // final height = MediaQuery.sizeOf(context).height;
    // final state = ref.watch(profileInfoProvider);
    final notifier = ref.read(profileInfoProvider.notifier);
    return Scaffold(
      backgroundColor: AppColor.white,
      extendBodyBehindAppBar: false,
      appBar: CustomAppBar2(
        title: AppText.personalInfo,
        fontSize: width * (24 / width),
        onBackTap: () => context.pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (24 / width)),
              child: Form(
                key: notifier.formKey,
                child: Column(
                  children: [
                    SizedBox(height: width * .045),
                    Stack(
                      children: [
                        Container(
                          width: width * .4,
                          height: width * .4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              width * (207 / width),
                            ),
                            border: Border.all(
                              color: AppColor.primaryColor,
                              width: 1.0,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              width * (207 / width),
                            ),
                            child: Image.network(
                              "https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                              width: width * (207 / width),
                              height: width * (207 / width),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  AppSvg.profilePicIcon,
                                  width: width * (207 / width),
                                  height: width * (207 / width),
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: width * .01,
                          right: width * .01,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: width * .075,
                              height: width * .075,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColor.white,
                                  width: 1.0,
                                ),
                              ),
                              child: SvgPicture.asset(
                                AppSvg.editIcon,
                                height: width * .05,
                                width: width * .05,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: width * .045),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UrbanistApptext(
                          text: "Name",
                          fontSize: width * 0.042,
                          fontWeight: FontWeight.w600,
                          color: AppColor.black,
                        ),
                        SizedBox(height: width * .02),
                        AppTextField(
                          fontSize: width * .036,
                          hint: AppText.name,
                          controller: notifier.nameController,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: width * .05),

                        UrbanistApptext(
                          text: "Email Address",
                          fontSize: width * 0.042,
                          fontWeight: FontWeight.w600,
                          color: AppColor.black,
                        ),
                        SizedBox(height: width * .02),

                        AppTextField(
                          fontSize: width * .036,
                          hint: AppText.emailAddress,
                          controller: notifier.emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: width * .05),

                        UrbanistApptext(
                          text: "Phone Number",
                          fontSize: width * 0.042,
                          fontWeight: FontWeight.w600,
                          color: AppColor.black,
                        ),
                        SizedBox(height: width * .02),

                        AppTextField(
                          fontSize: width * .036,
                          hint: AppText.phone,
                          controller: notifier.phoneController,
                          keyboardType: TextInputType.number,
                        ),

                        SizedBox(height: width * .2),
                        CustomButton(
                          text: AppText.save,
                          color: AppColor.primaryColor,
                          textColor: AppColor.white,
                          fontSize: width * .042,
                          fontWeight: FontWeight.w600,
                          borderRadius: width * .035,
                          borderColor: AppColor.primaryColor,
                          height: width * .13,
                          onPressed: () {
                            if (notifier.formKey.currentState!.validate()) {
                              notifier.formKey.currentState!.save();
                            }
                            notifier.submitProfileInfoData();
                            ProfileSavePopUp.show(
                              context,
                              AppText.profileInfoUpdatedSuccessfully,
                            );
                          },
                        ),

                        SizedBox(height: width * .06),
                        GestureDetector(
                          onTap: () {
                            DeleteAccountProfilePopup.show(context);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(AppSvg.deleteAccount),
                              SizedBox(width: width * .01),
                              PoppinsApptext(
                                text: AppText.deleteAccount,
                                fontSize: width * .035,
                                fontWeight: FontWeight.w600,
                                color: AppColor.redColor,
                                textDecoration: TextDecoration.underline,
                                textDecorationColor: AppColor.redColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
