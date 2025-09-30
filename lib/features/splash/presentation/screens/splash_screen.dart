import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import 'package:jimmy_sir_app/features/splash/providers/splash_provider.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // When splash completes, navigate.
    ref.listen(splashReadyProvider, (prev, next) {
      next.whenData((_) {

        //context.pushNamed(RouteNames.onboarding);
        // context.pushReplacementNamed(RouteNames.tabBar);
        context.pushNamed(RouteNames.tabBar);

      });
    });
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Center(
          child: Lottie.asset(
            'assets/lottie/splash_animation.json',
            width: width * 0.7, // adjust size
            height: height * 0.6,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
