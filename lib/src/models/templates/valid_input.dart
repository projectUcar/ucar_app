import '../../util/regex_comparison.dart';

mixin ValidInput{
  
  String? nameValidator(String? s) => RegexComparison.defaultValidator(s, 'Nombre(s)', RegexComparison.nameRegExp);
  
  String? phonenumberValidator(String? s) => RegexComparison.defaultValidator(s, 'Teléfono', RegexComparison.phonenumberRegExp);
  
  String? lastnameValidator(String? s) => RegexComparison.defaultValidator(s, 'Apellido(s)', RegexComparison.lastnameRegExp);
  
  String? emailValidator(String? s) => RegexComparison.defaultValidator(s, 'Email', RegexComparison.emailRegExp);
  
  String? passwordValidator(String? s) => RegexComparison.defaultValidator(s, 'Contraseña', RegexComparison.passwordRegExp);

  String? genderValidator(String? s) => RegexComparison.selectionValidator(s, 'Género');
  
  String? careerValidator(String? s) => RegexComparison.selectionValidator(s, 'Carrera');
  
}