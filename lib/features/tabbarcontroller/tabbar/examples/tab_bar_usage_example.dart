import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/tab_bar_controller.dart';

/// Example of how to use the Tab Bar Controller in your screens
class TabBarUsageExample extends ConsumerWidget {
  const TabBarUsageExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tab Bar Usage Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tab Bar Controller Usage Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Navigation Examples
            ElevatedButton(
              onPressed: () => TabBarController.navigateToHome(ref),
              child: const Text('Navigate to Home'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => TabBarController.navigateToLogs(ref),
              child: const Text('Navigate to Logs'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => TabBarController.navigateToMyWins(ref),
              child: const Text('Navigate to My Wins'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => TabBarController.navigateToProfile(ref),
              child: const Text('Navigate to Profile'),
            ),
            const SizedBox(height: 20),

            // Visibility Control Examples
            ElevatedButton(
              onPressed: () => TabBarController.hideTabBar(ref),
              child: const Text('Hide Tab Bar'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => TabBarController.showTabBar(ref),
              child: const Text('Show Tab Bar'),
            ),
            const SizedBox(height: 20),

            // State Information
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Tab Bar State:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Current Tab: ${TabBarController.getCurrentTab(ref).label}',
                    ),
                    Text(
                      'Tab Bar Visible: ${TabBarController.isTabBarVisible(ref)}',
                    ),
                    Text('Is Home Tab: ${TabBarController.isHomeTab(ref)}'),
                    Text('Is Logs Tab: ${TabBarController.isLogsTab(ref)}'),
                    Text(
                      'Is My Wins Tab: ${TabBarController.isMyWinsTab(ref)}',
                    ),
                    Text(
                      'Is Profile Tab: ${TabBarController.isProfileTab(ref)}',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
