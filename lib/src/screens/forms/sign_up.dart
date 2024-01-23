part of 'form_screen.dart';
class SignUpScreen extends FormScreen<UserSignupViewModel> {
  SignUpScreen({super.key}):super(withAppBar: true);

  @override
  ValueNotifier<UserSignupViewModel> _usNotifier() => ValueNotifier(UserSignupViewModel.newUser());

  @override
  List<Widget> _buildChildren(BuildContext context) => <Widget>[
    buildValueListenable(),
    AlreadyHaveAnAccountCheck(
      login: false,
      press: () => Navigator.pop(context),
    ),
  ];

  @override
  FormTemplate<UserSignupViewModel> _getForm(BuildContext context, UserSignupViewModel viewModel) => SignUpForm(
    formKey: formKey,
    onChanged: (value) => viewModel = value,
    viewModel: viewModel
  );
}
