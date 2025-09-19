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

final heightUnitProvider = StateProvider<String>((ref) => "cm");
final weightUnitProvider = StateProvider<String>((ref) => "kg");

class AboutYourselfScreen2 extends ConsumerWidget {
  const AboutYourselfScreen2({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final heightUnit = ref.watch(heightUnitProvider);
    final weightUnit = ref.watch(weightUnitProvider);
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
                        color: AppColor.ternaryColor.withOpacity(0.2),
                      ),
                      width: width * 0.2116,
                      height: height * 0.00858,
                    ),
                    SizedBox(width: width * 0.02),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.06),
                        color: AppColor.ternaryColor,
                      ),
                      width: width * 0.2116,
                      height: height * 0.00858,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              UrbanistApptext(
                text: "How old are you?",
                fontSize: width * 0.050,
                fontWeight: FontWeight.w400,
                color: AppColor.textBrownColor,
              ),
              SizedBox(height: height * 0.02),
              CommonTextField(
                hintText: "Your age",
                controller: TextEditingController(),
                onChanged: (value) {},
              ),
              SizedBox(height: height * 0.02),
              UrbanistApptext(
                text: "How tall are you?",
                fontSize: width * 0.050,
                fontWeight: FontWeight.w400,
                color: AppColor.textBrownColor,
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CommonTextField(
                      hintText: "Height",
                      controller: TextEditingController(),
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  AttachedDropdown(
                    valueProvider: heightUnitProvider,
                    expandedProvider: heightExpandedProvider,
                    items: const ["cm", "ft/in"],
                  ),
                  // Expanded(
                  //   child: AttachedDropdown(
                  //     value: "cm",
                  //     items: const ["cm", "ft/in"],
                  //     onChanged: (val) {
                  //       print("Selected: $val");
                  //     },
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: height * 0.02),
              UrbanistApptext(
                text: "What’s your weight?",
                fontSize: width * 0.050,
                fontWeight: FontWeight.w400,
                color: AppColor.textBrownColor,
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CommonTextField(
                      hintText: "Weight",
                      controller: TextEditingController(),
                      onChanged: (value) {},
                    ),
                  ),

                  SizedBox(width: width * 0.02),
                  AttachedDropdown(
                    valueProvider: weightUnitProvider,
                    expandedProvider: weightExpandedProvider,
                    items: const ["kg", "lbs"],
                  ),
                  // Expanded(
                  //   child: AttachedDropdown(
                  //     value: "cm",
                  //     items: const ["cm", "ft/in"],
                  //     onChanged: (val) {
                  //       print("Selected: $val");
                  //     },
                  //   ),
                  // ),
                ],
              ),

              const Spacer(),
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
                  context.pushNamed(RouteNames.lifestyle);
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

final heightExpandedProvider = StateProvider<bool>((ref) => false);
final weightExpandedProvider = StateProvider<bool>((ref) => false);

class AttachedDropdown extends ConsumerWidget {
  final StateProvider<String> valueProvider;
  final StateProvider<bool> expandedProvider;
  final List<String> items;

  const AttachedDropdown({
    super.key,
    required this.valueProvider,
    required this.expandedProvider,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValue = ref.watch(valueProvider);
    final expanded = ref.watch(expandedProvider);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main container
        GestureDetector(
          onTap: () => ref.read(expandedProvider.notifier).state = !expanded,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.018,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UrbanistApptext(
                  text: selectedValue,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textBrownColor,
                ),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.brown,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: height * 0.01),

        // Expanded list
        if (expanded)
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: items.map((item) {
                return InkWell(
                  onTap: () {
                    ref.read(valueProvider.notifier).state = item;
                    ref.read(expandedProvider.notifier).state = false;
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.01,
                      horizontal: width * 0.02,
                    ),
                    child: UrbanistApptext(
                      text: item,
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textBrownColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
