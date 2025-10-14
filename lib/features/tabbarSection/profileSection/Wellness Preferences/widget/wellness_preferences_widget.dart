import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/core/components/apptext/inter_apptext.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';

class WellnessPreferencesWidget extends ConsumerWidget {
  const WellnessPreferencesWidget({
    super.key,
    required this.title,
    required this.keys,
  });
  final String title;
  final List<String> keys;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * .04, vertical: width * .04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * .035),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.2*255).round()),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UrbanistApptext(
                text: title,
                fontSize: width * 0.045,
                fontWeight: FontWeight.w700,
                color: AppColor.black,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColor.black,
                size: width * 0.04,
              ),
            ],
          ),
          SizedBox(height: width * 0.005),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: Row(
              children: List<Widget>.generate(keys.length, (index) {
                final keyText = keys[index];
                return InterApptext(
                  text: keyText + (index != keys.length - 1 ? " • " : ""),
                  fontSize: width * 0.027,
                  fontWeight: FontWeight.w400,
                  color: AppColor.textGreyColor3,
                  key: Key(index.toString()),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
