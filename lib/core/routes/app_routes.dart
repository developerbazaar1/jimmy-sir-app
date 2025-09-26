import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/screens/Allergies/allergies_screen.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/screens/aboutYourSelf/about_yourself_screen.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/screens/aboutYourSelf/about_yourself_screen_1.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/screens/lifestyle/lifestyle_screen.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/screens/lifestyle/lifestyle_screen1.dart';
import '../../features/auth/changePassword/screen/change_password_screen.dart';
import '../../features/auth/signup/screen/singup_screen.dart';
import '../../features/tabbarcontroller/tabbar/screens/tab_bar.dart';
import '../../features/tabbarcontroller/tabbar/screens/tab_bar_test_screen.dart';

import 'route_import.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RoutePaths.splash,
    routes: [
      //----------------ashu---------------
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.onboarding,
        name: RouteNames.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RoutePaths.aboutYourself,
        name: RouteNames.aboutYourself,
        builder: (_, __) => const AboutYourselfScreen(),
      ),
      GoRoute(
        path: RoutePaths.aboutYourselfScreen1,
        name: RouteNames.aboutYourselfScreen1,
        builder: (_, __) => const AboutYourselfScreen1(),
      ),

      GoRoute(
        path: RoutePaths.lifestyle,
        name: RouteNames.lifestyle,
        builder: (_, __) => const LifestyleScreen(),
      ),

      //----------------pramod sir----------------
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (_, __) => LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.forgotPassword,
        name: RouteNames.forgotPassword,
        builder: (_, __) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.verifyOTP,
        name: RouteNames.verifyOTP,
        builder: (_, __) => VerifyOTPScreen(),
      ),
      GoRoute(
        path: RoutePaths.changePassword,
        name: RouteNames.changePassword,
        builder: (_, __) => ChangePasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.signup,
        name: RouteNames.signup,
        builder: (_, __) => SingupScreen(),
      ),
      GoRoute(
        path: RoutePaths.lifestyleScreen1,
        name: RouteNames.lifestyleScreen1,
        builder: (_, __) => const LifestyleScreen1(),
      ),
      GoRoute(
        path: RoutePaths.allergiesScreen,
        name: RouteNames.allergiesScreen,
        builder: (_, __) => const AllergiesScreen(),
      ),
      GoRoute(
        path: RoutePaths.tabBar,
        name: RouteNames.tabBar,
        builder: (_, __) => const TabBarScreen(),
      ),
      GoRoute(
        path: RoutePaths.tabBarTest,
        name: RouteNames.tabBarTest,
        builder: (_, __) => const TabBarTestScreen(),
      ),
      GoRoute(
        path: RoutePaths.profileInfo,
        name: RouteNames.profileInfo,
        builder: (_, __) => const ProfileInfoScreen(),
      ),
    ],
  );
});











//---wrough 
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:jimmy_sir_app/core/routes/route_constant.dart';
// import 'package:jimmy_sir_app/features/auth/presentation/screens/signUp_screen.dart';
// import 'package:jimmy_sir_app/features/onbaording/presentation/screens/onboarding_screen.dart';
// import 'package:jimmy_sir_app/features/splash/presentation/screens/splash_screen.dart';

// class AppRouter {
//   static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   static GoRouter router = GoRouter(
//     initialLocation: RoutePaths.splash,
//     routes: [
//       GoRoute(
//         name: RouteNames.splash,
//         path: RoutePaths.splash,
//         builder: (context, state) => SplashScreen(),
//       ),
//       GoRoute(
//         name: RouteNames.onboarding,
//         path: RoutePaths.onboarding,
//         builder: (context, state) => OnboardingScreen(),
//       ),
//       GoRoute(
//         name: RouteNames.signUp,
//         path: RoutePaths.signUp,
//         builder: (context, state) => SignUpScreen(),
//       ),
//       // Add other routes here
//     ],
//   );
// }