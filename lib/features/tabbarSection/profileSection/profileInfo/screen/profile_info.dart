import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/features/tabbarSection/profileSection/profileInfo/screen/widget/profile_save_pop.dart';

import '../../../../../../core/components/apptext/urbanist_apptext.dart';
import '../../../../../../core/components/button/custom_button.dart';
import '../../../../../../core/components/apptext/poppins_apptext.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_images.dart';
import '../../../../../../core/constants/app_text.dart';
import '../../../../../../core/constants/app_svg.dart';
import '../../../../../../core/constants/enum.dart';
import '../../../../auth/widget/updated_sheet_popup.dart';
import '../provider/profile_info_provider.dart';
import 'widget/delete_account_profile.dart';
import 'widget/profileTextFiled_info.dart';

class ProfileInfoScreen extends ConsumerWidget {
  const ProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    // final height = MediaQuery.sizeOf(context).height;
    final state = ref.watch(profileInfoProvider);
    final notifier = ref.read(profileInfoProvider.notifier);
    return Scaffold(
      backgroundColor: AppColor.white,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: UrbanistApptext(
          text: AppText.personalInfo,
          fontWeight: FontWeight.w700,
          fontSize: width * (24 / width),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: AppColor.textBrownColor,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (24 / width)),
              child: Form(
                key: notifier.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: width * (10 / width),
                  children: [
                    SizedBox(height: width * (10 / width)),
                    Stack(
                      children: [
                        Container(
                          width: width * (207 / width),
                          height: width * (207 / width),
                          decoration: BoxDecoration(
                            //color: AppColor.redColor,
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
                          bottom: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              // Add your edit functionality here
                              print('Edit profile picture tapped');
                            },
                            child: Container(
                              width: width * (40 / width),
                              height: width * (40 / width),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColor.white,
                                  width: 1.0,
                                ),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: AppColor.black,
                                size: width * (20 / width),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    ProfileTextFiledInfo(
                      label: AppText.name,
                      hint: AppText.name,
                      controller: notifier.nameController,
                      keyboardType: TextInputType.name,
                    ),
                    ProfileTextFiledInfo(
                      label: AppText.email,
                      hint: AppText.email,
                      controller: notifier.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    ProfileTextFiledInfo(
                      label: AppText.phone,
                      hint: AppText.phone,
                      controller: notifier.phoneController,
                      keyboardType: TextInputType.phone,
                    ),

                    SizedBox(height: width * (50 / width)),
                    CustomButton(
                      text: AppText.save,
                      color: AppColor.primaryColor,
                      textColor: AppColor.white,
                      fontSize: width * (18 / width),
                      fontWeight: FontWeight.w600,
                      borderRadius: width * (10 / width),
                      borderColor: AppColor.primaryColor,
                      elevation: 5,
                      height: width * (56 / width),
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

                    SizedBox(height: width * (12 / width)),
                    GestureDetector(
                      onTap: () {
                        DeleteAccountProfilePopup.show(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: AppColor.redColor),
                          PoppinsApptext(
                            text: AppText.deleteAccount,
                            fontSize: width * (18 / width),
                            fontWeight: FontWeight.w600,
                            color: AppColor.redColor,
                            textDecoration: TextDecoration.underline,
                            textDecorationColor: AppColor.redColor,
                            textDecorationThickness: 2.0,
                          ),
                        ],
                      ),
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
