import 'package:flutter/material.dart';
import 'package:ucar_app/src/theme/colors.dart';

import 'text_field_container.dart';

class DropDownButtonCustom extends StatefulWidget {
  String hintText;
  final IconData icon;
  final List<String> list;

  DropDownButtonCustom({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.list,
  }) : super(key: key);

  @override
  State<DropDownButtonCustom> createState() => DropDownButtonCustomState(
      hintText: hintText, icon: icon, list: list);
}

class DropDownButtonCustomState extends State<DropDownButtonCustom> {
  String hintText;
  final IconData icon;
  final List<String> list;

  DropDownButtonCustomState(
      {required this.hintText, required this.icon, required this.list});

  String? _selected;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: Text(hintText, style: const TextStyle(color: textGray, fontSize: 17)),
        isExpanded: true,
        dropdownColor: secondary,
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
          color: textGray,
          size: 35,
        ),
        elevation: 16,
        style: const TextStyle(color: textGray, fontSize: 17),
        value: _selected,
        onChanged: (String? value) => setState(() {
          _selected = value ;
        }),
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ));
  }
}
