import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimmy_sir_app/core/components/apptext/urbanist_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_images.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/features/tabbarcontroller/myWinsSection/provider/spin_provider.dart';
import 'package:stroke_text/stroke_text.dart';

/// StateProvider for selected index
final spinSelectedProvider = StateProvider<int?>((ref) => null);

class SpinWheelScreen extends ConsumerStatefulWidget {
  const SpinWheelScreen({super.key});

  @override
  ConsumerState<SpinWheelScreen> createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends ConsumerState<SpinWheelScreen> {
  @override
  void initState() {
    super.initState();
    //clear prev
    ref.read(selectedIndexProvider.notifier).state = null;
    Future.microtask(() {
      ref.read(spinControllerProvider).add(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    final items = [
      "50 points",
      "100 points",
      "200 points",
      "10 points",
      "30 points",
      "1000 points",
    ];

    final spinController = ref.watch(spinControllerProvider);
    final selected = ref.watch(selectedIndexProvider);

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.spinWheelBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: SizedBox(
                        height: height * 0.05,
                        width: width * 0.11,

                        child: Image.asset(
                          AppImages.backRoundButtonIcon,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.035),
                Image.asset(AppImages.spinTextImage, height: height * 0.07),
                Image.asset(AppImages.spinToImage, height: height * 0.07),
                Image.asset(AppImages.spinWinImage, height: height * 0.07),
                SizedBox(height: height * 0.04),

                AnimatedSwitcher(
                  duration: Duration(milliseconds: 2000),
                  transitionBuilder: (child, animation) {
                    final scaleAnimation = Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(animation);

                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: animation,
                        child: FadeTransition(opacity: animation, child: child),
                      ),
                    );
                  },
                  child: selected != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          key: ValueKey(selected),
                          children: [
                            StrokeText(
                              textAlign: TextAlign.center,
                              text: "Wow you won\n ${items[selected]} ",
                              textStyle: GoogleFonts.nunito(
                                fontSize: width * 0.1,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                              strokeColor: Color(0xFF5CD59A),
                              strokeWidth: width * 0.01,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),

                // SizedBox(height: height * 0.06),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  height: height * 0.36,
                  width: width * 0.8,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.center,
                          width: width * 0.8,
                          height: height * 0.18,
                          decoration: BoxDecoration(
                            color: AppColor.blackgrey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        child: Container(
                          height: height * 0.28,
                          width: width * 0.8,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                              color: AppColor.black,
                              width: width * 0.012,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.015),

                            child: Transform.rotate(
                              angle: pi, // 180° rotation
                              child: FortuneWheel(
                                selected: ref
                                    .watch(spinControllerProvider)
                                    .stream,
                                onAnimationEnd: () {
                                  final idx = ref.read(selectedIndexProvider);
                                  // Now show the "You won" text (AnimatedSwitcher)
                                  // Optionally, reset after a delay
                                },
                                items: [
                                  for (int i = 0; i < items.length; i++)
                                    FortuneItem(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(),
                                          UrbanistApptext(
                                            textAlign: TextAlign.center,
                                            text: items[i],
                                            fontSize: width * 0.039,
                                            fontWeight: FontWeight.w900,
                                            color: AppColor.blackgrey,
                                          ),
                                        ],
                                      ),
                                      style: FortuneItemStyle(
                                        color: i.isOdd
                                            ? AppColor.primaryColor
                                            : AppColor.greyColor2,
                                        borderColor: AppColor.white,
                                        borderWidth: width * 0.0,
                                      ),
                                    ),
                                ],
                                indicators: [],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: height * 0.12,
                        left: width * 0.35,
                        child: Container(
                          width: width * 0.10,
                          height: width * 0.10,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColor.black,
                              width: width * 0.016,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: AppColor.black,
                                width: width * 0.01,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: height * 0.01,
                        left: width * 0.28,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomPaint(
                              size: Size(height * 0.043, height * 0.043),
                              painter: TrianglePainterWithBorder(
                                fillColor: AppColor.yellowColor2,
                                borderColor: AppColor.blackgrey,
                              ),
                            ),
                            SizedBox(height: height * 0.01),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.greyColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.035,
                                  vertical: height * 0.01,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                final randomIndex = Random().nextInt(
                                  items.length,
                                );
                                ref.read(selectedIndexProvider.notifier).state =
                                    randomIndex;
                                spinController.add(randomIndex);
                              },

                              child: UrbanistApptext(
                                textAlign: TextAlign.center,
                                text: "Spin Now",
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w800,
                                color: AppColor.blackgrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TrianglePainterWithBorder extends CustomPainter {
  final Color fillColor;
  final Color borderColor;

  TrianglePainterWithBorder({
    required this.fillColor,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
