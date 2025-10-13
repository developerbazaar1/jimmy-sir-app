enum TabBarItem {
  home(
    0,
    'Home',
    'assets/svgs/selected/imgHomeSelected.svg',
    'assets/svgs/unSelected/imgHomeUnSelected.svg',
  ),
  logs(
    1,
    'Logs',
    'assets/svgs/selected/imgLogSelected.svg',
    'assets/svgs/unSelected/imgLogUnSelected.svg',
  ),
  myWins(
    2,
    'My Wins',
    'assets/svgs/selected/imgWinSelected.svg',
    'assets/svgs/unSelected/imgWinUnSelected.svg',
  ),
  profile(
    3,
    'Profile',
    'assets/svgs/selected/imgProfileSelected.svg',
    'assets/svgs/unSelected/imgProfileUnSelected.svg',
  );

  const TabBarItem(
    this.tabIndex,
    this.label,
    this.selectedIcon,
    this.unselectedIcon,
  );

  final int tabIndex;
  final String label;
  final String selectedIcon;
  final String unselectedIcon;
}

class TabBarModel {
  final TabBarItem currentTab;
  final bool isVisible;
  final bool isFullScreen;

  const TabBarModel({
    required this.currentTab,
    this.isVisible = true,
    this.isFullScreen = false,
  });

  TabBarModel copyWith({
    TabBarItem? currentTab,
    bool? isVisible,
    bool? isFullScreen,
  }) {
    return TabBarModel(
      currentTab: currentTab ?? this.currentTab,
      isVisible: isVisible ?? this.isVisible,
      isFullScreen: isFullScreen ?? this.isFullScreen,
    );
  }
}
