import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/my_wins_provider.dart';

class MyWinsScreen extends ConsumerWidget {
  const MyWinsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myWinsNotifier = ref.watch(myWinsProvider.notifier);
    final myWinsState = ref.watch(myWinsProvider);
    return Scaffold(body: Center(child: Text('My Wins Screen')));
  }
}
