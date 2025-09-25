import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/features/tabbarcontroller/dashboardSection/home/providers/home-provider.dart' as homeServices;

import '../services/home_services.dart';
import '../../../../../data/data sources/remote/network_api_service.dart';


class HomeNotifier extends StateNotifier<HomeState> {
  final HomeServices homeServices;

  HomeNotifier({required this.homeServices}) : super(HomeState(homeData: {}, isLoading: false, error: ''));

  Future<MapSD> getHomeData() async {
    return await homeServices.getHomeData();
  }
}

final homeServiceProvider = Provider<HomeServices>((ref) => HomeServices());

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(homeServices: ref.read(homeServiceProvider)),
);

class HomeState {
  final MapSD homeData;
  final bool isLoading;
  final String error;

  HomeState({required this.homeData, this.isLoading = false, this.error = ''});
}
  

  Future<MapSD> getHomeData() async {
    return await homeServices.getHomeData();
  }