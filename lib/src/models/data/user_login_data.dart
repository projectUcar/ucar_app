import 'package:ucar_app/src/models/data/user_data.dart';

class UserLogInData extends UserData{
  String? _emailOrPhonenumber, _password;
  UserLogInData({String? emailOrPhonenumber, String? password})
  : _emailOrPhonenumber = emailOrPhonenumber,
    _password = password;
  
  factory UserLogInData.newData() => UserLogInData(
    emailOrPhonenumber: null,
    password: null
  );

  String? get getEmailOrPhonenumber => _emailOrPhonenumber;
  String? get getPassword => _password;

  @override
  String toString() => "($_emailOrPhonenumber, ${super.formatPassword(_password)})";
}