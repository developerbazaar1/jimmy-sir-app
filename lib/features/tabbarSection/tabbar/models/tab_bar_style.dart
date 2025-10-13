import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/floating_tab_bar.dart';
import '../widgets/glassmorphism_tab_bar.dart';

enum TabBarStyle { modern, floating, glassmorphism }

class TabBarStyleConfig {
  final TabBarStyle style;
  final String name;
  final String description;
  final Widget Function() builder;

  const TabBarStyleConfig({
    required this.style,
    required this.name,
    required this.description,
    required this.builder,
  });
}

class TabBarStyleManager {
  static List<TabBarStyleConfig> get availableStyles => [
    TabBarStyleConfig(
      style: TabBarStyle.modern,
      name: 'Modern',
      description: 'Clean design with rounded corners and smooth animations',
      builder: () => const CustomTabBar(
        selectedColor: Color(0xFF6366F1),
        unselectedColor: Color(0xFF64748B),
        backgroundColor: Color(0xFFF8FAFC),
        elevation: 12.0,
        showLabels: true,
        iconSize: 22.0,
        useGradient: true,
        useRoundedCorners: true,
        borderRadius: 24.0,
      ),
    ),
    TabBarStyleConfig(
      style: TabBarStyle.floating,
      name: 'Floating',
      description: 'Floating design with elevated appearance',
      builder: () => FloatingTabBar(
        selectedColor: Colors.white,
        unselectedColor: Colors.white,
        backgroundColor: AppColor.bottomBarColor,
        elevation: 20.0,
        showLabels: false,
        iconSize: 25.0,
        borderRadius: 40.0,
        margin: const EdgeInsets.all(40),
      ),
    ),
    TabBarStyleConfig(
      style: TabBarStyle.glassmorphism,
      name: 'Glassmorphism',
      description: 'Glass-like effect with blur and transparency',
      builder: () => const GlassmorphismTabBar(
        selectedColor: Color(0xFF06B6D4),
        unselectedColor: Color(0xFF6B7280),
        elevation: 15.0,
        showLabels: true,
        iconSize: 22.0,
        borderRadius: 20.0,
        blurIntensity: 10.0,
      ),
    ),
  ];

  static TabBarStyleConfig getStyleConfig(TabBarStyle style) {
    return availableStyles.firstWhere(
      (config) => config.style == style,
      orElse: () => availableStyles.first,
    );
  }
}
