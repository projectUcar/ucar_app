import 'package:flutter/material.dart';

import '../theme/themes.dart';
import 'text_field_container.dart';

class CustomDropDownButton extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final double sizeFinal;
  final List<String> list;

  const CustomDropDownButton({
    super.key,
    required this.hintText,
    this.sizeFinal = 0.90,
    required this.icon,
    required this.list,
  });

  @override
  State<CustomDropDownButton> createState() => CustomDropDownButtonState();
}

class CustomDropDownButtonState extends State<CustomDropDownButton> {
  CustomDropDownButtonState();

  String? _selected;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        sizeFinal: widget.sizeFinal,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(widget.hintText,
                style: CustomStyles.greyStyle.copyWith(fontSize: 17)),
            isExpanded: true,
            dropdownColor: MyColors.secondary,
            icon: const Icon(
              Icons.arrow_drop_down_rounded,
              color: MyColors.textGrey,
              size: 35,
            ),
            elevation: 16,
            style: CustomStyles.greyStyle.copyWith(fontSize: 17),
            value: _selected,
            onChanged: (String? value) => setState(() {
              _selected = value;
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
