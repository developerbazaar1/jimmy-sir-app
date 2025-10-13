import 'package:flutter_riverpod/flutter_riverpod.dart';

// final selectedFocusProvider = StateProvider<String?>((ref) => null);
final selectedFocusProvider = StateProvider<Set<String>>((ref) => {});
