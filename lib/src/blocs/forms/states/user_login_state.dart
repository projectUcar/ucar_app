import '../data/user_login_data.dart';
import '../templates/valid_input.dart';
import 'user_state.dart';

class UserLoginState extends UserState<UserLogInData> with ValidInput<UserLogInData>{
  const UserLoginState(super.userData);

  factory UserLoginState.newUser() {
    return UserLoginState(UserLogInData.newData());
  }

  bool get emailOrPhonenumberIsValid => emailValidator(getUserData.getEmailOrPhonenumber) == null || phonenumberValidator(getUserData.getEmailOrPhonenumber) == null;
  bool get passwordIsValid => passwordValidator(getUserData.getPassword) == null;

  @override
  bool isValid() => emailOrPhonenumberIsValid && passwordIsValid;

  @override
  copyWith({String? emailOrPhonenumber, String? password}) {
    return UserLoginState(
      UserLogInData(
        emailOrPhonenumber: emailOrPhonenumber ?? getUserData.getEmailOrPhonenumber,
        password: password ?? getUserData.getPassword
      )
    );
  }

  @override
  String toString() {
    return 'userData: ${getUserData.toString()}';
  }
  
}