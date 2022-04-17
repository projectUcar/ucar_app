import 'package:flutter/material.dart';
import 'package:ucar_app/src/theme/colors.dart';
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
        cursorColor: textGray,
        style: const TextStyle(color: textGray, fontSize: 17),
        decoration:  InputDecoration(
          hintText: widget.text,
          hintStyle: const TextStyle(color: textGray,),
          icon: const Icon(
            Icons.lock,
            color: textGray,
          ),
          suffixIcon: IconButton(            
            icon: Icon(
              _secureText ? Icons.visibility : Icons.visibility_off
              //Icons.visibility
            ),
            color: textGray,
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