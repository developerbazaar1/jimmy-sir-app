import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Login/services/auth_service.dart';

class ForgotPasswordState {
  final bool isLoading;
  final String? error;

  ForgotPasswordState({this.isLoading = false, this.error});
}

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  final AuthService authService;

  ForgotPasswordNotifier({required this.authService}) : super(ForgotPasswordState());

  Future<bool> forgetPassword(String email) async {
    state = ForgotPasswordState(isLoading: true);
    try {
      await authService.forgotPassword(email);
      state = ForgotPasswordState(); // Reset state
      return true;
    } catch (e) {
      state = ForgotPasswordState(error: e.toString());
      return false;
    }
  }
}

final forgotPasswordServiceProvider = Provider<AuthService>((ref) => AuthService());

final forgotPasswordProvider = StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>((
  ref,
) {
  final service = ref.read(forgotPasswordServiceProvider);
  return ForgotPasswordNotifier(authService: service);
});
