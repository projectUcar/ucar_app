import 'user_data.dart';

class UserSignUpData extends UserData{
  final String? _name, _phonenumber, _lastname, _email, _password, _passwordConfirmation, _gender, _group;
  UserSignUpData({String? name, String? phonenumber, String? lastname, String? email, String? password, String? passwordConfirmation, String? gender, String? group})
  : _name = name,
    _phonenumber = phonenumber,
    _lastname = lastname,
    _email = email,
    _password = password,
    _passwordConfirmation = passwordConfirmation,
    _gender = gender,
    _group = group;
  
  factory UserSignUpData.newData() => UserSignUpData(
    name: null,
    phonenumber: null,
    lastname: null,
    email: null,
    password: null,
    passwordConfirmation: null,
    gender: null,
    group: null
  );

  String? get getName => _name;
  String? get getPhonenumber => _phonenumber;
  String? get getLastname => _lastname;
  String? get getEmail => _email;
  String? get getPassword => _password;
  String? get getPasswordConfirmation => _passwordConfirmation;
  String? get getGender => _gender;
  String? get getGroup => _group;

  @override
  String toString() => "($_name, $_lastname, $_email, $_group, $_phonenumber, $_gender, ${super.formatPassword(_password)}, ${super.formatPassword(_passwordConfirmation)})";
  
  @override
  Map<String, String> toJson() => {
    "firstName": getName!,
    "lastName": getLastname!,
    "email": getEmail!,
    "carrer": getGroup!,
    "phoneNumber": getPhonenumber!,
    "gender": getGender!,
    "password": getPassword!,
    "confirmPassword": getPasswordConfirmation!,
  }; //El método solo se ejecutará cuando el formulario esté correcto. Por tanto, no habrá datos nulos en este punto
}