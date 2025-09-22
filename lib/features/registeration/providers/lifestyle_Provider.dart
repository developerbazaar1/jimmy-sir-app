import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/features/registeration/models/lifestyle_model.dart';
import 'package:jimmy_sir_app/features/registeration/services/registration_service.dart';

class LifestyleState {
  final int currentStep;
  final Map<int, String> selections;
  final bool isLoading;
  final LifestyleResponse? response;

  LifestyleState({
    this.currentStep = 0,
    Map<int, String>? selections,
    this.isLoading = false,
    this.response,
  }) : selections = selections ?? {};

  LifestyleState copyWith({
    int? currentStep,
    Map<int, String>? selections,
    bool? isLoading,
    LifestyleResponse? response,
  }) {
    return LifestyleState(
      currentStep: currentStep ?? this.currentStep,
      selections: selections ?? this.selections,
      isLoading: isLoading ?? this.isLoading,
      response: response ?? this.response,
    );
  }
}

class LifestyleNotifier extends StateNotifier<LifestyleState> {
  final RegistrationServices _services;

  LifestyleNotifier(this._services) : super(LifestyleState());

  void selectOption(int step, String option) {
    final newSelections = {...state.selections, step: option};
    state = state.copyWith(selections: newSelections);
  }

  void nextStep(int totalSteps) {
    if (state.currentStep < totalSteps - 1) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void prevStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  Future<void> submitLifestyle() async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _services.submitLifestyle(
        LifestyleRequest(selections: state.selections),
      );
      state = state.copyWith(isLoading: false, response: response);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}

final lifestyleProvider =
    StateNotifierProvider<LifestyleNotifier, LifestyleState>((ref) {
      return LifestyleNotifier(RegistrationServices());
    });
