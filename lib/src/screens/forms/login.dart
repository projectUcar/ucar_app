part of 'form_screen.dart';
class LogInScreen extends FormScreen<UserLoginViewModel> {
  LogInScreen({super.key});

  @override
  ValueNotifier<UserLoginViewModel> _usNotifier() => ValueNotifier(UserLoginViewModel.newUser());

  @override
  List<Widget> _buildChildren(BuildContext context) => <Widget>[
    SvgPicture.asset("assets/icons/bucaramanga-1.svg",height: 101,),
      Text("¡Bienvenido\nNuevamente!",
        style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.titleFontSize, fontWeight: FontWeight.w900),
        textAlign: TextAlign.center,
      ),
      Text("Inicia sesión con tu cuenta existente de UCAR",
        style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize)
      ),
      buildValueListenable(),
      AlreadyHaveAnAccountCheck(press: () {
        Navigator.pushNamed(context, "/sign-up");
      })
    ].map((child) => Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.displayHeight(context) * 0.015),
      child: child,
    )).toList();

  @override
  FormTemplate<UserLoginViewModel> _getForm(BuildContext context, UserLoginViewModel viewModel) => LogInForm(
    formKey: formKey,
    onChanged: (value) => viewModel = value,
    viewModel: viewModel
  );

}
