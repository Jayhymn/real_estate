import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:real_estate/app.dart';
import 'package:real_estate/presentation/widgets/home/num_label_column.dart';

class HomeBottomSection extends StatelessWidget {
  const HomeBottomSection({
    super.key,
    required this.numValue1,
    required this.numValue2,
    required this.hideCircleRow,
  });

  final int numValue1;
  final int numValue2;
  final bool hideCircleRow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopRow(context),
        _buildBottomSection(),
      ].columnInPadding(15),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBuyColumn(context),
        _buildRentColumn(context),
      ],
    );
  }

  Widget _buildBuyColumn(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 15, bottom: 10),
        decoration: BoxDecoration(
          color: context.colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: NumLabelColumn(
          title: 'BUY',
          isCircle: true,
          numValue: numValue1,
        ),
      ).scale(
        delay: 1800.ms,
        animationDuration: 1000.ms,
      ),
    );
  }

  Widget _buildRentColumn(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(right: 15, top: 15, bottom: 10),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: NumLabelColumn(
          title: 'RENT',
          numValue: numValue2,
        ),
      ).scale(
        delay: 1800.ms,
        animationDuration: 1000.ms,
      ),
    );
  }

  Widget _buildBottomSection() {
    return Offstage(
      offstage: !hideCircleRow,
      child: const ApartmentGallery().slideInFromBottom(
        delay: 2700.ms,
        animationDuration: 1200.ms,
        begin: 1,
      ),
    );
  }
}
