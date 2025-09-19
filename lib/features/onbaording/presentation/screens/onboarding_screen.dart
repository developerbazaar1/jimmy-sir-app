import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jimmy_sir_app/core/components/apptext/inter_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';
import 'package:jimmy_sir_app/core/constants/app_images.dart';
import 'package:jimmy_sir_app/core/constants/app_svg.dart';
import 'package:jimmy_sir_app/core/constants/app_text.dart';
import 'package:jimmy_sir_app/core/routes/route_constant.dart';
import 'package:jimmy_sir_app/features/onbaording/providers/onboarding_provider.dart';
import 'package:jimmy_sir_app/features/registeration/presentation/screens/aboutYourSelf/about_yourself_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/components/apptext/urbanist_apptext.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController pageController;

  final List<_OnboardingPageModel> pages = [
    _OnboardingPageModel(
      color: AppColor.primaryColor,
      imagePath: AppImages.onboarding_11,
      title: AppText.onboardingHeading,
      description: AppText.onboardingDescription,
    ),
    _OnboardingPageModel(
      color: AppColor.secondaryColor,
      imagePath: AppImages.onboarding_22,
      title: AppText.onboardingHeading2,
      description: AppText.onboardingDescription2,
    ),
    _OnboardingPageModel(
      color: AppColor.ternaryColor,
      imagePath: AppImages.onboarding_33,
      title: AppText.onboardingHeading3,
      description: AppText.onboardingDescription3,
    ),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(onboardingPageProvider);
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;

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
                  text: AppText.skip,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.04,
                ),
              ),
            ),
            Expanded(
              child: PageView.custom(
                // physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (index) =>
                    ref.read(onboardingPageProvider.notifier).state = index,
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _OnboardingPage(pages[index], key: ValueKey(index));
                  },
                  childCount: pages.length,
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  addSemanticIndexes: false,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedBuilder(
                    animation: pageController,
                    builder: (context, _) {
                      if (!pageController.hasClients) {
                        return const SizedBox(height: 12, width: 80);
                      }
                      return SmoothPageIndicator(
                        controller: pageController,
                        count: pages.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: 10,
                          dotWidth: 12,
                          dotColor: Colors.grey.withOpacity(0.6),
                          activeDotColor: Colors.white,
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      final current = ref.read(onboardingPageProvider);

                      if (!pageController.hasClients) return;

                      if (current < pages.length - 1) {
                        // Trigger animation manually
                        ref.read(animateImageProvider.notifier).state = true;

                        // Thoda delay do taaki animation visible ho
                        await Future.delayed(const Duration(milliseconds: 50));

                        pageController.jumpToPage(current + 1);
                        ref.read(onboardingPageProvider.notifier).state =
                            current + 1;

                        // Reset flag
                        Future.delayed(const Duration(milliseconds: 800), () {
                          ref.read(animateImageProvider.notifier).state = false;
                        });
                      } else {
                        context.pushNamed(RouteNames.aboutYourself);
                      }
                    },

                    // onTap: () async {
                    //   final current = ref.read(onboardingPageProvider);
                    //   if (!pageController.hasClients) return;

                    //   if (current < pages.length - 1) {
                    //     // remove sliding effect
                    //     pageController.jumpToPage(current + 1);

                    //     // update provider manually (since jumpToPage is instant)
                    //     ref.read(onboardingPageProvider.notifier).state =
                    //         current + 1;
                    //   } else {
                    //     context.pushNamed(RouteNames.aboutYourself);
                    //   }
                    // },
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

// onTap: () async {
//   final current = ref.read(onboardingPageProvider);
//   if (!pageController.hasClients) return;
//   if (current < pages.length - 1) {
//     await pageController.nextPage(
//       duration: const Duration(milliseconds: 380),
//       curve: Curves.easeInOut,
//     );
//   } else {
//     context.pushNamed(RouteNames.aboutYourself);
//     print(
//       "navigate-------------------------------------to nexttt screennnnnnn",
//     );
//   }
// },
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

  int _pageIndexFor(String path) {
    if (path == AppImages.onboarding_11) return 0;
    if (path == AppImages.onboarding_22) return 1;
    return 2;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final currentPage = ref.watch(onboardingPageProvider);

    final pageIndex = _pageIndexFor(model.imagePath);
    final isCurrent = currentPage == pageIndex;

    final double targetOpacity = isCurrent ? 1.0 : 0.0;
    final double targetScale = (pageIndex == 2)
        ? (isCurrent ? 1.0 : 0.88)
        : (isCurrent ? 1.0 : 0.10);

    final double targetTurns = (isCurrent && pageIndex == 1)
        ? 0.0
        : (isCurrent && pageIndex == 2)
        ? (11.0 / 360.0)
        : (5.0 / 360.0);

    final Offset slideOffset = (pageIndex == 1)
        ? (isCurrent ? Offset.zero : const Offset(0.4, 0.0))
        : (pageIndex == 2)
        ? (isCurrent ? const Offset(0.0, -0.16) : Offset.zero)
        : Offset.zero;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: height * 0.36,
                width: width * 0.69,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              child: SizedBox(
                height: height * 0.33,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity: targetOpacity,
                      child: AnimatedSlide(
                        duration: const Duration(milliseconds: 500),
                        offset: slideOffset,
                        child: AnimatedScale(
                          duration: isCurrent
                              ? const Duration(milliseconds: 700)
                              : const Duration(milliseconds: 260),
                          curve: Curves.easeOutCubic,
                          scale: targetScale,
                          child: AnimatedRotation(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                            turns: targetTurns,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                model.imagePath,
                                width: height * 0.38,
                                height: height * 0.40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.09),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UrbanistApptext(
                text: model.title,
                textAlign: TextAlign.start,
                fontSize: width * 0.08,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
              SizedBox(height: height * 0.02),
              InterApptext(
                text: model.description,
                maxLines: 3,
                textAlign: TextAlign.start,
                fontSize: width * 0.04,
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















































//-----------------------wrough work--------------


   // final double targetScale = isCurrent
    //     ? 1.0
    //     : 0.12;
    // final double targetTurns = (isCurrent && pageIndex == 1)
    //     ? 0.0
    //     : (isCurrent && pageIndex == 2)
    //     ? (11.0 / 360.0)
    //     : (12.0 / 360.0);
    // // ? (-10.0 / 320.0) // <-- clockwise on 3rd index
    // // : (10.0 / 360.0); // this is for all image
    // // ? -(10.0 / 360.0) // anti-clockwise 45° for page 3
    // // : (13.0 / 360.0); // small idle tilt for others

    // // Slide:
    // // - index 1: right → center (your existing)
    // // - index 2: left → center (new)

    // final Offset slideOffset = (pageIndex == 1)
    //     ? (isCurrent ? Offset.zero : const Offset(0.4, 0.0))
    //     : (pageIndex == 2)
    //     ? (isCurrent ? Offset.zero : const Offset(0.0, 0.0))
    //     : Offset.zero;
    // // final Offset slideOffset = (pageIndex == 1)
    // //     ? (isCurrent ? Offset.zero : const Offset(0.4, 0.0))
    // //     : (pageIndex == 2)
    // //     ? (isCurrent ? Offset.zero : const Offset(-0.4, 0.0))
    // //     : Offset.zero;





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
       