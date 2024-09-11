part of 'form_screen.dart';
class LogInScreen extends FormScreen<UserLoginState, LogInCubit> with WidgetListFormatter{
  LogInScreen({super.key}) : super(usNotifier: ValueNotifier(UserLoginState.newUser()));

  @override
  List<Widget> _buildChildren(BuildContext context) => formatList(<Widget>[
    SvgPicture.asset("assets/icons/ucar_logo.svg", height: SizeConfig.displayHeight(context) * 0.15),
    Text("¡Bienvenido\nNuevamente!",
      style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.titleFontSize, fontWeight: FontWeight.w900),
      textAlign: TextAlign.center,
    ),
    Text("Inicia sesión con tu cuenta existente de UCAR",
      style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize),
      textAlign: TextAlign.center,
    ),
    buildValueListenable(context),
    AlreadyHaveAnAccountCheck(press: () {
      Navigator.pushNamed(context, "/sign-up");
    })], 20);
    
  @override
  FormTemplate<UserLoginState, LogInCubit> _getForm(BuildContext context, UserLoginState userState) => LogInForm(
    formKey: formKey,
    cubit: LogInCubit(userState: userState),
  );

}
