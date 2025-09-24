import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import 'package:jimmy_sir_app/features/splash/providers/splash_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // When splash completes, navigate.
    ref.listen(splashReadyProvider, (prev, next) {
      next.whenData((_) {
        // context.pushNamed(RouteNames.signup);
        context.pushReplacementNamed(RouteNames.tabBar);
      });
    });
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Splash Screen",
                    style: TextStyle(fontSize: 20, color: AppColor.textColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
