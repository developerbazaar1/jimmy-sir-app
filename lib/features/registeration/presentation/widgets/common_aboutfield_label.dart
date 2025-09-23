import 'package:flutter/material.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';

class commonAboutFieldLabel extends StatelessWidget {
  final String text;
  const commonAboutFieldLabel({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.sizeOf(context).height * 0.01,
      ),
      child: UrbanistApptext(
        text: text,
        fontSize: width * 0.040,
        fontWeight: FontWeight.w400,
        color: AppColor.textBrownColor,
      ),
    );
  }
}
