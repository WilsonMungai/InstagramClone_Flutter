import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  // widget check whether the child of this parent
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  // check if heart button is clicked
  final bool smallLike;

  const LikeAnimation(
      {super.key,
      required this.child,
      required this.isAnimating,
      this.duration = const Duration(milliseconds: 150),
      this.onEnd,
      this.smallLike = false});

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  // animation controller
  late AnimationController controller;
  late Animation<double> scale;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        // ~/ 2 converts the milliseconds to int
        milliseconds: widget.duration.inMilliseconds ~/ 2,
      ),
    );
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  // ! called when current widget is replaced by another widget
  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  // check if widget is animating
  startAnimation() async {
    if (widget.isAnimating || widget.smallLike) {
      // start animating
      await controller.forward();
      // stop animating
      await controller.reverse();
      // introduce delay for like animation
      await Future.delayed(
        const Duration(milliseconds: 200),
      );
      // call back
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  // dispose controller
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
