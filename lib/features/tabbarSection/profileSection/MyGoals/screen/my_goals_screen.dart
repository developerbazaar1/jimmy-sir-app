import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_text.dart';
import '../../../../../core/components/Button/custom_button.dart';
import '../../../../../core/components/apptext/urbanist_apptext.dart';
import '../../../../registeration/presentation/screens/PersonalGoal/personalgoal_screen.dart';
import '../../../../registeration/providers/personalgoal_provider.dart';
import '../../profileInfo/screen/widget/profile_save_pop.dart';

class MyGoalsScreen extends ConsumerWidget {
  MyGoalsScreen({super.key});
  final goals = [
    {
      'title': 'Improve Sleep',
      'description':
          'Build habits that help you fall asleep faster and wake up refreshed.',
    },
    {
      'title': 'Increase Hydration',
      'description':
          'Stay energized and healthy by drinking enough water daily.',
    },
    {
      'title': 'Manage Weight',
      'description':
          'Achieve and maintain a healthy body weight through balanced choices.',
    },
    {
      'title': 'Boost Energy',
      'description': 'Feel more active and alert throughout your day.',
    },
    {
      'title': 'Improve Fitness',
      'description': 'Enhance strength, endurance, and overall fitness.',
    },
    {
      'title': 'Boost ',
      'description': 'Feel more active and alert throughout your day.',
    },
    {
      'title': ' Fitness',
      'description': 'Enhance strength, endurance, and overall fitness.',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final selectedGoals = ref.watch(personalGoalProvider);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar2(
        title: AppText.myGoalsTitle,
        fontSize: width * 0.055,
        onBackTap: () => context.pop(),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: height * 0.01),

              UrbanistApptext(
                text: "Focus areas (choose up to 3)",
                fontSize: width * 0.045,
                color: AppColor.black,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: height * 0.02),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: goals.map((goal) {
                      //   final selectedGoals = ref.watch(myGoalsProvider);
                      final isSelected = selectedGoals.contains(goal['title']!);

                      return CommonSelectableContainer(
                        title: goal['title']!,
                        description: goal['description'],
                        isSelected: isSelected,
                        onTap: () => ref
                            .read(personalGoalProvider.notifier)
                            .toggleGoal(goal['title']!),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),

              CustomButton(
                text: AppText.save,
                color: AppColor.primaryColor,
                textColor: AppColor.white,
                fontSize: width * 0.046,
                height: width * 0.13,
                width: width,
                borderRadius: 10,
                borderColor: AppColor.primaryColor,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  ProfileSavePopUp.show(
                    context,
                    AppText.myGoalsUpdatedSuccessfully,
                  );
                  // context.pushNamed(RouteNames.membershipscreen);
                },
              ),
              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
