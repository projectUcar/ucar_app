import 'package:ucar_app/src/models/templates/valid_input.dart';
import 'package:ucar_app/src/models/vm/user_view_model.dart';
import 'package:ucar_app/src/util/regex_comparison.dart';

import '../data/user_signup_data.dart';

class UserSignupViewModel extends UserViewModel<UserSignUpData> with ValidInput{
  const UserSignupViewModel(super.userData);

  factory UserSignupViewModel.newUser() {
    return UserSignupViewModel(UserSignUpData.newData());
  }

  bool get nameIsValid => nameValidator(getUserData.getName) == null;
  bool get phonenumberIsValid => phonenumberValidator(getUserData.getPhonenumber) == null;
  bool get lastnameIsValid => lastnameValidator(getUserData.getLastname) == null;
  bool get emailIsValid => emailValidator(getUserData.getEmail) == null;
  bool get passwordIsValid => passwordValidator(getUserData.getPassword) == null;
  bool get passwordConfirmIsValid => passwordConfirmationValidator(getUserData.getPasswordConfirmation) == null;
  bool get careerIsValid => careerValidator(getUserData.getCareer) == null;
  bool get genderIsValid => genderValidator(getUserData.getGender) == null;
  
  @override
  bool isValid() =>
  nameIsValid && phonenumberIsValid &&
  lastnameIsValid &&
  emailIsValid &&
  passwordIsValid &&
  passwordConfirmIsValid &&
  careerIsValid &&
  genderIsValid;
  
  String? passwordConfirmationValidator(String? s){
    if (s == null || s.isWhitespace()) {
      return 'Campo Confirmación requerido';
    }
    if (s != getUserData.getPassword) {
      return 'Different password';
    }
    return null;
  }

  @override
  copyWith({String? name, String? phonenumber, String? lastname, String? email, String? password, String? passwordConfirmation, String? gender, String? career}) {
    return UserSignupViewModel(
      UserSignUpData(
        name: name ?? getUserData.getName,
        phonenumber: phonenumber ?? getUserData.getPhonenumber,
        lastname: lastname ?? getUserData.getLastname,
        email: email ?? getUserData.getEmail,
        password: password ?? getUserData.getPassword,
        passwordConfirmation: passwordConfirmation ?? getUserData.getPasswordConfirmation,
        gender: gender ?? getUserData.getGender,
        career: career ?? getUserData.getCareer
      )
    );
  }

  @override
  String toString() {
    return 'userData: ${getUserData.toString()}';
  }
  
}