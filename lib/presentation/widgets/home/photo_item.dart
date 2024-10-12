import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../app.dart';

class PhotoItem extends StatefulWidget {
  const PhotoItem({
    super.key,
    this.milliseconds = 3000,
    required this.text,
    this.imgHeight,
    this.imgPath,
    this.sliderWidth,
  });

  final String text;
  final int milliseconds;
  final String? imgPath;
  final double? imgHeight;
  final double? sliderWidth;

  @override
  PhotoItemState createState() => PhotoItemState();
}

class PhotoItemState extends State<PhotoItem> {
  bool _isTransformed = false;
  bool _hideText = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: widget.milliseconds), () {
        setState(() {
          _isTransformed = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final imgHeight = widget.imgHeight ?? context.sizeHeight(0.2);

    return SizedBox(
      height: imgHeight,
      child: Stack(
        children: [
          _buildImage(imgHeight), // Image displayed in ClipRRect
          _buildAnimatedContainer(context, imgHeight), // Animated container drawn at the bottom, overlapping
        ],
      ),
    );
  }

  Widget _buildImage(double imgHeight) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        // This ensures that the image fills the space without stretching
        height: imgHeight,
        width: double.infinity, // Full width of the parent
        child: FittedBox(
          fit: BoxFit.cover, // Ensures the image covers the container
          child: Image.asset(
            widget.imgPath ?? ImagePaths.apartment1,
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Icon(Icons.error)); // Handle image loading error
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedContainer(BuildContext context, double imgHeight) {
    return Positioned(
      top: imgHeight - 54, // Adjusted for better placement
      left: context.sizeWidth(0.03),
      child: AnimatedContainer(
        width: _isTransformed ? context.sizeWidth(widget.sliderWidth ?? 0.9) : 45,
        height: 42,
        duration: const Duration(milliseconds: 1200),
        curve: Curves.linear,
        onEnd: () {
          if (mounted) {
            setState(() {
              _hideText = false;
            });
          }
        },
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer.withOpacity(0.75),
          borderRadius: BorderRadius.circular(_isTransformed ? 100 : 10),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildAutoSizeText(context),
            _buildChevronIcon(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoSizeText(BuildContext context) {
    return Align(
      child: _hideText
          ? const SizedBox.shrink()
          : AutoSizeText(
        widget.text,
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        maxFontSize: 14,
        minFontSize: 10,
        maxLines: 1,
        textAlign: TextAlign.center,
      ).fadeInFromLeft(delay: 100.ms, animationDuration: 100.ms),
    );
  }

  Widget _buildChevronIcon(BuildContext context) {
    return Positioned(
      right: 0,
      child: Container(
        width: 40,
        height: 38,
        margin: _isTransformed ? const EdgeInsets.all(2) : null,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.chevron_right,
          size: 20,
          color: context.colorScheme.onSurface.withOpacity(0.5),
        ),
      ),
    );
  }
}