import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../models/tab_bar_model.dart';
import '../providers/tab_bar_provider.dart';

class FloatingTabBar extends ConsumerWidget {
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;
  final double? elevation;
  final bool showLabels;
  final double iconSize;
  final double borderRadius;
  final EdgeInsets margin;

  const FloatingTabBar({
    super.key,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
    this.elevation,
    this.showLabels = true,
    this.iconSize = 24.0,
    this.borderRadius = 25.0,
    this.margin = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabBarState = ref.watch(tabBarProvider);
    final tabBarNotifier = ref.watch(tabBarProvider.notifier);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: elevation ?? 20.0,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: TabBarItem.values.map((tab) {
              final isSelected = tabBarState.currentTab == tab;
              return Expanded(
                child: GestureDetector(
                  onTap: () => tabBarNotifier.changeTab(tab),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    padding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 8.0,
                    ),
                    // decoration: BoxDecoration(
                    //   color: isSelected
                    //       ? (selectedColor ?? Theme.of(context).primaryColor)
                    //             .withOpacity(0.1)
                    //       : Colors.transparent,
                    //   borderRadius: BorderRadius.circular(40.0),
                    // ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOutCubic,
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (selectedColor ??
                                      Theme.of(context).primaryColor)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(40.0),
                            // boxShadow: isSelected
                            //     ? [
                            //         BoxShadow(
                            //           color:
                            //               (selectedColor ??
                            //               Theme.of(context).primaryColor),
                            //           blurRadius: 8.0,
                            //           offset: const Offset(0, 2),
                            //         ),
                            //       ]
                            //     : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              isSelected
                                  ? tab.selectedIcon
                                  : tab.unselectedIcon,
                              width: iconSize,
                              height: iconSize,
                              // colorFilter: ColorFilter.mode(
                              //   isSelected
                              //       ? (selectedColor ??
                              //             Theme.of(context).primaryColor)
                              //       : (unselectedColor ??
                              //             Colors.grey.shade600),
                              //   BlendMode.srcIn,
                              // ),
                            ),
                          ),
                        ),
                        if (showLabels) ...[
                          const SizedBox(height: 4.0),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? (selectedColor ??
                                        Theme.of(context).primaryColor)
                                  : (unselectedColor ?? Colors.grey.shade600),
                              letterSpacing: 0.3,
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
