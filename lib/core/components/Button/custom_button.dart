import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? borderColor;
  final double? elevation;
  final FontWeight? fontWeight;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.fontSize,
    this.height,
    this.width,
    this.borderRadius,
    this.borderColor,
    this.elevation,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: elevation ?? 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
          ),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize ?? 16,

            fontWeight: fontWeight ?? FontWeight.w600,
            color: textColor ?? AppColor.textColor,
          ),
          //style: TextStyle(color: textColor, fontSize: fontSize,fontWeight: fontWeight.w600,fontFamily: 'urbanist'),
        ),
      ),
    );
  }
}









class CustomButtonwitharrow extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? borderColor;
  final double? elevation;
  final FontWeight? fontWeight;
  const CustomButtonwitharrow({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.fontSize,
    this.height,
    this.width,
    this.borderRadius,
    this.borderColor,
    this.elevation,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: elevation ?? 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
          ),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: fontSize ?? 16,

                fontWeight: fontWeight ?? FontWeight.w600,
                color: textColor ?? AppColor.textColor,
              ),
            ),
            SizedBox(width: width * 0.02),
            Icon(
              Icons.arrow_forward_rounded,
              color: textColor ?? AppColor.textColor,
              size: fontSize ?? 18,
            ),
          ],
        ),
      ),
    );
  }
}
