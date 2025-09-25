import 'dart:convert';
import '../../../../core/constants/app_urls.dart';
import '../../../../core/constants/enum.dart';
import '../../../../data/data sources/remote/network_api_service.dart';
import '../models/login_request.dart';
import '../../signup/models/signup_response.dart';

class AuthService {
  NetworkApiServices services = NetworkApiServices();
  Future<MapSD> login(LoginRequest request) async {
    Map<String, dynamic> body = request.toJson();
    try {
      return await services.sendHttpRequest(
        url: Uri.parse(ApiConstant.login),
        method: HttpMethod.post,
        body: body as Map<String, String>?,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<MapSD> signup(SignupRequest request) async {
    Map<String, dynamic> body = request.toJson();
    return await services.sendHttpRequest(
      url: Uri.parse(ApiConstant.signup),
      method: HttpMethod.post,
      body: body as Map<String, String>?,
    );
  }

  /// Returns true on success, throws on failure.
  Future<MapSD> forgotPassword(String contact) async {
    // Example API call; replace with your endpoint.
    Map<String, dynamic> body = {'contact': contact};
    try {
      return await services.sendHttpRequest(
        url: Uri.parse(ApiConstant.forgotPassword),
        method: HttpMethod.post,
        body: body as Map<String, String>?,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<MapSD> verifyOtp(String otp) async {
    Map<String, dynamic> body = {'otp': otp};
    return await services.sendHttpRequest(
      url: Uri.parse(ApiConstant.verifyOtp),
      method: HttpMethod.post,
      body: body as Map<String, String>?,
    );
  }

  Future<MapSD> resendOtp(String contact) async {
    Map<String, dynamic> body = {'contact': contact};
    return await services.sendHttpRequest(
      url: Uri.parse(ApiConstant.resendOtp),
      method: HttpMethod.post,
      body: body as Map<String, String>?,
    );
  }

  Future<MapSD> changePassword(String password) async {
    Map<String, dynamic> body = {'password': password};
    return await services.sendHttpRequest(
      url: Uri.parse(ApiConstant.changePassword),
      method: HttpMethod.post,
      body: body as Map<String, String>?,
    );
  }

  Future<MapSD> googleSignup(
    String token,
    String email,
    String name,
    String phone,
    String deviceToken,
  ) async {
    Map<String, dynamic> body = {
      'socialToken': token,
      'socialType': 'google',
      'email': email,
      'name': name,
      'phone': phone,
      'deviceToken': deviceToken,
    };
    return await services.sendHttpRequest(
      url: Uri.parse(ApiConstant.socialLogin),
      method: HttpMethod.post,
      body: body as Map<String, String>?,
    );
  }

  Future<MapSD> appleSignup(
    String token,
    String email,
    String name,
    String phone,
    String deviceToken,
  ) async {
    Map<String, dynamic> body = {
      'socialToken': token,
      'socialType': 'apple',
      'email': email,
      'name': name,
      'phone': phone,
      'deviceToken': deviceToken,
    };
    return await services.sendHttpRequest(
      url: Uri.parse(ApiConstant.socialLogin),
      method: HttpMethod.post,
      body: body as Map<String, String>?,
    );
  }
}
