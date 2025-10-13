import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../data/data sources/remote/network_api_service.dart';
import '../services/logs_services.dart';

class LogsState {
  final MapSD logsData;
  final bool isLoading;
  final String error;

  LogsState({required this.logsData, this.isLoading = false, this.error = ''});
}

class LogsNotifier extends StateNotifier<LogsState> {
  final LogsServices logsServices;

  LogsNotifier({required this.logsServices})
    : super(LogsState(logsData: {}, isLoading: false, error: ''));

  Future<MapSD> getLogsData() async {
    return await logsServices.getLogsData();
  }
}

final logsServiceProvider = Provider<LogsServices>((ref) => LogsServices());

final logsProvider = StateNotifierProvider<LogsNotifier, LogsState>(
  (ref) => LogsNotifier(logsServices: ref.read(logsServiceProvider)),
);

final expandedIndexProvider = StateProvider<int?>((ref) => null);
final selectedLogTabProvider = StateProvider<int>((ref) => 0);
