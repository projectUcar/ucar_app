import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ucar_app/src/components/rounded_password_field.dart';
import 'package:ucar_app/src/screens/background.dart';
import 'package:ucar_app/src/screens/passenger/pass_home.dart';
import 'package:ucar_app/src/theme/colors.dart';
import 'package:ucar_app/src/theme/fontsizes.dart';

import '../components/already_have_an_account.dart';
import '../components/rounded_button.dart';
import '../components/rounded_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _textNameUser = TextEditingController(text: "");

    return  Scaffold(
      backgroundColor: primary,
      body: Background(
      child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              SvgPicture.asset(
              "assets/icons/bucaramanga-1.svg",
              //color: backgroundSvg,
              height: 101,
            ),          
            SizedBox(height: size.height * 0.03),
              const Text("¡Bienvenido\nNuevamente!",
              style: TextStyle(
                color: textWhite, 
                fontSize: titleFontSize, 
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            
            const Text(
              "Inicia sesión con tu cuenta existente de UCAR", 
              style: TextStyle(
                color: textWhite,
                fontSize: bodyTextFontSize
              ),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Email o Teléfono",
              onChanged: (value) {}, 
              icon: Icons.person,
            ),
            const RoundedPasswordField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 13,),
                  child: const Text(
                    "¿Olvidaste tu contraseña?",
                    style: TextStyle(
                      color: textOrange,
                      fontSize: bodyTextFontSize
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: size.height * 0.04),
            RoundedButton(
              text: "INICIAR SESIÓN",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePassenger(name: "Andrey")));
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.pushNamed(
                  context, "/sing-up"
                );
              }
            )
          ],
        )
      ),
      )
    );
  }
}
