import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/core/components/Button/custom_button.dart';
import 'package:jimmy_sir_app/core/components/TextFeild/customTextField.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/features/registeration/providers/allergies_Provider.dart';

class FoodAllergyWidget extends ConsumerWidget {
  FoodAllergyWidget({Key? key}) : super(key: key);
  final TextEditingController _newAllergyController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allergies = ref.watch(allergyProvider);
    final predefinedAllergies = allergies['predefined'] as List<String>;
    final userAllergies = allergies['user'] as List<String>;
    final selectedAllergies = allergies['selected'] as Set<String>;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.02),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: predefinedAllergies
              .map(
                (allergy) => _AllergyChip(
                  label: allergy,
                  isSelected: selectedAllergies.contains(allergy),
                  onTap: () => ref
                      .read(allergyProvider.notifier)
                      .toggleSelection(allergy),
                ),
              )
              .toList(),
        ),

        SizedBox(height: height * 0.02),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: userAllergies
              .map(
                (allergy) => _AllergyChip(
                  label: allergy,
                  isSelected: selectedAllergies.contains(allergy),
                  onTap: () => ref
                      .read(allergyProvider.notifier)
                      .toggleSelection(allergy),
                ),
              )
              .toList(),
        ),

        SizedBox(height: height * 0.02),
        UrbanistApptext(
          text: AppText.others,
          fontSize: width * 0.05,
          color: AppColor.textBrownColor,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: height * 0.02),

        // --- Add new allergy ---
        CommonTextField(
          hintText: "Mention your allergy...",
          controller: _newAllergyController,
          suffixIcon: GestureDetector(
            onTap: () {
              final newAllergy = _newAllergyController.text.trim();
              if (newAllergy.isNotEmpty) {
                ref.read(allergyProvider.notifier).addAllergy(newAllergy);
                _newAllergyController.clear();
              }
            }, 
            child: Icon(Icons.add, color: Colors.grey),
          ),
        ),
        SizedBox(height: height * 0.07),
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
            // context.pushNamed(RouteNames.allergiesScreen1);
          },
        ),
        SizedBox(height: height * 0.01),
      ],
    );
  }
}

class _AllergyChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _AllergyChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.010,
          horizontal: width * 0.045,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.8),

          color: isSelected
              ? AppColor.secondaryColor.withOpacity(0.05)
              : AppColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: isSelected
                ? AppColor.secondaryColor.withOpacity(0.4)
                : Colors.white,
            width: 1.5,
          ),
        ),

        child: UrbanistApptext(
          text: label,
          fontSize: width * 0.04,
          color: isSelected ? AppColor.textBrownColor : AppColor.textBrownColor,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
  }
}
