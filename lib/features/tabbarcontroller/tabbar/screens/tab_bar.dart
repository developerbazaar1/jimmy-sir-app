import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/features/tabbarcontroller/dashboardSection/home/screen/home.dart';
import 'package:jimmy_sir_app/features/tabbarcontroller/logsSecton/logs/screen/Logs.dart';
import 'package:jimmy_sir_app/features/tabbarcontroller/myWinsSection/myWins/screen/my_wins.dart';
import 'package:jimmy_sir_app/features/tabbarcontroller/profileSection/profile/screen/profile.dart';
import '../providers/tab_bar_provider.dart';
import '../models/tab_bar_style.dart';

class TabBarScreen extends ConsumerWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabBarState = ref.watch(tabBarProvider);

    return Scaffold(
      body: IndexedStack(
        index: tabBarState.currentTab.tabIndex,
        children: const [
          HomeScreen(),
          LogsScreen(),
          MyWinsScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: tabBarState.isVisible
          ? TabBarStyleManager.getStyleConfig(TabBarStyle.floating).builder()
          : null,
    );
  }
}
