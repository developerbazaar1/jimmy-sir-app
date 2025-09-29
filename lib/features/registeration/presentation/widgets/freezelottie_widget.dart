import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class FreezedLottie extends StatefulWidget {
  const FreezedLottie({super.key});

  @override
  State<FreezedLottie> createState() => _FreezedLottieState();
}

class _FreezedLottieState extends State<FreezedLottie>
    with TickerProviderStateMixin {
  late final AnimationController _lottieController;
  bool _lottieFinished = false;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: height * 0.3,
      width: width * 0.5,
      child: Lottie.asset(
        'assets/lottie/splash_animation.json',
        controller: _lottieController,
        fit: BoxFit.contain,
        onLoaded: (composition) {
          _lottieController.duration = composition.duration;
          _lottieController.forward().whenComplete(() {
            _lottieController.stop(); // freeze at last frame
            setState(() => _lottieFinished = true);
          });
        },
      ),
    );
  }
}
