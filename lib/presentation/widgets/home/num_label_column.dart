import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/app.dart';

class NumLabelColumn extends StatelessWidget {
  const NumLabelColumn({
    super.key,
    required this.title,
    this.isCircle = false,
    required this.numValue,
  });

  final String title;
  final bool isCircle;
  final int numValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: context.textTheme.bodySmall?.copyWith(
            color: isCircle ? context.colorScheme.surface : null,
          ),
        ),
        Align(
          alignment: Alignment.center,
          heightFactor: 1.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: numValue.toDouble()),
                duration: const Duration(milliseconds: 1500),
                builder: (context, value, child) {
                  String formattedValue = NumberFormat('#,###', 'en_US').format(value.toInt()).replaceAll(',', ' ');

                  return Text(
                    formattedValue,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: isCircle ? context.colorScheme.surface : null,
                    ),
                  );
                },
              ),
              // Static text for offers
              Text(
                'offers',
                style: context.textTheme.bodySmall?.copyWith(
                  color: isCircle ? context.colorScheme.surface : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}