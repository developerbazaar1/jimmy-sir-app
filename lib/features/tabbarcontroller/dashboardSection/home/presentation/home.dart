// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/constants/app_svg.dart';
// import 'widget/life_style_score.dart';
// import 'widget/profile_header.dart';

// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   List<Color> containerColors = [Colors.red, Colors.blue, Colors.green];

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: AppColor.white,
//       floatingActionButton: null,

//       body: Stack(
//         children: [
//           SafeArea(
//             child: SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight:
//                       MediaQuery.of(context).size.height -
//                       MediaQuery.of(context).padding.top -
//                       MediaQuery.of(context).padding.bottom -
//                       32,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: width * 0.05,
//                     vertical: height * 0.01,
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(height: width * 0.055),
//                       ProfileHeader(),
//                       SizedBox(height: width * 0.051),
//                       LifeStyleScore(),
//                       SizedBox(height: width * 0.0204),

//                       SizedBox(
//                         height:
//                             containerColors.length * (width * 0.15 + 8) + 100,
//                         child: ReorderableListView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: containerColors.length,
//                           onReorder: (oldIndex, newIndex) {
//                             setState(() {
//                               if (newIndex > oldIndex) {
//                                 newIndex -= 1;
//                               }
//                               final color = containerColors.removeAt(oldIndex);
//                               containerColors.insert(newIndex, color);
//                             });
//                           },
//                           itemBuilder: (context, index) {
//                             final color = containerColors[index];
//                             return Container(
//                               key: ValueKey('$color-$index'),
//                               height: width * 0.15,
//                               margin: EdgeInsets.symmetric(vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: color,
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: color.withOpacity(0.3),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 16),
//                                       child: Icon(
//                                         Icons.drag_handle,
//                                         color: Colors.white,
//                                         size: 24,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Container ${index + 1}',
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 16),
//                                       child: Icon(
//                                         Icons.more_vert,
//                                         color: Colors.white,
//                                         size: 20,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // Custom positioned FloatingActionButton
//           Positioned(
//             bottom: 100,
//             right: 20,
//             child: FloatingActionButton(
//               backgroundColor: AppColor.bottomBarColor,
//               child: SvgPicture.asset(AppSvg.imgFloat),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(width * (40 / width)),
//               ),
//               elevation: 5,
//               onPressed: () {
//                 setState(() {
//                   containerColors.add(Colors.purple);
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'widget/life_style_score.dart';
import 'widget/profile_header.dart';

class SectionItem {
  final String id;
  final String title;
  final String subtitle;
  final Widget details;
  bool expanded;

  SectionItem({
    required this.id,
    required this.title,
    this.subtitle = '',
    required this.details,
    this.expanded = false,
  });
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late List<SectionItem> sections;

  @override
  void initState() {
    super.initState();
    sections = [
      SectionItem(
        id: "Today's Suggestion",
        title: "Today's key appointments",
        subtitle: "Today's key appointments",
        details: Builder(builder: (context) => _buildTodaySuggestionDetails()),
        expanded: true,
      ),
      SectionItem(
        id: 'goals',
        title: 'Goals & Milestones',
        // subtitle: '',
        details: Builder(
          builder: (context) => _buildGoalsMilestonesDetails(context),
        ),
        expanded: true,
      ),
      SectionItem(
        id: 'health',
        title: 'Health Overview',
        subtitle: '',
        details: Builder(
          builder: (context) => _buildHealthOverviewDetails(context),
        ),
        expanded: true,
      ),
    ];
  }

  // ---------- replace these builder stubs with your real details widgets ----------
  static Widget _buildTodaySuggestionDetails() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: const [
          ListTile(
            leading: Icon(Icons.brightness_low),
            title: Text('Take a 5-minute mindful break'),
          ),
          ListTile(
            leading: Icon(Icons.food_bank),
            title: Text('Swap one snack for fruit'),
          ),
        ],
      ),
    );
  }

  static Widget _buildGoalsMilestonesDetails(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Replace with your progress bars
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.015,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColor.border.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UrbanistApptext(
                            text: AppText.goalsMilestones,
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w700,
                          ),
                          GestureDetector(
                            onTap: () {
                              // context.pushNamed(RouteNames.addGoalScreen);
                            },
                            child: Container(
                              height: height * 0.04,
                              width: height * 0.04,
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                size: height * 0.03,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.01),
                      _buildGoalItem(
                        context,
                        width,
                        svg: AppSvg.goalIcon,
                        iconColor: AppColor.pinkColor,
                        title: "Weight Loss Goal",
                        progress: 0.75,
                        progressColor: AppColor.pinkColor,
                      ),
                      SizedBox(height: height * 0.02),

                      _buildGoalItem(
                        context,
                        width,
                        svg: AppSvg.goalIcon2,
                        iconColor: AppColor.yellowColor,
                        title: "Monthly Step",
                        progress: 0.9,
                        progressColor: AppColor.yellowColor,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.02),

                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColor.border.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UrbanistApptext(
                        text: AppText.recentWins,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: height * 0.02),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                          vertical: height * 0.011,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(width * 0.04),
                          border: Border.all(
                            color: AppColor.border.withOpacity(0.2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.border.withOpacity(0.2),
                              blurRadius: 8,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: height * 0.04,
                              width: width * 0.08,

                              child: Center(
                                child: SvgPicture.asset(AppSvg.dollarIcon),
                              ),
                            ),

                            SizedBox(width: width * 0.02),
                            Expanded(
                              child: UrbanistApptext(
                                text: AppText.cashbackEarned,
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            UrbanistApptext(
                              text: "10\$",
                              fontSize: width * 0.04,
                              color: AppColor.textGreyColor2,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildHealthOverviewDetails(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.border.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UrbanistApptext(
                  text: AppText.recentWins,
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: height * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03,
                    vertical: height * 0.011,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * 0.04),
                    border: Border.all(color: AppColor.border.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.border.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: height * 0.04,
                        width: width * 0.08,

                        child: Center(
                          child: SvgPicture.asset(AppSvg.dollarIcon),
                        ),
                      ),

                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: UrbanistApptext(
                          text: AppText.cashbackEarned,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      UrbanistApptext(
                        text: "10\$",
                        fontSize: width * 0.04,
                        color: AppColor.textGreyColor2,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: 12,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const ProfileHeader(),
                const SizedBox(height: 18),
                const LifeStyleScore(),
                const SizedBox(height: 14),

                // ---- Draggable sections area ----
                Builder(
                  builder: (context) {
                    final double headerHeight = width * 0.15;
                    final double detailsHeight = width * 0.45;
                    final expandedCount = sections
                        .where((s) => s.expanded)
                        .length;
                    final totalHeight =
                        sections.length * (headerHeight + 8) +
                        expandedCount * detailsHeight +
                        20;

                    return SizedBox(
                      height: totalHeight,
                      child: ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sections.length,
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) newIndex -= 1;
                            final item = sections.removeAt(oldIndex);
                            sections.insert(newIndex, item);
                          });
                        },
                        itemBuilder: (context, index) {
                          final item = sections[index];
                          return _buildDraggableCard(
                            context,
                            index,
                            item,
                            headerHeight,
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableCard(
    BuildContext context,
    int index,
    SectionItem item,
    double headerHeight,
  ) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      key: ValueKey(item.id),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.border.withOpacity(0.2)),
      ),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(12),
      //   border: Border.all(color: AppColor.border.withOpacity(0.2)),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // header card
          Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: headerHeight,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.circular(12),
                // border: Border.all(color: AppColor.border.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UrbanistApptext(
                          text: item.title,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w700,
                        ),
                        if (item.subtitle.isNotEmpty)
                          UrbanistApptext(
                            text: item.subtitle,
                            fontSize: width * 0.032,
                            fontWeight: FontWeight.w600,
                          ),
                      ],
                    ),
                  ),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            item.expanded = !item.expanded;
                          });
                        },
                        child: SizedBox(
                          width: 46,
                          height: 46,
                          child: SvgPicture.asset(AppSvg.dragIcon),
                        ),
                      ),

                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: ReorderableDelayedDragStartListener(
                            index: index,
                            child: Container(
                              width: 46,
                              height: 46,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: item.expanded
                ? Container(child: item.details)
                // Container(
                //     margin: const EdgeInsets.only(top: 8),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(12),
                //       border: Border.all(
                //         color: AppColor.border.withOpacity(0.15),
                //       ),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.08),
                //           blurRadius: 6,
                //         ),
                //       ],
                //     ),
                //     child: item.details,
                //   )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

Widget _buildGoalItem(
  BuildContext context,
  double width, {

  required String svg,
  required Color iconColor,
  required String title,
  required double progress,
  required Color progressColor,
}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: width * 0.03,
      vertical: height * 0.018,
    ),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColor.border.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.04,
              width: width * 0.08,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Center(child: SvgPicture.asset(svg)),
            ),
            SizedBox(width: width * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UrbanistApptext(
                        text: title,
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.w600,
                      ),
                      UrbanistApptext(
                        text: "${(progress * 100).toInt()}%",
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.008),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: height * 0.007,
                      backgroundColor: Colors.grey[200],
                      color: progressColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
