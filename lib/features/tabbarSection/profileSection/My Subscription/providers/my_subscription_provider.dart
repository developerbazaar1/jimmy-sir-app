import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../data/data sources/remote/network_api_service.dart';

import '../services/my_subscription_services.dart';

class MySubscriptionState {
  final MapSD mySubscriptionData;
  final bool isLoading;
  final String error;

  MySubscriptionState({
    required this.mySubscriptionData,
    this.isLoading = false,
    this.error = '',
  });

  MySubscriptionState copyWith({
    MapSD? mySubscriptionData,
    bool? isLoading,
    String? error,
  }) {
    return MySubscriptionState(
      mySubscriptionData: mySubscriptionData ?? this.mySubscriptionData,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class MySubscriptionNotifier extends StateNotifier<MySubscriptionState> {
  final MySubscriptionServices mySubscriptionServices;

  MySubscriptionNotifier({required this.mySubscriptionServices})
    : super(
        MySubscriptionState(
          mySubscriptionData: {},
          isLoading: false,
          error: '',
        ),
      );

  Future<MapSD> getMySubscriptionData() async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await mySubscriptionServices.getMySubscriptionData();
      state = state.copyWith(isLoading: false, mySubscriptionData: response);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
    return state.mySubscriptionData;
  }
}

final mySubscriptionServiceProvider = Provider<MySubscriptionServices>(
  (ref) => MySubscriptionServices(),
);

final mySubscriptionProvider =
    StateNotifierProvider<MySubscriptionNotifier, MySubscriptionState>(
      (ref) => MySubscriptionNotifier(
        mySubscriptionServices: ref.read(mySubscriptionServiceProvider),
      ),
    );
