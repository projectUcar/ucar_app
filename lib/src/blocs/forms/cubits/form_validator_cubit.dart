// ignore_for_file: duplicate_import

library form_validator_cubit;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../states/user_state.dart';
import '../states/user_signup_state.dart';
import '../states/user_login_state.dart';
import '../../../util/fail_to_message.dart';
import '../../../util/bad_response_model.dart';
import '../../../helpers/authentication/base_helper.dart';

part 'login_cubit.dart';
part 'signup_cubit.dart';
abstract class FormValidatorCubit<T extends UserState> extends Cubit<T> {
  FormValidatorCubit({required T userState}) : super(userState);

  void initForm() => emit(state);
  void reset();
  Future<void> submit();

  void updateSubmitted(bool? s) => emit(state.copyWith(submitted: s) as T);
  void _updateResultState(ResultState? s) => emit(state.copyWith(newRS: s) as T);
}
