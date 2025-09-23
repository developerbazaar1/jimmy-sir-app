import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllergyNotifier extends StateNotifier<Map<String, dynamic>> {
  AllergyNotifier()
    : super({
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
      });

  void addAllergy(String allergy) {
    final userList = List<String>.from(state['user']);
    if (!userList.contains(allergy)) {
      userList.add(allergy);
    }

    state = {
      'predefined': state['predefined'],
      'user': userList,
      'selected': state['selected'],
    };
  }

  void toggleSelection(String allergy) {
    final selected = Set<String>.from(state['selected']);
    if (selected.contains(allergy)) {
      selected.remove(allergy);
    } else {
      selected.add(allergy);
    }

    state = {
      'predefined': state['predefined'],
      'user': state['user'],
      'selected': selected,
    };
  }
}

final allergyProvider =
    StateNotifierProvider<AllergyNotifier, Map<String, dynamic>>(
      (ref) => AllergyNotifier(),
    );
