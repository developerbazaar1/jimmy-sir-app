import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Login/providers/auth_provider.dart';
import '../../Login/services/auth_service.dart';

class VerifyOtpState {
  final bool isLoading;
  final String? error;

  VerifyOtpState({this.isLoading = false, this.error});
}

class VerifyOtpNotifier extends StateNotifier<VerifyOtpState> {
  final AuthService authService;
  VerifyOtpNotifier({required this.authService}) : super(VerifyOtpState());

  Future<bool> verifyOtp(String otp) async {
    state = VerifyOtpState(isLoading: true);
    try {
      await authService.verifyOtp(otp);
      state = VerifyOtpState();
      return true;
    } catch (e) {
      state = VerifyOtpState(error: e.toString());
      return false;
    }
  }
}

final verifyOtpServiceProvider = Provider<AuthService>((ref) => AuthService());

final verifyOtpProvider =
    StateNotifierProvider<VerifyOtpNotifier, VerifyOtpState>((ref) {
      final authService = ref.read(verifyOtpServiceProvider);
      return VerifyOtpNotifier(authService: authService);
    });
