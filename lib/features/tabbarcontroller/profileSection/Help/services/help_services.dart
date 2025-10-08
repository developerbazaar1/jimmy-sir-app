import 'package:jimmy_sir_app/core/constants/app_urls.dart';
import 'package:jimmy_sir_app/core/constants/enum.dart';
import 'package:jimmy_sir_app/data/data sources/remote/network_api_service.dart';

class HelpServices {
  final NetworkApiServices services = NetworkApiServices();

  Future<MapSD> postHelp({required String message}) async {
    return await services.sendHttpRequest(
      url: Uri.parse(ApiConstant.help),
      method: HttpMethod.post,
      body: {'message': message} as Map<String, String>?,
    );
  }
}
