import 'package:flutter/material.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/components/TextFeild/text_feild.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';

class ProfileTextFiledInfo extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const ProfileTextFiledInfo({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.keyboardType,
  });
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: width * (8 / width),
      children: [
        UrbanistApptext(
          text: label,
          fontSize: width * (18 / width),
          fontWeight: FontWeight.w600,
          color: AppColor.black,
        ),

        TextFormField(
          controller: controller,

          style: TextStyle(
            fontSize: width * (18 / width),
            fontWeight: FontWeight.w600,
            color: AppColor.black,
            fontFamily: 'urbanist',
          ),
          cursorColor: AppColor.primaryColor,

          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: width * (16 / width),
              fontWeight: FontWeight.w400,
              color: AppColor.border,
              fontFamily: 'urbanist',
            ),
            filled: true,
            fillColor: AppColor.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * (12 / width)),
              borderSide: BorderSide(color: AppColor.border, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * (12 / width)),
              borderSide: BorderSide(color: AppColor.border, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * (12 / width)),
              borderSide: BorderSide(color: AppColor.primaryColor, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * (12 / width)),
              borderSide: BorderSide(color: AppColor.redColor, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * (12 / width)),
              borderSide: BorderSide(color: AppColor.redColor, width: 2.0),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: width * (16 / width),
              vertical: width * (16 / width),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
