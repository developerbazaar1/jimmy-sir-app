import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tab_bar_model.dart';
import '../services/tab_bar_service.dart';

class TabBarController {
  static final TabBarController _instance = TabBarController._internal();
  factory TabBarController() => _instance;
  TabBarController._internal();

  // Navigation methods
  static void navigateToHome(WidgetRef ref) {
    TabBarService.navigateToHome(ref);
  }

  static void navigateToTab(WidgetRef ref, TabBarItem tab) {
    TabBarService.navigateToTab(ref, tab);
  }

  static void navigateToLogs(WidgetRef ref) {
    TabBarService.navigateToTab(ref, TabBarItem.logs);
  }

  static void navigateToMyWins(WidgetRef ref) {
    TabBarService.navigateToTab(ref, TabBarItem.myWins);
  }

  static void navigateToProfile(WidgetRef ref) {
    TabBarService.navigateToTab(ref, TabBarItem.profile);
  }

  // Visibility methods
  static void hideTabBar(WidgetRef ref) {
    TabBarService.hideTabBar(ref);
  }

  static void showTabBar(WidgetRef ref) {
    TabBarService.showTabBar(ref);
  }

  // State methods
  static TabBarItem getCurrentTab(WidgetRef ref) {
    return TabBarService.getCurrentTab(ref);
  }

  static bool isTabBarVisible(WidgetRef ref) {
    return TabBarService.isTabBarVisible(ref);
  }

  // Utility methods
  static bool isHomeTab(WidgetRef ref) {
    return getCurrentTab(ref) == TabBarItem.home;
  }

  static bool isLogsTab(WidgetRef ref) {
    return getCurrentTab(ref) == TabBarItem.logs;
  }

  static bool isMyWinsTab(WidgetRef ref) {
    return getCurrentTab(ref) == TabBarItem.myWins;
  }

  static bool isProfileTab(WidgetRef ref) {
    return getCurrentTab(ref) == TabBarItem.profile;
  }
}
