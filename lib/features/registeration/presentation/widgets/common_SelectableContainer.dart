import 'package:flutter/material.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';

//--------------------------this is for a single option------------------------------------

class commonSelectableContainer extends StatelessWidget {
  final String title;
  final String? description;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  commonSelectableContainer({
    super.key,
    required this.title,
    this.description,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: width * 0.03),
        padding: EdgeInsets.symmetric(
          vertical: width * 0.04,
          horizontal: width * 0.05,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(
            color: isSelected ? AppColor.borderGreenLight : Colors.white,
            width: 1.5,
          ),
          color: isSelected
              ? AppColor.borderGreenLight.withOpacity(0.06)
              : Colors.white,
          boxShadow: !isSelected
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(right: width * 0.03),
                child: Icon(
                  icon,
                  color: isSelected ? AppColor.borderGreenLight : Colors.grey,
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  UrbanistApptext(
                    text: title,
                    fontSize: width * 0.04,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? AppColor.textBrownColor
                        : AppColor.textBrownColor,
                  ),
                  if (description != null)
                    UrbanistApptext(
                      text: description ?? "",
                      fontSize: width * 0.038,
                      fontWeight: FontWeight.w400,
                      color: isSelected
                          ? AppColor.textBrownColor
                          : AppColor.placeholderColor,
                    ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

//------------------------------------this is for an option in a list------------------------------------

class commonSelectableContainer1 extends StatelessWidget {
  final String title;

  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  commonSelectableContainer1({
    super.key,
    required this.title,

    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: width * 0.03),
        padding: EdgeInsets.symmetric(
          vertical: width * 0.04,
          horizontal: width * 0.05,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.03),
          border: Border.all(
            color: isSelected ? AppColor.borderGreenLight : Colors.white,
            width: 1.5,
          ),
          color: isSelected
              ? AppColor.borderGreenLight.withOpacity(0.06)
              : Colors.white,
          boxShadow: !isSelected
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(right: width * 0.03),
                child: Icon(
                  icon,
                  color: isSelected ? AppColor.borderGreenLight : Colors.grey,
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  UrbanistApptext(
                    text: title,
                    fontSize: width * 0.04,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? AppColor.textBrownColor
                        : AppColor.textBrownColor,
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
