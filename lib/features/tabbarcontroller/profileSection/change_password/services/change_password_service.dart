import '../../../../../../core/constants/enum.dart';
import '../../../../../../data/data sources/remote/network_api_service.dart';
import '../../../../../core/constants/app_urls.dart';

class ChangePasswordService {


  Future<MapSD> changePasswordInfoData(String password) async {

    return await NetworkApiServices().sendHttpRequest(
      url: Uri.parse(ApiConstant.changePassword2),
      method: HttpMethod.put,
      includeHeaders: true,
    );
  }
}
