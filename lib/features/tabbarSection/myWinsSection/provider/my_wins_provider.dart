import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/my_wins_services.dart';
import '../../../../data/data sources/remote/network_api_service.dart';

//data holder.
class MyWinsState {
  final MapSD myWinsData;
  final bool isLoading;
  final String error;

  MyWinsState({
    required this.myWinsData,
    this.isLoading = false,
    this.error = '',
  });
}

//business logic.
class MyWinsNotifier extends StateNotifier<MyWinsState> {
  final MyWinsServices myWinsServices;

  MyWinsNotifier({required this.myWinsServices})
    : super(MyWinsState(myWinsData: {}, isLoading: false, error: ''));

  Future<void> fetchMyWins() async {
    try {
      state = MyWinsState(myWinsData: {}, isLoading: true, error: '');
      final data = await myWinsServices.getMyWinsData();
      state = MyWinsState(myWinsData: data, isLoading: false, error: '');
    } catch (e) {
      state = MyWinsState(
        myWinsData: {},
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final myWinsServiceProvider = Provider<MyWinsServices>(
  (ref) => MyWinsServices(),
);

final myWinsProvider = StateNotifierProvider<MyWinsNotifier, MyWinsState>(
  (ref) => MyWinsNotifier(myWinsServices: ref.read(myWinsServiceProvider)),
);
