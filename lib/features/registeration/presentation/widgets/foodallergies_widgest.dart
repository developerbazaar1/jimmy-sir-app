import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/core/components/TextFeild/customTextField.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/widgets/common_selectable_container.dart';
import 'package:jimmy_sir_app/features/registeration/providers/allergies_Provider.dart';

class FoodAllergyWidget extends ConsumerWidget {
  FoodAllergyWidget({Key? key}) : super(key: key);
  final TextEditingController _newAllergyController = TextEditingController();
  final TextEditingController _antibioticsController = TextEditingController();
  final TextEditingController _painRelieversController =
      TextEditingController();
  final TextEditingController _vitaminsController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allergies = ref.watch(allergyProvider);
    final step = allergies['step'] as int;
    final section = (allergies['sections'] as List)[step];

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    Widget sectionWidget;

    // ✅ First: Medication & Supplement Allergies
    if (section is Map<String, dynamic> &&
        section['title'] == 'Medication & Supplement Allergies') {
      sectionWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.04),
          UrbanistApptext(
            text: 'Antibiotics (Penicillin, Sulfa Drugs etc.,)',
            fontSize: width * 0.045,
            color: AppColor.textBrownColor,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: height * 0.02),
          CommonTextField(
            hintText: "Mention antibiotics...",
            controller: _antibioticsController,
            keyboardType: TextInputType.name,
            maxLines: 2,
          ),
          SizedBox(height: height * 0.02),
          UrbanistApptext(
            text: 'Pain relievers (NSAIDs: ibuprofen, aspirin)',
            fontSize: width * 0.045,
            color: AppColor.textBrownColor,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: height * 0.02),
          CommonTextField(
            hintText: "Mention pain relievers...",
            controller: _painRelieversController,
            keyboardType: TextInputType.name,
            maxLines: 2,
          ),
          SizedBox(height: height * 0.02),
          UrbanistApptext(
            text: 'Vitamins / Minerals (e.g., Iron, Vitamin B12)',
            fontSize: width * 0.045,
            color: AppColor.textBrownColor,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: height * 0.02),
          CommonTextField(
            hintText: "Mention vitamins/minerals...",
            controller: _vitaminsController,
            keyboardType: TextInputType.name,
            maxLines: 2,
          ),
        ],
      );
    }
    // ✅ Second: Severity Step
    else if (section is FoodAllergyStep) {
      final selected = Set<String>.from(
        allergies['severitySelection'] ?? <String>{},
      );

      sectionWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: section.options
            .map(
              (option) => Padding(
                padding: EdgeInsets.only(bottom: height * 0.015),
                child: CommonSelectableContainer(
                  title: option.label,
                  description: option.desc,
                  isSelected: selected.contains(option.label),
                  onTap: () => ref
                      .read(allergyProvider.notifier)
                      .toggleSelection(option.label),
                ),
              ),
            )
            .toList(),
      );
    }
    // ✅ Third: Generic Allergy Step (Food, Environmental, etc.)
    else if (section is Map<String, dynamic>) {
      final predefinedAllergies =
          (section['predefined'] as List<String>?) ?? <String>[];
      final userAllergies = (section['user'] as List<String>?) ?? <String>[];
      final selectedAllergies =
          (section['selected'] as Set<String>?) ?? <String>{};

      sectionWidget = Column(
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
            fontSize: width * 0.045,
            color: AppColor.textBrownColor,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: height * 0.01),
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
        ],
      );
    } else {
      sectionWidget = const Text("Unknown section");
    }

    return sectionWidget;
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
