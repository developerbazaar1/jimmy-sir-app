import 'package:jimmy_sir_app/core/constants/app_urls.dart';
import 'package:jimmy_sir_app/core/constants/enum.dart';
import 'package:jimmy_sir_app/data/data%20sources/remote/network_api_service.dart';
import 'package:jimmy_sir_app/features/registeration/models/about_user_model.dart';
import 'package:jimmy_sir_app/features/registeration/models/lifestyle_model.dart';

class RegistrationServices {
  NetworkApiServices services = NetworkApiServices();
  //--------------------------------this is an registor-----------------------------
  Future<AboutUserResponse> submitAboutUser(AboutUserRequest request) async {
    try {
      final response = await services.sendHttpRequest(
        url: Uri.parse(ApiConstant.register),
        method: HttpMethod.post,
        body: request.toJson() as Map<String, String>?,
      );
      return AboutUserResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //---------------------------------this is an lifestyle-----------------------------
  Future<LifestyleResponse> submitLifestyle(LifestyleRequest request) async {
    try {
      final response = await services.sendHttpRequest(
        url: Uri.parse(ApiConstant.lifestyle),
        method: HttpMethod.post,
        body: request.toJson() as Map<String, String>?,
      );
      return LifestyleResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
