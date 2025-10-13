import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/core/constants/enum.dart';
import 'package:jimmy_sir_app/features/tabbarSection/dashboardSection/home/providers/graph_provider.dart';

class GraphHistoryNotifier extends StateNotifier<List<GraphData>> {
  GraphHistoryNotifier()
    : super([
        GraphData(
          title: 'Lifestyle Score',
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
          type: ScoreType.lifestyle,
        ),
        GraphData(
          title: 'Nutrition Score',
          features: [
            'Sleep Quality',
            'Physical Activity',
            'Hydration',
            'Stress Management',
            'Focus',
            'Meditation',
            'Social Media',
          ],
          actual: [70, 55, 40, 60, 50, 45, 35],
          goal: [80, 70, 70, 80, 70, 50, 50],
          type: ScoreType.lifestyle,
        ),
        // Add more GraphData for more horizontal items
      ]);
}

final graphHistoryProvider =
    StateNotifierProvider<GraphHistoryNotifier, List<GraphData>>(
      (ref) => GraphHistoryNotifier(),
    );
