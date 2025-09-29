import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import 'package:jimmy_sir_app/features/registeration/models/lifestyle_model.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/common_SelectableContainer.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/common_progressIndicator.dart';
import 'package:jimmy_sir_app/features/registeration/providers/lifestyle_Provider.dart';

class LifestyleScreen1 extends ConsumerWidget {
  const LifestyleScreen1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final state = ref.watch(lifestyleProvider);
    final notifier = ref.read(lifestyleProvider.notifier);

    final currentStepData = lifestyleSteps[state.currentStep];

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar(
        title: AppText.currentLifeStyle,
        showBack: true,
        onBackTap: () {
          if (state.currentStep == 0) {
            context.pop();
          } else {
            notifier.prevStep();
          }
        },
        showSkip: true,
        onSkipTap: () {
          context.pushNamed(RouteNames.allergiesScreen);
          // handle
        },
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
                step: state.currentStep,
                totalSteps: lifestyleSteps.length,
              ),
              SizedBox(height: height * 0.03),
              UrbanistApptext(
                text: currentStepData.title,
                fontSize: width * 0.05,
                color: AppColor.textBrownColor,
                fontWeight: FontWeight.w500,
              ),

              SizedBox(height: height * 0.02),
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
                    ? "Next"
                    : "Next",
                onPressed: () {
                  if (state.currentStep < lifestyleSteps.length - 1) {
                    notifier.nextStep(lifestyleSteps.length);
                  } else {
                    context.pushNamed(RouteNames.allergiesScreen);
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
