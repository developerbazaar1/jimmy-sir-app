import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/profile_info_provider.dart';

class ProfileInfoScreen extends ConsumerWidget {
  const ProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final state = ref.watch(profileInfoProvider);
    // final notifier = ref.read(profileInfoProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Info')),
      body: Center(child: Text('Profile Info')),
    );
  }
}
