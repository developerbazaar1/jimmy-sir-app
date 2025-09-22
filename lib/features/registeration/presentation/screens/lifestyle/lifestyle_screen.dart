import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';

class LifestyleScreen extends ConsumerWidget {
  const LifestyleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.white,

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColor.primaryColor.withOpacity(0.5),
              AppColor.white.withOpacity(0.3),
              AppColor.secondaryColor.withOpacity(0.5),
            ],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.03),
                UrbanistApptext(
                  text: "Current LifeStyle",
                  fontSize: width * 0.055,
                  color: AppColor.textBrownColor,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.01,
                    bottom: height * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.06),
                          color: AppColor.primaryColor,
                        ),
                        width: width * 0.2116,
                        height: height * 0.00858,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.06),
                          color: AppColor.primaryColor,
                        ),
                        width: width * 0.2116,
                        height: height * 0.00858,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.06),
                          color: AppColor.white,
                        ),
                        width: width * 0.2116,
                        height: height * 0.00858,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.06),
                          color: AppColor.white,
                        ),
                        width: width * 0.2116,
                        height: height * 0.00858,
                      ),
                    ],
                  ),
                ),
                // Field labels
                const AboutFieldLabel(text: "Daily Work Style"),
                const AboutFieldLabel(text: "Daily Routine"),
                const AboutFieldLabel(text: "Exercise Frequency"),
                const AboutFieldLabel(text: "Dietary Style"),
                const AboutFieldLabel(text: "Stress Level"),
                const Spacer(),
                CustomButton(
                  text: AppText.next,
                  color: AppColor.primaryColor,
                  textColor: AppColor.white,
                  fontSize: width * 0.046,
                  height: width * 0.13,
                  width: width,
                  borderRadius: 10,
                  borderColor: AppColor.primaryColor,
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    // context.pushNamed(RouteNames.aboutYourselfScreen1);
                    print("welcom brooo");
                  },
                ),
                SvgPicture.asset(
                  AppSvg.lifestyleImage,
                  fit: BoxFit.contain,
                  height: height * 0.5,
                  width: width * 0.4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutFieldLabel extends StatelessWidget {
  final String text;
  const AboutFieldLabel({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.sizeOf(context).height * 0.01,
      ),
      child: UrbanistApptext(
        text: text,
        fontSize: width * 0.040,
        fontWeight: FontWeight.w400,
        color: AppColor.textBrownColor,
      ),
    );
  }
}
