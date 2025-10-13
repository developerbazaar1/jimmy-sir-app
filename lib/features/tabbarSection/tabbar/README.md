# Tab Bar Controller

A comprehensive tab bar controller for Flutter apps using Riverpod for state management with multiple modern design styles.

## Features

- ✅ State management with Riverpod
- ✅ Multiple modern design styles (Modern, Floating, Glassmorphism)
- ✅ Custom tab bar widgets with advanced styling
- ✅ Tab visibility control
- ✅ Navigation methods
- ✅ Type-safe tab management
- ✅ Easy integration with existing screens
- ✅ Style selector for easy switching
- ✅ Demo screen for testing designs

## Structure

```
tabbar/
├── models/
│   ├── tab_bar_model.dart          # Tab bar data models and enums
│   └── tab_bar_style.dart          # Tab bar style configurations
├── providers/
│   └── tab_bar_provider.dart       # Riverpod state management
├── services/
│   └── tab_bar_service.dart        # Tab bar service methods
├── controllers/
│   └── tab_bar_controller.dart    # Main controller with static methods
├── widgets/
│   ├── custom_tab_bar.dart         # Modern tab bar widget
│   ├── floating_tab_bar.dart       # Floating tab bar widget
│   ├── glassmorphism_tab_bar.dart # Glassmorphism tab bar widget
│   └── tab_bar_style_selector.dart # Style selector widget
├── screens/
│   └── tab_bar_demo_screen.dart    # Demo screen for testing styles
├── examples/
│   └── tab_bar_usage_example.dart  # Usage examples
├── tab_bar.dart                    # Main tab bar screen
├── tab_bar_exports.dart            # Export file
└── README.md                       # This file
```

## Usage

### 1. Basic Setup

The tab bar is already integrated into your app routes. Navigate to `/tab_bar_screen` to see it in action.

### 2. Navigation

```dart
// Navigate to specific tabs
TabBarController.navigateToHome(ref);
TabBarController.navigateToLogs(ref);
TabBarController.navigateToMyWins(ref);
TabBarController.navigateToProfile(ref);

// Navigate to any tab
TabBarController.navigateToTab(ref, TabBarItem.profile);
```

### 3. Tab Bar Visibility

```dart
// Hide tab bar
TabBarController.hideTabBar(ref);

// Show tab bar
TabBarController.showTabBar(ref);
```

### 4. State Checking

```dart
// Get current tab
TabBarItem currentTab = TabBarController.getCurrentTab(ref);

// Check if tab bar is visible
bool isVisible = TabBarController.isTabBarVisible(ref);

// Check specific tabs
bool isHome = TabBarController.isHomeTab(ref);
bool isLogs = TabBarController.isLogsTab(ref);
bool isMyWins = TabBarController.isMyWinsTab(ref);
bool isProfile = TabBarController.isProfileTab(ref);
```

### 5. Tab Bar Design Styles

#### Modern Style (Default)

```dart
CustomTabBar(
  selectedColor: Color(0xFF6366F1),
  unselectedColor: Color(0xFF64748B),
  backgroundColor: Color(0xFFF8FAFC),
  elevation: 12.0,
  showLabels: true,
  iconSize: 22.0,
  useGradient: true,
  useRoundedCorners: true,
  borderRadius: 24.0,
)
```

#### Floating Style

```dart
FloatingTabBar(
  selectedColor: Color(0xFF8B5CF6),
  unselectedColor: Color(0xFF6B7280),
  backgroundColor: Colors.white,
  elevation: 20.0,
  showLabels: true,
  iconSize: 22.0,
  borderRadius: 25.0,
  margin: EdgeInsets.all(16.0),
)
```

#### Glassmorphism Style

```dart
GlassmorphismTabBar(
  selectedColor: Color(0xFF06B6D4),
  unselectedColor: Color(0xFF6B7280),
  elevation: 15.0,
  showLabels: true,
  iconSize: 22.0,
  borderRadius: 20.0,
  blurIntensity: 10.0,
)
```

### 6. Style Management

```dart
// Get available styles
List<TabBarStyleConfig> styles = TabBarStyleManager.availableStyles;

// Get specific style configuration
TabBarStyleConfig config = TabBarStyleManager.getStyleConfig(TabBarStyle.modern);

// Use style selector widget
TabBarStyleSelector(
  currentStyle: TabBarStyle.modern,
  onStyleChanged: (style) {
    // Handle style change
  },
)
```

## Tab Items

The tab bar includes four main tabs:

- **Home** - Dashboard/Home screen
- **Logs** - Activity logs screen
- **My Wins** - Achievements/wins screen
- **Profile** - User profile screen

## Integration with Existing Screens

The tab bar controller automatically integrates with your existing screens:

- `HomeScreen` - Dashboard section
- `LogsScreen` - Logs section
- `MyWinsScreen` - My Wins section
- `ProfileScreen` - Profile section

## State Management

The tab bar uses Riverpod for state management with:

- `TabBarModel` - Contains current tab and visibility state
- `TabBarNotifier` - Handles state changes
- `tabBarProvider` - Global state provider

## Customization

### Adding New Tabs

1. Add new enum value to `TabBarItem` in `tab_bar_model.dart`
2. Add corresponding screen to `TabBarScreen`
3. Update navigation methods in `TabBarController`

### Styling

Customize the tab bar appearance using the `CustomTabBar` widget parameters:

- `selectedColor` - Color for selected tab
- `unselectedColor` - Color for unselected tabs
- `backgroundColor` - Background color
- `elevation` - Shadow elevation
- `showLabels` - Show/hide tab labels
- `iconSize` - Icon size

## Best Practices

1. Use `TabBarController` static methods for navigation
2. Check tab state before performing tab-specific actions
3. Use `IndexedStack` to maintain screen state
4. Handle tab bar visibility based on screen context
5. Use type-safe tab management with enums

## Example Implementation

See `tab_bar_usage_example.dart` for comprehensive usage examples.

## Dependencies

- `flutter_riverpod` - State management
- `flutter/material.dart` - UI components

## Route Integration

The tab bar is integrated into the app routes:

```dart
GoRoute(
  path: RoutePaths.tabBar,
  name: RouteNames.tabBar,
  builder: (_, __) => const TabBarScreen(),
),
```

Navigate to the tab bar using:

```dart
context.go(RoutePaths.tabBar);
```
