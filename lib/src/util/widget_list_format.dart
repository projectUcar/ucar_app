import 'package:flutter/widgets.dart';

mixin WidgetListFormatter{
  List<Widget> formatList(List<Widget> list, double height){
    for (int i = list.length - 1; i > 0; i--) {
      list.insert(i, SizedBox(height: height,));
    }
    return list;
  }
}