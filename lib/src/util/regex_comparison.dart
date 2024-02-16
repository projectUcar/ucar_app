extension RegexComparison on String{
  static const String phonenumberRegExp = r"(3\d{9})|(60[1245678]\d{7})", //Corregida
  nameRegExp = r"^[A-ZÑÁÉÍÓÚ][a-zñáéíóúü]{1,}(\s[A-ZÑÁÉÍÓÚ][a-zñáéíóúü]{1,}){0,2}$", //Corregida
  lastnameRegExp = r"^[A-ZÑÁÉÍÓÚ][a-zñáéíóúü]{1,}(\s[A-ZÑÁÉÍÓÚ][a-zñáéíóúü]{1,})?$", //Corregida
  emailRegExp = r"[a-z]+\.[a-z]+(\.[2][0]\d{2})?@upb\.edu\.co", //Corregida
  passwordRegExp = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])([A-Za-z\d$@$!%*?&]|[^ ]){8,15}$";

  bool isValidField(String regExp) => RegExp(regExp).hasMatch(this);
  bool isWhitespace() => trim().isEmpty;
  static String? defaultValidator(String? s, String field, String regexp){
    if (s == null || s.isWhitespace()) {
      return 'Llena el campo obligatorio $field';
    }
    else if (!s.isValidField(regexp)) {
      return '$field inválido';
    }
    return null;
  }

  static String? selectionValidator(String? s, String field){
    if (s == null || s.isWhitespace()) {
      return 'Llena el campo obligatorio $field';
    }
    return null;
  }

}