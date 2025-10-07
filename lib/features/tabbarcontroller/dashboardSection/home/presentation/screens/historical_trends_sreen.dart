import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';

class HistoricalTrendsScreen extends ConsumerWidget {
  const HistoricalTrendsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar2(
        title: "",
        onBackTap: () {
          context.pop();
        },
      ),
      body: const Center(child: Text('Historical Trends')),
    );
  }
}
