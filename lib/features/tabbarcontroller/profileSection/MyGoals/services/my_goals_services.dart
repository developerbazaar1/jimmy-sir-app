import 'package:jimmy_sir_app/core/constants/app_urls.dart';
import 'package:jimmy_sir_app/core/constants/enum.dart';
import '../../../../../../data/data sources/remote/network_api_service.dart';

class MyGoalsServices {
  Future<MapSD> getMyGoalsData() async {
    return await NetworkApiServices().sendHttpRequest(
      url: Uri.parse(ApiConstant.myGoals),
      method: HttpMethod.get,
    );
  }
}
