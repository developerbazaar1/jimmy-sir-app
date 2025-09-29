import 'package:flutter/material.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_images.dart';
import 'package:jimmy_sir_app/features/registeration/models/membershipPlan.dart';

class MembershipCard extends StatelessWidget {
  final MembershipPlan plan;
  final bool isSelected;
  final VoidCallback onTap;

  const MembershipCard({
    Key? key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.03),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColor.primaryColor : AppColor.textGreyColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(width * 0.05),
          color: isSelected
              ? AppColor.primaryColor.withOpacity(0.3)
              : AppColor.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.03,
            horizontal: width * 0.09,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title + Best Offer
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UrbanistApptext(
                    text: plan.title,
                    fontSize: width * 0.095,
                    fontWeight: FontWeight.w500,
                    color: AppColor.textBrownColor,
                  ),
                  SizedBox(width: width * 0.03),

                  // Only show "Best Offer" for Premium
                  if (plan.title.toLowerCase() == "premium")
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      height: height * 0.03,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.textBrownColor),
                        borderRadius: BorderRadius.circular(width * 0.02),
                        color: AppColor.primaryColor.withOpacity(0.1),
                      ),
                      child: UrbanistApptext(
                        text: "Best Offer",
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                        color: AppColor.textBrownColor,
                      ),
                    ),
                ],
              ),

              SizedBox(height: height * 0.01),

              /// Subtitle
              UrbanistApptext(
                text: plan.subtitle,
                fontSize: width * 0.05,
                fontWeight: FontWeight.w400,
                color: AppColor.textBrownColor,
              ),

              SizedBox(height: height * 0.01),

              /// Price + Period
              Row(
                children: [
                  UrbanistApptext(
                    text: plan.price,
                    fontSize: width * 0.15,
                    fontWeight: FontWeight.w700,
                    color: AppColor.textBrownColor,
                  ),
                  SizedBox(width: width * 0.02),
                  UrbanistApptext(
                    text: plan.period,
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textGreyColor2,
                  ),
                ],
              ),

              SizedBox(height: height * 0.01),

              Divider(color: Colors.black, thickness: 1),

              /// Features
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: plan.features.map((feature) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.007),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.tickIcon,
                          height: height * 0.03,
                          width: width * 0.03,
                        ),
                        SizedBox(width: width * 0.02),
                        Expanded(
                          child: UrbanistApptext(
                            text: feature,
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textBrownColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: height * 0.02),

              /// Action Button
              CustomButton(
                text: plan.buttonText,
                color: isSelected
                    ? AppColor.primaryColor
                    : AppColor.textGreyColor,
                textColor: AppColor.white,
                fontSize: width * 0.040,
                height: width * 0.13,
                width: width,
                borderRadius: 10,
                borderColor: isSelected
                    ? AppColor.primaryColor
                    : AppColor.textGreyColor,
                fontWeight: FontWeight.w600,
                onPressed: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
