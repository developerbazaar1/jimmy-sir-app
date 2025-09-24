import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tab_bar_model.dart';

class TabBarNotifier extends StateNotifier<TabBarModel> {
  TabBarNotifier() : super(TabBarModel(currentTab: TabBarItem.home));

  void changeTab(TabBarItem tab) {
    if (state.currentTab != tab) {
      state = state.copyWith(currentTab: tab);
    }
  }

  void setTabVisibility(bool isVisible) {
    state = state.copyWith(isVisible: isVisible);
  }

  void resetToHome() {
    state = state.copyWith(currentTab: TabBarItem.home);
  }
}

final tabBarProvider = StateNotifierProvider<TabBarNotifier, TabBarModel>((
  ref,
) {
  return TabBarNotifier();
});
