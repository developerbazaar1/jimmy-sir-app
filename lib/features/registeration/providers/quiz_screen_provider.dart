import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quizProvider = StateNotifierProvider<QuizScreenNotifier, QuizState>(
  (ref) => QuizScreenNotifier(),
);

class QuizState {
  final int currentStep;
  final Map<int, String> selections;
  final double sittingStart;
  final double sittingEnd;

  QuizState({
    this.currentStep = 0,
    Map<int, String>? selections,
    this.sittingStart = 1,
    this.sittingEnd = 12,
  }) : selections = selections ?? {};

  QuizState copyWith({
    int? currentStep,
    Map<int, String>? selections,
    double? sittingStart,
    double? sittingEnd,
  }) {
    return QuizState(
      currentStep: currentStep ?? this.currentStep,
      selections: selections ?? this.selections,
      sittingStart: sittingStart ?? this.sittingStart,
      sittingEnd: sittingEnd ?? this.sittingEnd,
    );
  }
}

class QuizScreenNotifier extends StateNotifier<QuizState> {
  QuizScreenNotifier() : super(QuizState());

  void selectOption(int stepIndex, String answer) {
    final newSelections = {...state.selections, stepIndex: answer};
    state = state.copyWith(selections: newSelections);
  }

  void updateSlider(RangeValues values) {
    state = state.copyWith(sittingStart: values.start, sittingEnd: values.end);
  }

  void nextStep() {
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }
}
