import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/custom_styles.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final String text;

  const RoundedPasswordField({
    Key ? key,
    this.text = "Contraseña",
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
   bool _secureText = true;

  _RoundedPasswordFieldState();


  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _secureText,
        cursorColor: MyColors.textGrey,
        style: CustomStyles.greyStyle.copyWith(fontSize: 17),
        decoration:  InputDecoration(
          hintText: widget.text,
          hintStyle: CustomStyles.greyStyle,
          icon: const Icon(
            Icons.lock,
            color: MyColors.textGrey,
          ),
          suffixIcon: IconButton(            
            icon: Icon(
              _secureText ? Icons.visibility : Icons.visibility_off
              //Icons.visibility
            ),
            color: MyColors.textGrey,
            onPressed: (){
              setState(() {
                _secureText = !_secureText;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}