import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/screens/about_yourself_screen.dart';
import 'route_import.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RoutePaths.splash,
    routes: [
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
        path: RoutePaths.signUp,
        name: RouteNames.signUp,
        builder: (_, __) => const SignUpScreen(),
      ),
      GoRoute(
        path: RoutePaths.aboutYourself,
        name: RouteNames.aboutYourself,
        builder: (_, __) => const AboutYourselfScreen(),
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