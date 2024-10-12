import 'package:flutter/material.dart';

import '../../../app.dart';

class ApartmentGallery extends StatelessWidget {
  const ApartmentGallery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sizeWidth(1),
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
           PhotoItem(
            text: 'Gladkova St., 25',
            imgHeight: context.sizeHeight(0.23),
          ),
          SizedBox(
            height: context.sizeHeight(0.4),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: PhotoItem(
                      imgPath: ImagePaths.apartment4,
                      imgHeight: context.sizeHeight(0.4),
                      milliseconds: 3700,
                      text: 'Malaga St., 92',
                      sliderWidth: 0.4,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(2,
                            (index) => Flexible(
                              child: PhotoItem(
                                imgPath: index == 0 ? ImagePaths.apartment3 : ImagePaths.apartment2,
                                imgHeight: context.sizeHeight(0.2),  // Adjust height
                                milliseconds: 4000,
                                text: index == 0 ? 'Margaret., 32' : 'Trefeleva., 43',
                                sliderWidth: 0.4,
                              ),
                            ),
                      ).columnInPadding(5),
                    ),
                  ),
                ].rowInPadding(5)),
          ).padSymmetric(vertical: 5),
        ],
      ),
    );
  }
}
