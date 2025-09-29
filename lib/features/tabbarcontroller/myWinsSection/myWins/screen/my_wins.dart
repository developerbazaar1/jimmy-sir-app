import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_images.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import '../provider/my_wins_provider.dart';

class MyWinsScreen extends ConsumerWidget {
  const MyWinsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;
    final myWinsNotifier = ref.watch(myWinsProvider.notifier);
    final myWinsState = ref.watch(myWinsProvider);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  AppSvg.myWinBanner,
                  width: width,
                  height: height * 0.22,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: -height * 0.07,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColor.primaryColor,
                        width: width * 0.02,
                      ),
                    ),
                    height: height * 0.14,
                    width: height * 0.14,
                    child: ClipOval(
                      child: Image.asset(
                        AppImages.personTemp,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.08),
            SvgPicture.asset(AppSvg.myWinsTextIcon, fit: BoxFit.fill),
            SizedBox(height: height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.02),
                  border: Border.all(
                    color: AppColor.primaryColor.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppSvg.imgFloat,
                          height: height * 0.03,
                          width: width * 0.03,
                        ),
                        SizedBox(width: width * 0.02),
                        UrbanistApptext(
                          text: "Cashback Points",
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UrbanistApptext(
                          text: "1250 pts",
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.w800,
                          color: AppColor.primaryColor,
                        ),
                        UrbanistApptext(
                          text: "Redeem Points",
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: height * 0.02),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.01,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.primaryColor.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.01),
                    UrbanistApptext(
                      text: "Weekly Spins",
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: height * 0.01),
                    Image.asset(AppImages.myspinnBanner),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            //   child: Container(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: width * 0.05,
            //       vertical: height * 0.01,
            //     ),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(width * 0.02),
            //       border: Border.all(
            //         color: AppColor.primaryColor.withOpacity(0.2),
            //       ),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             UrbanistApptext(
            //               text: "Goals & Milestones",
            //               fontSize: width * 0.04,
            //               fontWeight: FontWeight.w700,
            //             ),
            //             SizedBox(width: width * 0.02),
            //           ],
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Goals & Milestones Section ---
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.015,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * 0.04),
                      border: Border.all(
                        color: AppColor.primaryColor.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UrbanistApptext(
                              text: "Goals & Milestones",
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w700,
                            ),
                            Container(
                              height: height * 0.05,
                              width: height * 0.05,
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
                          ],
                        ),
                        SizedBox(height: height * 0.01),

                        // Goal 1 - Weight Loss
                        _buildGoalItem(
                          context,
                          width,
                          svg: AppSvg.goalIcon,
                          iconColor: Colors.pinkAccent,
                          title: "Weight Loss Goal",
                          progress: 0.75,
                          progressColor: Colors.pinkAccent,
                        ),
                        SizedBox(height: height * 0.02),

                        // Goal 2 - Monthly Step
                        _buildGoalItem(
                          context,
                          width,
                          svg: AppSvg.goalIcon,
                          iconColor: Colors.orange,
                          title: "Monthly Step",
                          progress: 0.9,
                          progressColor: Colors.orange,
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
                          color: AppColor.border.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(0, 6),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * 0.04),
                      border: Border.all(
                        color: AppColor.primaryColor.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UrbanistApptext(
                          text: "Recent Wins",
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: height * 0.02),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.03,
                            vertical: height * 0.01,
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
                                width: height * 0.04,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.attach_money,
                                  size: height * 0.03,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: width * 0.02),
                              Expanded(
                                child: UrbanistApptext(
                                  text: "Cashback Earned",
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

            SizedBox(height: height * 0.2),
          ],
        ),
      ),
    );
  }
}

Widget _buildGoalItem(
  BuildContext context,
  double width, {

  // required IconData icon,
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
      vertical: height * 0.02,
    ),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: AppColor.border.withOpacity(0.2),
          blurRadius: 8,
          offset: Offset(0, 6),
        ),
      ],
      color: iconColor.withOpacity(0.05),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: height * 0.04,
              width: width * 0.04,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(svg),
              //Icon(icon, size: 16, color: iconColor),
            ),
            SizedBox(width: width * 0.02),
            Expanded(
              child: UrbanistApptext(
                text: title,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
            UrbanistApptext(
              text: "${(progress * 100).toInt()}%",
              fontSize: width * 0.04,
              fontWeight: FontWeight.w500,
              color: AppColor.textColor.withOpacity(0.7),
            ),
          ],
        ),
        SizedBox(height: height * 0.02),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: height * 0.01,
            backgroundColor: Colors.grey[200],
            color: progressColor,
          ),
        ),
      ],
    ),
  );
}
