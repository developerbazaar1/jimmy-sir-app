import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';

//----------------------------------this is for outer app bar bro----------------------------------

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool showSkip;
  final VoidCallback? onBackTap;
  final VoidCallback? onSkipTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.showSkip = false,
    this.onBackTap,
    this.onSkipTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return AppBar(
      surfaceTintColor: AppColor.white,
      backgroundColor: AppColor.white,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Back Button + Title
              Row(
                children: [
                  if (showBack)
                    GestureDetector(
                      onTap: onBackTap ?? () => context.pop(),
                      child: SvgPicture.asset(
                        AppSvg.arrowLeftIcon,
                        height: height * 0.03,
                        width: width * 0.02,
                      ),
                    ),
                  if (showBack) SizedBox(width: width * 0.01),
                  UrbanistApptext(
                    textAlign: TextAlign.center,
                    text: title,
                    fontWeight: FontWeight.w700,
                    color: AppColor.textBrownColor,
                    fontSize: width * 0.055,
                  ),
                ],
              ),

              /// Skip Button
              if (showSkip)
                GestureDetector(
                  onTap: onSkipTap,
                  child: UrbanistApptext(
                    textAlign: TextAlign.center,
                    text: AppText.skip,
                    fontWeight: FontWeight.w500,
                    color: AppColor.textGreyColor3,
                    fontSize: width * 0.038,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//----------------------------------this is for iner app bar bro----------------------------------

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final VoidCallback? onBackTap;
  final VoidCallback? onSkipTap;

  const CustomAppBar2({
    super.key,
    required this.title,
    this.onBackTap,
    this.onSkipTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return AppBar(
      surfaceTintColor: AppColor.white,
      backgroundColor: AppColor.white,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              onBackTap != null ?
              GestureDetector(
                onTap: onBackTap ?? () => context.pop(),
                child: SvgPicture.asset(
                  AppSvg.arrowLeftIcon,
                  height: height * 0.03,
                  width: width * 0.02,
                ),
              ) : SizedBox.shrink(),
              UrbanistApptext(
                textAlign: TextAlign.center,
                text: title,
                fontWeight: FontWeight.w700,
                color: AppColor.black,
                fontSize: width * 0.055,
              ),
              Container(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
