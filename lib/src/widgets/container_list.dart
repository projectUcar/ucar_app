import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/custom_styles.dart';
import '../theme/fontsizes.dart';

class ListContainer extends StatelessWidget {
  final List<String> destinations;

  const ListContainer({Key? key, required this.destinations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (destinations.length < 4) {
      return Row(
        children: [
          for (var item in destinations)
            Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                item,
                style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.smallTextFontSize),
                overflow: TextOverflow.ellipsis,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.secondary,
              ),
              constraints: const BoxConstraints(maxWidth: 60),
            ),
        ],
      );
    } else {
      return Row(
        children: [
          for (var i = 0; i < 3; i++)
            Container(
              child: Text(
                destinations[i],
                style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.smallTextFontSize),
                overflow: TextOverflow.ellipsis,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.secondary,
              ),
              constraints: const BoxConstraints(maxWidth: 60),
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.only(left: 8, right: 8),
            ),
          Text("+" + (destinations.length - 3).toString(),
              style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.smallTextFontSize)),
        ],
      );
    }
  }
}
