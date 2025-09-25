import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/features/registeration/models/membershipPlan.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/membershipCard.dart';

class MembershipScreen extends ConsumerStatefulWidget {
  const MembershipScreen({super.key});

  @override
  ConsumerState<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends ConsumerState<MembershipScreen> {
  int selectedIndex = 0;

  final plans = [
    MembershipPlan(
      title: "Free trial",
      subtitle: "Basic",
      price: "\$0",
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
      features: [
        "All Basic features",
        "Unlimited access",
        "Advanced tools",
        "Priority Support",
      ],
      buttonText: "Upgrade to Premium",
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.03),
                UrbanistApptext(
                  text: "Membership Tier Selection",
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textBrownColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UrbanistApptext(
                      text: "Select membership",
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textBrownColor,
                    ),
                    UrbanistApptext(
                      text: "Skip",
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textGreyColor3,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.04),
                Expanded(
                  child: ListView.builder(
                    // padding: const EdgeInsets.all(16),
                    itemCount: plans.length,
                    itemBuilder: (context, index) {
                      return MembershipCard(
                        plan: plans[index],
                        isSelected: selectedIndex == index,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
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

// class MembershipScreen extends ConsumerWidget {
//   const MembershipScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final height = MediaQuery.sizeOf(context).height;
//     final width = MediaQuery.sizeOf(context).width;
//     return Scaffold(
//       backgroundColor: AppColor.white,

//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [
//               AppColor.primaryColor.withOpacity(0.5),
//               AppColor.white.withOpacity(0.3),
//               AppColor.secondaryColor.withOpacity(0.5),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.06),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: height * 0.02),
//                 UrbanistApptext(
//                   text: "Membership Tier Selection",
//                   fontSize: width * 0.06,
//                   fontWeight: FontWeight.w700,
//                   color: AppColor.textBrownColor,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     UrbanistApptext(
//                       text: "Select membership",
//                       fontSize: width * 0.05,
//                       fontWeight: FontWeight.w500,
//                       color: AppColor.textBrownColor,
//                     ),
//                     UrbanistApptext(
//                       text: "Skip",
//                       fontSize: width * 0.04,
//                       fontWeight: FontWeight.w500,
//                       color: AppColor.textGreyColor3,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: height * 0.02),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColor.primaryColor3),
//                     borderRadius: BorderRadius.circular(width * 0.05),
//                     color: AppColor.primaryColor.withOpacity(0.2),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                       vertical: height * 0.03,
//                       horizontal: width * 0.09,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         UrbanistApptext(
//                           text: "Free trial",
//                           fontSize: width * 0.09,
//                           fontWeight: FontWeight.w500,
//                           color: AppColor.textBrownColor,
//                         ),
//                         SizedBox(height: height * 0.01),
//                         UrbanistApptext(
//                           text: "Basic",
//                           fontSize: width * 0.05,
//                           fontWeight: FontWeight.w400,
//                           color: AppColor.textBrownColor,
//                         ),

//                         SizedBox(height: height * 0.01),
//                         Row(
//                           children: [
//                             UrbanistApptext(
//                               text: "\$0",
//                               fontSize: width * 0.1,
//                               fontWeight: FontWeight.w700,
//                               color: AppColor.textBrownColor,
//                             ),
//                             SizedBox(width: width * 0.02),
//                             UrbanistApptext(
//                               text: "per month",
//                               fontSize: width * 0.05,
//                               fontWeight: FontWeight.w400,
//                               color: AppColor.textBrownColor,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: height * 0.01),
//                         Divider(color: Colors.black, thickness: 1),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                   AppImages.tickIcon,
//                                   height: height * 0.05,
//                                   width: width * 0.05,
//                                 ),
//                                 SizedBox(width: width * 0.02),
//                                 UrbanistApptext(
//                                   text: "Basic features",
//                                   fontSize: width * 0.05,
//                                   fontWeight: FontWeight.w400,
//                                   color: AppColor.textBrownColor,
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                   AppImages.tickIcon,
//                                   height: height * 0.06,
//                                   width: width * 0.06,
//                                 ),
//                                 SizedBox(width: width * 0.02),
//                                 UrbanistApptext(
//                                   text: "Limited access",
//                                   fontSize: width * 0.05,
//                                   fontWeight: FontWeight.w400,
//                                   color: AppColor.textBrownColor,
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                   AppImages.tickIcon,
//                                   height: height * 0.06,
//                                   width: width * 0.06,
//                                 ),
//                                 SizedBox(width: width * 0.02),
//                                 UrbanistApptext(
//                                   text: "Advanced tools",
//                                   fontSize: width * 0.05,
//                                   fontWeight: FontWeight.w400,
//                                   color: AppColor.textBrownColor,
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                   AppImages.tickIcon,
//                                   height: height * 0.06,
//                                   width: width * 0.06,
//                                 ),
//                                 SizedBox(width: width * 0.02),
//                                 UrbanistApptext(
//                                   text: "Priority Support",
//                                   fontSize: width * 0.05,
//                                   fontWeight: FontWeight.w400,
//                                   color: AppColor.textBrownColor,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: height * 0.01),
//                         CustomButton(
//                           text: "continue with Free Trial",
//                           color: AppColor.primaryColor,
//                           textColor: AppColor.white,
//                           fontSize: width * 0.046,
//                           height: width * 0.13,
//                           width: width,
//                           borderRadius: 10,
//                           borderColor: AppColor.primaryColor,
//                           fontWeight: FontWeight.w600,
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
