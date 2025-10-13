import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tab_bar_model.dart';
import '../providers/tab_bar_provider.dart';

class TabBarService {
  static void navigateToTab(WidgetRef ref, TabBarItem tab) {
    final tabBarNotifier = ref.read(tabBarProvider.notifier);
    tabBarNotifier.changeTab(tab);
  }

  static void navigateToHome(WidgetRef ref) {
    final tabBarNotifier = ref.read(tabBarProvider.notifier);
    tabBarNotifier.resetToHome();
  }

  static void hideTabBar(WidgetRef ref) {
    final tabBarNotifier = ref.read(tabBarProvider.notifier);
    tabBarNotifier.setTabVisibility(false);
  }

  static void showTabBar(WidgetRef ref) {
    final tabBarNotifier = ref.read(tabBarProvider.notifier);
    tabBarNotifier.setTabVisibility(true);
  }

  static TabBarItem getCurrentTab(WidgetRef ref) {
    final tabBarState = ref.read(tabBarProvider);
    return tabBarState.currentTab;
  }

  static bool isTabBarVisible(WidgetRef ref) {
    final tabBarState = ref.read(tabBarProvider);
    return tabBarState.isVisible;
  }
}
