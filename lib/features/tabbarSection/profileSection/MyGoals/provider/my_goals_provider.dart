import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../data/data sources/remote/network_api_service.dart';

import '../services/my_goals_services.dart';

class MyGoalsState {
  final MapSD myGoalsData;
  final bool isLoading;
  final String error;

  MyGoalsState({
    required this.myGoalsData,
    this.isLoading = false,
    this.error = '',
  });
}

class MyGoalsNotifier extends StateNotifier<MyGoalsState> {
  final MyGoalsServices myGoalsServices;

  MyGoalsNotifier({required this.myGoalsServices})
    : super(MyGoalsState(myGoalsData: {}, isLoading: false, error: ''));

  Future<MapSD> getMyGoalsData() async {
    return await myGoalsServices.getMyGoalsData();
  }
}

final myGoalsServiceProvider = Provider<MyGoalsServices>(
  (ref) => MyGoalsServices(),
);

final myGoalsProvider = StateNotifierProvider<MyGoalsNotifier, MyGoalsState>(
  (ref) => MyGoalsNotifier(myGoalsServices: ref.read(myGoalsServiceProvider)),
);
