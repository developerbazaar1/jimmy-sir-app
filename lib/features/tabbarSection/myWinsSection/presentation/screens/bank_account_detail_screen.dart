import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/TextFeild/text_feild.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/features/tabbarSection/myWinsSection/presentation/widgets/bank_popup.dart';

class BankAccountDetailScreen extends ConsumerWidget {
  const BankAccountDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar2(
        onBackTap: () => context.pop(),

        title: AppText.bankAccountDetail,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.04),
              UrbanistApptext(
                text: AppText.accountHolderName,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
              SizedBox(height: height * 0.01),
              AppTextField(
                controller: TextEditingController(),
                hint: AppText.enterAccountHolderName,
              ),
              SizedBox(height: height * 0.02),
              UrbanistApptext(
                text: AppText.bankName,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
              SizedBox(height: height * 0.01),
              AppTextField(
                controller: TextEditingController(),
                hint: AppText.enterBankName,
              ),

              SizedBox(height: height * 0.02),
              UrbanistApptext(
                text: AppText.accountNumber,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
              SizedBox(height: height * 0.01),
              AppTextField(
                controller: TextEditingController(),
                hint: AppText.enterAccountNumber,
              ),
              SizedBox(height: height * 0.02),
              UrbanistApptext(
                text: AppText.accountNumber,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
              SizedBox(height: height * 0.01),
              AppTextField(
                controller: TextEditingController(),
                hint: AppText.enterAccountNumber,
              ),
              SizedBox(height: height * 0.1),
              CustomButton(
                text: AppText.withdrawNow,
                onPressed: () {
                  BankPopup.show(
                    context,
                    "Confirm Withdrawal",
                    "Are you sure you want to withdraw \$25 to your bank account?",
                    "Please confirm that the details are correct before proceeding. Withdrawals cannot be undone.",
                    () {
                      context.pop();
                    },
                    () {
                      context.pop();
                      SubmittedBankPopup.show(
                        context,
                        "Withdrawal Request Submitted",
                        "Your withdrawal request of \$25 to your wallet has been submitted. Processing time: 24 hrs.",
                      );
                    },
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
      ),
    );
  }
}
