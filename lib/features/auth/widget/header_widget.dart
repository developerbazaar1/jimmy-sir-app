import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/components/apptext/inter_apptext.dart';
import '../../../core/components/apptext/plus_jakarta_sans.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_svg.dart';

class HeaderWidget extends ConsumerWidget {
  const HeaderWidget({
    super.key,
    required this.title,
    required this.description,
  });
  final String title;
  final String description;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Row(
          spacing: width * 0.0306,
          children: [
            PlusJakartaSansApptext(
              text: title,
              fontSize: width * 0.0715,
              fontWeight: FontWeight.w700,
              color: AppColor.primaryColor,
            ),

            SvgPicture.asset(
              AppSvg.logo,
              height: width * 0.0867,
              width: width * 0.0867,
            ),
          ],
        ),
        SizedBox(height: width * 0.0204),
        InterApptext(
          text: description,
          fontSize: width * 0.03,
          fontWeight: FontWeight.w500,
          color: AppColor.textGreyColor2,
        ),
        SizedBox(height: width * 0.0418),
      ],
    );
  }
}
