import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/common_progressIndicator.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/foodallergies_widgest.dart';
import 'package:jimmy_sir_app/features/registeration/providers/allergies_Provider.dart';

class AllergiesScreen1 extends ConsumerWidget {
  const AllergiesScreen1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final allergies = ref.watch(allergyProvider);
    final step = allergies['step'] as int;
    final sections = allergies['sections'] as List;
    final section = sections[step];

    // Resolve title depending on type
    String title = '';
    if (section is Map<String, dynamic>) {
      title = section['title'] as String;
    } else if (section is FoodAllergyStep) {
      title = section.title;
    }

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar(
        title: AppText.allergiesAndRestrictions,
        showBack: true,
        onBackTap: () {
          if (step == 0) {
            context.pop();
          } else {
            ref.read(allergyProvider.notifier).previousStep();
          }
        },

        showSkip: true,
        // onSkipTap: () => ref.read(allergyProvider.notifier).nextStep(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.02),

                CommonProgressIndicator2(
                  barWidth: width * 0.11,
                  barHeight: height * 0.009,
                  step: step,
                  totalSteps: sections.length,
                ),
                SizedBox(height: height * 0.02),

                UrbanistApptext(
                  text: section is Map<String, dynamic>
                      ? section['title'] as String
                      : section is FoodAllergyStep
                      ? section.title
                      : 'Medication & Supplement Allergies',
                  fontSize: width * 0.044,
                  color: AppColor.textBrownColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: height * 0.01),

                FoodAllergyWidget(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.05,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: step == sections.length - 1 ? "Next" : AppText.next,
              color: AppColor.primaryColor,
              textColor: AppColor.white,
              fontSize: width * 0.046,
              height: width * 0.13,
              width: width,
              borderRadius: 10,
              borderColor: AppColor.primaryColor,
              fontWeight: FontWeight.w600,
              onPressed: () {
                if (step < sections.length - 1) {
                  ref.read(allergyProvider.notifier).nextStep();
                } else {
                  // debugPrint("Allergy flow finished: $allergies");
                  context.pushNamed(RouteNames.personalGoal);
                }
              },
            ),
            SizedBox(height: height * 0.05),
          ],
        ),
      ),
    );
  }
}
