extension RegexComparison on String{
  static const String phonenumberRegExp = r"(3\d{9})|(60[1245678]\d{7})", //Corregida
  nameRegExp = r"^[A-ZÑÁÉÍÓÚ][a-zñáéíóúü]+(\s[A-ZÑÁÉÍÓÚ][a-zñáéíóúü]+){0,2}$", //Corregida
  lastnameRegExp = r"^[A-ZÑÁÉÍÓÚ][a-zñáéíóúü]+(\s[A-ZÑÁÉÍÓÚ][a-zñáéíóúü]+)?$", //Corregida
  emailRegExp = r"[a-z]+\.[a-z]+(\.[2][0]\d{2})?@upb\.edu\.co", //Corregida
  passwordRegExp = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])([A-Za-z\d$@$!%*?&]|[^ ]){8,15}$",
  modelRegExp = r"20\d{2}",
  plateRegExp = r"[A-Z]{3}[0-9]{3}",
  brandRegExp = r"^[A-ZÑÁÉÍÓÚ][a-zñáéíóúü]+(\s[A-ZÑÁÉÍÓÚ][a-zñáéíóúü]+){0,3}$",
  lineRegExp = r"^(\d|\w)+(\s(\d|\w)+){0,2}$",
  colorRegExp = r"^\w+$",
  nitRegExp = r"\d{8,13}-\d",
  ccOrTiRegExp = r"\d{8,13}",
  doorsRegExp = r"[1-8]",
  seatsRegExp = r"([1-5][0-9])|[1-9]";

  bool isValidField(String regExp) => RegExp(regExp).hasMatch(this);
  bool isWhitespace() => trim().isEmpty;
  static String? defaultValidator(String? s, String field, String regexp){
    if (s == null || s.isWhitespace()) {
      return 'Llena el campo obligatorio $field';
    }
    else if (!s.isValidField(regexp)) {
      return 'Campo $field inválido';
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