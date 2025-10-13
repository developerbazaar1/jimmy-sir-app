import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/core/components/apptext/plus_jakarta_sans.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_import.dart';
import 'package:jimmy_sir_app/features/tabbarSection/dashboardSection/home/presentation/widget/customRaderChart.dart';
import 'package:jimmy_sir_app/features/tabbarSection/dashboardSection/home/providers/graph_provider.dart';

class GraphExpandScreen extends ConsumerWidget {
  final GraphData graphData;

  const GraphExpandScreen({super.key, required this.graphData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.white,

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.06,
          vertical: height * 0.06,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UrbanistApptext(
                  text: graphData.title,
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(Icons.cancel_outlined, color: AppColor.black),
                ),
              ],
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

            Center(
              child: Container(
                // alignment: Alignment.topLeft,
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
            ),

            SizedBox(height: height * 0.1),
          ],
        ),
      ),
    );
  }
}
