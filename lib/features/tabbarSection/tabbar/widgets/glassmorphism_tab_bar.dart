import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../models/tab_bar_model.dart';
import '../providers/tab_bar_provider.dart';

class GlassmorphismTabBar extends ConsumerWidget {
  final Color? selectedColor;
  final Color? unselectedColor;
  final double? elevation;
  final bool showLabels;
  final double iconSize;
  final double borderRadius;
  final double blurIntensity;

  const GlassmorphismTabBar({
    super.key,
    this.selectedColor,
    this.unselectedColor,
    this.elevation,
    this.showLabels = true,
    this.iconSize = 24.0,
    this.borderRadius = 20.0,
    this.blurIntensity = 10.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabBarState = ref.watch(tabBarProvider);
    final tabBarNotifier = ref.watch(tabBarProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: elevation ?? 15.0,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurIntensity,
            sigmaY: blurIntensity,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.0,
                ),
              ),
            ),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: TabBarItem.values.map((tab) {
                    final isSelected = tabBarState.currentTab == tab;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => tabBarNotifier.changeTab(tab),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 6.0,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (selectedColor ??
                                          Theme.of(context).primaryColor)
                                      .withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16.0),
                            border: isSelected
                                ? Border.all(
                                    color:
                                        (selectedColor ??
                                                Theme.of(context).primaryColor)
                                            .withOpacity(0.3),
                                    width: 1.0,
                                  )
                                : null,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? (selectedColor ??
                                                Theme.of(context).primaryColor)
                                            .withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: SvgPicture.asset(
                                  isSelected
                                      ? tab.selectedIcon
                                      : tab.unselectedIcon,
                                  width: iconSize,
                                  height: iconSize,
                                  colorFilter: ColorFilter.mode(
                                    isSelected
                                        ? (selectedColor ??
                                              Theme.of(context).primaryColor)
                                        : (unselectedColor ??
                                              Colors.grey.shade700),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              if (showLabels) ...[
                                const SizedBox(height: 6.0),
                                Text(
                                  tab.label,
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? (selectedColor ??
                                              Theme.of(context).primaryColor)
                                        : (unselectedColor ??
                                              Colors.grey.shade700),
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
