import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_outline_border_button.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/freezelottie_widget.dart';
import 'package:lottie/lottie.dart';

class WelcomeQuizScreen extends ConsumerWidget {
  const WelcomeQuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

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
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.02),

                //  Freeze Lottie
                const Center(child: FreezedLottie()),

                SizedBox(height: height * 0.06),
                Center(
                  child: UrbanistApptext(
                    text: AppText.welcomeToEliteQuiz + " Jamie!",
                    fontSize: width * 0.06,
                    color: AppColor.textBrownColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: height * 0.01),
                UrbanistApptext(
                  text: AppText.welcomeToEliteQuizDescription,
                  fontSize: width * 0.04,
                  textAlign: TextAlign.center,
                  color: AppColor.textGreyColor2,
                  fontWeight: FontWeight.w500,
                  maxLines: 5,
                ),
                SizedBox(height: height * 0.05),
                CustomButton(
                  onPressed: () {
                    context.pushNamed(RouteNames.quizScreens);
                  },
                  borderRadius: width * 0.03,
                  text: AppText.startQuiz,
                  fontSize: width * 0.04,
                  textColor: AppColor.white,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primaryColor,
                ),
                SizedBox(height: height * 0.02),
                CustomOutlineBorderButton(
                  text: AppText.skipForNow,
                  onPressed: () {
                    context.pushNamed(RouteNames.welcomeScreen);
                  },
                  borderRadius: width * 0.03,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
