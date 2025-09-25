import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tab_bar_style.dart';
import '../widgets/tab_bar_style_selector.dart';

class TabBarDemoScreen extends ConsumerStatefulWidget {
  const TabBarDemoScreen({super.key});

  @override
  ConsumerState<TabBarDemoScreen> createState() => _TabBarDemoScreenState();
}

class _TabBarDemoScreenState extends ConsumerState<TabBarDemoScreen> {
  TabBarStyle _currentStyle = TabBarStyle.modern;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tab Bar Design Demo'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Style Selector
            TabBarStyleSelector(
              currentStyle: _currentStyle,
              onStyleChanged: (style) {
                setState(() {
                  _currentStyle = style;
                });
              },
            ),

            const SizedBox(height: 20.0),

            // Preview Section
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preview',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Content area
                        const Center(
                          child: Text(
                            'Your app content goes here',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),

                        // Tab bar preview
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: _buildTabBarPreview(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20.0),

            // Style Information
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700),
                      const SizedBox(width: 8.0),
                      Text(
                        'Current Style: ${TabBarStyleManager.getStyleConfig(_currentStyle).name}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    TabBarStyleManager.getStyleConfig(
                      _currentStyle,
                    ).description,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBarPreview() {
    return TabBarStyleManager.getStyleConfig(_currentStyle).builder();
  }
}
