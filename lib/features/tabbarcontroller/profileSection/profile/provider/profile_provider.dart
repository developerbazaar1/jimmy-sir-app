import '../../../../../data/data sources/remote/network_api_service.dart';
import '../services/profile_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
  
class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileServices profileServices;

  ProfileNotifier({required this.profileServices}) : super(ProfileState(profileData: {}, isLoading: false, error: ''));

  Future<MapSD> getProfileData() async {
    return await profileServices.getProfileData();
  }
}

final profileServiceProvider = Provider<ProfileServices>((ref) => ProfileServices());

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>(
  (ref) => ProfileNotifier(profileServices: ref.read(profileServiceProvider)),
);

class ProfileState {  
  final MapSD profileData;
  final bool isLoading;
  final String error;

  ProfileState({required this.profileData, this.isLoading = false, this.error = ''});
}