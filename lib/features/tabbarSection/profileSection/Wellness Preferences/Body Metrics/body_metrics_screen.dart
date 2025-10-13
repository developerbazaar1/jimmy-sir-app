import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/features/tabbarSection/profileSection/profileInfo/screen/widget/profile_save_pop.dart';
import 'package:jimmy_sir_app/features/registeration/providers/aboutyourself_Provider.dart';

import '../../../../../core/components/TextFeild/customTextField.dart';
import '../../../../../core/components/apptext/urbanist_apptext.dart';
import '../../../../registeration/presentation/screens/aboutYourSelf/attached_drop_down.dart';
import '../../../../registeration/presentation/widgets/common_SelectableContainer.dart';

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
      appBar: AppBar(
        title: UrbanistApptext(
          text: AppText.bodyMetricsTitle,
          fontSize: width * 0.055,
          fontWeight: FontWeight.w700,
          color: AppColor.black,
        ),
        backgroundColor: AppColor.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back_ios_new, color: AppColor.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * (24 / width)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.03),
                    UrbanistApptext(
                      text: AppText.whatIsYourGender,
                      fontSize: width * (20 / width),
                      fontWeight: FontWeight.w500,
                      color: AppColor.textBrownColor,
                    ),
                    SizedBox(height: height * 0.03),

                    commonSelectableContainer1(
                      title: AppText.male,
                      isSelected: state.gender == "Male",
                      onTap: () => notifier.updateGender("Male"),
                    ),
                    commonSelectableContainer1(
                      title: AppText.female,
                      isSelected: state.gender == "Female",
                      onTap: () => notifier.updateGender("Female"),
                    ),
                    commonSelectableContainer1(
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
                    SizedBox(height: height * 0.01),
                    UrbanistApptext(
                      text: AppText.howOldAreYou,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textBrownColor,
                    ),
                    SizedBox(height: width * (10 / width)),
                    CommonTextField(
                      hintText: "Your age",
                      controller: TextEditingController(),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: width * (10 / width)),

                    UrbanistApptext(
                      text: AppText.howTallAreYou,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textBrownColor,
                    ),
                    SizedBox(height: width * (10 / width)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Expanded(
                          child: CommonTextField(
                            hintText: AppText.height,
                            controller: TextEditingController(),
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
                      borderRadius: 10,
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
