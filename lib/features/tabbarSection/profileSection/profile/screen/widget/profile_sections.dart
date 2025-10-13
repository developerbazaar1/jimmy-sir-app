import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/components/apptext/poppins_apptext.dart';
import '../../../../../../core/constants/app_sizer.dart';

class ProfileSections extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final Color? color;
  final ColorFilter? colorFilter;

  const ProfileSections({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    AppSizer as = AppSizer(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: as.h(25),
        left: as.w(4),
        right: as.w(4),
        top: as.h(4),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? AppColor.white,
            borderRadius: BorderRadius.circular(as.w(16)),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor3.withAlpha((0.05*255).round()),
                blurRadius: as.w(8),
                offset: Offset(0, as.h(8)),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: AppColor.primaryColor3.withAlpha((0.02*255).round()),
                blurRadius: as.w(6),
                offset: Offset(0, as.h(4)),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(as.w(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  height:
                      color == AppColor.primaryColor ||
                          color == AppColor.redColor
                      ? as.w(23)
                      : as.w(30),
                  width:
                      color == AppColor.primaryColor ||
                          color == AppColor.redColor
                      ? as.w(30)
                      : as.w(35),
                  colorFilter: colorFilter,
                ),
                SizedBox(width: color == AppColor.primaryColor ||
                          color == AppColor.redColor ? as.w(15) : as.w(12)),
                PoppinsApptext(
                  text: title,
                  fontSize: as.w(15),
                  fontWeight:
                      color == AppColor.primaryColor ||
                          color == AppColor.redColor
                      ? FontWeight.w600
                      : FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color:
                      color == AppColor.primaryColor ||
                          color == AppColor.redColor
                      ? AppColor.white
                      : AppColor.textColor,
                ),
                Spacer(),
                if (color != AppColor.primaryColor &&
                    color != AppColor.redColor)
                  Icon(Icons.arrow_forward_ios, size: as.w(18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
