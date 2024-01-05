import '../data/user_login_data.dart';
import '../templates/valid_input.dart';
import 'user_view_model.dart';

class UserLoginViewModel extends UserViewModel<UserLogInData> with ValidInput{
  const UserLoginViewModel(super.userData);

  factory UserLoginViewModel.newUser() {
    return UserLoginViewModel(UserLogInData.newData());
  }

  bool get emailOrPhonenumberIsValid => emailValidator(userData.getEmailOrPhonenumber) == null || phonenumberValidator(userData.getEmailOrPhonenumber) == null;
  bool get passwordIsValid => passwordValidator(userData.getPassword) == null;

  @override
  bool isValid() => emailOrPhonenumberIsValid && passwordIsValid;

  @override
  copyWith(Enum field, String? s) {
    switch (field) {
      case LogInEnum.emailOrPhonenumber:
        userData.setEmailOrPhonenumber = s ?? '';
        break;
      case LogInEnum.password:
        userData.setPassword = s ?? '';
        break;
      default:
        break;
    }
    return this;
  }

  @override
  String toString() {
    return 'userData: ${userData.toString()}';
  }
  
}

enum LogInEnum {emailOrPhonenumber, password}