import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import 'package:jimmy_sir_app/features/registeration/providers/personalgoal_provider.dart';

class PersonalGoalScreen extends ConsumerWidget {
  PersonalGoalScreen({super.key});
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
    // final selectedGoals = ref.watch(personalGoalProvider);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColor.primaryColor.withOpacity(0.5),
              AppColor.white.withOpacity(0.3),
              AppColor.secondaryColor.withOpacity(0.5),
            ],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColor.primaryColor.withOpacity(0.5),
                AppColor.white.withOpacity(0.3),
                AppColor.secondaryColor.withOpacity(0.5),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: SvgPicture.asset(
                              AppSvg.arrowLeftIcon,
                              height: height * 0.03,
                              width: width * 0.02,
                            ),
                          ),
                          SizedBox(width: width * 0.01),
                          UrbanistApptext(
                            textAlign: TextAlign.center,
                            text: AppText.personalGoal,
                            fontWeight: FontWeight.w700,
                            color: AppColor.textBrownColor,
                            fontSize: width * 0.055,
                          ),
                        ],
                      ),

                      /// Skip Button
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(RouteNames.membershipscreen);
                        },
                        child: UrbanistApptext(
                          textAlign: TextAlign.center,
                          text: AppText.skip,
                          fontWeight: FontWeight.w500,
                          color: AppColor.textGreyColor3,
                          fontSize: width * 0.038,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.00),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.06),
                            color: AppColor.primaryColor,
                          ),
                          width: width * 0.2116,
                          height: height * 0.00858,
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.06),
                            color: AppColor.primaryColor,
                          ),
                          width: width * 0.2116,
                          height: height * 0.00858,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.06),
                            color: AppColor.primaryColor,
                          ),
                          width: width * 0.2116,
                          height: height * 0.00858,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.06),
                            color: AppColor.primaryColor,
                          ),
                          width: width * 0.2116,
                          height: height * 0.00858,
                        ),
                      ],
                    ),
                  ),

                  UrbanistApptext(
                    text: "Focus areas (choose up to 3)",
                    fontSize: width * 0.045,
                    color: AppColor.textBrownColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: height * 0.02),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: goals.map((goal) {
                          final selectedGoals = ref.watch(personalGoalProvider);
                          final isSelected = selectedGoals.contains(
                            goal['title']!,
                          );

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
                    text: AppText.next,
                    color: AppColor.primaryColor,
                    textColor: AppColor.white,
                    fontSize: width * 0.046,
                    height: width * 0.13,
                    width: width,
                    borderRadius: 10,
                    borderColor: AppColor.primaryColor,
                    fontWeight: FontWeight.w600,
                    onPressed: () {
                      context.pushNamed(RouteNames.membershipscreen);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommonSelectableContainer extends StatelessWidget {
  final String title;
  final String? description;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const CommonSelectableContainer({
    super.key,
    required this.title,
    this.description,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: width * 0.03),
        padding: EdgeInsets.symmetric(
          vertical: width * 0.035,
          horizontal: width * 0.04,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(
            color: isSelected ? AppColor.borderGreenLight : Colors.transparent,
            width: 1.5,
          ),
          color: isSelected
              ? AppColor.borderGreenLight.withAlpha((.06 * 255).round())
              : AppColor.white,
          boxShadow: !isSelected
              ? [
                  BoxShadow(
                    color: Colors.grey.withAlpha((0.2 * 255).round()),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UrbanistApptext(
                    text: title,
                    fontSize: width * 0.04,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: AppColor.textBrownColor,
                  ),
                  if (description != null) SizedBox(height: width * 0.01),
                  if (description != null)
                    UrbanistApptext(
                      text: description!,
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textGreyColor3,
                    ),
                ],
              ),
            ),
            SizedBox(width: width * 0.02),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColor.greenColor : AppColor.textGreyColor3,
            ),
          ],
        ),
      ),
    );
  }
}
