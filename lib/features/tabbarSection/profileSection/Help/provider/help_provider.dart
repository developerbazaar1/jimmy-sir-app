import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/data/data sources/remote/network_api_service.dart';
import 'package:jimmy_sir_app/features/tabbarSection/profileSection/Help/services/help_services.dart';

class HelpState {
  final bool isLoading;
  final String? error;
  final MapSD? help;

  HelpState({this.isLoading = false, this.error, this.help});
}

class HelpProvider extends StateNotifier<HelpState> {
  final HelpServices helpServices = HelpServices();

  HelpProvider({required HelpServices helpServices}) : super(HelpState());

  Future<void> postHelp({required String message}) async {
    state = HelpState(isLoading: true);
    try {
      final response = await helpServices.postHelp(message: message);
      state = HelpState(help: response);
    } catch (e) {
      state = HelpState(error: e.toString());
    } finally {
      state = HelpState(isLoading: false);
    }
  }
}

final helpServiceProvider = Provider<HelpServices>((ref) => HelpServices());

final helpProvider = StateNotifierProvider<HelpProvider, HelpState>((ref) {
  final service = ref.read(helpServiceProvider);
  return HelpProvider(helpServices: service);
});
