import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/features/tabbarSection/profileSection/profileInfo/screen/widget/profile_save_pop.dart';
import 'package:jimmy_sir_app/features/registeration/providers/aboutyourself_Provider.dart';

import '../../../../../core/components/TextFeild/customTextField.dart';
import '../../../../../core/components/apptext/urbanist_apptext.dart';
import '../../../../registeration/presentation/screens/aboutYourSelf/attached_drop_down.dart';
import '../../../../registeration/presentation/widgets/common_selectable_container.dart';

class BodyMetricsScreen extends ConsumerWidget {
  const BodyMetricsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final state = ref.watch(aboutProvider);
    final notifier = ref.read(aboutProvider.notifier);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar2(
        title: AppText.bodyMetricsTitle,
        fontSize: width * 0.055,
        onBackTap: () => context.pop(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.03),
                    UrbanistApptext(
                      text: AppText.whatIsYourGender,
                      fontSize: width * 0.046,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textBrownColor,
                    ),
                    SizedBox(height: width * 0.02),
                    CommonSelectableContainer1(
                      title: AppText.male,
                      isSelected: state.gender == "Male",
                      onTap: () => notifier.updateGender("Male"),
                    ),
                    CommonSelectableContainer1(
                      title: AppText.female,
                      isSelected: state.gender == "Female",
                      onTap: () => notifier.updateGender("Female"),
                    ),
                    CommonSelectableContainer1(
                      title: AppText.others,
                      isSelected: state.gender == "Others",
                      onTap: () => notifier.updateGender("Others"),
                    ),

                    if (state.gender == "Others") ...[
                      SizedBox(height: height * 0.02),
                      CommonTextField(
                        hintText: AppText.pleaseSpecify,
                        controller: TextEditingController(),
                      ),
                    ],
                    SizedBox(height: height * 0.015),
                    UrbanistApptext(
                      text: AppText.howOldAreYou,
                      fontSize: width * 0.046,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textBrownColor,
                    ),
                    SizedBox(height: width * 0.02),
                    CommonTextField(
                      hintText: "Your age",
                      controller: TextEditingController(),
                      keyboardType: TextInputType.number,
                      textWeight: FontWeight.w800,
                    ),
                    SizedBox(height: height * 0.015),

                    UrbanistApptext(
                      text: AppText.howTallAreYou,
                      fontSize: width * 0.046,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textBrownColor,
                    ),
                    SizedBox(height: width * 0.02),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CommonTextField(
                            hintText: AppText.height,
                            controller: TextEditingController(),
                            keyboardType: TextInputType.number,
                            textWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        AttachedDropdown(
                          value: state.heightUnit,
                          items: const ["cm", "ft/in"],
                          onChanged: (value) =>
                              notifier.updateHeightUnit(value),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.015),

                    UrbanistApptext(
                      text: AppText.whatsYourWeight,
                      fontSize: width * 0.046,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textBrownColor,
                    ),
                    SizedBox(height: width * 0.02),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CommonTextField(
                            textWeight: FontWeight.w800,
                            hintText: AppText.height,
                            controller: TextEditingController(),
                            keyboardType: TextInputType.number,

                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        AttachedDropdown(
                          value: state.weightUnit,
                          items: const ["kg", "lbs"],
                          onChanged: (value) =>
                              notifier.updateWeight(value),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.03),

                    CustomButton(
                      text: AppText.save,
                      onPressed: () {
                        ProfileSavePopUp.show(
                          context,
                          AppText.bodyMetricsUpdatedSuccessfully,
                        );
                      },
                      color: AppColor.primaryColor,
                      textColor: AppColor.white,
                      fontSize: width * 0.046,
                      height: width * 0.13,
                      width: width,
                      borderRadius: width * 0.025,
                      borderColor: AppColor.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
