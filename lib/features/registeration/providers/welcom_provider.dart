import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final welcomeAnimationProvider = Provider.autoDispose
    .family<WelcomeAnimationNotifier, TickerProvider>((ref, vsync) {
      final notifier = WelcomeAnimationNotifier(vsync);
      ref.onDispose(() => notifier.dispose());
      return notifier;
    });

class WelcomeAnimationNotifier extends StateNotifier<void> {
  late final AnimationController controller;
  late final Animation<double> fadeText;
  late final Animation<double> scaleText;
  late final Animation<double> fadeButton;
  late final Animation<double> scaleButton;

  WelcomeAnimationNotifier(TickerProvider vsync) : super(null) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 2500),
    );

    fadeText = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    scaleText = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    fadeButton = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    scaleButton = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOutBack),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
