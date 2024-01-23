import '../data/user_login_data.dart';
import '../templates/valid_input.dart';
import 'user_view_model.dart';

class UserLoginViewModel extends UserViewModel<UserLogInData> with ValidInput{
  const UserLoginViewModel(super.userData);

  factory UserLoginViewModel.newUser() {
    return UserLoginViewModel(UserLogInData.newData());
  }

  bool get emailOrPhonenumberIsValid => emailValidator(getUserData.getEmailOrPhonenumber) == null || phonenumberValidator(getUserData.getEmailOrPhonenumber) == null;
  bool get passwordIsValid => passwordValidator(getUserData.getPassword) == null;

  @override
  bool isValid() => emailOrPhonenumberIsValid && passwordIsValid;

  @override
  copyWith({String? emailOrPhonenumber, String? password}) {
    return UserLoginViewModel(
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