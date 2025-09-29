import 'package:flutter/material.dart';

import '../../../../../../data/data sources/remote/network_api_service.dart';
import '../services/profile_info_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileInfoState {
  final MapSD profileInfoData;
  final bool isLoading;
  final String error;

  ProfileInfoState({
    required this.profileInfoData,
    this.isLoading = false,
    this.error = '',
  });
}

class ProfileInfoNotifier extends StateNotifier<ProfileInfoState> {
  final ProfileInfoServices profileInfoServices;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phone = '';
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void updateName(String v) {
    name = v;
    nameController.text = v;
  }

  void updateEmail(String v) {
    email = v;
    emailController.text = v;
  }

  void updatePhone(String v) {
    phone = v;
    phoneController.text = v;
  }

  void submitProfileInfoData() async {
    state = ProfileInfoState(profileInfoData: {}, isLoading: true);
    try {
      final response = await profileInfoServices.updateProfileInfoData({
        'name': name,
        'email': email,
        'phone': phone,
      });
      if (!response['success']) {
        state = ProfileInfoState(
          profileInfoData: {},
          error: response['message'],
        );
      }
      state = ProfileInfoState(profileInfoData: response);
    } catch (e) {
      state = ProfileInfoState(profileInfoData: {}, error: e.toString());
    }
  }

  ProfileInfoNotifier({required this.profileInfoServices})
    : super(ProfileInfoState(profileInfoData: {}, isLoading: false, error: ''));

  Future<MapSD> getProfileInfoData(MapSD data) async {
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return await profileInfoServices.getProfileInfoData(data);
  }

  Future<MapSD> updateProfileInfoData(MapSD data) async {
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return await profileInfoServices.updateProfileInfoData(data);
  }
}

final profileInfoServiceProvider = Provider<ProfileInfoServices>(
  (ref) => ProfileInfoServices(),
);

final profileInfoProvider =
    StateNotifierProvider<ProfileInfoNotifier, ProfileInfoState>(
      (ref) => ProfileInfoNotifier(
        profileInfoServices: ref.read(profileInfoServiceProvider),
      ),
    );
