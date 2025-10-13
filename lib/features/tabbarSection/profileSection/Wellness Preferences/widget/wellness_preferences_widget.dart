import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimmy_sir_app/core/components/apptext/inter_apptext.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';

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
    return Card(
      color: Colors.white,
      elevation: 5,
      shadowColor: AppColor.shadowColor,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(width * (16 / width)),
      ),
      child: Padding(
        padding: EdgeInsets.all(width * (16 / width)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UrbanistApptext(
                  text: title,
                  fontSize: width * (20 / width),
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.black,
                  size: width * (20 / width),
                ),
              ],
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children: List<Widget>.generate(keys.length, (index) {
                  final keyText = keys[index];
                  return InterApptext(
                    text: keyText + (index != keys.length - 1 ? " • " : ""),
                    fontSize: width * (14 / width),
                    fontWeight: FontWeight.w400,
                    color: AppColor.placeholderColor,
                    key: Key(index.toString()),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
