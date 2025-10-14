import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
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
      appBar: CustomAppBar2(
        title: AppText.lifeStyle,
        fontSize: width * 0.055,
        onBackTap: () {
          if (state.currentStep == 0) {
            context.pop();
          } else {
            notifier.prevStep();
          }
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: width * 0.03),

              SizedBox(height: width * 0.03),
              UrbanistApptext(
                text: currentStepData.title,
                fontSize: width * 0.05,
                color: AppColor.textBrownColor,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: width * 0.03),
              Expanded(
                child: ListView(
                  children: [
                    ...List.generate(currentStepData.options.length, (index) {
                      final option = currentStepData.options[index];
                      return CommonSelectableContainer(
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
