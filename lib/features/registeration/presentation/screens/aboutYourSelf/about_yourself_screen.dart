import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/common_aboutfield_label.dart';

class AboutYourselfScreen extends ConsumerWidget {
  const AboutYourselfScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
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
                SizedBox(height: height * 0.02),
                UrbanistApptext(
                  text: AppText.welcome,
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
                UrbanistApptext(
                  text: AppText.aboutYourself,
                  fontSize: width * 0.040,
                  fontWeight: FontWeight.w400,
                  color: AppColor.textBrownColor,
                ),
                SizedBox(height: height * 0.01),

                const commonAboutFieldLabel(text: AppText.name),
                const commonAboutFieldLabel(text: AppText.gender),
                const commonAboutFieldLabel(text: AppText.age),
                const commonAboutFieldLabel(text: AppText.height),
                const commonAboutFieldLabel(text: AppText.weight),
                // const Spacer(),
                SizedBox(height: height * 0.02),
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
                    context.pushNamed(RouteNames.aboutYourselfScreen1);
                    print("welcom brooo");
                  },
                ),
                const Spacer(),
                SvgPicture.asset(
                  AppSvg.aboutYourScreenImage,
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
