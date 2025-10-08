import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/Tab_bar/custom_tab_bar.dart';

import 'package:jimmy_sir_app/features/tabbarcontroller/logsSecton/logs/presentation/widgets/horizontal_calender.dart';
import 'package:jimmy_sir_app/features/tabbarcontroller/logsSecton/logs/presentation/widgets/meal_container.dart';
import 'package:jimmy_sir_app/features/tabbarcontroller/logsSecton/logs/provider/logs_provider.dart';
import '../../../../../../../../core/routes/route_import.dart';

class LogsScreen extends ConsumerWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final selectedTab = ref.watch(selectedLogTabProvider);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const CustomAppBar2(title: "Log"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            const HorizontalWeekCalendar(),
            SizedBox(height: height * 0.02),

            /// ---- Add Meal/Activity Button ----
            CustomButton(
              text: selectedTab == 0 ? 'Add Meal' : 'Add Activity',
              onPressed: () {
                if (selectedTab == 0) {
                  context.pushNamed(RouteNames.mealLogScreen);
                } else {
                  print('Add Activity pressed');
                }
              },
              width: width * 0.9,
              height: height * 0.06,
              fontSize: width * 0.04,
              fontWeight: FontWeight.w500,
              borderRadius: width * 0.02,
              borderColor: AppColor.primaryColor,
              color: AppColor.primaryColor,
              textColor: AppColor.white,
            ),

            SizedBox(height: height * 0.02),

            /// ---- Tabs Section ----
            SizedBox(
              height: height * 0.45,
              child: CustomTextTabBar(
                tabHeight: height * 0.06,
                borderRadius: BorderRadius.circular(width * 0.02),
                tabs: const ['Meals', 'Activities'],

                /// when tab changes -> update selectedLogTabProvider
                onTabChanged: (index) {
                  ref.read(selectedLogTabProvider.notifier).state = index;
                },

                tabViews: [
                  /// ---- Meals Tab ----
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      final expandedIndex = ref.watch(expandedIndexProvider);
                      final isExpanded = expandedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          ref.read(expandedIndexProvider.notifier).state =
                              isExpanded ? null : index;
                        },
                        child: MealContainer(
                          isExpanded,
                          'Meal $index',
                          'This is the meal description or subtitle.',
                          'https://picsum.photos/seed/$index/400/200',
                        ),
                      );
                    },
                  ),

                  /// ---- Activities Tab ----
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(width * 0.03),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.textGreyColor3,
                            width: 1.2,
                          ),
                          borderRadius: BorderRadius.circular(width * 0.02),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                UrbanistApptext(
                                  text: 'Activity ',
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.black,
                                ),
                                SizedBox(width: width * 0.01),
                                UrbanistApptext(
                                  text: '●',
                                  fontSize: width * 0.03,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.greyColor,
                                ),
                                SizedBox(width: width * 0.01),
                                UrbanistApptext(
                                  text: 'Low Intensity',
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.greenColor,
                                ),
                              ],
                            ),
                            UrbanistApptext(
                              text:
                                  'This is the activity description or subtitle or time or anything you want to add like this .',
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textGreyColor3,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
