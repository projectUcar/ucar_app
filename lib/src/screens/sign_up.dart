import 'package:flutter/material.dart';

import '../components/app_bar_custom.dart';
import '../components/sign_up_form.dart';
import '../models/vm/user_signup_view_model.dart';
import 'background.dart';
import '../components/already_have_an_account.dart';
import '../theme/colors.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final ValueNotifier<UserSignupViewModel> usNotifier = ValueNotifier(UserSignupViewModel.newUser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: const PreferredSize(
        child: AppBarCustom(
          color: MyColors.backgroundSvg,
          text: "",
        ),
        preferredSize: Size.fromHeight(50),
      ),
      body: Background(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ValueListenableBuilder<UserSignupViewModel>(
                valueListenable: usNotifier,
                builder: (context, viewModel, _) => SignUpForm(
                  formKey: formKey,
                  onChanged: (value) => viewModel = value,
                  viewModel: viewModel),
              ),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
