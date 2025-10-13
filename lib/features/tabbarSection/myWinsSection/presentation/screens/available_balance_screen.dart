import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import 'package:jimmy_sir_app/features/tabbarSection/myWinsSection/presentation/widgets/available_balace_widgets.dart';

class AvailableBalanceScreen extends ConsumerWidget {
  const AvailableBalanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar2(
        title: "",
        onBackTap: () {
          context.pop();
        },
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.02),
            Container(
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(width * 0.06),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.02,
                  horizontal: width * 0.05,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UrbanistApptext(
                              text: AppText.availableBalance,
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w500,
                              color: AppColor.white,
                            ),
                            UrbanistApptext(
                              text: "\$45.00",
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w800,
                              color: AppColor.white,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            UrbanistApptext(
                              text: AppText.cashpoints,
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w500,
                              color: AppColor.white,
                            ),
                            UrbanistApptext(
                              text: "900 pts",
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w800,
                              color: AppColor.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        UrbanistApptext(
                          text: "100 pts =\$1 ",
                          fontSize: width * 0.03,
                          fontWeight: FontWeight.w500,
                          color: AppColor.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),

            Column(
              children: [
                availableBalanceContainer(
                  title: AppText.bank,
                  description: AppText.bankDescription,
                  icon: AppSvg.bankIcon,
                  onTap: () {
                    context.pushNamed(RouteNames.bankAccountDetailScreen);
                  },
                ),
                availableBalanceContainer(
                  title: AppText.paypal,
                  description: AppText.paypalDescription,
                  icon: AppSvg.paypalIcon,
                  onTap: () {
                    context.pushNamed(RouteNames.paypalDetailsScreen);
                  },
                ),
                availableBalanceContainer(
                  title: AppText.wallet,
                  description: AppText.otherUPI,
                  icon: AppSvg.walletIcon,
                  onTap: () {
                    context.pushNamed(RouteNames.walletDetailScreen);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
