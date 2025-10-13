import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/TextFeild/text_feild.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/features/tabbarSection/myWinsSection/presentation/widgets/bank_popup.dart';
import 'package:jimmy_sir_app/features/tabbarSection/profileSection/profileInfo/screen/widget/profile_save_pop.dart';

class WalletDetailScreen extends ConsumerWidget {
  const WalletDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar2(
        title: AppText.walletDetails,
        onBackTap: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(height: height * 0.05),
            UrbanistApptext(
              text: AppText.idtext,
              fontSize: width * 0.04,
              fontWeight: FontWeight.w600,
              color: AppColor.black,
            ),
            SizedBox(height: height * 0.01),
            AppTextField(
              controller: TextEditingController(),
              hint: AppText.enterId,
            ),
            SizedBox(height: height * 0.02),
            UrbanistApptext(
              text: AppText.enterWithdrawalAmount,
              fontSize: width * 0.04,
              fontWeight: FontWeight.w600,
              color: AppColor.black,
            ),
            SizedBox(height: height * 0.01),
            AppTextField(
              controller: TextEditingController(),
              hint: AppText.enterWithdrawalAmount,
            ),
            SizedBox(height: height * 0.30),

            CustomButton(
              text: AppText.withdrawNow,
              onPressed: () {
                ProfileSavePopUp.show(
                  context,
                  "Wallet Details Update Sucessfully",
                );
              },
              color: AppColor.primaryColor,
              textColor: AppColor.white,
              fontSize: width * 0.05,
              height: height * 0.06,
              width: width * 0.9,
              borderRadius: 10,
              elevation: 0,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
