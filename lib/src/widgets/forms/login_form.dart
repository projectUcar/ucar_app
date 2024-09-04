part of 'form_template.dart';

class LogInForm extends FormTemplate<UserLoginState, LogInCubit> {
  const LogInForm({super.key, required super.formKey, required super.cubit}) : super(text: 'Entrar', successRoute: AppRouter.landing);

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends _FormTemplateState<LogInForm> {
  late FocusNode emailFocusNode, passwordFocusNode;

  @override
  void initState() {
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogInCubit>(
      create: (context) => widget.cubit,
      child: super.build(context),
    );
  }

  @override
  List<Widget> _buildChildren(BuildContext context) => <Widget>[
    //EMAIL O TELEFONO
    OrdinaryFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) => widget.cubit.updateEmailOrPhonenumber(s),
      validator: widget.cubit.state.emailValidator,
      currentValue: widget.cubit.state.getUserData.getEmailOrPhonenumber,
      focusNode: emailFocusNode,
      nextFocusNode: passwordFocusNode,
      fieldType: FieldTypes.email,
    ),
    //CONTRASEÑA
    PasswordFormField(
      autovalidateMode: (_submitted.value)? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      focusNode: passwordFocusNode,
      nextFocusNode: super.buttonFocusNode,
      onChanged: (s) => widget.cubit.updatePassword(s),
      currentValue: widget.cubit.state.getUserData.getPassword,
      fieldType: FieldTypes.loginPassword,
      validator: widget.cubit.state.passwordValidator,
    ),
    Container(
      alignment: Alignment.topRight,
      child: Text("¿Olvidaste tu contraseña?", style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize)),
    ),
  ];
  
  @override
  Future<void> redirect() async {
    final session = await AuthClient().session;
    if (session!.logged && session.refreshToken != null && context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, widget.successRoute, (_) => false, arguments: LandingPageArgs(name: session.name, isDriver: session.isDriver()));
      super.redirect();
    }
  }
}
