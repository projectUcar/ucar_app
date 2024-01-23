part of 'form_template.dart';

class SignUpForm extends FormTemplate<UserSignupViewModel>{
  const SignUpForm({super.key, required super.formKey, required super.onChanged, required super.viewModel, required}) : super(text: 'Registrar');

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends FormTemplateState<SignUpForm> {

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
  List<Widget> _buildChildren() => <Widget>[
    //NOMBRES
    OrdinaryFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) => 
        widget.onChanged(widget.viewModel.copyWith(name: s) as UserSignupViewModel),
      validator: widget.viewModel.nameValidator,
      currentValue: widget.viewModel.getUserData.getName,
      focusNode: nameFocusNode,
      nextFocusNode: lastnameFocusNode,
      fieldType: FieldTypes.name,
    ),
    //APELLIDOS
    OrdinaryFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) => 
        widget.onChanged(widget.viewModel.copyWith(lastname: s) as UserSignupViewModel),
      validator: widget.viewModel.lastnameValidator,
      currentValue: widget.viewModel.getUserData.getLastname,
      focusNode: lastnameFocusNode,
      nextFocusNode: genderFocusNode,
      fieldType: FieldTypes.lastname,
    ),
    //GENERO
    SelectionFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) {
        widget.onChanged(widget.viewModel.copyWith(gender: s) as UserSignupViewModel);
        careerFocusNode.requestFocus();
      },
      validator: widget.viewModel.genderValidator,
      currentValue: widget.viewModel.getUserData.getGender,
      focusNode: genderFocusNode,
      fieldType: FieldTypes.genders,
      selectionFieldType: SelectionFieldTypes.genders,
    ),
    //CARRERA
    SelectionFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) {
        widget.onChanged(widget.viewModel.copyWith(career: s) as UserSignupViewModel);
        phonenumberFocusNode.requestFocus();
      },
      validator: widget.viewModel.careerValidator,
      currentValue: widget.viewModel.getUserData.getCareer,
      focusNode: careerFocusNode,
      fieldType: FieldTypes.groups,
      selectionFieldType: SelectionFieldTypes.groups,
    ),
    //TELEFONO
    OrdinaryFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) => 
        widget.onChanged(widget.viewModel.copyWith(phonenumber: s) as UserSignupViewModel),
      validator: widget.viewModel.phonenumberValidator,
      currentValue: widget.viewModel.getUserData.getPhonenumber,
      focusNode: phonenumberFocusNode,
      nextFocusNode: emailFocusNode,
      fieldType: FieldTypes.phonenumber,
      maxLength: 10,
    ),
    //EMAIL
    OrdinaryFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      onChanged: (s) => 
        widget.onChanged(widget.viewModel.copyWith(email: s) as UserSignupViewModel),
      validator: widget.viewModel.emailValidator,
      currentValue: widget.viewModel.getUserData.getEmail,
      focusNode: emailFocusNode,
      nextFocusNode: passwordFocusNode,
      fieldType: FieldTypes.email,
    ),
    //CONTRASEÑA
    PasswordFormField(
      autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      focusNode: passwordFocusNode,
      nextFocusNode: passwordConfirmationFocusNode,
      onChanged: (s) => 
        widget.onChanged(widget.viewModel.copyWith(password: s) as UserSignupViewModel),
      currentValue: widget.viewModel.getUserData.getPassword,
      fieldType: FieldTypes.password,
      validator: widget.viewModel.passwordValidator,
    ),
    //CONFIRMACION DE CONTRASEÑA
    PasswordFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: passwordConfirmationFocusNode,
      nextFocusNode: super.buttonFocusNode,
      onChanged: (s) => 
        widget.onChanged(widget.viewModel.copyWith(passwordConfirmation: s) as UserSignupViewModel),
      currentValue: widget.viewModel.getUserData.getPasswordConfirmation,
      fieldType: FieldTypes.confirmation,
      validator: widget.viewModel.passwordConfirmationValidator,
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