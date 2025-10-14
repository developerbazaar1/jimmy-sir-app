import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/features/registeration/models/membershipPlan.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/membershipCard.dart';
import 'package:jimmy_sir_app/features/registeration/providers/membership_Provider.dart';

class MySubscriptionListScreen extends ConsumerWidget {
  const MySubscriptionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    final selectedIndex = ref.watch(membershipProvider);

    final plans = [
      MembershipPlan(
        title: "Free trial",
        subtitle: "Basic",
        price: "\$0",
        // bestoffer: "",
        period: "per month",
        features: [
          "Basic features",
          "Limited access",
          "Advanced tools",
          "Priority Support",
        ],
        buttonText: "Continue with Free Trial",
      ),
      MembershipPlan(
        title: "Premium",
        subtitle: "Elite",
        price: "\$9.99",
        period: "per month",
        // bestoffer: "Best Offer",
        features: [
          "All Basic features",
          "Unlimited access",
          "Advanced tools",
          "Priority Support",
        ],
        buttonText: "Get Started",
      ),
    ];

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
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColor.black,
                      ),
                    ),

                    Spacer(),
                    UrbanistApptext(
                      text: AppText.membershipList,
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: width * 0.06),
                UrbanistApptext(
                  text: AppText.selectMembership,
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textBrownColor,
                ),
                SizedBox(height: width * 0.03),
                Expanded(
                  child: ListView.builder(
                    itemCount: plans.length,
                    itemBuilder: (context, index) {
                      return MembershipCard(
                        plan: plans[index],
                        isSelected: selectedIndex == index,
                        onTap: () {
                          ref.read(membershipProvider.notifier).state = index;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
