import 'package:ucar_app/src/models/templates/valid_input.dart';
import 'package:ucar_app/src/models/vm/user_view_model.dart';
import 'package:ucar_app/src/util/regex_comparison.dart';

import '../data/user_signup_data.dart';

class UserSignupViewModel extends UserViewModel<UserSignUpData> with ValidInput{
  const UserSignupViewModel(super.userData);

  factory UserSignupViewModel.newUser() {
    return UserSignupViewModel(UserSignUpData.newData());
  }

  bool get nameIsValid => nameValidator(userData.getName) == null;
  bool get phonenumberIsValid => phonenumberValidator(userData.getPhonenumber) == null;
  bool get lastnameIsValid => lastnameValidator(userData.getLastname) == null;
  bool get emailIsValid => emailValidator(userData.getEmail) == null;
  bool get passwordIsValid => passwordValidator(userData.getPassword) == null;
  bool get passwordConfirmIsValid => passwordConfirmationValidator(userData.getPasswordConfirmation) == null;
  bool get careerIsValid => careerValidator(userData.getCareer) == null;
  bool get genderIsValid => genderValidator(userData.getGender) == null;
  
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
    if (s != userData.getPassword) {
      return 'Different password';
    }
    return null;
  }

  @override
  copyWith(Enum field, String? s) {
    switch (field) {
      case SignUpEnum.career:
        userData.setCareer = s ?? '';
        break;
      case SignUpEnum.name:
        userData.setName = s ?? '';
        break;
      case SignUpEnum.phonenumber:
        userData.setPhonenumber = s ?? '';
        break;
      case SignUpEnum.lastname:
        userData.setLastname = s ?? '';
        break;
      case SignUpEnum.email:
        userData.setEmail = s ?? '';
        break;
      case SignUpEnum.password:
        userData.setPassword = s ?? '';
        break;
      case SignUpEnum.passwordConfirmation:
        userData.setPasswordConfirmation = s ?? '';
        break;
      case SignUpEnum.gender:
        userData.setGender = s ?? '';
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

enum SignUpEnum{career, name, phonenumber, lastname, email, password, passwordConfirmation, gender}