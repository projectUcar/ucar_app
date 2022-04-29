import 'package:flutter/material.dart';
import 'package:ucar_app/src/theme/colors.dart';

import 'text_field_container.dart';

class DropDownButtonCustom extends StatefulWidget {
  String hintText;
  final IconData icon;
  final double sizeFinal;
  final List<String> list;

  DropDownButtonCustom({
    Key? key,
    required this.hintText,
    this.sizeFinal = 0.90,
    required this.icon,
    required this.list,
  }) : super(key: key);

  @override
  State<DropDownButtonCustom> createState() => DropDownButtonCustomState();
}

class DropDownButtonCustomState extends State<DropDownButtonCustom> {

  DropDownButtonCustomState();

  String? _selected;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      sizeFinal: widget.sizeFinal,
        child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: Text(widget.hintText, style: const TextStyle(color: textGray, fontSize: 17)),
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
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ));
  }
}
