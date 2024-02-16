import 'package:dio/dio.dart';
import '../../../helpers/authentication/base_helper.dart';

import 'form_validator_cubit.dart';
import '../states/user_login_state.dart';

class LogInCubit extends FormValidatorCubit<UserLoginState> {
  LogInCubit() : super(userState: UserLoginState.newUser());

  UserLoginState updateEmailOrPhonenumber(String? s) => update(state.copyWith(emailOrPhonenumber: s) as UserLoginState);
  UserLoginState updatePassword(String? s) => update(state.copyWith(password: s) as UserLoginState);

  @override
  void reset() => emit(UserLoginState.newUser());

  @override
  Future<Response> submit(UserLoginState userState) {
    final helper = LogInHelper();
    return helper.submit(state.getUserData);
  }
  
}
