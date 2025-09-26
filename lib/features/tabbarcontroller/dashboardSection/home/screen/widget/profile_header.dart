import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/components/apptext/urbanist_apptext.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    return Row(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        //  SvgPicture.asset(AppSvg.profileIconSelected),
        CircleAvatar(
          radius: width * 0.09,
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            UrbanistApptext(
              text: 'Good Morning, Jimmy!',
              fontSize: width * 0.05,
              fontWeight: FontWeight.w600,
              color: AppColor.textColor,
            ),
            UrbanistApptext(
              text: 'Manage your account and settings',
              fontSize: width * 0.035,
              fontWeight: FontWeight.w400,
              color: AppColor.textGreyColor2,
            ),
          ],
        ),
      ],
    );
  }
}
