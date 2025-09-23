import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/common_progressIndicator.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/foodallergies_widgest.dart';

class AllergiesScreen1 extends ConsumerWidget {
  const AllergiesScreen1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar(
        title: AppText.allergiesAndRestrictions,
        showBack: true,
        onBackTap: () {},
        showSkip: true,
        onSkipTap: () {},
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),

              CommonProgressIndicator2(
                barWidth: width * 0.11,
                barHeight: height * 0.009,
                step: 0,
                totalSteps: 5,
              ),
              SizedBox(height: height * 0.02),

              UrbanistApptext(
                text: AppText.foodAllergies,
                fontSize: width * 0.05,
                color: AppColor.textBrownColor,
                fontWeight: FontWeight.w600,
              ),

              FoodAllergyWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
