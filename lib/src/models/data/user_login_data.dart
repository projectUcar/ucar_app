import 'package:ucar_app/src/models/data/user_data.dart';

class UserLogInData extends UserData{
  String? _emailOrPhonenumber, _password;
  UserLogInData({String? email, String? password})
  : _emailOrPhonenumber = email,
    _password = password;
  
  factory UserLogInData.newData() => UserLogInData(
    email: null,
    password: null
  );

  String? get getEmailOrPhonenumber => _emailOrPhonenumber;
  String? get getPassword => _password;

  set setEmailOrPhonenumber(String value) => _emailOrPhonenumber = value;
  set setPassword(String value) => _password = value;

  @override
  String toString() => "($_emailOrPhonenumber, ${super.formatPassword(_password)})";
}