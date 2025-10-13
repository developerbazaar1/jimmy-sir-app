// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jimmy_sir_app/core/components/apptext/poppins_apptext.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';

class availableBalanceContainer extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final String description;
  const availableBalanceContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.description,
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
            color: AppColor.white,
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
                  height: width * (35 / width),
                  width: width * (35 / width),
                ),

                SizedBox(width: width * (8 / width)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UrbanistApptext(
                      text: title,
                      fontSize: width * (16 / width),
                      fontWeight: FontWeight.w600,

                      color: AppColor.black,
                    ),

                    PoppinsApptext(
                      text: description,
                      maxLines: 2,
                      fontSize: width * (11 / width),
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      color: AppColor.textGreyColor3,
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: width * (18 / width)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
