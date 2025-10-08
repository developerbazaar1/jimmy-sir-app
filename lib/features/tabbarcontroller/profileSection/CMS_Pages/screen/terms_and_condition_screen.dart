import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/components/customAppbar/CustomAppBar.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizer.dart';
import '../provider/terms_condition_provider.dart';

class TermsConditionsScreen extends ConsumerWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final htmlContent = ref.watch(termsConditionsHtmlProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar2(
        title: "Terms & Conditions",
        onBackTap: () => context.pop(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizer.width * 0.04,
          vertical: AppSizer.height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Html(
            data: htmlContent,
            style: {
              "p": Style(
                fontSize: FontSize(AppSizer.width * 0.04),
                color: AppColor.textColor,
                lineHeight: LineHeight(1.5),
              ),
              "h2": Style(
                fontSize: FontSize(AppSizer.width * 0.06),
                fontWeight: FontWeight.w700,
                color: AppColor.primaryColor,
              ),
              "h3": Style(
                fontSize: FontSize(AppSizer.width * 0.048),
                fontWeight: FontWeight.w600,
                color: AppColor.primaryColor.withOpacity(0.9),
                margin: Margins.only(top: 16, bottom: 8),
              ),
              "ul": Style(
                margin: Margins.only(left: 12, bottom: 12),
              ),
              "li": Style(
                fontSize: FontSize(AppSizer.width * 0.04),
                color: AppColor.textColor,
              ),
              "a": Style(
                color: AppColor.primaryColor,
                textDecoration: TextDecoration.underline,
              ),
            },
          ),
        ),
      ),
    );
  }
}
