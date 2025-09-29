import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/freezelottie_widget.dart';
import 'package:jimmy_sir_app/features/registeration/providers/welcom_provider.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    final animation = ref.watch(welcomeAnimationProvider(this));

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
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.09),
                const Center(child: FreezedLottie()),
                SizedBox(height: height * 0.01),

                /// Animated Text + Subtitle
                FadeTransition(
                  opacity: animation.fadeText,
                  child: ScaleTransition(
                    scale: animation.scaleText,
                    child: Column(
                      children: [
                        UrbanistApptext(
                          text: AppText.welcomeAboard + " Jamie!",
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.w700,
                          color: AppColor.textBrownColor,
                        ),
                        SizedBox(height: height * 0.01),
                        UrbanistApptext(
                          text: AppText.welcomeAboardDescription,
                          fontSize: width * 0.042,
                          maxLines: 4,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          color: AppColor.textGreyColor2,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: height * 0.09),

                /// Animated Button
                FadeTransition(
                  opacity: animation.fadeButton,
                  child: ScaleTransition(
                    scale: animation.scaleButton,
                    child: CustomButtonwitharrow(
                      onPressed: () {
                        // context.pushNamed(RouteNames.quizScreens);
                        context.pushNamed(RouteNames.tabBar);
                      },
                      borderRadius: width * 0.03,
                      text: AppText.goToDashboard,
                      fontSize: width * 0.04,
                      textColor: AppColor.white,
                      fontWeight: FontWeight.w600,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
