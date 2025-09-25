import '../../../../../core/constants/app_urls.dart';
import '../../../../../core/constants/enum.dart';
import '../../../../../data/data sources/remote/network_api_service.dart';

class HomeServices {
  Future<MapSD> getHomeData() async {
    return await NetworkApiServices().sendHttpRequest(
      url: Uri.parse(ApiConstant.dashboard),
      method: HttpMethod.get,
    );
  }
}
