import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/components/apptext/poppins_apptext.dart';

class ProfileSections extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final Color? color;
  const ProfileSections({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(
        bottom: width * (16 / width),
        left: width * (4 / width),
        right: width * (4 / width),
        top: width * (4 / width),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? AppColor.white,
            borderRadius: BorderRadius.circular(width * (16 / width)),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor3.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 8),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: AppColor.primaryColor3.withOpacity(0.02),
                blurRadius: 6,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(width * (12 / width)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  height: color == AppColor.primaryColor
                      ? width * (30 / width)
                      : width * (35 / width),
                  width: color == AppColor.primaryColor
                      ? width * (30 / width)
                      : width * (35 / width),
                ),

                SizedBox(width: width * (8 / width)),
                PoppinsApptext(
                  text: title,
                  fontSize: width * (16 / width),
                  fontWeight: color == AppColor.primaryColor
                      ? FontWeight.w700
                      : FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: color == AppColor.primaryColor
                      ? AppColor.white
                      : AppColor.textColor,
                ),
                Spacer(),
                if (color != AppColor.primaryColor)
                  Icon(Icons.arrow_forward_ios, size: width * (18 / width)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
