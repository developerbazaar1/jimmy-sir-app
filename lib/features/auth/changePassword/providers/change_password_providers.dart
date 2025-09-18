import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Login/services/auth_service.dart';

class ChangePasswordState {
  final bool isLoading;
  final String? error;

  ChangePasswordState({this.isLoading = false, this.error});
}

class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  final AuthService authService;
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String newPassword = '';
  String confirmPassword = '';
  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your new password';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your confirm password';
    }
    return null;
  }


  ChangePasswordNotifier({required this.authService})
    : super(ChangePasswordState());

  Future<bool> changePassword(String password) async {
    state = ChangePasswordState(isLoading: true);
    try {
      await authService.changePassword(password);
      state = ChangePasswordState();
      return true;
    } catch (e) {
      state = ChangePasswordState(error: e.toString());
      return false;
    }
  }
}

final changePasswordServiceProvider = Provider<AuthService>(
  (ref) => AuthService(),
);

final changePasswordProvider =
    StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>((ref) {
      final authService = ref.read(changePasswordServiceProvider);
      return ChangePasswordNotifier(authService: authService);
    });
