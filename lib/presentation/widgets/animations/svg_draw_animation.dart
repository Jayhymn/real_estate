import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:svg_flutter/svg.dart';

class SvgDrawing extends StatefulWidget {
  final String assetPath;
  final Duration duration;

  const SvgDrawing({
    super.key,
    required this.assetPath,
    required this.duration,
  });

  @override
  State<SvgDrawing> createState() => _SvgDrawingState();
}

class _SvgDrawingState extends State<SvgDrawing> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SvgPicture.asset(
          widget.assetPath,
          color: Colors.black, // set color or use theme
          placeholderBuilder: (context) => CircularProgressIndicator(),
          clipBehavior: Clip.antiAlias,
        ).animate(
          delay: 300.ms,
        ).scaleXY(
          begin: 0,
          end: 1,
          duration: widget.duration,
          curve: Curves.easeInOut,
        ); // Scale animation mimics the "drawing" feel
      },
    );
  }
}