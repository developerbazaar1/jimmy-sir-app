import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../../core/routes/route_import.dart';

class MealLogScreen extends ConsumerWidget {
  const MealLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar2(
        title: 'Meal Log',
        onBackTap: () {
          context.pop();
        },
      ),
      body: Column(children: [Text('Meal Log')]),
    );
  }
}
