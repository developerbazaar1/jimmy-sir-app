import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'dart:async';

class ApiCallHandler {
  // Singleton instance
  static final ApiCallHandler _instance = ApiCallHandler._internal();

  // // Logging toggle
  // final bool enableLogging;

  ApiCallHandler._internal();

  factory ApiCallHandler() {
    return _instance;
  }

  void log(String message) {
    // message.log("ApiCallHandler");
  }

  void onErrorHandler(Object? error, StackTrace stackTrace) {
    log("$error $stackTrace");
  }

  void handleApiError(BuildContext context, Object error, StackTrace stackTrace,
      RxString errorMessage) {
    // Update the error message
    errorMessage.value = error.toString();

    if (context.mounted) {
      // AppSnackBar.showSnackbar(
      //   context: context,
      //   title: "Oh Snap!",
      //   type: SnackbarType.error,
      //   message: errorMessage.value,
      // );
    }
    onErrorHandler(error, stackTrace);
  }

  Future<bool> _isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> apiHandler<T>({
    required BuildContext context,
    required Future<T> Function() apiCall,
    required RxBool isLoading,
    void Function(T result)? onSuccess,
    required RxString errorMessage,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      isLoading.value = true;
      final result = await apiCall();
      if (onSuccess != null) onSuccess(result);
    } catch (error, stackTrace) {
      if (onError != null) {
        onError(error, stackTrace);
      } else if (context.mounted) {
        handleApiError(context, error, stackTrace, errorMessage);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> apiHandlerWithConnectivity<T>({
    required BuildContext context,
    required Future<T> Function() apiCall,
    required RxBool isLoading,
    required void Function(T result) onSuccess,
    required RxString errorMessage,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    if (!await _isConnected()) {
      // AppSnackBar.showSnackbar(
      //   context: context,
      //   title: "No Internet",
      //   type: SnackbarType.error,
      //   message: "Please check your internet connection.",
      // );
      return;
    }

    await apiHandler(
      context: context,
      apiCall: apiCall,
      isLoading: isLoading,
      onSuccess: onSuccess,
      errorMessage: errorMessage,
      onError: onError,
    );
  }
}

// class ApiCallHandler {
//   void onErrorHandler(Object? error, StackTrace stackTrace) {
//     ("$error $stackTrace").log("Error");
//   }

//   void handleApiError(
//       BuildContext context, Object error, StackTrace stackTrace) {
//     if (context.mounted) {
//       AppSnackBar.showSnackbar(
//         context: context,
//         title: "Oh Snap!",
//         type: SnackbarType.error,
//         message: error.toString(),
//       );
//     }
//     onErrorHandler(error, stackTrace);
//   }

//   Future<void> apiHandler<T>({
//     required BuildContext context,
//     required Future<T> Function() apiCall,
//     required void Function(T result) onSuccess,
//     required RxBool isLoading,
//   }) async {
//     try {
//       isLoading.value = true;
//       final result = await apiCall();
//       onSuccess(result);
//     } catch (error, stackTrace) {
//       if (context.mounted) handleApiError(context, error, stackTrace);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
