import 'user_data.dart';

class UserLogInData extends UserData{
  final String? _emailOrPhonenumber, _password;
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
  
  @override
  Map<String, String> toJson() => {
    'email': getEmailOrPhonenumber!,
    'password': getPassword!
  };
}