import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/custom_tab_bar.dart';

class TabBarTestScreen extends ConsumerWidget {
  const TabBarTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tab Bar Test'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tab Bar Test Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'This screen tests the tab bar with SVG icons',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomTabBar(
        selectedColor: Color(0xFF6366F1),
        unselectedColor: Color(0xFF64748B),
        backgroundColor: Color(0xFFF8FAFC),
        elevation: 12.0,
        showLabels: true,
        iconSize: 24.0,
        useGradient: true,
        useRoundedCorners: true,
        borderRadius: 24.0,
      ),
    );
  }
}
