import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/components/customAppbar/CustomAppBar.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_sizer.dart';

/// ✅ Riverpod State Provider for push notifications
final pushNotificationProvider = StateProvider<bool>((ref) => false);

class NotificationSettings extends ConsumerWidget {
  const NotificationSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ✅ Watch current switch state
    final isPushEnabled = ref.watch(pushNotificationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar2(
        title: "Notification Settings",
        onBackTap: () => context.pop(),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizer.width * 0.055),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UrbanistApptext(
              text: "Push Notifications",
              fontSize: AppSizer.width * 0.05,
              fontWeight: FontWeight.w400,
            ),
            Switch(
              value: isPushEnabled,
              activeColor: AppColor.greenColor,
              thumbColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  return Colors.white;
                },
              ),
              trackOutlineColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  return Colors.white;
                },
              ),
              onChanged: (value) {
                // ✅ Update Riverpod state
                ref.read(pushNotificationProvider.notifier).state = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
