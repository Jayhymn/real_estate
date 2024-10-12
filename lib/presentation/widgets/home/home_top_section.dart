import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:real_estate/app.dart';
import 'package:svg_flutter/svg_flutter.dart';


class HomeTopSection extends StatelessWidget {
  const HomeTopSection({
    super.key,
    required this.expandText,
    required this.hideCircleRow,
  });

  final bool expandText;
  final bool hideCircleRow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeaderRow(context),
        SizedBox(height: hideCircleRow ? 10 : 20),
        _buildGreetingSection(context),
      ],
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: AnimatedSize(
            duration: 800.ms,
            curve: Curves.linear,
            child: Container(
              padding: const EdgeInsets.all(12),
              width: expandText ? context.sizeWidth(0.48) : 10,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.secondary.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: _buildLocationRow(context),
            ),
          ).animate(delay: 2000.ms),
        ),
        const CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage(ImagePaths.profileImage),
        ).scale(animationDuration: 900.ms),
      ],
    );
  }

  Widget _buildLocationRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          ImagePaths.marker,
          color: context.colorScheme.secondary,
          height: 20,
        ).animate().fadeInFromLeft(delay: 450.ms, animationDuration: 500.ms),
        const SizedBox(width: 5),
        Flexible(
          child: const AutoSizeText(
            'Saint Petersburg',
            maxLines: 1,
          ).animate().fadeInFromLeft(delay: 600.ms, animationDuration: 800.ms),
        ),
      ],
    );
  }

  Widget _buildGreetingSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Hi, Marina',
            style: context.textTheme.bodyLarge,
          ).fadeInFromLeft(delay: 1500.ms),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingText('let\'s select your', context, delay: 1800.ms),
              _buildGreetingText('perfect place', context, delay: 2100.ms),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingText(String text, BuildContext context, {required Duration delay}) {
    return Text(
      text,
      style: context.textTheme.titleLarge?.copyWith(fontSize: 34),
    ).fadeInFromBottom(delay: delay, animationDuration: 450.ms);
  }
}
