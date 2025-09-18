import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/login_request.dart';
import '../services/auth_service.dart';

class AuthState {
  final bool isLoading;
  final String? error;

  AuthState({this.isLoading = false, this.error});
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthNotifier({required this.authService}) : super(AuthState());

  Future<bool> login(String email, String password) async {
    state = AuthState(isLoading: true);
    try {
      await authService.login(LoginRequest(email: email, password: password));
      state = AuthState(); // Reset state
      return true;
    } catch (e) {
      state = AuthState(error: e.toString());
      return false;
    }
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final service = ref.read(authServiceProvider);
  return AuthNotifier(authService: service);
});
