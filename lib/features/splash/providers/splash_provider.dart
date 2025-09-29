import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Simulate bootstrapping (token check / preload). Replace with real logic later.
final splashReadyProvider = FutureProvider<void>((ref) async {
  await Future.delayed(const Duration(milliseconds: 3000));
  // Example: read a flag / token and decide where to go in the screen listener.
});
