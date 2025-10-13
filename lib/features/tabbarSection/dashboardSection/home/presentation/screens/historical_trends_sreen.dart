import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/apptext/plus_jakarta_sans.dart';
import 'package:jimmy_sir_app/core/components/apptext/poppins_apptext.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/features/tabbarSection/dashboardSection/home/presentation/widget/customRaderChart.dart';
import 'package:jimmy_sir_app/features/tabbarSection/dashboardSection/home/providers/graph_history_povider.dart';
import 'package:jimmy_sir_app/features/tabbarSection/dashboardSection/home/providers/graph_provider.dart';

class HistoricalTrendsScreen extends ConsumerWidget {
  final GraphData graphData;
  const HistoricalTrendsScreen({super.key, required this.graphData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final graphHistory = ref.watch(graphHistoryProvider);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar2(
        title: "Nutrition Trends",
        onBackTap: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
            Container(
              width: width,
              height: height * 0.05,
              decoration: BoxDecoration(
                color: AppColor.primaryColor2.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.01,
                ),
                child: UrbanistApptext(
                  text: "Today",
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textBrownColor,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: CustomRadarChart(
                  size: Size(width * 0.600, height * 0.300),
                  features: graphData.features,
                  actualData: graphData.actual,
                  goalData: graphData.goal,
                ),
              ),
            ),
            Container(
              width: width,
              height: height * 0.05,
              decoration: BoxDecoration(
                color: AppColor.primaryColor2.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.01,
                ),
                child: UrbanistApptext(
                  text: "History",
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textBrownColor,
                ),
              ),
            ),

            SizedBox(height: height * 0.01),
            SizedBox(
              height: height * 0.30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: graphHistory.length,
                itemBuilder: (context, index) {
                  return GraphSection(
                    width: width,
                    height: height,
                    graphData: graphHistory[index],
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.02),
            Container(
              height: height * 0.08,
              width: width * 0.500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width * 0.02),
                border: Border.all(color: AppColor.greenColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.070,
                        child: Divider(
                          color: AppColor.primaryColor3,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      PlusJakartaSansApptext(
                        text: AppText.actual,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primaryColor3,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.070,
                        child: DottedLine(dashGapLength: 1),
                      ),
                      SizedBox(width: width * 0.02),
                      PlusJakartaSansApptext(
                        text: AppText.goal,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                        color: AppColor.greenColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.04),
          ],
        ),
      ),
    );
  }
}

class GraphSection extends ConsumerWidget {
  final double width;
  final double height;
  final GraphData graphData;

  const GraphSection({
    super.key,
    required this.width,
    required this.height,
    required this.graphData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graphData = ref.watch(graphProvider);
    return Container(
      width: width * 0.7,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.01,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.06,
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
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PoppinsApptext(
                text: "11 Sep 2025",
                fontSize: height * 0.02,
                fontWeight: FontWeight.w500,
                color: AppColor.textBrownColor,
              ),
            ],
          ),
          SizedBox(height: height * 0.01),
          CustomRadarChart(
            size: Size(width * 0.360, height * 0.200),
            features: graphData.features,
            actualData: graphData.actual,
            goalData: graphData.goal,
          ),
        ],
      ),
    );
  }
}
