import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';

import '../../../../../../core/components/apptext/poppins_apptext.dart';
import '../../../../../../core/components/apptext/urbanist_apptext.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_svg.dart';
import '../../provider/help_provider.dart';

class HelpWidget extends ConsumerStatefulWidget {
  const HelpWidget({super.key});

  @override
  ConsumerState<HelpWidget> createState() => _HelpWidgetState();
}

class _HelpWidgetState extends ConsumerState<HelpWidget> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final helpState = ref.watch(helpProvider);

    ref.listen(helpProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColor.redColor,
          ),
        );
      } else if (next.help != null && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppText.yourMessageHasBeenSentSuccessfullyToYou),
            backgroundColor: AppColor.greenColor,
          ),
        );
        _messageController.clear();
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Illustration Section
        SvgPicture.asset(
          AppSvg.helpStateIcon,
          height: width * (200 / width),
          width: width * (200 / width),
        ),

        SizedBox(height: width * (32 / width)),

        // Question Text
        UrbanistApptext(
          text: AppText.howCanWeHelpYou,
          fontSize: width * (18 / width),
          fontWeight: FontWeight.w600,
          color: AppColor.black,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: width * (32 / width)),

        // Write Us Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UrbanistApptext(
              text: AppText.writeUs,
              fontSize: width * (16 / width),
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
            SizedBox(height: width * (12 / width)),
            Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(width * (12 / width)),
                border: Border.all(color: AppColor.greyColor, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.shadowColor,
                    blurRadius: width * (4 / width),
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _messageController,
                focusNode: _messageFocusNode,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: AppText.haveAQuestionOrNeedAssistance,
                  hintStyle: TextStyle(
                    color: AppColor.placeholderColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(width * (16 / width)),
                ),
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: width * (14 / width),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Submit Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: helpState.isLoading
                ? null
                : () {
                    if (_messageController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppText.pleaseEnterYourMessage),
                          backgroundColor: AppColor.redColor,
                        ),
                      );
                      return;
                    }

                    ref
                        .read(helpProvider.notifier)
                        .postHelp(message: _messageController.text.trim());
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              foregroundColor: AppColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: helpState.isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColor.white),
                    ),
                  )
                : PoppinsApptext(
                    text: AppText.submit,
                    fontSize: width * (16 / width),
                    fontWeight: FontWeight.w600,
                    color: AppColor.white,
                  ),
          ),
        ),
      ],
    );
  }
}
