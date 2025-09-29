import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_outline_border_button.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/common_aboutfield_label.dart';

class AllergiesScreen extends ConsumerWidget {
  const AllergiesScreen({super.key});

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
                  text: AppText.allergiesAndRestrictions,
                  fontSize: width * 0.055,
                  color: AppColor.textBrownColor,
                  fontWeight: FontWeight.w700,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01),
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
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                const commonAboutFieldLabel(text: AppText.foodAllergies),
                const commonAboutFieldLabel(text: AppText.foodIntolerances),
                const commonAboutFieldLabel(text: AppText.severity),
                const commonAboutFieldLabel(
                  text: AppText.medicationAndSupplementAllergies,
                ),
                const commonAboutFieldLabel(
                  text: AppText.environmentalAllergies,
                ),

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
                    context.pushNamed(RouteNames.allergiesScreen1);
                  },
                ),
                SizedBox(height: height * 0.01),
                CustomOutlineBorderButton(
                  borderRadius: 15,
                  text: AppText.skipForNow,
                  fontSize: width * 0.038,
                  height: width * 0.13,
                  width: width,
                  borderColor: AppColor.primaryColor,
                  fontWeight: FontWeight.w600,

                  onPressed: () {
                    context.pushNamed(RouteNames.personalGoal);
                  },
                ),
                const Spacer(),
                SvgPicture.asset(
                  AppSvg.allergiesImage,
                  fit: BoxFit.cover,
                  height: height * 0.4,
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
