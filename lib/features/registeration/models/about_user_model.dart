class AboutUserRequest {
  final String name;
  final String? gender;
  final String? otherGender;
  final int? age;
  final double? height;
  final String heightUnit;
  final double? weight;
  final String weightUnit;
  final int currentStep;

  AboutUserRequest({
    required this.name,
    this.gender,
    this.otherGender,
    this.age,
    this.height,
    this.heightUnit = "cm",
    this.weight,
    this.weightUnit = "kg",
    this.currentStep = 0,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "gender": gender,
    "other_gender": otherGender,
    "age": age,
    "height": height,
    "height_unit": heightUnit,
    "weight": weight,
    "weight_unit": weightUnit,
    "current_step": currentStep,
  };
}

class AboutUserResponse {
  final bool success;
  final String message;

  AboutUserResponse({required this.success, required this.message});

  factory AboutUserResponse.fromJson(Map<String, dynamic> json) {
    return AboutUserResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
    );
  }
}
