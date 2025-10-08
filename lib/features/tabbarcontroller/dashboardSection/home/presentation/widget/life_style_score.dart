import 'dart:math';

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
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w700,

                  color: AppColor.textColor,
                ),
                PlusJakartaSansApptext(
                  text: "LifeStyle Score",
                  fontSize: width * 0.03,
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

            SizedBox(height: width * 0.01),

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
            SizedBox(height: width * 0.01),
            CustomButton(
              text: ' Log Activity',
              onPressed: () {},
              color: AppColor.primaryColor,
              textColor: AppColor.white,
              fontSize: width * 0.03,
              height: height * 0.05,
              width: width * 0.40,
              fontWeight: FontWeight.w500,
              borderRadius: width * 0.02,
              borderColor: AppColor.primaryColor,
            ),
            SizedBox(height: width * 0.01),

            Container(
              width: width * 0.45,
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
              child: CustomPaint(
                child: RadarChart(
                  ticks: ticks,
                  features: features,
                  reverseAxis: false,
                  sides: 8,
                  data: [actualData, goalData],
                  graphColors: [
                    AppColor.primaryColor.withOpacity(0.6),
                    Colors.green.withOpacity(0.5),
                  ],
                  featuresTextStyle: TextStyle(
                    fontSize: width * (12 / width),
                    color: AppColor.black,
                  ),
                  outlineColor: Colors.grey,
                  axisColor: AppColor.primaryColor,
                ),
              ),
            ),
          ),

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

class DottedRadarPainter extends CustomPainter {
  final List<double> actualData;
  final List<double> goalData;
  final List<String> features;
  final Color outlineColor;
  final Color axisColor;
  final Color actualColor;
  final Color goalColor;

  DottedRadarPainter({
    required this.actualData,
    required this.goalData,
    required this.features,
    required this.outlineColor,
    required this.axisColor,
    required this.actualColor,
    required this.goalColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint axisPaint = Paint()
      ..color = axisColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8; // ✅ thinner lines

    final Paint outlinePaint = Paint()
      ..color = outlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final Paint actualPaint = Paint()
      ..color = actualColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Paint goalPaint = Paint()
      ..color = goalColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.42;
    final sides = features.length;
    final angle = (2 * pi) / sides;

    // ✅ Draw axes (thin)
    for (int i = 0; i < sides; i++) {
      final x = center.dx + radius * cos(angle * i - pi / 2);
      final y = center.dy + radius * sin(angle * i - pi / 2);
      canvas.drawLine(center, Offset(x, y), axisPaint);
    }

    // ✅ Actual data line (solid)
    final Path actualPath = Path();
    for (int i = 0; i < sides; i++) {
      final r = (actualData[i] / 100) * radius;
      final x = center.dx + r * cos(angle * i - pi / 2);
      final y = center.dy + r * sin(angle * i - pi / 2);
      if (i == 0) {
        actualPath.moveTo(x, y);
      } else {
        actualPath.lineTo(x, y);
      }
    }
    actualPath.close();
    canvas.drawPath(actualPath, actualPaint);

    // ✅ Goal data line (dotted)
    final Path goalPath = Path();
    for (int i = 0; i < sides; i++) {
      final r = (goalData[i] / 100) * radius;
      final x = center.dx + r * cos(angle * i - pi / 2);
      final y = center.dy + r * sin(angle * i - pi / 2);
      if (i == 0) {
        goalPath.moveTo(x, y);
      } else {
        goalPath.lineTo(x, y);
      }
    }
    goalPath.close();

    // Draw as dashed line
    final Path dashedPath = Path();
    const dashWidth = 4.0;
    const dashSpace = 3.0;
    for (final metric in goalPath.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        dashedPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashedPath, goalPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}



































































//------------rought part




// class ChartSection extends StatelessWidget {
//   final double width;
//   final double height;
//   final List<String> features;
//   final List<double> actualData;
//   final List<double> goalData;

//   const ChartSection({
//     super.key,
//     required this.width,
//     required this.height,
//     required this.features,
//     required this.actualData,
//     required this.goalData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // final ticks = [20, 40, 60, 80, 100];
//     final ticks = [20.0, 40.0, 60.0, 80.0, 100.0];

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: width * (24 / width),
//                         child: Divider(
//                           color: AppColor.primaryColor3,
//                           thickness: 1,
//                         ),
//                       ),
//                       SizedBox(width: 6),
//                       PlusJakartaSansApptext(
//                         text: 'Actual',
//                         fontSize: width * (14 / width),
//                         fontWeight: FontWeight.w600,
//                         color: AppColor.primaryColor3,
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: width * (25 / width),
//                         child: DottedLine(dashGapLength: 1),
//                       ),
//                       SizedBox(width: 6),
//                       PlusJakartaSansApptext(
//                         text: 'Goal',
//                         fontSize: width * (14 / width),
//                         fontWeight: FontWeight.w600,
//                         color: AppColor.greenColor,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SvgPicture.asset(
//                 AppSvg.expandIcon,
//                 width: width * (25 / width),
//                 color: AppColor.black,
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               // other widgets
//               SizedBox(
//                 width: width * 0.7,
//                 height: width * 0.7,
//                 child: RepaintBoundary(
//                   child: CustomPaint(
//                     painter: RadarPainter(
//                       features: features,
//                       actualData: actualData,
//                       goalData: goalData,
//                       ticks: ticks,
//                       width: width,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Center(
//           //   child: SizedBox(
//           //     width: width * 0.35,
//           //     height: width * 0.35,
//           //     child: RadarChart(
//           //       ticks: ticks,
//           //       features: features,
//           //       reverseAxis: false,
//           //       sides: 8,
//           //       data: [actualData, goalData],
//           //       graphColors: [AppColor.primaryColor, Colors.green],
//           //       featuresTextStyle: TextStyle(
//           //         fontSize: width * (12 / width),
//           //         color: AppColor.black,
//           //       ),
//           //       outlineColor: Colors.grey,
//           //       axisColor: Colors.red,
//           //     ),
//           //   ),
//           // ),

//           // Expanded(
//           //   child: Center(
//           //     child: RadarChart(
//           //       ticks: ticks,
//           //       features: features,
//           //       // ticksTextStyle: TextStyle(
//           //       //   fontSize: width * (10 / width),
//           //       //   color: AppColor.yellowColor,
//           //       // ),
//           //       reverseAxis: false,
//           //       sides: 8,
//           //       data: [actualData, goalData],
//           //       graphColors: [AppColor.primaryColor, Colors.green],
//           //       featuresTextStyle: TextStyle(
//           //         fontSize: width * (12 / width),
//           //         color: AppColor.black,
//           //       ),
//           //       outlineColor: Colors.grey,
//           //       axisColor: Colors.red,
//           //     ),
//           //   ),
//           // ),
//           SizedBox(height: width * 0.02),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,

//             children: [SvgPicture.asset(AppSvg.arrowRightIcon)],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class RadarPainter extends CustomPainter {
//   final List<String> features;
//   final List<double> actualData;
//   final List<double> goalData;
//   final List<double> ticks;
//   final double width;

//   RadarPainter({
//     required this.features,
//     required this.actualData,
//     required this.goalData,
//     required this.ticks,
//     required this.width,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint axisPaint = Paint()
//       ..color = Colors.grey.shade400
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.5;

//     final Paint actualPaint = Paint()
//       ..color = Colors.orange.shade700.withOpacity(0.3)
//       ..style = PaintingStyle.fill;

//     final Paint actualLinePaint = Paint()
//       ..color = Colors.orange.shade700
//       ..strokeWidth = 1.5
//       ..style = PaintingStyle.stroke;

//     final Paint goalLinePaint = Paint()
//       ..color = Colors.green
//       ..strokeWidth = 1.2
//       ..style = PaintingStyle.stroke;

//     final Paint dotPaint = Paint()..color = Colors.green;

//     final Offset center = Offset(size.width / 2, size.height / 2);
//     final double radius = size.width / 2.5;
//     final int sides = features.length;

//     final double angleStep = (2 * 3.141592653589793) / sides;

//     // Draw axes
//     for (int i = 0; i < sides; i++) {
//       final double angle = angleStep * i - 3.141592653589793 / 2;
//       final Offset end = Offset(
//         center.dx + radius * cos(angle),
//         center.dy + radius * sin(angle),
//       );
//       canvas.drawLine(center, end, axisPaint);
//     }

//     // Draw grid circles
//     for (double t in ticks) {
//       double r = radius * (t / 100);
//       canvas.drawCircle(center, r, axisPaint);
//     }

//     // Draw goal dotted path
//     final Path goalPath = Path();
//     for (int i = 0; i < sides; i++) {
//       final double angle = angleStep * i - 3.141592653589793 / 2;
//       final double r = radius * (goalData[i] / 100);
//       final Offset point = Offset(
//         center.dx + r * cos(angle),
//         center.dy + r * sin(angle),
//       );
//       if (i == 0) {
//         goalPath.moveTo(point.dx, point.dy);
//       } else {
//         goalPath.lineTo(point.dx, point.dy);
//       }
//     }
//     goalPath.close();

//     // Create dotted effect using PathMetrics
//     final PathMetrics metrics = goalPath.computeMetrics();
//     for (final metric in metrics) {
//       double distance = 0.0;
//       while (distance < metric.length) {
//         final extract = metric.extractPath(distance, distance + 4);
//         canvas.drawPath(extract, goalLinePaint);
//         distance += 8;
//       }
//     }

//     // Draw goal dots
//     for (int i = 0; i < sides; i++) {
//       final double angle = angleStep * i - 3.141592653589793 / 2;
//       final double r = radius * (goalData[i] / 100);
//       final Offset point = Offset(
//         center.dx + r * cos(angle),
//         center.dy + r * sin(angle),
//       );
//       canvas.drawCircle(point, 3, dotPaint);
//     }

//     // Draw actual line
//     final Path actualPath = Path();
//     for (int i = 0; i < sides; i++) {
//       final double angle = angleStep * i - 3.141592653589793 / 2;
//       final double r = radius * (actualData[i] / 100);
//       final Offset point = Offset(
//         center.dx + r * cos(angle),
//         center.dy + r * sin(angle),
//       );
//       if (i == 0) {
//         actualPath.moveTo(point.dx, point.dy);
//       } else {
//         actualPath.lineTo(point.dx, point.dy);
//       }
//     }
//     actualPath.close();

//     canvas.drawPath(actualPath, actualPaint);
//     canvas.drawPath(actualPath, actualLinePaint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
