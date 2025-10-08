// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../services/change_password_service.dart';
//
// // State class
// class ChangePasswordState2 {
//   final bool isLoading;
//   final String? error;
//
//   ChangePasswordState2({this.isLoading = false, this.error});
// }
//
// // Notifier
// class ChangePasswordNotifier2 extends StateNotifier<ChangePasswordState2> {
//   final ChangePasswordService changePasswordService;
//   final newPasswordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//
//   ChangePasswordNotifier2({required this.changePasswordService})
//       : super(ChangePasswordState2());
//
//   String? validateNewPassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your new password';
//     } else if (value.length < 6) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }
//
//   String? validateConfirmPassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please confirm your password';
//     } else if (value != newPasswordController.text) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }
//
//   Future<bool> changePassword(String password) async {
//     state = ChangePasswordState2(isLoading: true);
//     try {
//       await changePasswordService.changePasswordInfoData(password);
//       state = ChangePasswordState2(isLoading: false);
//       return true;
//     } catch (e) {
//       state = ChangePasswordState2(isLoading: false, error: e.toString());
//       return false;
//     }
//   }
// }
//
// // Providers
// final changePasswordServiceProvider = Provider<ChangePasswordService>(
//       (ref) => ChangePasswordService(),
// );
//
// final changePasswordProvider =
// StateNotifierProvider<ChangePasswordNotifier2, ChangePasswordState2>((ref) {
//   final changePasswordService = ref.read(changePasswordServiceProvider);
//   return ChangePasswordNotifier2(changePasswordService: changePasswordService);
// });
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/change_password_service.dart';

// State class
class ChangePasswordState2 {
  final bool isLoading;
  final String? error;

  ChangePasswordState2({this.isLoading = false, this.error});
}

// Notifier
class ChangePasswordNotifier2 extends StateNotifier<ChangePasswordState2> {
  final ChangePasswordService changePasswordService;
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ChangePasswordNotifier2({required this.changePasswordService})
      : super(ChangePasswordState2());

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your new password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<bool> changePassword(String password) async {
    state = ChangePasswordState2(isLoading: true);
    try {
      await changePasswordService.changePasswordInfoData(password);
      state = ChangePasswordState2(isLoading: false);
      return true;
    } catch (e) {
      state = ChangePasswordState2(isLoading: false, error: e.toString());
      return false;
    }
  }
}

// Providers
final changePasswordServiceProvider = Provider<ChangePasswordService>(
      (ref) => ChangePasswordService(),
);

final changePasswordProvider =
StateNotifierProvider<ChangePasswordNotifier2, ChangePasswordState2>((ref) {
  final changePasswordService = ref.read(changePasswordServiceProvider);
  return ChangePasswordNotifier2(changePasswordService: changePasswordService);
});
