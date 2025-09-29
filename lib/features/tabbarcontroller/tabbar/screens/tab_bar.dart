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

    return Stack(
      children: [
        // Main content upside down
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(0.0), // 90 degrees rotation
          child: IndexedStack(
            index: tabBarState.currentTab.tabIndex,
            children: [
              HomeScreen(),
              LogsScreen(),
              MyWinsScreen(),
              ProfileScreen(),
            ],
          ),
        ),
        // Bottom tab bar at the top (since content is flipped)
        if (tabBarState.isVisible)
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: TabBarStyleManager.getStyleConfig(
              TabBarStyle.floating,
            ).builder(),
          ),
      ],
    );
  }
}
