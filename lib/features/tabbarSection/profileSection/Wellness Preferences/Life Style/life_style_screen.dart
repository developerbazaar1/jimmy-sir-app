import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/features/tabbarSection/profileSection/profileInfo/screen/widget/profile_save_pop.dart';
import '../../../../../core/components/Button/custom_button.dart';
import '../../../../registeration/models/lifestyle_model.dart';
import '../../../../registeration/presentation/screens/PersonalGoal/personalgoal_screen.dart';
import '../../../../registeration/providers/lifestyle_Provider.dart';

class LifeStyleScreen extends ConsumerWidget {
  const LifeStyleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final state = ref.watch(lifestyleProvider);
    final notifier = ref.read(lifestyleProvider.notifier);
    final currentStepData = lifestyleSteps[state.currentStep];
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: UrbanistApptext(
          text: AppText.lifeStyle,
          fontSize: width * 0.055,
          fontWeight: FontWeight.w700,
          color: AppColor.black,
        ),
        backgroundColor: AppColor.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            if (state.currentStep == 0) {
              context.pop();
            } else {
              notifier.prevStep();
            }
          },
          child: Icon(Icons.arrow_back_ios_new, color: AppColor.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * (24 / width)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: width * 0.03),
              UrbanistApptext(
                text: currentStepData.title,
                fontSize: width * 0.05,
                color: AppColor.textBrownColor,
                fontWeight: FontWeight.w500,
              ),

              SizedBox(height: width * 0.02),
              Expanded(
                child: ListView(
                  children: [
                    ...List.generate(currentStepData.options.length, (index) {
                      final option = currentStepData.options[index];
                      return commonSelectableContainer(
                        title: option.label,
                        description: option.desc,
                        isSelected:
                            state.selections[state.currentStep] == option.label,
                        onTap: () => notifier.selectOption(
                          state.currentStep,
                          option.label,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              CustomButton(
                height: width * 0.13,
                width: width,
                borderRadius: 15,
                text: state.currentStep == lifestyleSteps.length - 1
                    ? AppText.save
                    : AppText.next,
                onPressed: () {
                  if (state.currentStep < lifestyleSteps.length - 1) {
                    notifier.nextStep(lifestyleSteps.length);
                  } else {
                    //context.pushNamed(RouteNames.allergiesScreen);
                    ProfileSavePopUp.show(
                      context,
                      AppText.lifeStyleUpdatedSuccessfully,
                    );
                  }
                },
                color: AppColor.primaryColor,
                textColor: Colors.white,
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
