import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/data/data%20sources/remote/network_api_service.dart';
import 'package:jimmy_sir_app/features/tabbarSection/logsSecton/logs/services/logs_services.dart';

class MealLogsState {
  final MapSD mealLogsData;
  final bool isLoading;
  final String error;

  MealLogsState({
    required this.mealLogsData,
    this.isLoading = false,
    this.error = '',
  });
}

class MealLogsNotifier extends StateNotifier<MealLogsState> {
  final LogsServices mealLogsServices;

  MealLogsNotifier({required this.mealLogsServices})
    : super(MealLogsState(mealLogsData: {}, isLoading: false, error: ''));
}
