import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jimmy_sir_app/core/components/apptext/plus_jakarta_sans.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/features/tabbarcontroller/dashboardSection/home/providers/home-provider.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/components/apptext/urbanist_apptext.dart';

class LifeStyleScore extends ConsumerWidget {
  const LifeStyleScore({super.key});

  // Helper to safely parse numeric values from a map
  double _getValue(Map data, String key, double fallback) {
    if (data.isEmpty) return fallback;
    final v = data[key];
    if (v == null) return fallback;
    if (v is num) return v.toDouble();
    if (v is String) {
      return double.tryParse(v) ?? fallback;
    }
    return fallback;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final homeData = ref.watch(homeProvider);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    final homeState = ref.watch(homeProvider);

    // categories you want on the radar
    final features = [
      "Sleep Quality",
      "Physical Activity",
      "Hydration",
      "Stress Management",
    ];

    // Try to read a nested structure; adjust keys to match your API
    final Map lifestyleData = (homeState.homeData['lifestyle'] is Map)
        ? homeState.homeData['lifestyle'] as Map
        : homeState.homeData;

    // Fallback values if API doesn't provide them
    final actual = [
      _getValue(lifestyleData, 'Sleep Quality', 50),
      _getValue(lifestyleData, 'Physical Activity', 50),
      _getValue(lifestyleData, 'Hydration', 50),
      _getValue(lifestyleData, 'Stress Management', 50),
    ].map((e) => e.clamp(0, 80).toDouble()).toList();

    final goal = [
      _getValue(lifestyleData, 'Sleep Quality', 100),
      _getValue(lifestyleData, 'Physical Activity', 100),
      _getValue(lifestyleData, 'Hydration', 100),
      _getValue(lifestyleData, 'Stress Management', 100),
    ].map((e) => e.clamp(0, 90).toDouble()).toList();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.01,
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

      child: Padding(
        padding: EdgeInsets.all(width * (16 / width)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UrbanistApptext(
                  text: 'Build Today\'s Progress',
                  fontSize: width * (18 / width),
                  fontWeight: FontWeight.w700,

                  color: AppColor.textColor,
                ),
                PlusJakartaSansApptext(
                  text: "LifeStyle Score",
                  fontSize: width * (14 / width),
                  fontWeight: FontWeight.w500,
                  color: AppColor.textBrownColor,
                ),
              ],
            ),

            SizedBox(height: width * (16 / width)),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.012,
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

              child: ChartSection(
                width: width,
                height: height,
                features: features,
                actualData: actual,
                goalData: goal,
              ),
            ),

            SizedBox(height: width * (5 / width)),

            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.06),
                      color: AppColor.primaryColor,
                    ),
                    width: width * 0.150,
                    height: height * 0.00858,
                  ),
                  SizedBox(width: width * 0.02),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.06),
                      color: AppColor.greyColor.withOpacity(0.3),
                    ),
                    width: width * 0.150,
                    height: height * 0.00858,
                  ),
                ],
              ),
            ),
            SizedBox(height: width * (10 / width)),
            CustomButton(
              text: ' Log Activity',
              onPressed: () {},
              color: AppColor.primaryColor,
              textColor: AppColor.white,
              fontSize: width * (16 / width),
              height: height * (40 / height),
              width: width * (200 / width),
              fontWeight: FontWeight.w500,
              borderRadius: width * (5 / width),
              borderColor: AppColor.primaryColor,
            ),
            SizedBox(height: width * (11 / width)),

            Container(
              width: width * (200 / width),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColor.border.withOpacity(0.2)),
              ),
              child: Padding(
                padding: EdgeInsets.all(width * (10 / width)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      AppSvg.tadaCelebrateIcon,
                      height: height * (18 / height),
                      width: width * (18 / width),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlusJakartaSansApptext(
                          text: 'Complete today’s logs to earn:',
                          fontSize: width * (9 / width),
                          fontWeight: FontWeight.w500,
                          color: AppColor.textColor,
                        ),

                        PlusJakartaSansApptext(
                          text: '10% cashback / xxx',
                          fontSize: width * (9 / width),
                          fontWeight: FontWeight.w500,
                          color: AppColor.textColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartSection extends StatelessWidget {
  final double width;
  final double height;
  final List<String> features;
  final List<double> actualData;
  final List<double> goalData;

  const ChartSection({
    super.key,
    required this.width,
    required this.height,
    required this.features,
    required this.actualData,
    required this.goalData,
  });

  @override
  Widget build(BuildContext context) {
    final ticks = [20, 40, 60, 80, 100];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * (24 / width),
                        child: Divider(
                          color: AppColor.primaryColor3,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(width: 6),
                      PlusJakartaSansApptext(
                        text: 'Actual',
                        fontSize: width * (14 / width),
                        fontWeight: FontWeight.w600,
                        color: AppColor.primaryColor3,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * (25 / width),
                        child: DottedLine(dashGapLength: 1),
                      ),
                      SizedBox(width: 6),
                      PlusJakartaSansApptext(
                        text: 'Goal',
                        fontSize: width * (14 / width),
                        fontWeight: FontWeight.w600,
                        color: AppColor.greenColor,
                      ),
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(
                AppSvg.expandIcon,
                width: width * (25 / width),
                color: AppColor.black,
              ),
            ],
          ),
          Center(
            child: SizedBox(
              width: width * 0.35,
              height: width * 0.35,
              child: RadarChart(
                ticks: ticks,
                features: features,
                reverseAxis: false,
                sides: 8,
                data: [actualData, goalData],
                graphColors: [AppColor.primaryColor, Colors.green],
                featuresTextStyle: TextStyle(
                  fontSize: width * (12 / width),
                  color: AppColor.black,
                ),
                outlineColor: Colors.grey,
                axisColor: Colors.red,
              ),
            ),
          ),

          // Expanded(
          //   child: Center(
          //     child: RadarChart(
          //       ticks: ticks,
          //       features: features,
          //       // ticksTextStyle: TextStyle(
          //       //   fontSize: width * (10 / width),
          //       //   color: AppColor.yellowColor,
          //       // ),
          //       reverseAxis: false,
          //       sides: 8,
          //       data: [actualData, goalData],
          //       graphColors: [AppColor.primaryColor, Colors.green],
          //       featuresTextStyle: TextStyle(
          //         fontSize: width * (12 / width),
          //         color: AppColor.black,
          //       ),
          //       outlineColor: Colors.grey,
          //       axisColor: Colors.red,
          //     ),
          //   ),
          // ),
          SizedBox(height: width * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [SvgPicture.asset(AppSvg.arrowRightIcon)],
          ),
        ],
      ),
    );
  }
}
