import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/features/registeration/models/quid_model.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/common_selectable_container.dart';
import 'package:jimmy_sir_app/features/registeration/providers/quiz_screen_provider.dart';

import '../../../../../core/constants/app_text.dart';
import '../../profileInfo/screen/widget/profile_save_pop.dart';

class RetakeQuizScreen extends ConsumerWidget {
  const RetakeQuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quizProvider);
    final notifier = ref.read(quizProvider.notifier);

    final step = quizSteps[state.currentStep];
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar(
        title: "",
        showBack: true,
        onBackTap: () {
          if (state.currentStep == 0) {
            context.pop();
          } else {
            notifier.previousStep();
          }
        },
        showSkip: false,
        onSkipTap: () {},
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              UrbanistApptext(
                text: step.title,
                fontSize: width * 0.05,
                color: AppColor.textBrownColor,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: height * 0.03),

              if (state.currentStep == 1)
                Column(
                  children: [
                    RangeSlider(
                      activeColor: AppColor.borderGreenLight,
                      inactiveColor: AppColor.textGreyColor.withOpacity(0.1),
                      values: RangeValues(state.sittingStart, state.sittingEnd),
                      min: 1,
                      max: 12,
                      divisions: 12,
                      onChanged: (RangeValues values) {
                        notifier.updateSlider(values);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UrbanistApptext(
                            text: "${state.sittingStart.round()} hrs",
                            fontSize: width * 0.04,
                            color: AppColor.textBrownColor,
                            fontWeight: FontWeight.w500,
                          ),
                          UrbanistApptext(
                            text: "${state.sittingEnd.round()} hrs",
                            fontSize: width * 0.04,
                            color: AppColor.textBrownColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: step.options
                      .map(
                        (option) => Padding(
                          padding:  EdgeInsets.only(bottom: width * 0.02),
                          child: CommonSelectableContainer1(
                            title: option.label,
                            isSelected:
                                state.selections[state.currentStep] ==
                                option.label,
                            onTap: () {
                              notifier.selectOption(
                                state.currentStep,
                                option.label,
                              );
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),

              const Spacer(),

              CustomButton(
                text: state.currentStep == quizSteps.length - 1
                    ? "Finish"
                    : "Next",
                color: AppColor.primaryColor,
                textColor: AppColor.white,
                fontSize: width * 0.046,
                height: width * 0.13,
                width: width,
                borderRadius: width * 0.025,
                borderColor: AppColor.primaryColor,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  if (state.currentStep < quizSteps.length - 1) {
                    notifier.nextStep();
                  } else {
                    ProfileSavePopUp.show(
                      context,
                      AppText.retakeQuizUpdatedSuccessfully,
                    );
                  }
                },
              ),
              SizedBox(height: width * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
