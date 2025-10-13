import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// StreamController for wheel
final spinControllerProvider = Provider<StreamController<int>>((ref) {
  final controller = StreamController<int>.broadcast();

  // Dispose controller when provider is destroyed
  ref.onDispose(() {
    controller.close();
  });

  return controller;
});

final selectedIndexProvider = StateProvider<int?>((ref) => null);
