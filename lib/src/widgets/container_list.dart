import 'package:flutter/material.dart';

import '../config/size_config.dart';
import '../theme/themes.dart';

class ListContainer extends StatelessWidget {
  final List<String> destinations;

  const ListContainer({super.key, required this.destinations});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.displayWidth(context) * 0.5,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (String item in destinations)
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
        ),
      ),
    );
  }
}
