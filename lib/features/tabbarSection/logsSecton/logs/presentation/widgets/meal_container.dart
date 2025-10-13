import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';

class MealContainer extends ConsumerWidget {
  final bool isExpanded;
  final String title;
  final String description;
  final String imageUrl;
  const MealContainer(
    this.isExpanded,
    this.title,
    this.description,
    this.imageUrl, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.all(width * 0.03),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(width * 0.02),
        border: Border.all(color: AppColor.textGreyColor3, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColor.textGreyColor.withAlpha((0.15 * 255).round()),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Header Row ---
          Row(
            children: [
              UrbanistApptext(
                text: title.toString(),
                fontSize: width * 0.04,
                fontWeight: FontWeight.w500,
                color: AppColor.black,
              ),
              const Spacer(),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: SvgPicture.asset(AppSvg.arrowDown),
              ),
            ],
          ),

          /// --- Expanded Content ---
          if (isExpanded) ...[
            UrbanistApptext(
              text: description.toString(),
              fontSize: width * 0.035,
              fontWeight: FontWeight.w400,
              color: AppColor.textGreyColor3,
            ),
            SizedBox(height: 8),
            SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(width * 0.02),
              child: Image.network(
                imageUrl.toString(),
                height: width * 0.4,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
