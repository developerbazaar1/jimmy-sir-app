import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/features/tabbarSection/logsSecton/logs/provider/activity_logs_provider.dart';

class ActivityContainer extends ConsumerWidget {
  final bool isExpanded;
  final String title;

  const ActivityContainer(this.isExpanded, this.title, {super.key});

  static const List<Map<String, String>> aerobicOptions = [
    {
      'title': 'Low Intensity',
      'description': 'Light walking, easy cycling, gentle yoga',
    },
    {
      'title': 'Moderate',
      'description': 'Brisk walking, hiking, dancing, swimming',
    },
    {
      'title': 'High',
      'description': 'Running, rowing, spin classes, intense aerobics',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(width * 0.03),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(width * 0.02),
            border: Border.all(
              color: isExpanded
                  ? AppColor.primaryColor
                  : AppColor.textGreyColor3,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.textGreyColor.withAlpha((0.15 * 255).round()),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
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
        ),

        if (isExpanded) ...[
          const SizedBox(height: 12),
          Column(
            children: aerobicOptions
                .map(
                  (option) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _ActivityOption(
                      title: option['title']!,
                      description: option['description']!,
                      groupValue: ref.watch(activitySelectionProvider),
                      value: option['title']!,
                      onChanged: (newValue) {
                        ref
                            .read(activitySelectionProvider.notifier)
                            .selectIntensity(newValue);
                      },
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: width * 0.03),
        ],
      ],
    );
  }
}

class _ActivityOption extends StatelessWidget {
  final String title;
  final String description;
  final String? groupValue;
  final String value;
  final ValueChanged<String?> onChanged;

  const _ActivityOption({
    required this.title,
    required this.description,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSelected = groupValue == value;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: width * 0.025,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.borderGreenLight.withAlpha((.05 * 255).round())
              : AppColor.white,
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    color: AppColor.borderGreenLight.withAlpha(
                      (.15 * 255).round(),
                    ),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
          borderRadius: BorderRadius.circular(width * 0.02),
          border: Border.all(
            color: isSelected
                ? AppColor.borderGreenLight.withAlpha((.5 * 255).round())
                : Colors.transparent,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UrbanistApptext(
                    text: title,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w700,
                    color: AppColor.black,
                  ),
                  SizedBox(height: width * 0.005),
                  UrbanistApptext(
                    text: description,
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textGreyColor,
                  ),
                ],
              ),
            ),
            Container(
              width: width * 0.05,
              height: width * 0.05,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColor.borderGreenLight
                      : AppColor.textGreyColor3,
                  width: 2.0,
                ),
                color: AppColor.white,
              ),
              child: Center(
                child: isSelected
                    ? Container(
                        width: width * 0.03,
                        height: width * 0.03,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.borderGreenLight,
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
