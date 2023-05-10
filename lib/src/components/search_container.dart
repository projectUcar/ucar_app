import 'package:flutter/material.dart';
import 'package:ucar_app/src/theme/colors.dart';

class SearchFieldContainer extends StatelessWidget {
  final Widget child;

  const SearchFieldContainer({ 
    Key? key, 
    required this.child 
    }) : super(key: key);

  @override
   Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.80,
      height: 42,
      decoration: BoxDecoration(
        color: textGray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}