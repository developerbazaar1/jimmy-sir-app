import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jimmy_sir_app/core/components/apptext/plus_jakarta_sans.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/constants/enum.dart';
import 'package:jimmy_sir_app/core/routes/route_import.dart';
import 'package:jimmy_sir_app/features/tabbarSection/dashboardSection/home/presentation/widget/customRaderChart.dart';
import 'package:jimmy_sir_app/features/tabbarSection/dashboardSection/home/providers/graph_provider.dart';

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
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final graphData = ref.watch(graphProvider);

    return 
    
    Container(
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
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UrbanistApptext(
                  text: AppText.buildTodayProgress,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w700,

                  color: AppColor.textColor,
                ),
                PlusJakartaSansApptext(
                  text: graphData.title,
                  fontSize: width * 0.03,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textBrownColor,
                ),
              ],
            ),

            SizedBox(height: width * 0.04),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.012,
                vertical: height * 0.015,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: width * 0.02,
                    offset: const Offset(0, 2),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(width * 0.02),
                border: Border.all(color: AppColor.border.withOpacity(0.2)),
              ),

              child: ChartSection(width: width, height: height),
            ),
            SizedBox(height: width * 0.01),

            //chart section
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.06),
                      color: graphData.type == ScoreType.nutrition
                          ? AppColor.greyColor.withOpacity(0.3)
                          : AppColor.primaryColor,
                    ),
                    width: width * 0.150,
                    height: height * 0.00858,
                  ),
                  SizedBox(width: width * 0.02),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.06),
                      color: graphData.type == ScoreType.lifestyle
                          ? AppColor.greyColor.withOpacity(0.3)
                          : AppColor.primaryColor,
                    ),
                    width: width * 0.150,
                    height: height * 0.00858,
                  ),
                ],
              ),
            ),
            SizedBox(height: width * 0.01),
            CustomButton(
              // text: ' Log Activity',
              text: graphData.type == ScoreType.lifestyle
                  ? AppText.logActivity
                  : AppText.logMeal,
              onPressed: () {},
              color: AppColor.primaryColor,
              textColor: AppColor.white,
              fontSize: width * 0.03,
              height: height * 0.04,
              width: width * 0.50,
              fontWeight: FontWeight.w500,
              borderRadius: width * 0.02,
              borderColor: AppColor.primaryColor,
            ),
            SizedBox(height: width * 0.02),

            Container(
              width: width * 0.50,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(width * 0.02),
                border: Border.all(color: AppColor.border.withOpacity(0.2)),
              ),
              child: Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      AppSvg.tadaCelebrateIcon,
                      height: height * 0.02,
                      width: width * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlusJakartaSansApptext(
                          text: 'Complete today’s logs to earn:',
                          fontSize: width * 0.02,
                          fontWeight: FontWeight.w500,
                          color: AppColor.textColor,
                        ),

                        PlusJakartaSansApptext(
                          text: '10% cashback / xxx',
                          fontSize: width * 0.02,
                          fontWeight: FontWeight.w500,
                          color: AppColor.textBrownColor,
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

class ChartSection extends ConsumerWidget {
  final double width;
  final double height;

  const ChartSection({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graphData = ref.watch(graphProvider);
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
                        width: width * 0.060,
                        child: Divider(
                          color: AppColor.primaryColor3,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      PlusJakartaSansApptext(
                        text: AppText.actual,
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primaryColor3,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.060,
                        child: DottedLine(dashGapLength: 1),
                      ),
                      SizedBox(width: width * 0.02),
                      PlusJakartaSansApptext(
                        text: AppText.goal,
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.w600,
                        color: AppColor.greenColor,
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  context.pushNamed(
                    RouteNames.graphExpandScreen,
                    extra: ref.read(graphProvider),
                  );
                },
                child: SvgPicture.asset(
                  AppSvg.expandIcon,
                  width: width * 0.060,
                  color: AppColor.black,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.03),
          CustomRadarChart(
            features: graphData.features,
            actualData: graphData.actual,
            goalData: graphData.goal,
          ),

          SizedBox(height: width * 0.02),

          // Toggle and historical trends section
          Row(
            mainAxisAlignment: graphData.type == ScoreType.lifestyle
                ? MainAxisAlignment.end
                : MainAxisAlignment.spaceBetween,
            children: [
              if (graphData.type == ScoreType.nutrition) ...[
                GestureDetector(
                  onTap: () => ref.read(graphProvider.notifier).toggleScore(),
                  child: Container(
                    width: width * 0.06,
                    height: width * 0.06,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.greyColor.withOpacity(0.4),
                    ),
                    child: SvgPicture.asset(
                      AppSvg.arrowLeftIcon,
                      width: width * 0.02,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      RouteNames.historicalTrendsScreen,
                      extra: ref.read(graphProvider),
                    );
                  },
                  child: PlusJakartaSansApptext(
                    text: AppText.historicalTrends,
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w600,
                    underline: true,
                    color: AppColor.primaryColor,
                  ),
                ),
              ] else ...[
                GestureDetector(
                  onTap: () => ref.read(graphProvider.notifier).toggleScore(),
                  child: SvgPicture.asset(
                    AppSvg.arrowRightIcon,
                    width: width * 0.08,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}










































































//-----------------------------wrough work---------------------------------------
// //-------------custom raidr painter-----------------------
// class CustomRadarChart extends StatelessWidget {
//   final List<String> features;
//   final List<double> actualData;
//   final List<double> goalData;
//   final int levels;
//   final double maxValue;

//   const CustomRadarChart({
//     super.key,
//     required this.features,
//     required this.actualData,
//     required this.goalData,
//     this.levels = 6,
//     this.maxValue = 100,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return CustomPaint(
//       size: Size(width * 0.380, height * 0.190), // You can make this dynamic
//       painter: RadarChartPainter(
//         features: features,
//         actualData: actualData,
//         goalData: goalData,
//         levels: levels,
//         maxValue: maxValue,
//       ),
//     );
//   }
// }

// class RadarChartPainter extends CustomPainter {
//   final List<String> features;
//   final List<double> actualData;
//   final List<double> goalData;
//   final int levels;
//   final double maxValue;

//   RadarChartPainter({
//     required this.features,
//     required this.actualData,
//     required this.goalData,
//     required this.levels,
//     required this.maxValue,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final int sides = features.length;
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = min(size.width, size.height) / 2 * 0.9;
//     final angle = (2 * pi) / sides;

//     //  Grid ring color pattern
//     final List<Color> gridColors = [
//       Colors.grey,
//       Colors.red,
//       Colors.red,
//       Colors.orange.withOpacity(0.6),
//       Colors.orange.withOpacity(0.6),
//     ];

//     final Paint axisPaint = Paint()
//       ..color = AppColor.textGreyColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.6;

//     final Paint actualPaint = Paint()
//       ..color = Color(0xffCC7A2A).withOpacity(0.3)
//       ..style = PaintingStyle.fill;

//     final Paint goalPaint = Paint()
//       ..color = Color(0xff6BA03A)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.8;

//     // 1. Draw background grid (polygons) with custom colors
//     for (int i = 1; i <= levels; i++) {
//       final r = radius * (i / levels);
//       final path = Path();

//       for (int j = 0; j < sides; j++) {
//         final x = center.dx + r * cos(angle * j - pi / 2);
//         final y = center.dy + r * sin(angle * j - pi / 2);
//         if (j == 0) {
//           path.moveTo(x, y);
//         } else {
//           path.lineTo(x, y);
//         }
//       }
//       path.close();

//       // Use color from gridColors list (wrap around if needed)
//       final color = gridColors[(i - 1) % gridColors.length];

//       final Paint gridPaint = Paint()
//         ..color = color
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 0.4;

//       canvas.drawPath(path, gridPaint);
//     }

//     // 2. Draw axis lines
//     for (int i = 0; i < sides; i++) {
//       final x = center.dx + radius * cos(angle * i - pi / 2);
//       final y = center.dy + radius * sin(angle * i - pi / 2);
//       canvas.drawLine(center, Offset(x, y), axisPaint);
//     }

//     // 3. Draw actualData shape (filled orange)
//     final Path actualPath = Path();
//     for (int i = 0; i < sides; i++) {
//       final value = actualData[i] / maxValue;
//       final r = value * radius;
//       final x = center.dx + r * cos(angle * i - pi / 2);
//       final y = center.dy + r * sin(angle * i - pi / 2);
//       if (i == 0) {
//         actualPath.moveTo(x, y);
//       } else {
//         actualPath.lineTo(x, y);
//       }
//     }
//     actualPath.close();
//     canvas.drawPath(actualPath, actualPaint);

//     // 4. Draw goalData shape (dotted orange)
//     final Path goalPath = Path();
//     for (int i = 0; i < sides; i++) {
//       final value = goalData[i] / maxValue;
//       final r = value * radius;
//       final x = center.dx + r * cos(angle * i - pi / 2);
//       final y = center.dy + r * sin(angle * i - pi / 2);
//       if (i == 0) {
//         goalPath.moveTo(x, y);
//       } else {
//         goalPath.lineTo(x, y);
//       }
//     }
//     goalPath.close();

//     // Dotted/dashed path
//     const dashWidth = 3.0;
//     const dashSpace = 2.0;
//     final Path dashedPath = Path();
//     for (final metric in goalPath.computeMetrics()) {
//       double distance = 0.0;
//       while (distance < metric.length) {
//         dashedPath.addPath(
//           metric.extractPath(distance, distance + dashWidth),
//           Offset.zero,
//         );
//         distance += dashWidth + dashSpace;
//       }
//     }
//     canvas.drawPath(dashedPath, goalPaint);

//     // 5. Draw dots on vertices
//     final Paint dotPaint = Paint()..style = PaintingStyle.fill;
//     for (int i = 0; i < sides; i++) {
//       final rActual = actualData[i] / maxValue * radius;
//       final xActual = center.dx + rActual * cos(angle * i - pi / 2);
//       final yActual = center.dy + rActual * sin(angle * i - pi / 2);
//       dotPaint.color = Color(0xffCC7A2A);
//       canvas.drawCircle(Offset(xActual, yActual), 2, dotPaint);

//       final rGoal = goalData[i] / maxValue * radius;
//       final xGoal = center.dx + rGoal * cos(angle * i - pi / 2);
//       final yGoal = center.dy + rGoal * sin(angle * i - pi / 2);
//       dotPaint.color = Color(0xff6BA03A);
//       canvas.drawCircle(Offset(xGoal, yGoal), 2, dotPaint);
//     }

//     // 6. Draw feature labels
//     final textStyle = const TextStyle(color: Colors.black, fontSize: 14);
//     for (int i = 0; i < sides; i++) {
//       final label = features[i];
//       final textPainter = TextPainter(
//         text: TextSpan(text: label, style: textStyle),
//         textAlign: TextAlign.center,
//         textDirection: TextDirection.ltr,
//       )..layout(maxWidth: 100);

//       final r = radius + 35;
//       final x = center.dx + r * cos(angle * i - pi / 2);
//       final y = center.dy + r * sin(angle * i - pi / 2);

//       canvas.save();
//       canvas.translate(x - textPainter.width / 2, y - textPainter.height / 2);
//       textPainter.paint(canvas, Offset.zero);
//       canvas.restore();
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }































//----------------wrough work----------------------


// class ReusableRadarChart extends StatelessWidget {
//   final List<String>
//   features; // e.g. ["Stress", "Sleep", "Physical", "Hydration"]
//   final List<double> actual; // same length as features
//   final List<double> goal; // same length as features
//   final int threadCount; // e.g. 6
//   final double maxValue; // maximum value scale (e.g. 100)
//   final Color actualColor;
//   final Color goalColor;
//   final Color gridColor;
//   final TextStyle labelStyle;

//   const ReusableRadarChart({
//     Key? key,
//     required this.features,
//     required this.actual,
//     required this.goal,
//     this.threadCount = 6,
//     this.maxValue = 100,
//     this.actualColor = Colors.orange,
//     this.goalColor = Colors.green,
//     this.gridColor = const Color(0xFFCCCCCC),
//     this.labelStyle = const TextStyle(fontSize: 12, color: Colors.black),
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     assert(
//       features.length == actual.length && features.length == goal.length,
//       "features, actual, goal must have the same length",
//     );

//     return RadarChart(
//       RadarChartData(
//         radarBackgroundColor: Colors.transparent,
//         radarShape: RadarShape.polygon,
//         tickCount: threadCount,
//         ticksTextStyle: const TextStyle(color: Colors.transparent),
//         // getTitle: (int index) {
//         //   return RadarChartTitle(
//         //     text: features[index],
//         //     textStyle: labelStyle,
//         //   );
//         // },
//         radarBorderData: BorderSide(color: gridColor, width: 0.6),
//         tickBorderData: BorderSide(color: gridColor, width: 0.3),
//         gridBorderData: BorderSide(color: gridColor, width: 0.3),
//         // You can choose whether to draw the inner grid (polygons) or not
//         // The below shows data sets
//         dataSets: [
//           // Actual (solid orange)
//           RadarDataSet(
//             fillColor: actualColor.withOpacity(0.3),
//             borderColor: actualColor,
//             entryRadius: 3,
//             borderWidth: 2,
//             dataEntries: actual.map((e) => RadarEntry(value: e)).toList(),
//           ),
//           // Goal (dotted green)
//           RadarDataSet(
//             fillColor: Colors.transparent,
//             borderColor: goalColor,
//             borderWidth: 1.8,
//             entryRadius: 4,
//             dataEntries: goal.map((e) => RadarEntry(value: e)).toList(),
//             // borderDashArray: [6, 3], // dotted style
//           ),
//         ],
//       ),
//     );
//   }
// }

//--3rdd graph
// class CustomRadarChart extends StatelessWidget {
//   const CustomRadarChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Features shown on each axis
//     const features = [
//       'Sleep Quality',
//       'Physical Activity',
//       'Hydration',
//       'Stress Management',
//     ];

//     // Actual data (orange solid)
//     final actualData = [60.0, 55.0, 50.0, 48.0];

//     // Goal data (green dotted)
//     final goalData = [75.0, 70.0, 65.0, 60.0];

//     return Center(
//       child: SizedBox(
//         width: 300,
//         height: 300,
//         child: RadarChart(
//           RadarChartData(
//             radarBackgroundColor: Colors.transparent,
//             radarShape: RadarShape.polygon,
//             tickCount: 5,
//             ticksTextStyle: const TextStyle(
//               color: Colors.transparent, // Hide ticks text
//             ),
//             // getTitle: (index) {
//             //   return RadarChartTitle(
//             //     text: features[index],
//             //     textStyle: const TextStyle(
//             //       fontSize: 14,
//             //       fontWeight: FontWeight.w500,
//             //       color: Colors.black,
//             //     ),
//             //   );
//             // },
//             radarBorderData: const BorderSide(
//               color: Colors.black87,
//               width: 0.4,
//             ),
//             tickBorderData: BorderSide(
//               color: Colors.orange.withOpacity(0.3),
//               width: 0.4,
//             ),
//             gridBorderData: BorderSide(
//               color: Colors.orange.withOpacity(0.3),
//               width: 0.4,
//             ),
//             dataSets: [
//               // Actual (solid orange)
//               RadarDataSet(
//                 fillColor: Colors.orange.withOpacity(0.3),
//                 borderColor: Colors.orange,
//                 entryRadius: 3,
//                 borderWidth: 2,
//                 dataEntries: actualData
//                     .map((e) => RadarEntry(value: e))
//                     .toList(),
//               ),

//               // Goal (dotted green)
//               RadarDataSet(
//                 fillColor: Colors.transparent,
//                 borderColor: Colors.green,
//                 borderWidth: 2,
//                 // borderDashArray: [6, 3], // Dotted line
//                 entryRadius: 4,
//                 dataEntries: goalData.map((e) => RadarEntry(value: e)).toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }






//2 ATTEMPT
// class RadarChartPainter extends CustomPainter {
//   final List<String> features;
//   final List<double> actualData;
//   final List<double> goalData;
//   final int levels;
//   final double maxValue;

//   RadarChartPainter({
//     required this.features,
//     required this.actualData,
//     required this.goalData,
//     required this.levels,
//     required this.maxValue,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final int sides = features.length;
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = min(size.width, size.height) / 2 * 0.8;
//     final angle = (2 * pi) / sides;

//     final Paint gridPaint = Paint()
//       ..color = AppColor.textGreyColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.4;

//     final Paint axisPaint = Paint()
//       ..color = AppColor.textGreyColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.6;

//     final Paint actualPaint = Paint()
//       ..color = Colors.orange.withOpacity(0.5)
//       ..style = PaintingStyle.fill;

//     final Paint goalPaint = Paint()
//       ..color = Colors.green
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.3;

//     // 1. Draw background grid (polygons)
//     for (int i = 1; i <= levels; i++) {
//       final r = radius * (i / levels);
//       final path = Path();
//       for (int j = 0; j < sides; j++) {
//         final x = center.dx + r * cos(angle * j - pi / 2);
//         final y = center.dy + r * sin(angle * j - pi / 2);
//         if (j == 0) {
//           path.moveTo(x, y);
//         } else {
//           path.lineTo(x, y);
//         }
//       }
//       path.close();
//       canvas.drawPath(path, gridPaint);
//     }

//     // 2. Draw axis lines
//     for (int i = 0; i < sides; i++) {
//       final x = center.dx + radius * cos(angle * i - pi / 2);
//       final y = center.dy + radius * sin(angle * i - pi / 2);
//       canvas.drawLine(center, Offset(x, y), axisPaint);
//     }

//     // 3. Draw actualData shape
//     final Path actualPath = Path();
//     for (int i = 0; i < sides; i++) {
//       final value = actualData[i] / maxValue;
//       final r = value * radius;
//       final x = center.dx + r * cos(angle * i - pi / 2);
//       final y = center.dy + r * sin(angle * i - pi / 2);
//       if (i == 0) {
//         actualPath.moveTo(x, y);
//       } else {
//         actualPath.lineTo(x, y);
//       }
//     }
//     actualPath.close();
//     canvas.drawPath(actualPath, actualPaint);

//     // 4. Draw goalData shape (dotted)
//     final Path goalPath = Path();
//     for (int i = 0; i < sides; i++) {
//       final value = goalData[i] / maxValue;
//       final r = value * radius;
//       final x = center.dx + r * cos(angle * i - pi / 2);
//       final y = center.dy + r * sin(angle * i - pi / 2);
//       if (i == 0) {
//         goalPath.moveTo(x, y);
//       } else {
//         goalPath.lineTo(x, y);
//       }
//     }
//     goalPath.close();

//     // Dashed/dotted path
//     const dashWidth = 4.0;
//     const dashSpace = 3.0;
//     final Path dashedPath = Path();
//     for (final metric in goalPath.computeMetrics()) {
//       double distance = 0.0;
//       while (distance < metric.length) {
//         dashedPath.addPath(
//           metric.extractPath(distance, distance + dashWidth),
//           Offset.zero,
//         );
//         distance += dashWidth + dashSpace;
//       }
//     }
//     canvas.drawPath(dashedPath, goalPaint);

//     // 5. Draw dots on vertices
//     final Paint dotPaint = Paint()..style = PaintingStyle.fill;

//     for (int i = 0; i < sides; i++) {
//       final rActual = actualData[i] / maxValue * radius;
//       final xActual = center.dx + rActual * cos(angle * i - pi / 2);
//       final yActual = center.dy + rActual * sin(angle * i - pi / 2);
//       dotPaint.color = Colors.orange;
//       canvas.drawCircle(Offset(xActual, yActual), 3, dotPaint);

//       final rGoal = goalData[i] / maxValue * radius;
//       final xGoal = center.dx + rGoal * cos(angle * i - pi / 2);
//       final yGoal = center.dy + rGoal * sin(angle * i - pi / 2);
//       dotPaint.color = Colors.green;
//       canvas.drawCircle(Offset(xGoal, yGoal), 3, dotPaint);
//     }

//     // 6. Draw labels
//     final textStyle = const TextStyle(color: Colors.black, fontSize: 14);
//     for (int i = 0; i < sides; i++) {
//       final label = features[i];
//       final textPainter = TextPainter(
//         text: TextSpan(text: label, style: textStyle),
//         textAlign: TextAlign.center,
//         textDirection: TextDirection.ltr,
//       )..layout(maxWidth: 100);

//       final r = radius + 20;
//       final x = center.dx + r * cos(angle * i - pi / 2);
//       final y = center.dy + r * sin(angle * i - pi / 2);

//       canvas.save();
//       canvas.translate(x - textPainter.width / 2, y - textPainter.height / 2);
//       textPainter.paint(canvas, Offset.zero);
//       canvas.restore();
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }


//------------------custom radar painter---------------------













//-------------------------this is for an fortune --------

// class DottedRadarPainter extends CustomPainter {
//   final List<double> actualData;
//   final List<double> goalData;
//   final List<String> features;
//   final Color outlineColor;
//   final Color axisColor;
//   final Color actualColor;
//   final Color goalColor;

//   DottedRadarPainter({
//     required this.actualData,
//     required this.goalData,
//     required this.features,
//     required this.outlineColor,
//     required this.axisColor,
//     required this.actualColor,
//     required this.goalColor,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint axisPaint = Paint()
//       ..color = axisColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.8; // ✅ thinner lines

//     final Paint outlinePaint = Paint()
//       ..color = outlineColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.5;

//     final Paint actualPaint = Paint()
//       ..color = actualColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.5;

//     final Paint goalPaint = Paint()
//       ..color = goalColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.5;

//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width * 0.42;
//     final sides = features.length;
//     final angle = (2 * pi) / sides;

//     // ✅ Draw axes (thin)
//     for (int i = 0; i < sides; i++) {
//       final x = center.dx + radius * cos(angle * i - pi / 2);
//       final y = center.dy + radius * sin(angle * i - pi / 2);
//       canvas.drawLine(center, Offset(x, y), axisPaint);
//     }

//     // ✅ Actual data line (solid)
//     final Path actualPath = Path();
//     for (int i = 0; i < sides; i++) {
//       final r = (actualData[i] / 100) * radius;
//       final x = center.dx + r * cos(angle * i - pi / 2);
//       final y = center.dy + r * sin(angle * i - pi / 2);
//       if (i == 0) {
//         actualPath.moveTo(x, y);
//       } else {
//         actualPath.lineTo(x, y);
//       }
//     }
//     actualPath.close();
//     canvas.drawPath(actualPath, actualPaint);

//     // ✅ Goal data line (dotted)
//     final Path goalPath = Path();
//     for (int i = 0; i < sides; i++) {
//       final r = (goalData[i] / 100) * radius;
//       final x = center.dx + r * cos(angle * i - pi / 2);
//       final y = center.dy + r * sin(angle * i - pi / 2);
//       if (i == 0) {
//         goalPath.moveTo(x, y);
//       } else {
//         goalPath.lineTo(x, y);
//       }
//     }
//     goalPath.close();

//     // Draw as dashed line
//     final Path dashedPath = Path();
//     const dashWidth = 4.0;
//     const dashSpace = 3.0;
//     for (final metric in goalPath.computeMetrics()) {
//       double distance = 0.0;
//       while (distance < metric.length) {
//         dashedPath.addPath(
//           metric.extractPath(distance, distance + dashWidth),
//           Offset.zero,
//         );
//         distance += dashWidth + dashSpace;
//       }
//     }
//     canvas.drawPath(dashedPath, goalPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }


//------------------------------------forutne--------------


































































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
