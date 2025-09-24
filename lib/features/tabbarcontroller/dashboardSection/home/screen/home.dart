import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/features/tabbarcontroller/dashboardSection/home/providers/home-provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeNotifier = ref.watch(homeProvider.notifier);

    return Scaffold(body: Center(child: Text('Home Screen')));
  }
}
