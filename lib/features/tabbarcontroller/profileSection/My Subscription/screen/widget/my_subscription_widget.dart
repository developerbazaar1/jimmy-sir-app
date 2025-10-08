import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/components/apptext/urbanist_apptext.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/components/button/custom_button.dart';
import '../../../../../../core/constants/app_text.dart';
import '../../../../../../core/routes/route_constant.dart';

class MySubscriptionWidget extends ConsumerWidget {
  final String subscriptionType;
  final String renewalDate;
  final String price;
  final String pricePer;
  final String planFeatures;
  final String cancelSubscription;
  final String needHelp;
  final String contactUs;
  const MySubscriptionWidget({
    super.key,
    required this.subscriptionType,
    required this.renewalDate,
    required this.price,
    required this.pricePer,
    required this.planFeatures,
    required this.cancelSubscription,
    required this.needHelp,
    required this.contactUs,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        // Main Subscription Card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.primaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(width * (16 / width)),
            gradient: LinearGradient(
              colors: [
                AppColor.primaryColor.withOpacity(0.4),
                AppColor.textGreyColor.withOpacity(0.2),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(width * (16 / width)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UrbanistApptext(
                          text: subscriptionType,
                          fontSize: width * (28 / width),
                          fontWeight: FontWeight.w700,
                          color: AppColor.primaryColor,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                UrbanistApptext(
                                  text: '\$ $price',
                                  fontSize: width * (24 / width),
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.black,
                                ),
                                UrbanistApptext(
                                  text: '/$pricePer',
                                  fontSize: width * (12 / width),
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.textGreyColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // Renewal Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UrbanistApptext(
                      text: subscriptionType,
                      fontSize: width * (16 / width),
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    Row(
                      children: [
                        UrbanistApptext(
                          text: AppText.renewalDate,
                          fontSize: width * (16 / width),
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                        ),
                        UrbanistApptext(
                          text: renewalDate,
                          fontSize: width * (16 / width),
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Your Plan Includes
                CustomButton(
                  text: AppText.upgradeNow,
                  textColor: AppColor.white,
                  color: AppColor.primaryColor,
                  borderRadius: width * (12 / width),
                  fontSize: width * (16 / width),
                  fontWeight: FontWeight.w500,
                  height: width * (58 / width),
                  onPressed: () {
                    context.push(RoutePaths.mySubscriptionList);
                    // Handle upgrade action
                  },
                ),

                // Cancel Subscription Sectionz
                SizedBox(height: width * (20 / width)),
                // Plan Features
                UrbanistApptext(
                  text: AppText.yourPlanIncludes,
                  fontSize: width * (18 / width),
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
                SizedBox(height: width * (12 / width)),
                _buildFeatureItem(planFeatures, true, context),
                _buildFeatureItem('Limited access', true, context),
                _buildFeatureItem('Advanced tools', false, context),
                _buildFeatureItem('Priority Support', false, context),
              ],
            ),
          ),
        ),
        SizedBox(height: width * (20 / width)),
        // Cancel Subscription Section
        CustomButton(
          text: AppText.cancelSubscription,
          textColor: AppColor.primaryColor,
          color: AppColor.white,
          borderColor: AppColor.primaryColor,
          borderRadius: width * (16 / width),
          fontSize: width * (16 / width),
          fontWeight: FontWeight.w500,
          height: width * (58 / width),
          onPressed: () {
            // Handle cancel subscription
          },
        ),

        SizedBox(height: width * (8 / width)),
        UrbanistApptext(
          text: AppText.subscriptionWillRemainActive,
          fontSize: width * (12 / width),
          fontWeight: FontWeight.w400,
          color: AppColor.textGreyColor,
        ),
        SizedBox(height: width * (32 / width)),
        // Need Help Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UrbanistApptext(
              text: AppText.needHelp,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColor.black,
            ),
            SizedBox(height: width * (12 / width)),
            UrbanistApptext(
              text: AppText.ifYouAreFacingIssues,
              fontSize: width * (14 / width),
              fontWeight: FontWeight.w400,
              color: AppColor.black,
            ),
            SizedBox(height: width * (16 / width)),
            CustomButton(
              text: AppText.contactUs,
              textColor: AppColor.white,
              color: AppColor.primaryColor,
              borderRadius: width * (12 / width),
              fontSize: width * (16 / width),
              fontWeight: FontWeight.w500,
              height: width * (58 / width),
              onPressed: () {
                context.push(RoutePaths.helpAndSupport);
                // Handle contact us action
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String text, bool isIncluded, BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(bottom: width * (12 / width)),
      child: Row(
        children: [
          Icon(
            Icons.check,
            size: 20,
            color: isIncluded ? AppColor.greenColor : AppColor.textGreyColor,
          ),
          SizedBox(width: width * (12 / width)),
          UrbanistApptext(
            text: text,
            fontSize: width * (14 / width),
            fontWeight: FontWeight.w400,
            color: isIncluded ? AppColor.black : AppColor.textGreyColor,
          ),
        ],
      ),
    );
  }
}
