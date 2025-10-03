import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/TextFeild/text_feild.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/features/tabbarcontroller/myWinsSection/provider/add_goals_provider.dart';
import 'package:jimmy_sir_app/features/tabbarcontroller/profileSection/profileInfo/screen/widget/profile_save_pop.dart';

class AddGoalScreen extends ConsumerWidget {
  const AddGoalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar2(title: AppText.addGoal),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.04),
              UrbanistApptext(
                text: AppText.goalName,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
              SizedBox(height: height * 0.01),

              AppTextField(
                controller: TextEditingController(),
                hint: AppText.enterGoalName,
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UrbanistApptext(
                    text: AppText.duration,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w600,
                    color: AppColor.black,
                  ),
                  UrbanistApptext(
                    text: AppText.inDays,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primaryColor,
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              AppTextField(
                controller: TextEditingController(),
                hint: AppText.enterDuration,
              ),
              SizedBox(height: height * 0.02),
              UrbanistApptext(
                text: AppText.whatDoYouWantToFocusOn,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
              SizedBox(height: height * 0.01),
              Wrap(
                children: const [
                  FocusOption(label: "Nutrition"),
                  FocusOption(label: "Fitness"),
                  FocusOption(label: "Sleep"),
                  FocusOption(label: "Overall Balance"),
                  FocusOption(label: "Mindfulness"),
                ],
              ),
              SizedBox(height: height * 0.25),
              CustomButton(
                text: AppText.addGoal,
                onPressed: () {
                  ProfileSavePopUp.show(context, AppText.goalAddedSucessfully);
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

class FocusOption extends ConsumerWidget {
  final String label;

  const FocusOption({super.key, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final selectedSet = ref.watch(selectedFocusProvider);
    final isSelected = selectedSet.contains(label);

    return GestureDetector(
      onTap: () {
        final notifier = ref.read(selectedFocusProvider.notifier);
        final current = Set<String>.from(notifier.state);

        if (isSelected) {
          current.remove(label);
        } else {
          current.add(label);
        }

        notifier.state = current;
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.01,
          vertical: height * 0.01,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.01,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : AppColor.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor : AppColor.border,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: width * 0.04,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColor.white : AppColor.black,
          ),
        ),
      ),
    );
  }
}
