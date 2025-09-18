import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';

class PlusJakartaSansApptext extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final double? height;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;

  const PlusJakartaSansApptext({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.height,
    this.maxLines,
    this.textAlign,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: fontSize ?? width * 0.065,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: color ?? AppColor.textColor,
        height: height ?? (heights > 650 ? heights / 600 : heights / 600),
        decoration: textDecoration ?? TextDecoration.none,
      ),
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
