import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/components/apptext/urbanist_apptext.dart';
import '../../../../../../core/constants/app_colors.dart';

class MySubscriptionWidget extends ConsumerWidget {
  const MySubscriptionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.primaryColor),
        borderRadius: BorderRadius.circular(width * (16 / width)),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColor.primaryColor.withOpacity(0.5),
            AppColor.white.withOpacity(0.3),
            AppColor.secondaryColor.withOpacity(0.5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(width * (16 / width)),
        child: Column(
          children: [
            Row(
              children: [
                UrbanistApptext(
                  text: 'My Subscription',
                  fontSize: width * (28 / width),
                  fontWeight: FontWeight.w700,
                  color: AppColor.primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
