import 'user_state.dart';
import '../templates/valid_input.dart';
import '../data/user_login_data.dart';

class UserLoginState extends UserState<UserLogInData> with ValidInput<UserLogInData>{
  UserLoginState(super.userData, {required super.resultState, required super.submitted});

  factory UserLoginState.newUser() {
    return UserLoginState(UserLogInData.newData(), resultState: ResultState.missing(), submitted: false);
  }

  bool get emailOrPhonenumberIsValid => emailValidator(getUserData.getEmailOrPhonenumber) == null || phonenumberValidator(getUserData.getEmailOrPhonenumber) == null;
  bool get passwordIsValid => passwordValidator(getUserData.getPassword) == null;

  @override
  bool isValid() => emailOrPhonenumberIsValid && passwordIsValid;

  @override
  UserLoginState copyWith({ResultState? newRS, bool? submitted, String? emailOrPhonenumber, String? password}) {
    return UserLoginState(
      resultState: newRS ?? getResultState,
      UserLogInData(
        emailOrPhonenumber: emailOrPhonenumber ?? getUserData.getEmailOrPhonenumber,
        password: password ?? getUserData.getPassword
      ),
      submitted: submitted ?? getSubmitted
    );
  }
  
}