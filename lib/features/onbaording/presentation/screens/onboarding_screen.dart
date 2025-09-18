import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimmy_sir_app/core/components/apptext/inter_apptext.dart';
import 'package:jimmy_sir_app/core/components/apptext/plus_jakarta_sans.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';  
import 'package:jimmy_sir_app/core/constants/app_images.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/features/onbaording/data/providers/onboarding_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/components/apptext/urbanist_apptext.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final pageController = PageController();

  final List<_OnboardingPageModel> pages = [
    _OnboardingPageModel(
      color: AppColor.primaryColor,
      imagePath: AppImages.onboarding_11,
      title: "Set Goals.\nGet Smarter Plans.",
      description:
          "Whether it’s weight loss, better sleep, or stress relief — choose what matters most to you.",
    ),
    _OnboardingPageModel(
      color: AppColor.secondaryColor,
      imagePath: AppImages.onboarding_22,
      title: "Stay on Top of your\nProgress",
      description:
          "Monitor nutrition, sleep, activity, and wellness with clear insights and simple visuals.",
    ),
    _OnboardingPageModel(
      color: AppColor.ternaryColor,
      imagePath: AppImages.onboarding_33,
      title: "Meet Your Smart Life\nAssistant",
      description:
          "Get quick tips, reminders, and guidance whenever you need extra support.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(onboardingPageProvider);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: pages[currentPage].color,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Align(
                alignment: Alignment.centerRight,
                child: InterApptext(
                  text: "Skip",
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.04,
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            Expanded(
              child: PageView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                itemCount: pages.length,
                onPageChanged: (index) =>
                    ref.read(onboardingPageProvider.notifier).state = index,
                itemBuilder: (context, index) {
                  return _OnboardingPage(pages[index]);
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.03,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: pages.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 12,
                      dotColor: Colors.grey.withOpacity(0.6),
                      activeDotColor: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (currentPage < pages.length - 1) {
                        pageController.jumpToPage(currentPage + 1);

                        // pageController.nextPage(
                        //   duration: const Duration(milliseconds: 300),
                        //   curve: Curves.easeInCirc,
                        // );
                      } else {
                        // Finish onboarding
                      }
                    },
                    child: SvgPicture.asset(
                      AppSvg.roundNextIcon,
                      height: height * 0.06,
                      width: width * 0.06,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.07),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageModel {
  final Color color;
  final String imagePath;
  final String title;
  final String description;

  _OnboardingPageModel({
    required this.color,
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class _OnboardingPage extends ConsumerWidget {
  final _OnboardingPageModel model;

  const _OnboardingPage(this.model, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final currentPage = ref.watch(onboardingPageProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// AnimatedSwitcher handles image transitions
        // AnimatedSwitcher(
        //   duration: const Duration(milliseconds: 600),
        //   transitionBuilder: (child, animation) {
        //     return FadeTransition(
        //       opacity: animation,
        //       child: ScaleTransition(scale: animation, child: child),
        //     );
        //   },
        //   child: Container(
        //     key: ValueKey<String>(model.imagePath),
        //     height: height * 0.33,
        //     // decoration: const BoxDecoration(
        //     //   shape: BoxShape.circle,
        //     //   color: Colors.white,
        //     // ),
        //     child: Image.asset(model.imagePath, fit: BoxFit.contain),
        //   ),
        // ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (child, animation) {
            final offsetAnimation =
                Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
                );

            return SlideTransition(
              position: offsetAnimation,
              textDirection: TextDirection.ltr,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: TweenAnimationBuilder<double>(
            key: ValueKey<String>(model.imagePath),
            tween: Tween<double>(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 600),
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Container(
                  height: height * 0.33,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Image.asset(model.imagePath, fit: BoxFit.contain),
                ),
              );
            },
          ),
        ),
        SizedBox(height: height * 0.1),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                UrbanistApptext(
                text: model.title,
                textAlign: TextAlign.start,
                fontSize: 28,
                fontWeight: FontWeight.w700,

                color: Colors.white,
              ),
              SizedBox(height: height * 0.02),
              InterApptext(
                text: model.description,
                maxLines: 3,
                textAlign: TextAlign.start,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
