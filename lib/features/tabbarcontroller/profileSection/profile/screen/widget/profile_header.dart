import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/components/apptext/inter_apptext.dart';
import '../../../../../../core/components/apptext/urbanist_apptext.dart';

class ProfileSettingsHeader extends ConsumerWidget {
  const ProfileSettingsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    return Row(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        //  SvgPicture.asset(AppSvg.profileIconSelected),
        CircleAvatar(
          radius: width * (36 / width),
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            UrbanistApptext(
              text: 'Jimmy Doe',
              fontSize: width * (18 / width),
              fontWeight: FontWeight.w700,
              color: AppColor.textColor,
            ),

            InterApptext(
              text: 'jimmy@gmail.com',
              fontSize: width * (14 / width),
              fontWeight: FontWeight.w500,
              color: AppColor.textGreyColor2,
            ),
          ],
        ),
      ],
    );
  }
}
