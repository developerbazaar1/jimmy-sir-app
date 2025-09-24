import '../../../../../../core/constants/app_urls.dart';
import '../../../../../../core/constants/enum.dart';
import '../../../../../../data/data sources/remote/network_api_service.dart';


class MyWinsServices {
  Future<MapSD> getMyWinsData() async {
    return await NetworkApiServices().sendHttpRequest(
      url: Uri.parse(ApiConstant.myWins),
      method: HttpMethod.get,
    );
  }
}   