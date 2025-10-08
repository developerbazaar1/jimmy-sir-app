import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/home_services.dart';

typedef MapSD = Map<String, dynamic>;

class HomeState {
  final MapSD homeData;
  final bool isLoading;
  final String error;

  HomeState({
    required this.homeData,
    this.isLoading = false,
    this.error = '',
  });

  HomeState copyWith({MapSD? homeData, bool? isLoading, String? error}) {
    return HomeState(
      homeData: homeData ?? this.homeData,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeServices homeServices;

  HomeNotifier({required this.homeServices})
      : super(HomeState(homeData: {}, isLoading: false, error: '')) {
    // automatically fetch once created
    fetchHomeData();
  }

  // fetch & store in state
  Future<void> fetchHomeData() async {
    try {
      state = state.copyWith(isLoading: true, error: '');
      final MapSD data = await homeServices.getHomeData();
      state = state.copyWith(homeData: data, isLoading: false);
    } catch (e, st) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      // optionally log st
    }
  }

  // keep an async getter if other code already calls getHomeData
  Future<MapSD> getHomeData() async {
    return await homeServices.getHomeData();
  }
}

final homeServiceProvider = Provider<HomeServices>((ref) => HomeServices());

final homeProvider =
    StateNotifierProvider<HomeNotifier, HomeState>((ref) => HomeNotifier(homeServices: ref.read(homeServiceProvider)));
