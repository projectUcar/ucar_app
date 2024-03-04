import '../templates/valid_input.dart';
import 'user_state.dart';
import '../../../util/regex_comparison.dart';
import '../data/user_signup_data.dart';

class UserSignupState extends UserState<UserSignUpData> with ValidInput<UserSignUpData>{
  UserSignupState(super.userData, {required super.resultState, required super.submitted});

  factory UserSignupState.newUser() {
    return UserSignupState(UserSignUpData.newData(), resultState: ResultState.missing(), submitted: false);
  }

  bool get nameIsValid => nameValidator(getUserData.getName) == null;
  bool get phonenumberIsValid => phonenumberValidator(getUserData.getPhonenumber) == null;
  bool get lastnameIsValid => lastnameValidator(getUserData.getLastname) == null;
  bool get emailIsValid => emailValidator(getUserData.getEmail) == null;
  bool get passwordIsValid => passwordValidator(getUserData.getPassword) == null;
  bool get passwordConfirmIsValid => passwordConfirmationValidator(getUserData.getPasswordConfirmation) == null;
  bool get groupIsValid => groupValidator(getUserData.getGroup) == null;
  bool get genderIsValid => genderValidator(getUserData.getGender) == null;
  
  @override
  bool isValid() =>
  nameIsValid && phonenumberIsValid &&
  lastnameIsValid &&
  emailIsValid &&
  passwordIsValid &&
  passwordConfirmIsValid &&
  groupIsValid &&
  genderIsValid;
  
  String? passwordConfirmationValidator(String? s){
    if (s == null || s.isWhitespace()) {
      return 'Campo Confirmación requerido';
    }
    if (s != getUserData.getPassword) {
      return 'Contraseña diferente';
    }
    return null;
  }

  @override
  UserSignupState copyWith({ResultState? newRS, bool? submitted, String? name, String? phonenumber, String? lastname, String? email, String? password, String? passwordConfirmation, String? gender, String? group}) {
    return UserSignupState(
      resultState: newRS ?? getResultState,
      UserSignUpData(
        name: name ?? getUserData.getName,
        phonenumber: phonenumber ?? getUserData.getPhonenumber,
        lastname: lastname ?? getUserData.getLastname,
        email: email ?? getUserData.getEmail,
        password: password ?? getUserData.getPassword,
        passwordConfirmation: passwordConfirmation ?? getUserData.getPasswordConfirmation,
        gender: gender ?? getUserData.getGender,
        group: group ?? getUserData.getGroup
      ),
      submitted: submitted ?? getSubmitted
    );
  }

  
}