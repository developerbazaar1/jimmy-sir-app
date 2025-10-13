import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/core/constants/enum.dart';

class GraphData {
  final List<String> features;
  final List<double> actual;
  final List<double> goal;
  final String title;
  final ScoreType type;

  GraphData({
    required this.features,
    required this.actual,
    required this.goal,
    required this.title,
    required this.type,
  });
}

class GraphNotifier extends StateNotifier<GraphData> {
  GraphNotifier()
    : super(
        GraphData(
          features: [
            'Sleep Quality',
            'Physical Activity',
            'Hydration',
            'Stress Management',
            'Focus',
            'Meditation',
            'Social Media',
          ],
          actual: [60, 50, 45, 55, 40, 40, 40],
          goal: [80, 70, 70, 80, 70, 50, 50],
          title: 'Lifestyle Score',
          type: ScoreType.lifestyle,
        ),
      );

  void toggleScore() {
    if (state.type == ScoreType.lifestyle) {
      state = GraphData(
        features: ['Fats', 'Carbohydrates', 'Protein', 'Fiber', 'Vitamins'],
        actual: [60, 70, 65, 50, 55],
        goal: [70, 70, 70, 60, 60],
        title: 'Nutrition Score',
        type: ScoreType.nutrition,
      );
    } else {
      state = GraphData(
        features: [
          'Sleep Quality',
          'Physical Activity',
          'Hydration',
          'Stress Management',
          'Focus',
          'Meditation',
          'Social Media',
        ],
        actual: [60, 50, 45, 55, 40, 40, 40],
        goal: [80, 70, 70, 80, 70, 50, 50],
        title: 'Lifestyle Score',
        type: ScoreType.lifestyle,
      );
    }
  }
}

final graphProvider = StateNotifierProvider<GraphNotifier, GraphData>(
  (ref) => GraphNotifier(),
);
