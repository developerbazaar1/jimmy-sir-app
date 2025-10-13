import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_text.dart';
import '../../../../../../core/components/apptext/urbanist_apptext.dart';
import 'widget/my_subscription_widget.dart';

class MySubscriptionScreen extends ConsumerWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: UrbanistApptext(
          text: AppText.mySubscription,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColor.black,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: AppColor.black,
        ),
        backgroundColor: AppColor.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
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
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
