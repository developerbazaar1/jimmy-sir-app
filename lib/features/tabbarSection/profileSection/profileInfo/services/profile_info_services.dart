import '../../../../../../core/constants/app_urls.dart';
import '../../../../../../core/constants/enum.dart';
import '../../../../../../data/data sources/remote/network_api_service.dart';

class ProfileInfoServices {
  Future<MapSD> getProfileInfoData(MapSD data) async {
    final id = data['id'];
    return await NetworkApiServices().sendHttpRequest(
      url: Uri.parse(ApiConstant.profileInfo),
      method: HttpMethod.get,
      id: id,
    );
  }

  Future<MapSD> updateProfileInfoData(MapSD data) async {
    final id = data['id'];
    return await NetworkApiServices().sendHttpRequest(
      url: Uri.parse(ApiConstant.profileInfo),
      method: HttpMethod.put,
      body: data as Map<String, String>?,
      id: id,
      includeHeaders: true,
    );
  }
}
