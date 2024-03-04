part of 'form_screen.dart';
class LogInScreen extends FormScreen<UserLoginState, LogInCubit> with WidgetListFormatter{
  LogInScreen({super.key}) : super(usNotifier: ValueNotifier(UserLoginState.newUser()));

  @override
  List<Widget> _buildChildren(BuildContext context) => formatList(<Widget>[
    SvgPicture.asset("assets/icons/bucaramanga-1.svg",height: 101,),
    Text("¡Bienvenido\nNuevamente!",
      style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.titleFontSize, fontWeight: FontWeight.w900),
      textAlign: TextAlign.center,
    ),
    Text("Inicia sesión con tu cuenta existente de UCAR",
      style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize)
    ),
    buildValueListenable(context),
    AlreadyHaveAnAccountCheck(press: () {
      Navigator.pushNamed(context, "/sign-up");
    })], SizeConfig.displayHeight(context) * 0.03);
  // .map((child) => Padding(
  //   padding: EdgeInsets.symmetric(vertical: SizeConfig.displayHeight(context) * 0.015),
  //   child: child,
  // )).toList();
    
  @override
  FormTemplate<UserLoginState, LogInCubit> _getForm(BuildContext context, UserLoginState userState) => LogInForm(
    formKey: formKey,
    onChanged: (value) => userState = value,
    cubit: LogInCubit(userState: userState),
  );

}
