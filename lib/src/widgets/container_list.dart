import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/custom_styles.dart';
import '../theme/fontsizes.dart';

class ListContainer extends StatelessWidget {
  final List<String> destinations;

  const ListContainer({super.key, required this.destinations});

  @override
  Widget build(BuildContext context) {
    if (destinations.length < 4) {
      return Row(
        children: [
          for (var item in destinations)
            Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.secondary,
              ),
              constraints: const BoxConstraints(maxWidth: 60),
              child: Text(
                item,
                style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.smallTextFontSize),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      );
    } else {
      return Row(
        children: [
          for (var i = 0; i < 3; i++)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.secondary,
              ),
              constraints: const BoxConstraints(maxWidth: 60),
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                destinations[i],
                style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.smallTextFontSize),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          Text("+${destinations.length - 3}",
              style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.smallTextFontSize)),
        ],
      );
    }
  }
}
