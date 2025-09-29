import 'package:flutter/material.dart';
import 'package:jimmy_sir_app/core/components/apptext/plus_jakarta_sans.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/components/apptext/urbanist_apptext.dart';
import 'radar_chart_graphic.dart';

class LifeStyleScore extends StatelessWidget {
  const LifeStyleScore({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
        color: AppColor.white,
        borderRadius: BorderRadius.circular(width * (16 / width)),
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
                  color: AppColor.primaryColor3,
                ),
              ],
            ),
            SizedBox(height: width * (16 / width)),

            // const ChartSection(),
            Container(
              width: width,
              height: width * (200 / width),
              decoration: BoxDecoration(
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                ],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(width * (16 / width)),
              ),

              child: Column(children: [Text('Hello')]),
            ),

            SizedBox(height: width * (16 / width)),

            CustomButton(
              text: '+ Log Activity',

              onPressed: () {},
              color: AppColor.primaryColor,
              textColor: AppColor.white,
              fontSize: width * (14 / width),
              height: width * (40 / width),
              width: width * (200 / width),
              fontWeight: FontWeight.w500,
              borderRadius: width * (16 / width),
              borderColor: AppColor.primaryColor,
            ),
            SizedBox(height: width * (16 / width)),

            Container(
              width: width * (200 / width),
              //  height: width * (100 / width),
              decoration: BoxDecoration(
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                ],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(width * (16 / width)),
              ),
              child: Row(
                children: [
                  //  Image.asset(AppImages.profileImage),
                  Column(children: [Text('Hello'), Text('Hello')]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
