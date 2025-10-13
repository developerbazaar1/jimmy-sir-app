import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import '../../../../../core/components/Button/custom_button.dart';
import '../../../../../core/components/apptext/urbanist_apptext.dart';
import '../../../../registeration/presentation/widgets/foodallergies_widgest.dart';
import '../../../../registeration/providers/allergies_Provider.dart';
import '../../profileInfo/screen/widget/profile_save_pop.dart';

class AllergiesRestrictionsScreen extends ConsumerWidget {
  const AllergiesRestrictionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final allergies = ref.watch(allergyProvider);
    final step = allergies['step'] as int;
    final sections = allergies['sections'] as List;
    final section = sections[step];
    final notifier = ref.read(allergyProvider.notifier);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: UrbanistApptext(
          text: AppText.allergiesRestrictions,
          fontSize: width * (20 / width),
          fontWeight: FontWeight.w700,
          color: AppColor.black,
        ),
        backgroundColor: AppColor.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColor.black),
          onPressed: () {
            if (step == 0) {
              context.pop();
            } else {
              ref.read(allergyProvider.notifier).previousStep();
            }
          },
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              text: step == sections.length - 1 ? AppText.save : AppText.next,
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
                  ProfileSavePopUp.show(
                    context,
                    AppText.allergiesRestrictionsUpdatedSuccessfully,
                  );

                  // debugPrint("Allergy flow finished: $allergies");
                  // context.pushNamed(RouteNames.personalGoal);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
