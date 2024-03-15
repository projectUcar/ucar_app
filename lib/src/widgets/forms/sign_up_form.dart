part of 'form_template.dart';

class SignUpForm extends FormTemplate<UserSignupState, SignUpCubit>{
  const SignUpForm({super.key, required super.formKey, required super.cubit}) : super(text: 'Registrar', successRoute: AppRouter.root);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends _FormTemplateState<SignUpForm> {

  late FocusNode nameFocusNode, phonenumberFocusNode, lastnameFocusNode, emailFocusNode, passwordFocusNode, passwordConfirmationFocusNode, genderFocusNode, careerFocusNode;

  @override
  void initState() {
    nameFocusNode = FocusNode();
    phonenumberFocusNode = FocusNode();
    lastnameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    passwordConfirmationFocusNode = FocusNode();
    genderFocusNode = FocusNode();
    careerFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    phonenumberFocusNode.dispose();
    lastnameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordConfirmationFocusNode.dispose();
    genderFocusNode.dispose();
    careerFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => widget.cubit,
      child: super.build(context),
    );
  }

  @override
  List<Widget> _buildChildren(BuildContext context) => <Widget>[
    //NOMBRES
    OrdinaryFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) => widget.cubit.updateName(s),
      validator: widget.cubit.state.nameValidator,
      currentValue: widget.cubit.state.getUserData.getName,
      focusNode: nameFocusNode,
      nextFocusNode: lastnameFocusNode,
      fieldType: FieldTypes.name,
    ),
    //APELLIDOS
    OrdinaryFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) => widget.cubit.updateLastname(s),
      validator: widget.cubit.state.lastnameValidator,
      currentValue: widget.cubit.state.getUserData.getLastname,
      focusNode: lastnameFocusNode,
      nextFocusNode: genderFocusNode,
      fieldType: FieldTypes.lastname,
    ),
    //GENERO
    SelectionFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) {
        widget.cubit.updateGender(s);
        careerFocusNode.requestFocus();
      },
      validator: widget.cubit.state.genderValidator,
      currentValue: widget.cubit.state.getUserData.getGender,
      focusNode: genderFocusNode,
      fieldType: FieldTypes.genders,
      selectionFieldType: SelectionFieldTypes.genders,
    ),
    //COLECTIVO
    SelectionFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) {
        widget.cubit.updateGroup(s);
        phonenumberFocusNode.requestFocus();
      },
      validator: widget.cubit.state.groupValidator,
      currentValue: widget.cubit.state.getUserData.getGroup,
      focusNode: careerFocusNode,
      fieldType: FieldTypes.groups,
      selectionFieldType: SelectionFieldTypes.groups,
    ),
    //TELEFONO
    OrdinaryFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) => widget.cubit.updatePhonenumber(s),
      validator: widget.cubit.state.phonenumberValidator,
      currentValue: widget.cubit.state.getUserData.getPhonenumber,
      focusNode: phonenumberFocusNode,
      nextFocusNode: emailFocusNode,
      fieldType: FieldTypes.phonenumber,
      maxLength: 10,
    ),
    //EMAIL
    OrdinaryFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) => widget.cubit.updateEmail(s),
      validator: widget.cubit.state.emailValidator,
      currentValue: widget.cubit.state.getUserData.getEmail,
      focusNode: emailFocusNode,
      nextFocusNode: passwordFocusNode,
      fieldType: FieldTypes.email,
    ),
    //CONTRASEÑA
    PasswordFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      focusNode: passwordFocusNode,
      nextFocusNode: passwordConfirmationFocusNode,
      onChanged: (s) => widget.cubit.updatePassword(s),
      currentValue: widget.cubit.state.getUserData.getPassword,
      fieldType: FieldTypes.password,
      validator: widget.cubit.state.passwordValidator,
    ),
    //CONFIRMACION DE CONTRASEÑA
    PasswordFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: passwordConfirmationFocusNode,
      nextFocusNode: super.buttonFocusNode,
      onChanged: (s) => widget.cubit.updatePasswordConfirmation(s),
      currentValue: widget.cubit.state.getUserData.getPasswordConfirmation,
      fieldType: FieldTypes.confirmation,
      validator: widget.cubit.state.passwordConfirmationValidator,
    ),
  ];
  
  @override
  Future<void> redirect() => Navigator.of(context).pushNamedAndRemoveUntil(widget.successRoute, (_) => false);
  
}