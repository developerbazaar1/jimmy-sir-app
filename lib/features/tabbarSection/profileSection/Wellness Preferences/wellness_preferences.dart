import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import 'package:jimmy_sir_app/features/tabbarSection/profileSection/Wellness%20Preferences/widget/wellness_preferences_widget.dart';

class WellnessPreferences extends ConsumerWidget {
  const WellnessPreferences({super.key});

  final List<dynamic> wellnessPreferences = const [
    {
      'title': 'Body Metrics',
      'keys': ["Age", "Gender", "Height", "Weight"],
    },
    {
      'title': 'Lifestyle',
      'keys': ["Work Style", "Routine", "Exercise", "Diet", "Stress"],
    },
    {
      'title': 'Allergies',
      'keys': ["Food", "Severity", "Intolerances", "Medication", "Environment"],
    },
    {
      'title': 'Retake Quiz',
      'keys': ["Retake the quiz to keep your plan up to date."],
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: UrbanistApptext(
          text: AppText.wellnessPreferences,
          fontSize: width * (24 / width),
          fontWeight: FontWeight.w700,
          color: AppColor.black,
        ),
        backgroundColor: AppColor.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back_ios_new, color: AppColor.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                UrbanistApptext(
                  text: AppText.bodyMetricsMsg,
                  fontSize: width * (20 / width),
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                ),

                SizedBox(height: width * 0.02),

                ...List.generate(wellnessPreferences.length, (index) {
                  final item = wellnessPreferences[index];
                  return GestureDetector(
                    onTap: () {
                      if (item['title'] == 'Body Metrics') {
                        context.pushNamed(RouteNames.bodyMetrics);
                      } else if (item['title'] == 'Lifestyle') {
                        context.pushNamed(RouteNames.lifeStyle);
                      } else if (item['title'] == 'Allergies') {
                        context.pushNamed(RouteNames.allergiesRestrictions);
                      } else if (item['title'] == 'Retake Quiz') {
                        context.pushNamed(RouteNames.retakeQuizWelcome);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: width * (16 / width)),
                      child: WellnessPreferencesWidget(
                        title: item['title'],
                        keys: item['keys'],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
