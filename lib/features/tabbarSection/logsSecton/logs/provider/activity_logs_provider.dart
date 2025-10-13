import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/data/data%20sources/remote/network_api_service.dart';
import 'package:jimmy_sir_app/features/tabbarSection/logsSecton/logs/services/logs_services.dart';

class ActivityLogsState {
  final MapSD activityLogsData;
  final bool isLoading;
  final String error;

  ActivityLogsState({
    required this.activityLogsData,
    this.isLoading = false,
    this.error = '',
  });
}

//  For Activity Container Logs
class ActivityLogsNotifier extends StateNotifier<ActivityLogsState> {
  final LogsServices activityLogsServices;

  ActivityLogsNotifier({required this.activityLogsServices})
    : super(
        ActivityLogsState(activityLogsData: {}, isLoading: false, error: ''),
      );
}

class ActivitySelectionNotifier extends StateNotifier<String?> {
  ActivitySelectionNotifier() : super(null);

  /// Sets the new selected intensity.
  void selectIntensity(String? intensity) {
    state = intensity;
  }
}

final activitySelectionProvider =
    StateNotifierProvider<ActivitySelectionNotifier, String?>(
      (ref) => ActivitySelectionNotifier(),
    );

final expandedActivityIndexProvider = StateProvider<int?>((ref) => null);
