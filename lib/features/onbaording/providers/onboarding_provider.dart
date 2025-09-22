import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingPageProvider = StateProvider<int>((ref) => 0);
final animateImageProvider = StateProvider<bool>((ref) => false);
