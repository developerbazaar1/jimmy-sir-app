import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State model holding multiple selected sleep quality options
class SleepState {
  final Set<String> selectedOptions;

  const SleepState({required this.selectedOptions});

  SleepState copyWith({Set<String>? selectedOptions}) {
    return SleepState(selectedOptions: selectedOptions ?? this.selectedOptions);
  }
}

class SleepNotifier extends StateNotifier<SleepState> {
  SleepNotifier() : super(const SleepState(selectedOptions: {}));

  /// Toggle selection on/off
  void toggleOption(String option) {
    final current = {...state.selectedOptions}; // clone safely
    if (current.contains(option)) {
      current.remove(option);
    } else {
      current.add(option);
    }
    state = state.copyWith(selectedOptions: current);
  }

  /// Helper to check if an option is selected
  bool isSelected(String option) => state.selectedOptions.contains(option);

  /// Optional: clear all selections
  void clearSelections() {
    state = const SleepState(selectedOptions: {});
  }
}

/// Global provider
final sleepProvider = StateNotifierProvider<SleepNotifier, SleepState>(
  (ref) => SleepNotifier(),
);
