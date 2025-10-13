import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../My Subscription/screen/my_subscription_screen.dart';
import '../../../../../core/constants/app_svg.dart';
import '../../../../../core/constants/app_text.dart';
import '../../../../../core/routes/route_constant.dart';
import 'widget/profile_header.dart';
import '../provider/profile_provider.dart';
import 'widget/profile_sections.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final state = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    final profileNotifier = ref.watch(profileProvider.notifier);
    final profileState = ref.watch(profileProvider);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              SizedBox(height: width * (16 / width)),
              ProfileSettingsHeader(),
              SizedBox(height: width * (16 / width)),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    ProfileSections(
                      title: AppText.personalInfo,
                      icon: AppSvg.personalInfoIcon,
                      onTap: () {
                        context.push(RoutePaths.profileInfo);
                      },
                    ),
                    ProfileSections(
                      title: AppText.myGoals,
                      icon: AppSvg.myGoalsIcon,
                      onTap: () {
                        context.push(RoutePaths.myGoals);
                      },
                    ),

                    ProfileSections(
                      title: AppText.wellnessPreferences,
                      icon: AppSvg.wellnessPreferencesIcon,
                      onTap: () {
                        context.push(RoutePaths.wellnessPreferences);
                      },
                    ),

                    ProfileSections(
                      title: AppText.mySubscriptions,
                      icon: AppSvg.mySubscriptionsIcon,
                      onTap: () {
                        context.push(RoutePaths.mySubscription);
                      },
                    ),

                    // ProfileSections(
                    //   title: AppText.bankAccountDetails,
                    //   icon: AppSvg.bankAccountDetailsIcon,
                    //   onTap: () {},
                    // ),
                    ProfileSections(
                      title: AppText.changePassword,
                      icon: AppSvg.changePasswordIcon,
                      onTap: () {
                        context.push(RoutePaths.changePassword2);
                      },
                    ),

                    ProfileSections(
                      title: AppText.notificationSettings,
                      icon: AppSvg.notificationSettingsIcon,
                      onTap: () {
                        context.push(RoutePaths.notificationSettings);
                      },
                    ),

                    ProfileSections(
                      title: AppText.helpAndSupport,
                      icon: AppSvg.helpAndSupportIcon,
                      onTap: () {
                        context.push(RoutePaths.helpAndSupport);
                      },
                    ),

                    ProfileSections(
                      title: AppText.termsAndConditions,
                      icon: AppSvg.termsAndConditionsIcon,
                      onTap: () {
                        context.push(RoutePaths.termsAndConditions);
                      },
                    ),

                    ProfileSections(
                      title: AppText.privacyPolicy,
                      icon: AppSvg.privacyPolicyIcon,
                      onTap: () {
                        context.push(RoutePaths.privacyPolicy);
                      },
                    ),

                    ProfileSections(
                      title: AppText.logOut,
                      icon: AppSvg.logOutIcon,
                      color: AppColor.primaryColor,
                      onTap: () {},
                    ),

                    ProfileSections(
                      title: AppText.deleteAccount,
                      icon: AppSvg.deleteAccountIcon,
                      color: AppColor.redColor,

                      onTap: () {},
                    ),

                    SizedBox(height: width * (60 / width)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
