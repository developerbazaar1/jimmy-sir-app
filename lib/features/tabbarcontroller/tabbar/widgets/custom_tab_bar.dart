import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../models/tab_bar_model.dart';
import '../providers/tab_bar_provider.dart';

class CustomTabBar extends ConsumerWidget {
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;
  final double? elevation;
  final bool showLabels;
  final double iconSize;
  final bool useGradient;
  final bool useRoundedCorners;
  final double borderRadius;

  const CustomTabBar({
    super.key,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
    this.elevation,
    this.showLabels = true,
    this.iconSize = 24.0,
    this.useGradient = true,
    this.useRoundedCorners = true,
    this.borderRadius = 20.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabBarState = ref.watch(tabBarProvider);
    final tabBarNotifier = ref.watch(tabBarProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        gradient: useGradient
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  backgroundColor ?? Colors.white,
                  (backgroundColor ?? Colors.white).withOpacity(0.95),
                ],
              )
            : null,
        color: useGradient ? null : backgroundColor ?? Colors.white,
        borderRadius: useRoundedCorners
            ? BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: elevation ?? 12.0,
            offset: const Offset(0, -4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6.0,
            offset: const Offset(0, -2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: TabBarItem.values.map((tab) {
              final isSelected = tabBarState.currentTab == tab;
              return Expanded(
                child: GestureDetector(
                  onTap: () => tabBarNotifier.changeTab(tab),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (selectedColor ?? Theme.of(context).primaryColor)
                                .withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (selectedColor ??
                                      Theme.of(context).primaryColor)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
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
                                    : (unselectedColor ?? Colors.grey.shade600),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),

                        if (showLabels) ...[
                          const SizedBox(height: 6.0),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? (selectedColor ??
                                        Theme.of(context).primaryColor)
                                  : (unselectedColor ?? Colors.grey.shade600),
                              letterSpacing: 0.2,
                            ),
                            child: Text(tab.label),
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
    );
  }
}
