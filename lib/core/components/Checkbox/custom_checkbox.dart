import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final Color? activeColor;
  final Color? checkColor;
  final Color? borderColor;
  final double? size;
  final double? borderRadius;
  final EdgeInsets? padding;
  final bool showTitle;
  final bool showSubtitle;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final String? checkIcon;
  final bool isRounded;

  const CustomCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.title,
    this.subtitle,
    this.subtitleWidget,
    this.activeColor,
    this.checkColor,
    this.borderColor,
    this.size,
    this.borderRadius,
    this.padding,
    this.showTitle = false,
    this.showSubtitle = false,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.checkIcon,
    this.isRounded = false,
  });

  @override
  Widget build(BuildContext context) {
    final checkboxSize = size ?? 20.0;
    final borderRadiusValue =
        borderRadius ?? (isRounded ? checkboxSize / 2 : 4.0);
    final activeColorValue = activeColor ?? AppColor.primaryColor;
    final checkColorValue = checkColor ?? AppColor.white;
    final borderColorValue = borderColor ?? AppColor.border;

    return GestureDetector(
      onTap: () => onChanged?.call(!value),
      child: Container(
        padding: padding ?? EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: crossAxisAlignment!,
          mainAxisAlignment: mainAxisAlignment!,
          children: [
            // Custom Checkbox
            Container(
              width: checkboxSize,
              height: checkboxSize,
              decoration: BoxDecoration(
                color: value ? activeColorValue : Colors.transparent,
                border: Border.all(
                  color: value ? activeColorValue : borderColorValue,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(borderRadiusValue),
              ),
              child: value
                  ? Center(
                      child: checkIcon != null
                          ? SvgPicture.asset(
                              checkIcon!,
                              width: checkboxSize * 0.6,
                              height: checkboxSize * 0.6,
                              colorFilter: ColorFilter.mode(
                                checkColorValue,
                                BlendMode.srcIn,
                              ),
                            )
                          : Icon(
                              Icons.check,
                              size: checkboxSize * 0.7,
                              color: checkColorValue,
                            ),
                    )
                  : null,
            ),

            // Title and Subtitle
            if (showTitle || showSubtitle) ...[
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showTitle && title != null)
                      Text(
                        title!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.textColor,
                        ),
                      ),
                    if (showSubtitle && subtitle != null)
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textGreyColor,
                          ),
                        ),
                      ),
                    if (showSubtitle && subtitleWidget != null)
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: subtitleWidget!,
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Custom Checkbox List Tile for easier usage
class CustomCheckboxListTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final Color? activeColor;
  final Color? checkColor;
  final Color? borderColor;
  final double? size;
  final double? borderRadius;
  final EdgeInsets? padding;
  final ListTileControlAffinity? controlAffinity;
  final bool isRounded;
  final String? checkIcon;

  const CustomCheckboxListTile({
    super.key,
    required this.value,
    this.onChanged,
    this.title,
    this.subtitle,
    this.subtitleWidget,
    this.activeColor,
    this.checkColor,
    this.borderColor,
    this.size,
    this.borderRadius,
    this.padding,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.isRounded = false,
    this.checkIcon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCheckbox(
      value: value,
      onChanged: onChanged,
      title: title,
      subtitle: subtitle,
      subtitleWidget: subtitleWidget,
      activeColor: activeColor,
      checkColor: checkColor,
      borderColor: borderColor,
      size: size,
      borderRadius: borderRadius,
      padding: padding,
      showTitle: title != null,
      showSubtitle: subtitle != null || subtitleWidget != null,
      isRounded: isRounded,
      checkIcon: checkIcon,
    );
  }
}
