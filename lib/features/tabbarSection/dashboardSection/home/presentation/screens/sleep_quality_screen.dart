import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/features/tabbarSection/dashboardSection/home/providers/sleep_provider.dart';

class SleepQualityScreen extends ConsumerWidget {
  const SleepQualityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar2(
        title: "",
        onBackTap: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
            UrbanistApptext(
              text: AppText.sleepQualityQuestion,
              fontSize: width * 0.04,
              fontWeight: FontWeight.w500,
              color: AppColor.textColor,
            ),
            SizedBox(height: height * 0.02),
            Wrap(
              spacing: width * 0.02,
              runSpacing: height * 0.02,
              alignment: WrapAlignment.center,
              children: const [
                SleepQualityOption(label: "Very Good", questionId: "1"),
                SleepQualityOption(label: "Fair Good", questionId: "1"),
                SleepQualityOption(label: "Fairy Bad", questionId: "1"),
                SleepQualityOption(label: "Very Bad", questionId: "1"),
              ],
            ),

            SizedBox(height: height * 0.02),
            UrbanistApptext(
              text: AppText.sleepQualityQuestion2,
              fontSize: width * 0.04,
              fontWeight: FontWeight.w500,
              color: AppColor.textColor,
            ),
            SizedBox(height: height * 0.02),
            Wrap(
              spacing: width * 0.02,
              runSpacing: height * 0.02,
              alignment: WrapAlignment.center,
              children: const [
                SleepQualityOption(label: "Less than 5 hours", questionId: "2"),
                SleepQualityOption(label: "5 to 6 hours", questionId: "2"),
                SleepQualityOption(label: "6 to 7 hours", questionId: "2"),
                SleepQualityOption(label: "More than 7 hours", questionId: "2"),
              ],
            ),
            SizedBox(height: height * 0.02),
            UrbanistApptext(
              text: AppText.sleepQualityQuestion3,
              fontSize: width * 0.04,
              fontWeight: FontWeight.w500,
              color: AppColor.textColor,
            ),
            SizedBox(height: height * 0.02),
            Wrap(
              spacing: width * 0.02,
              runSpacing: height * 0.02,
              alignment: WrapAlignment.center,
              children: const [
                SleepQualityOption(label: "Never", questionId: "3"),
                SleepQualityOption(label: "1–2 times a week", questionId: "3"),
                SleepQualityOption(label: "2–3 times a week", questionId: "3"),
                SleepQualityOption(
                  label: "Almost every night",
                  questionId: "3",
                ),
              ],
            ),
            // SizedBox(height: height * 0.02),
            Spacer(),

            CustomButton(
              text: AppText.next,
              onPressed: () {},
              color: AppColor.primaryColor,
              textColor: AppColor.white,
              fontSize: width * 0.05,
              height: height * 0.06,
              width: width * 0.9,
              borderRadius: 10,
              elevation: 0,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}

class SleepQualityOption extends ConsumerWidget {
  final String label;
  final String questionId;

  const SleepQualityOption({
    super.key,
    required this.label,
    required this.questionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    final notifier = ref.read(sleepProvider.notifier);
    final isSelected = ref.watch(
      sleepProvider.select((state) => state.selectedOptions.contains(label)),
    );

    return GestureDetector(
      onTap: () => notifier.toggleOption(label),

      child: Container(
        width: width * 0.4,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.01,
          vertical: height * 0.01,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.01,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.greenColor.withOpacity(0.05)
              : AppColor.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColor.greenColor : AppColor.border,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: width * 0.035,
            fontWeight: FontWeight.w600,
            color: AppColor.black,
          ),
        ),
      ),
    );
  }
}
