import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/features/tabbarcontroller/profileSection/Wellness Preferences/Body Metrics/body_metrics_services.dart';
import '../../../../../data/data sources/remote/network_api_service.dart';

class BodyMetricsState {
  final MapSD bodyMetricsData;
  final bool isLoading;
  final String error;

  BodyMetricsState({
    required this.bodyMetricsData,
    this.isLoading = false,
    this.error = '',
  });
}

class BodyMetricsNotifier extends StateNotifier<BodyMetricsState> {
  final BodyMetricsServices bodyMetricsServices;

  BodyMetricsNotifier({required this.bodyMetricsServices})
    : super(BodyMetricsState(bodyMetricsData: {}, isLoading: false, error: ''));

  Future<MapSD> getBodyMetricsData() async {
    return await bodyMetricsServices.getBodyMetricsData();
  }
}

final bodyMetricsServiceProvider = Provider<BodyMetricsServices>(
  (ref) => BodyMetricsServices(),
);

final bodyMetricsProvider =
    StateNotifierProvider<BodyMetricsNotifier, BodyMetricsState>(
      (ref) => BodyMetricsNotifier(
        bodyMetricsServices: ref.read(bodyMetricsServiceProvider),
      ),
    );
