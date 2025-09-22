import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/features/registeration/models/about_user_model.dart';
import 'package:jimmy_sir_app/features/registeration/services/registration_service.dart';

class AboutState {
  final int step;
  final String name;
  final String? gender;
  final String? otherGender;
  final int? age;
  final double? height;
  final String heightUnit;
  final double? weight;
  final String weightUnit;
  final bool isLoading;
  final String? error;

  AboutState({
    this.step = 0,
    this.name = "",
    this.gender,
    this.otherGender,
    this.age,
    this.height,
    this.heightUnit = "cm",
    this.weight,
    this.weightUnit = "kg",
    this.isLoading = false,
    this.error,
  });

  AboutState copyWith({
    int? step,
    String? name,
    String? gender,
    String? otherGender,
    int? age,
    double? height,
    String? heightUnit,
    double? weight,
    String? weightUnit,
    bool? isLoading,
    String? error,
  }) {
    return AboutState(
      step: step ?? this.step,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      otherGender: otherGender ?? this.otherGender,
      age: age ?? this.age,
      height: height ?? this.height,
      heightUnit: heightUnit ?? this.heightUnit,
      weight: weight ?? this.weight,
      weightUnit: weightUnit ?? this.weightUnit,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AboutNotifier extends StateNotifier<AboutState> {
  final RegistrationServices service;
  AboutNotifier(this.service) : super(AboutState());

  /// Step Navigation
  void nextStep() => state = state.copyWith(step: state.step + 1);
  void prevStep() => state = state.copyWith(step: state.step - 1);

  /// Field Updates
  void updateName(String v) => state = state.copyWith(name: v);
  void updateGender(String v) => state = state.copyWith(gender: v);
  void updateOtherGender(String v) => state = state.copyWith(otherGender: v);
  void updateAge(String v) => state = state.copyWith(age: int.tryParse(v));
  void updateHeight(String v) =>
      state = state.copyWith(height: double.tryParse(v));
  void updateHeightUnit(String v) => state = state.copyWith(heightUnit: v);
  void updateWeight(String v) =>
      state = state.copyWith(weight: double.tryParse(v));
  void updateWeightUnit(String v) => state = state.copyWith(weightUnit: v);

  /// API Call
  Future<void> submitDetails() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final request = AboutUserRequest(
        name: state.name,
        gender: state.gender,
        otherGender: state.otherGender,
        age: state.age,
        height: state.height,
        heightUnit: state.heightUnit,
        weight: state.weight,
        weightUnit: state.weightUnit,
      );
      final response = await service.submitAboutUser(request);

      if (!response.success) {
        state = state.copyWith(error: response.message);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final aboutProvider = StateNotifierProvider<AboutNotifier, AboutState>((ref) {
  return AboutNotifier(RegistrationServices());
});
