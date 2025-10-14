import 'package:flutter_svg/svg.dart';
import 'package:jimmy_sir_app/core/components/apptext/poppins_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_import.dart';

Widget buildHealthOverviewDetails(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  // final height = MediaQuery.of(context).size.height;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
    child: Column(
      children: [
        healthOverviewtile(
          title: AppText.sleepQuality,
          icon: AppSvg.bedIcon,
          onTap: () {
            context.pushNamed(RouteNames.sleepQualityScreen);
          },
        ),
        healthOverviewtile(
          title: AppText.hydrationAwareness,
          icon: AppSvg.dropIcon,
          onTap: () {},
        ),
        healthOverviewtile(
          title: AppText.nutritionBalance,
          icon: AppSvg.leafIcon,
          onTap: () {},
        ),
        healthOverviewtile(
          title: AppText.activityLevel,
          icon: AppSvg.runIcon,
          onTap: () {},
        ),
        healthOverviewtile(
          title: AppText.mood,
          icon: AppSvg.smileIcon,
          onTap: () {},
        ),
      ],
    ),
  );
}

class healthOverviewtile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final Color? color;
  healthOverviewtile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: height * 0.01),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.border),
          borderRadius: BorderRadius.circular(width * 0.03),
        ),
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                height: height * 0.03,
                width: width * 0.03,
              ),

              SizedBox(width: width * 0.04),
              PoppinsApptext(
                text: title,
                fontSize: width * 0.03,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                color: AppColor.textColor,
              ),
              Spacer(),

              Icon(Icons.arrow_forward_ios, size: width * 0.06),
            ],
          ),
        ),
      ),
    );
  }
}
