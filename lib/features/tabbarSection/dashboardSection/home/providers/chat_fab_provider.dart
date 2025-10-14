// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // class ChatFabState {
// //   final bool isOpen;

// //   ChatFabState({required this.isOpen});

// //   ChatFabState copyWith({bool? isOpen}) {
// //     return ChatFabState(isOpen: isOpen ?? this.isOpen);
// //   }
// // }

// // class ChatFabNotifier extends StateNotifier<ChatFabState> {
// //   late final AnimationController controller;

// //   ChatFabNotifier({required TickerProvider vsync})
// //     : super(ChatFabState(isOpen: false)) {
// //     controller = AnimationController(
// //       vsync: vsync,
// //       duration: const Duration(milliseconds: 300),
// //     );
// //   }

// //   void toggle() {
// //     final open = !state.isOpen;
// //     state = state.copyWith(isOpen: open);

// //     if (open) {
// //       controller.forward();
// //     } else {
// //       controller.reverse();
// //     }
// //   }

// //   Animation<double> get animation =>
// //       CurvedAnimation(parent: controller, curve: Curves.easeOutQuart);

// //   void dispose() {
// //     controller.dispose();
// //   }
// // }

// // // We’ll use this with ConsumerStatefulWidget for vsync access
// // final chatFabProvider = StateNotifierProvider.autoDispose
// //     .family<ChatFabNotifier, ChatFabState, TickerProvider>((ref, vsync) {
// //       final notifier = ChatFabNotifier(vsync: vsync);
// //       ref.onDispose(() => notifier.dispose());
// //       return notifier;
// //     });

// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ChatFabState {
//   final bool isOpen;

//   ChatFabState({required this.isOpen});

//   ChatFabState copyWith({bool? isOpen}) {
//     return ChatFabState(isOpen: isOpen ?? this.isOpen);
//   }
// }

// class ChatFabNotifier extends StateNotifier<ChatFabState> {
//   ChatFabNotifier() : super(ChatFabState(isOpen: false));

//   void toggle() {
//     state = state.copyWith(isOpen: !state.isOpen);
//   }
// }

// final chatFabProvider = StateNotifierProvider<ChatFabNotifier, ChatFabState>(
//   (ref) => ChatFabNotifier(),
// );
