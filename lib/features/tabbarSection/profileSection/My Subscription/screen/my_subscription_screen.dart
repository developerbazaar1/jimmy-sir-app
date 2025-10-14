import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_text.dart';
import 'widget/my_subscription_widget.dart';

class MySubscriptionScreen extends ConsumerWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar2(
        title: AppText.mySubscription,
        fontSize: width * 0.055,
        onBackTap: () => context.pop(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.07),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: width * 0.04),
                MySubscriptionWidget(
                  subscriptionType: 'Free trial',
                  renewalDate: '27/12/2024',
                  price: '0',
                  pricePer: 'month',
                  planFeatures: 'Basic features',
                  cancelSubscription: 'Cancel Subscription',
                  needHelp: 'Need Help',
                  contactUs: 'Contact Us',
                ),
                SizedBox(height: width * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
