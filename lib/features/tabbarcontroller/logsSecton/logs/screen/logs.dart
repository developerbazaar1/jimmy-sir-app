import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';

class LogsScreen extends ConsumerWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
     appBar:  CustomAppBar2(
        title: "Log",      
      ),
      body: Center(child: Text('Logs Screen')));
  }
}
