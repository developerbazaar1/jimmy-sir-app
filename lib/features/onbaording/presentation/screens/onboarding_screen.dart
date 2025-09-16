import 'package:flutter/material.dart';
import 'package:jimmy_sir_app/core/components/apptext/inter_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InterApptext(
                    text: "Skip",
                    color: AppColor.white,
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.04,
                  ),
                ],
              ),
              SizedBox(height: height * 0.1),
              Stack(
                children: [
                  Container(
                    height: height * 0.3,
                    width: width * 0.7,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(width * 0.9),
                    ),
                  ),

                  // Positioned(
                  //   child: SvgPicture.asset(AppSvg.logo1)
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
