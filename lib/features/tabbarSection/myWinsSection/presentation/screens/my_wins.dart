import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_images.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';

class MyWinsScreen extends ConsumerWidget {
  const MyWinsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;
    //  final myWinsState = ref.watch(myWinsProvider);
    //   final myWinsNotifier = ref.read(myWinsProvider.notifier);
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
                          text: AppText.cashbackPoints,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(RouteNames.availableBalanceScreen);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UrbanistApptext(
                            text: "1250 pts",
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w900,
                            color: AppColor.primaryColor,
                          ),
                          UrbanistApptext(
                            text: AppText.redeemPoints,
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.01),
                    UrbanistApptext(
                      text: AppText.weeklySpins,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: height * 0.01),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(RouteNames.spinWheelScreen);
                      },
                      child: Image.asset(AppImages.myspinnBanner),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),

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
                      border: Border.all(
                        color: AppColor.border.withOpacity(0.2),
                      ),
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
                                context.pushNamed(RouteNames.addGoalScreen);
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
                      border: Border.all(
                        color: AppColor.border.withOpacity(0.2),
                      ),
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
