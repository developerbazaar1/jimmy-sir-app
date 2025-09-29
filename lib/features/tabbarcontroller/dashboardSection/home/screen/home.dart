import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_svg.dart';
import 'widget/life_style_score.dart';
import 'widget/profile_header.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Color> containerColors = [Colors.red, Colors.blue, Colors.green];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.white,
      floatingActionButton: null,

      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom -
                      32,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      SizedBox(height: width * 0.0504),
                      ProfileHeader(),
                      SizedBox(height: width * 0.0204),
                      LifeStyleScore(),
                      SizedBox(height: width * 0.0204),

                      SizedBox(
                        height:
                            containerColors.length * (width * 0.15 + 8) + 100,
                        child: ReorderableListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: containerColors.length,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              final color = containerColors.removeAt(oldIndex);
                              containerColors.insert(newIndex, color);
                            });
                          },
                          itemBuilder: (context, index) {
                            final color = containerColors[index];
                            return Container(
                              key: ValueKey('$color-$index'),
                              height: width * 0.15,
                              margin: EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: color.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Icon(
                                        Icons.drag_handle,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      'Container ${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Custom positioned FloatingActionButton
          Positioned(
            bottom: 100,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: AppColor.bottomBarColor,
              child: SvgPicture.asset(AppSvg.imgFloat),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * (40 / width)),
              ),
              elevation: 5,
              onPressed: () {
                setState(() {
                  containerColors.add(Colors.purple);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
