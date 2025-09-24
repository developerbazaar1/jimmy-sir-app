import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Login/services/auth_service.dart';
import '../models/signup_response.dart';

class SignupProvider extends StateNotifier<SignupState> {
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  final phoneController = TextEditingController();
  final phoneFocusNode = FocusNode();

  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();

  final confirmPasswordController = TextEditingController();
  final confirmPasswordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  final otpController = TextEditingController();
  final otpFocusNode = FocusNode();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your confirm password';
    }
    return null;
  }

  String? matchPassword(String? value, String? value2) {
    if (value == null || value.isEmpty || value2 == null || value2.isEmpty) {
      return 'Please enter your confirm password';
    }
    if (value != value2) {
      return 'Passwords do not match';
    }
    return null;
  }

  String email = '';
  String phone = '';
  String password = '';
  String confirmPassword = '';
  String message = '';
  String token = '';
  String refreshToken = '';
  String name = '';
  bool isAccepted = false;
  String deviceToken = '';
  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    phoneController.dispose();
    phoneFocusNode.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    confirmPasswordController.dispose();
    confirmPasswordFocusNode.dispose();
    isAccepted = false;
    otpController.dispose();
    otpFocusNode.dispose();
    deviceToken = '';
  }

  final AuthService signupService;

  SignupProvider({required this.signupService}) : super(SignupState());

  Future<void> signup() async {
    state = SignupState(isLoading: true);
    try {
      final response = await signupService.signup(
        SignupRequest(
          email: email,
          phone: phone,
          password: password,
          message: message,
          token: token,
          refreshToken: refreshToken,
          name: name,
          isAccepted: isAccepted,
          deviceToken: deviceToken,
        ),
      );
    } catch (e) {
      state = SignupState(error: e.toString());
    }
  }

  Future<void> googleSignup(
    String token,
    String email,
    String name,
    String phone,
    String deviceToken,
  ) async {
    state = SignupState(isLoading: true);
    try {
      final response = await signupService.googleSignup(
        token,
        email,
        name,
        phone,
        deviceToken,
      );
    } catch (e) {
      state = SignupState(error: e.toString());
    }
  }

  Future<void> appleSignup(
    String token,
    String email,
    String name,
    String phone,
    String deviceToken,
  ) async {
    state = SignupState(isLoading: true);
    try {
      final response = await signupService.appleSignup(
        token,
        email,
        name,
        phone,
        deviceToken,
      );
    } catch (e) {
      state = SignupState(error: e.toString());
    }
  }
}

final signupServiceProvider = Provider<AuthService>((ref) => AuthService());

final signupProvider = StateNotifierProvider<SignupProvider, SignupState>((
  ref,
) {
  final service = ref.read(signupServiceProvider);
  return SignupProvider(signupService: service);
});

class SignupState {
  final bool isLoading;
  final String? error;

  SignupState({this.isLoading = false, this.error});
}
