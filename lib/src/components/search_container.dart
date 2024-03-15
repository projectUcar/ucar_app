import 'package:flutter/material.dart';
import 'package:ucar_app/src/config/size_config.dart';
import '../theme/colors.dart';

class SearchFieldContainer extends StatelessWidget {
  final Widget child;

  const SearchFieldContainer({ 
    super.key, 
    required this.child 
    });

  @override
   Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: SizeConfig.displayWidth(context) * 0.80,
      height: 42,
      decoration: BoxDecoration(
        color: MyColors.textGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}