import 'package:flutter_svg/svg.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/core/routes/route_import.dart';

Widget buildGoalsMilestonesDetails(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
      ],
    ),
  );
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
