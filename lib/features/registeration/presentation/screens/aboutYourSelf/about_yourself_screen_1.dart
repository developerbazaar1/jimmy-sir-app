import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/TextFeild/customTextField.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import 'package:jimmy_sir_app/features/registeration/providers/aboutyourself_Provider.dart';

class AboutYourselfScreen1 extends ConsumerWidget {
  const AboutYourselfScreen1({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final selectedGender = ref.watch(genderProvider);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar(
        title: AppText.welcome,
        showBack: true,
        showSkip: true,
        onSkipTap: () {
          // Handle skip tap
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.03),
              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.01,
                  bottom: height * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.06),
                        color: AppColor.ternaryColor,
                      ),
                      width: width * 0.2116,
                      height: height * 0.00858,
                    ),
                    SizedBox(width: width * 0.02),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.06),
                        color: AppColor.ternaryColor.withOpacity(0.2),
                      ),
                      width: width * 0.2116,
                      height: height * 0.00858,
                    ),
                  ],
                ),
              ),
              UrbanistApptext(
                text: AppText.whatYourName,
                fontSize: width * 0.050,
                fontWeight: FontWeight.w400,
                color: AppColor.textBrownColor,
              ),
              SizedBox(height: height * 0.02),
              CommonTextField(
                hintText: "Your name",
                controller: TextEditingController(),
                onChanged: (value) {},
              ),
              SizedBox(height: height * 0.02),
              UrbanistApptext(
                text: AppText.pleaseSelectYourGender,
                fontSize: width * 0.050,
                fontWeight: FontWeight.w400,
                color: AppColor.textBrownColor,
              ),
              SizedBox(height: height * 0.02),
              // Gender options
              SelectableContainer(
                label: "Male",
                isSelected: selectedGender == "Male",
                onTap: () => ref.read(genderProvider.notifier).state = "Male",
              ),
              SelectableContainer(
                label: "Female",
                isSelected: selectedGender == "Female",
                onTap: () => ref.read(genderProvider.notifier).state = "Female",
              ),
              SelectableContainer(
                label: "Others",
                isSelected: selectedGender == "Others",
                onTap: () => ref.read(genderProvider.notifier).state = "Others",
              ),

              // Show extra TextField only if "Others"
              if (selectedGender == "Others") ...[
                SizedBox(height: height * 0.02),
                CommonTextField(
                  hintText: "Please specify",
                  controller: TextEditingController(),
                ),
              ],
              const Spacer(),
              // SizedBox(height: height * 0.2),
              CustomButton(
                text: AppText.next,
                color: AppColor.primaryColor,
                textColor: AppColor.white,
                fontSize: width * 0.046,
                height: width * 0.13,
                width: width,
                borderRadius: 10,
                borderColor: AppColor.primaryColor,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  context.pushNamed(RouteNames.aboutYourselfScreen2);
                  print("welcom brooo");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectableContainer extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableContainer({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: width * 0.03),
        padding: EdgeInsets.symmetric(
          vertical: width * 0.04,
          horizontal: width * 0.05,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.white,
            width: 1.5,
          ),
          color: Colors.white,
          boxShadow: !isSelected
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UrbanistApptext(
              text: label,
              fontSize: width * 0.04,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              color: isSelected ? Colors.brown : Colors.black,
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
