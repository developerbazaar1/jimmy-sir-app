import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalGoalNotifier extends StateNotifier<List<String>> {
  PersonalGoalNotifier() : super([]);

  void toggleGoal(String goal) {
    if (state.contains(goal)) {
      state = List.from(state)..remove(goal);
    } else {
      if (state.length < 3) {
        state = List.from(state)..add(goal);
      }
    }
  }

  bool isSelected(String goal) {
    return state.contains(goal);
  }
}

final personalGoalProvider =
    StateNotifierProvider<PersonalGoalNotifier, List<String>>(
      (ref) => PersonalGoalNotifier(),
    );
