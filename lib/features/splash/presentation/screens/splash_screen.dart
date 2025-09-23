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
    // When splash completes, navigate.
    ref.listen(splashReadyProvider, (prev, next) {
      next.whenData((_) {
        context.pushNamed(RouteNames.onboarding);
      });
    });
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Center(
          child: Lottie.asset(
            'assets/lottie/splash_animation.json',
            width: 200, // adjust size
            height: 200,
            fit: BoxFit.contain,
            repeat: true, // set false if you want one-time play
          ),
        ),

        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Center(
        //           child: Text(
        //             "Splash Screen",
        //             style: TextStyle(fontSize: 20, color: AppColor.textColor),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
