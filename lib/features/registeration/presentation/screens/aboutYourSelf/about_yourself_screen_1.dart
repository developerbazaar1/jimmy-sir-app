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
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/common_SelectableContainer.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/common_progressIndicator.dart';
import 'package:jimmy_sir_app/features/registeration/providers/aboutyourself_Provider.dart';

class AboutYourselfScreen1 extends ConsumerWidget {
  const AboutYourselfScreen1({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final state = ref.watch(aboutProvider);
    final notifier = ref.read(aboutProvider.notifier);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar(
        title: AppText.welcome,
        showBack: state.step > 0 || state.step < 1,
        onBackTap: () {
          if (state.step > 0) {
            notifier.prevStep();
          } else {
            context.pop();
          }
        },
        showSkip: true,
        onSkipTap: () {
          context.pushNamed(RouteNames.lifestyle);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              CommonProgressIndicator(step: state.step, totalSteps: 2),
              SizedBox(height: height * 0.03),

              if (state.step == 0) _StepOne(width: width, height: height),
              if (state.step == 1) _StepTwo(width: width, height: height),

              const Spacer(),
              CustomButton(
                text: state.isLoading ? "Loading..." : AppText.next,
                color: AppColor.primaryColor,
                textColor: AppColor.white,
                fontSize: width * 0.046,
                height: width * 0.13,
                width: width,
                borderRadius: 10,
                borderColor: AppColor.primaryColor,
                fontWeight: FontWeight.w600,
                onPressed: () async {
                  if (state.step < 1) {
                    notifier.nextStep();
                  } else {
                    await notifier.submitDetails();
                    if (state.error == null) {
                      context.pushNamed(RouteNames.lifestyle);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------------- Step One ----------------------------------/

class _StepOne extends ConsumerWidget {
  final double width, height;
  const _StepOne({required this.width, required this.height});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aboutProvider);
    final notifier = ref.read(aboutProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.01),
        UrbanistApptext(
          text: AppText.whatYourName,
          fontSize: width * 0.05,
          fontWeight: FontWeight.w500,
          color: AppColor.textBrownColor,
        ),
        SizedBox(height: height * 0.03),
        CommonTextField(
          hintText: "Your name",
          controller: TextEditingController(),
          keyboardType: TextInputType.name,
        ),

        SizedBox(height: height * 0.03),
        UrbanistApptext(
          text: AppText.pleaseSelectYourGender,
          fontSize: width * 0.05,
          fontWeight: FontWeight.w500,
          color: AppColor.textBrownColor,
        ),
        SizedBox(height: height * 0.02),

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
      ],
    );
  }
}

// --------------------------------- Step Two ----------------------------------/

class _StepTwo extends ConsumerWidget {
  final double width, height;
  const _StepTwo({required this.width, required this.height});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aboutProvider);
    final notifier = ref.read(aboutProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UrbanistApptext(
          text: AppText.howOldAreYou,
          fontSize: width * 0.05,
          fontWeight: FontWeight.w500,
          color: AppColor.textBrownColor,
        ),
        SizedBox(height: height * 0.01),
        CommonTextField(
          hintText: "Your age",
          controller: TextEditingController(),
        ),

        SizedBox(height: height * 0.03),
        UrbanistApptext(
          text: AppText.howTallAreYou,
          fontSize: width * 0.05,
          fontWeight: FontWeight.w500,
          color: AppColor.textBrownColor,
        ),
        SizedBox(height: height * 0.02),
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
            _AttachedDropdown(
              value: state.heightUnit,
              items: const ["cm", "ft/in"],
              onChanged: (value) => notifier.updateHeightUnit(value),
            ),
          ],
        ),

        SizedBox(height: height * 0.03),
        UrbanistApptext(
          text: AppText.whatsYourWeight,
          fontSize: width * 0.05,
          fontWeight: FontWeight.w400,
          color: AppColor.textBrownColor,
        ),
        SizedBox(height: height * 0.02),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CommonTextField(
                hintText: AppText.weight,
                controller: TextEditingController(),
              ),
            ),
            SizedBox(width: width * 0.02),
            _AttachedDropdown(
              value: state.weightUnit,
              items: const ["kg", "lbs"],
              onChanged: (value) => notifier.updateWeightUnit(value),
            ),
          ],
        ),
      ],
    );
  }
}

// --------------------------------- Attached Dropdown ------------------------/

class _AttachedDropdown extends StatefulWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const _AttachedDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  State<_AttachedDropdown> createState() => _AttachedDropdownState();
}

class _AttachedDropdownState extends State<_AttachedDropdown> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main container
        GestureDetector(
          onTap: () => setState(() => expanded = !expanded),
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
                  text: widget.value,
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
              children: widget.items.map((item) {
                return InkWell(
                  onTap: () {
                    widget.onChanged(item);
                    setState(() => expanded = false);
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




















































//---------------------------wrough work--------------------------





// final heightExpandedProvider = StateProvider<bool>((ref) => false);
// final weightExpandedProvider = StateProvider<bool>((ref) => false);

// class AttachedDropdown extends ConsumerWidget {
//   final StateProvider<String> valueProvider;
//   final StateProvider<bool> expandedProvider;
//   final List<String> items;

//   const AttachedDropdown({
//     super.key,
//     required this.valueProvider,
//     required this.expandedProvider,
//     required this.items,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedValue = ref.watch(valueProvider);
//     final expanded = ref.watch(expandedProvider);
//     final height = MediaQuery.sizeOf(context).height;
//     final width = MediaQuery.sizeOf(context).width;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Main container
//         GestureDetector(
//           onTap: () => ref.read(expandedProvider.notifier).state = !expanded,
//           child: Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: width * 0.03,
//               vertical: height * 0.018,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.08),
//                   blurRadius: 6,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 UrbanistApptext(
//                   text: selectedValue,
//                   fontSize: width * 0.04,
//                   fontWeight: FontWeight.w600,
//                   color: AppColor.textBrownColor,
//                 ),
//                 Icon(
//                   expanded
//                       ? Icons.keyboard_arrow_up
//                       : Icons.keyboard_arrow_down,
//                   color: Colors.brown,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: height * 0.01),

//         // Expanded list
//         if (expanded)
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.03),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.08),
//                   blurRadius: 6,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: items.map((item) {
//                 return InkWell(
//                   onTap: () {
//                     ref.read(valueProvider.notifier).state = item;
//                     ref.read(expandedProvider.notifier).state = false;
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                       vertical: height * 0.01,
//                       horizontal: width * 0.02,
//                     ),
//                     child: UrbanistApptext(
//                       text: item,
//                       fontSize: width * 0.04,
//                       fontWeight: FontWeight.w600,
//                       color: AppColor.textBrownColor,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//       ],
//     );
//   }
// }
