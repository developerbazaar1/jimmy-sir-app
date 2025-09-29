class QuizRequest {
  final Map<int, String> selections;

  QuizRequest({required this.selections});

  Map<String, dynamic> toJson() {
    return {
      "quiz": selections.map((key, value) => MapEntry("step_$key", value)),
    };
  }
}

class QuizResponse {
  final bool success;
  final String message;

  QuizResponse({required this.success, required this.message});

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
    );
  }
}

class QuizStep {
  final String title;
  final List<QuizOption> options;

  QuizStep({required this.title, required this.options});
}

class QuizOption {
  final String label;

  QuizOption({required this.label});
}

// lifestyle_steps_data.dart

final quizSteps = [
  QuizStep(
    title: "How often do you feel tired or fatigued during the day?",
    options: [
      QuizOption(label: "Never"),
      QuizOption(label: "Occasionally"),
      QuizOption(label: "Frequently"),
      QuizOption(label: "Always"),
    ],
  ),
  QuizStep(
    title: "How many hours do you spend sitting or being inactive daily?",
    options: [],
  ),
  QuizStep(
    title: "Do you prioritize planning your meals ahead of time?",
    options: [
      QuizOption(label: "Always"),
      QuizOption(label: "Often"),
      QuizOption(label: "Sometimes"),
      QuizOption(label: "Rarely"),
      QuizOption(label: "Never"),
    ],
  ),
  QuizStep(
    title: "Do you have any specific health challenges (e.g., allergies)?",
    options: [
      QuizOption(label: "yes"),
      QuizOption(label: "no"),
    ],
  ),
  QuizStep(
    title: "How often do you engage in social activities?",
    options: [
      QuizOption(label: "Daily"),
      QuizOption(label: "Weekly"),
      QuizOption(label: "Occasionally"),
      QuizOption(label: "Rarely"),
      QuizOption(label: "Never"),
    ],
  ),
];
