import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:real_estate/app.dart';
import 'package:svg_flutter/svg.dart';

class BottomNavBar extends StatelessWidget {
  final int pageIndex;
  final Animation<double> rippleAnimation;
  final bool isBorderVisible;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.pageIndex,
    required this.rippleAnimation,
    required this.isBorderVisible,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: kBottomNavigationBarHeight * 1.4,
          width: context.sizeWidth(0.75),
          child: Card(
            color: context.colorScheme.onSurface.withOpacity(0.85),
            shape: const StadiumBorder(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                5,
                (index) => InkResponseWidget(
                  index: index,
                  onTap: () => onTap(index),
                  rippleAnimation: rippleAnimation,
                  width: pageIndex == index ? 52 : 47,
                  height: pageIndex == index ? 52 : 47,
                  showRipple: pageIndex == index,
                  onHideBorder: !isBorderVisible,
                  decoration: BoxDecoration(
                    color: pageIndex == index
                        ? AppColors.primary
                        : index == 0
                            ? Colors.black26
                            : context.colorScheme.onSurface,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    navbarIcons.values.toList()[index],
                    color: context.colorScheme.surface,
                    height: pageIndex == index ? 28 : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ).slideInFromBottom(delay: 3000.ms, animationDuration: 2500.ms, begin: 0.5),
    );
  }
}
