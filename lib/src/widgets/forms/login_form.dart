part of 'form_template.dart';
class LogInForm extends FormTemplate<UserLoginViewModel> {
  const LogInForm({super.key, required super.formKey, required super.onChanged, required super.viewModel}) : super(text: 'Entrar');

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends FormTemplateState<LogInForm> {
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
  List<Widget> _buildChildren() => <Widget>[
    //EMAIL O TELEFONO
    OrdinaryFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) => 
        widget.onChanged(widget.viewModel.copyWith(emailOrPhonenumber: s) as UserLoginViewModel),
      validator: widget.viewModel.emailValidator,
      currentValue: widget.viewModel.getUserData.getEmailOrPhonenumber,
      focusNode: emailFocusNode,
      nextFocusNode: passwordFocusNode,
      fieldType: FieldTypes.email,
    ),
    //CONTRASEÑA
    PasswordFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      focusNode: passwordFocusNode,
      nextFocusNode: super.buttonFocusNode,
      onChanged: (s) => 
        widget.onChanged(widget.viewModel.copyWith(password: s) as UserLoginViewModel),
      currentValue: widget.viewModel.getUserData.getPassword,
      fieldType: FieldTypes.loginPassword,
      validator: widget.viewModel.passwordValidator,
    ),
    Container(
      alignment: Alignment.topRight,
      child: Text("¿Olvidaste tu contraseña?",
        style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize)),
    ),
  ];
  
  @override
  VoidCallback get _onSubmit => () {
    _submitted.value = true;
    if (widget.formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  };
}
