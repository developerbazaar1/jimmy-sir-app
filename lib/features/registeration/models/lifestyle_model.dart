// Request model for lifestyle API
class LifestyleRequest {
  final Map<int, String> selections;

  LifestyleRequest({required this.selections});

  Map<String, dynamic> toJson() {
    // Convert selections into backend format
    return {
      "lifestyle": selections.map((key, value) => MapEntry("step_$key", value)),
    };
  }
}

// Response model for lifestyle API
class LifestyleResponse {
  final bool success;
  final String message;

  LifestyleResponse({required this.success, required this.message});

  factory LifestyleResponse.fromJson(Map<String, dynamic> json) {
    return LifestyleResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
    );
  }
}

// lifestyle_step_model.dart
class LifestyleStep {
  final String title;
  final List<LifestyleOption> options;

  LifestyleStep({required this.title, required this.options});
}

class LifestyleOption {
  final String label;
  final String desc;

  LifestyleOption({required this.label, required this.desc});
}

// lifestyle_steps_data.dart

final lifestyleSteps = [
  LifestyleStep(
    title: "Daily Work Style",
    options: [
      LifestyleOption(label: "Sedentary", desc: "<5,000 steps/day"),
      LifestyleOption(label: "Lightly Active", desc: "5,000–7,500 steps/day"),
      LifestyleOption(
        label: "Moderately Active",
        desc: "7,500–10,000 steps/day",
      ),
      LifestyleOption(label: "Highly Active", desc: ">10,000 steps/day"),
    ],
  ),
  LifestyleStep(
    title: "Daily Routine",
    options: [
      LifestyleOption(label: "Consistent", desc: "Fixed daily pattern"),
      LifestyleOption(label: "Varies", desc: "Routine changes daily"),
      LifestyleOption(label: "Shift Worker", desc: "Night/rotating schedules"),
      LifestyleOption(label: "Frequent Traveler", desc: "Often travels"),
    ],
  ),
  LifestyleStep(
    title: "Exercise Frequency",
    options: [
      LifestyleOption(label: "Rarely", desc: "0–1x/week"),
      LifestyleOption(label: "Light", desc: "1–2x/week"),
      LifestyleOption(label: "Moderate", desc: "3–4x/week"),
      LifestyleOption(label: "Heavy", desc: "5–6x/week"),
      LifestyleOption(label: "Athlete", desc: "Daily"),
    ],
  ),
  LifestyleStep(
    title: "Dietary Style",
    options: [
      LifestyleOption(label: "Omnivore", desc: "Plant + animal-based foods"),
      LifestyleOption(label: "Vegetarian", desc: "Avoids meat/fish"),
      LifestyleOption(label: "Vegan", desc: "Excludes all animal products"),
      LifestyleOption(label: "Pescatarian", desc: "Plant + fish/seafood"),
      LifestyleOption(label: "Others", desc: "Custom diet preferences"),
    ],
  ),
  LifestyleStep(
    title: "Stress Level",
    options: [
      LifestyleOption(
        label: "Low",
        desc: "Calm, stress rarely affects daily life",
      ),
      LifestyleOption(label: "Moderate", desc: "Occasional, manageable"),
      LifestyleOption(label: "High", desc: "Frequent stress affecting energy"),
    ],
  ),
];
