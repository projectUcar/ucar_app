import 'package:dio/dio.dart';

import '../../../helpers/authentication/base_helper.dart';
import 'form_validator_cubit.dart';
import '../states/user_signup_state.dart';

class SignUpCubit extends FormValidatorCubit<UserSignupState> {
  SignUpCubit():super(userState: UserSignupState.newUser());

  UserSignupState updateName(String? s) => update(state.copyWith(name: s) as UserSignupState);
  UserSignupState updatePhonenumber(String? s) => update(state.copyWith(phonenumber: s) as UserSignupState);
  UserSignupState updateLastname(String? s) => update(state.copyWith(lastname: s) as UserSignupState);
  UserSignupState updateEmail(String? s) => update(state.copyWith(email: s) as UserSignupState);
  UserSignupState updatePassword(String? s) => update(state.copyWith(password: s) as UserSignupState);
  UserSignupState updatePasswordConfirmation(String? s) => update(state.copyWith(passwordConfirmation: s) as UserSignupState);
  UserSignupState updateGroup(String? s) => update(state.copyWith(group: s) as UserSignupState);
  UserSignupState updateGender(String? s) => update(state.copyWith(gender: s) as UserSignupState);
  
  @override
  void reset() => emit(UserSignupState.newUser());
  
  @override
  Future<Response> submit(UserSignupState userState) {
    final helper = SignUpHelper();
    return helper.submit(state.getUserData);
  }
}