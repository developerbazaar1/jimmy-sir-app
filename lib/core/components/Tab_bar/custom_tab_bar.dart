import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';

final tabBarProvider = StateNotifierProvider<TabBarNotifier, int>(
  (ref) => TabBarNotifier(),
);

class TabBarNotifier extends StateNotifier<int> {
  TabBarNotifier() : super(0);

  void changeTab(int index) => state = index;
}

/// ----------------------
/// CUSTOM TAB BAR WIDGET
/// ----------------------
class CustomTextTabBar extends ConsumerWidget {
  final List<String> tabs;
  final List<Widget> tabViews;
  final double? spacing;
  final double? tabHeight;
  final BorderRadiusGeometry? borderRadius;
  final Function(int) onTabChanged;

  const CustomTextTabBar({
    super.key,
    required this.tabs,
    required this.tabViews,
    this.spacing,
    this.tabHeight,
    this.borderRadius,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mq = MediaQuery.of(context).size;
    final selectedIndex = ref.watch(tabBarProvider);
    final notifier = ref.read(tabBarProvider.notifier);

    return Column(
      children: [
        Container(
          height: tabHeight ?? mq.width * .09,
          width: mq.width * .9,
          decoration: BoxDecoration(            
            borderRadius: BorderRadius.circular(mq.width * .025),
            border: Border.all(color: AppColor.primaryColor , width: 1.7),
          ),
          margin: EdgeInsets.symmetric(horizontal: mq.width * 0.005),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(tabs.length, (index) {
              final isSelected = selectedIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    notifier.changeTab(index);
                    onTabChanged(index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColor.primaryColor
                          : AppColor.white,
                      borderRadius:
                          borderRadius ??
                          BorderRadius.circular(mq.width * .013),
                    ),
                    child: UrbanistApptext(
                      text: tabs[index],
                      color: isSelected
                          ? AppColor.white
                          : AppColor.primaryColor,
                      fontSize: mq.width * .041,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(child: tabViews[selectedIndex]),
      ],
    );
  }
}
