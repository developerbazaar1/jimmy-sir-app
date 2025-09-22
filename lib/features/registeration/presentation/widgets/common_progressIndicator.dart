import 'package:flutter/material.dart';
//------------------------------------------ in this heading and icon only----------------------------

class CommonProgressIndicator extends StatelessWidget {
  final int step;
  final int totalSteps;
  final double? barWidth;
  final double? barHeight;
  final double spacing;
  final Color activeColor;
  final Color inactiveColor;

  const CommonProgressIndicator({
    super.key,
    required this.step,
    required this.totalSteps,
    this.barWidth,
    this.barHeight,
    this.spacing = 8.0,
    this.activeColor = const Color(0XFFE7D75C),
    this.inactiveColor = const Color(0xFFDDDDDD),
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    final width = barWidth ?? screenWidth * 0.21;
    final height = barHeight ?? screenHeight * 0.008;

    return Row(
      children: List.generate(totalSteps, (index) {
        return Padding(
          padding: EdgeInsets.only(
            right: index == totalSteps - 1 ? 0 : spacing,
          ),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: step == index
                  ? activeColor
                  : inactiveColor.withOpacity(0.2),
            ),
          ),
        );
      }),
    );
  }
}

//------------------------------------------ in this heading , des , icon----------------------------
class CommonProgressIndicator2 extends StatelessWidget {
  final int step;
  final int totalSteps;
  final double barWidth;
  final double barHeight;

  const CommonProgressIndicator2({
    super.key,
    required this.step,
    required this.totalSteps,
    required this.barWidth,
    required this.barHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        Color color;

        if (index < step) {
          color = Color(0XFFE7D75C);
        } else if (index == step) {
          color = Color(0XFFE7D75C);
        } else {
          color = Color(0XFFE7D75C).withOpacity(0.1);
        }

        return Padding(
          padding: EdgeInsets.only(right: barWidth * 0.3),
          child: Container(
            width: barWidth,
            height: barHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: color,
            ),
          ),
        );
      }),
    );
  }
}
