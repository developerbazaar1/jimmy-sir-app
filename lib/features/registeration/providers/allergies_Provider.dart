import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllergyNotifier extends StateNotifier<Map<String, dynamic>> {
  AllergyNotifier()
    : super({
        'step': 0, // current step
        'sections': [
          {
            'title': 'Food Allergies',
            'predefined': [
              'Peanuts',
              'Eggs',
              'Soy',
              'Tree Nuts',
              'Fish',
              'Milk & Dairy',
              'Wheat/Gluten',
              'Shellfish',
              'Sesame',
              'Strawberries',
            ],
            'user': <String>[],
            'selected': <String>{},
          },
          {
            'title': 'Food Intolerances (Digestive Discomfort)',
            'predefined': [
              'Lactose Intolerance',
              'Gluten Sensitivity',
              'Fructose Intolerance',
              'Histamine Intolerance',
            ],
            'user': <String>[],
            'selected': <String>{},
          },
          FoodAllergyStep(
            title: "Severrity(severe / Moderate / Mild)",
            options: [
              FoodAllergyOption(
                label: "Severe",
                desc:
                    "Triggers strong reactions, may need immediate medical help",
              ),
              FoodAllergyOption(
                label: "Moderate",
                desc: "Noticeable symptoms, sometimes requires treatment.",
              ),
              FoodAllergyOption(
                label: "Mild",
                desc: "Causes minor discomfort, usually manageable.",
              ),
            ],
          ),
          {
            'title': 'Medication & Supplement Allergies',
            'medications': {
              'Antibiotics': <String>[],
              'Pain relievers': <String>[],
              'Vitamins / Minerals': <String>[],
            },
          },
          {
            'title': 'Environmental Allergies (Optional)',
            'predefined': [
              'Pollens',
              'Mold',
              'Dust Mites',
              'Pet Dander',
              'Shellfish',
            ],
            'user': <String>[],
            'selected': <String>{},
          },
        ],
      });

  void nextStep() {
    final step = state['step'] as int;
    final sections = state['sections'] as List;
    if (step < sections.length - 1) {
      state = {...state, 'step': step + 1};
    }
  }

  void previousStep() {
    final step = state['step'] as int;
    if (step > 0) {
      state = {...state, 'step': step - 1};
    }
  }

  void addAllergy(String allergy) {
    final step = state['step'] as int;
    final sections = List.from(state['sections']);
    if (sections[step] is Map<String, dynamic> &&
        sections[step].containsKey('user')) {
      final userList = List<String>.from(sections[step]['user']);
      if (!userList.contains(allergy)) userList.add(allergy);
      sections[step]['user'] = userList;
      state = {...state, 'sections': sections};
    }
  }

  void toggleSelection(String allergy) {
    final step = state['step'] as int;
    final sections = List.from(state['sections']);

    if (sections[step] is Map<String, dynamic> &&
        sections[step].containsKey('selected')) {
      final selected = Set<String>.from(sections[step]['selected']);
      selected.contains(allergy)
          ? selected.remove(allergy)
          : selected.add(allergy);
      sections[step]['selected'] = selected;
      state = {...state, 'sections': sections};
    } else if (sections[step] is FoodAllergyStep) {
      final selected = Set<String>.from(
        state['severitySelection'] ?? <String>{},
      );
      selected.contains(allergy)
          ? selected.remove(allergy)
          : selected.add(allergy);
      state = {...state, 'sections': sections, 'severitySelection': selected};
    }
  }

  void addMedication(String type, String value) {
    final step = state['step'] as int;
    final sections = List.from(state['sections']);
    if (sections[step] is Map<String, dynamic> &&
        sections[step].containsKey('medications')) {
      final meds = Map<String, List<String>>.from(
        sections[step]['medications'],
      );
      meds[type]?.add(value);
      sections[step]['medications'] = meds;
      state = {...state, 'sections': sections};
    }
  }
}

final allergyProvider =
    StateNotifierProvider<AllergyNotifier, Map<String, dynamic>>(
      (ref) => AllergyNotifier(),
    );

class FoodAllergyStep {
  final String title;
  final List<FoodAllergyOption> options;

  FoodAllergyStep({required this.title, required this.options});
}

class FoodAllergyOption {
  final String label;
  final String desc;

  FoodAllergyOption({required this.label, required this.desc});
}
