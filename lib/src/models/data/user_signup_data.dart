import 'user_data.dart';

class UserSignUpData extends UserData{
  String? _name, _phonenumber, _lastname, _email, _password, _passwordConfirmation, _gender, _career;
  UserSignUpData({String? name, String? phonenumber, String? lastname, String? email, String? password, String? passwordConfirmation, String? gender, String? career})
  : _name = name,
    _phonenumber = phonenumber,
    _lastname = lastname,
    _email = email,
    _password = password,
    _passwordConfirmation = passwordConfirmation,
    _gender = gender,
    _career = career;
  
  factory UserSignUpData.newData() => UserSignUpData(
    name: null,
    phonenumber: null,
    lastname: null,
    email: null,
    password: null,
    passwordConfirmation: null,
    gender: null,
    career: null
  );

  String? get getName => _name;
  String? get getPhonenumber => _phonenumber;
  String? get getLastname => _lastname;
  String? get getEmail => _email;
  String? get getPassword => _password;
  String? get getPasswordConfirmation => _passwordConfirmation;
  String? get getGender => _gender;
  String? get getCareer => _career;

  @override
  String toString() => "($_career, $_name, $_phonenumber, $_lastname, $_email, ${super.formatPassword(_password)}, ${super.formatPassword(_passwordConfirmation)}, $_gender)";
}