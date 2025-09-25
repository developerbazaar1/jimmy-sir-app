import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileNotifier = ref.watch(profileProvider.notifier);
    final profileState = ref.watch(profileProvider);
    return Scaffold(body: Center(child: Text('Profile Screen')));
  }
}
