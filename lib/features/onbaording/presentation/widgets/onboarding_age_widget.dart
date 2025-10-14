import 'package:jimmy_sir_app/core/components/apptext/inter_apptext.dart';
import 'package:jimmy_sir_app/core/constants/app_images.dart';
import 'package:jimmy_sir_app/core/routes/route_import.dart';
import 'package:jimmy_sir_app/features/onbaording/models/onboarding_models.dart';
import 'package:jimmy_sir_app/features/onbaording/providers/onboarding_provider.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  final OnboardingPageModel model;

  const OnboardingPage(this.model, {super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  int _pageIndexFor(String path) {
    if (path == AppImages.onboarding_11) return 0;
    if (path == AppImages.onboarding_22) return 1;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final currentPage = ref.watch(onboardingPageProvider);

    final pageIndex = _pageIndexFor(widget.model.imagePath);
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
                                widget.model.imagePath,
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
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UrbanistApptext(
                    text: widget.model.title,
                    textAlign: TextAlign.start,
                    fontSize: width * 0.08,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                  SizedBox(height: height * 0.02),
                  InterApptext(
                    text: widget.model.description,
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
