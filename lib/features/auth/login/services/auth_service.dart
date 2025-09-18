import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/app_urls.dart';
import '../../../../core/constants/enum.dart';
import '../../../../data/data sources/remote/network_api_service.dart';
import '../models/login_request.dart';

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
}
