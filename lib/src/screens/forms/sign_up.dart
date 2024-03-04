part of 'form_screen.dart';
class SignUpScreen extends FormScreen<UserSignupState, SignUpCubit> {
  SignUpScreen({super.key}):super(withAppBar: true, usNotifier: ValueNotifier(UserSignupState.newUser()));

  @override
  List<Widget> _buildChildren(BuildContext context) => <Widget>[
    buildValueListenable(context),
    AlreadyHaveAnAccountCheck(
      login: false,
      press: () => Navigator.pop(context),
    ),
  ];

  @override
  FormTemplate<UserSignupState, SignUpCubit> _getForm(BuildContext context, UserSignupState userState) => SignUpForm(
    formKey: formKey,
    onChanged: (value) => userState = value,
    cubit: SignUpCubit(userState: userState)
  );
}
