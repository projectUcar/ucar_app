import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/login_form.dart';
import '../models/vm/user_login_view_model.dart';
import '../screens/background.dart';
import '../theme/colors.dart';
import '../theme/custom_styles.dart';
import '../theme/fontsizes.dart';
import '../components/already_have_an_account.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final ValueNotifier<UserLoginViewModel> usNotifier = ValueNotifier(UserLoginViewModel.newUser());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.primary,
      body: Background(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/icons/bucaramanga-1.svg",
                height: 101,
              ),
              Text(
                "¡Bienvenido\nNuevamente!",
                style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.titleFontSize, fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
              Text("Inicia sesión con tu cuenta existente de UCAR",
                  style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize)),
              ValueListenableBuilder<UserLoginViewModel>(
                valueListenable: usNotifier,
                builder: (context, viewModel, _) => LogInForm(
                  formKey: formKey,
                  onChanged: (value) => viewModel = value,
                  viewModel: viewModel),
              ),
              AlreadyHaveAnAccountCheck(press: () {
                Navigator.pushNamed(context, "/sign-up");
              })
            ].map((child) => Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
            child: child,
          )).toList(),
          )
        ),
      )
    );
  }
}
