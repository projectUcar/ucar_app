library form_validator_cubit;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../helpers/helpers.dart';
import '../../../models/auth_response.dart';
import '../../../storage/auth_client.dart';
import '../../../util/bad_response_model.dart';
import '../../../util/fail_to_message.dart';
import '../states/user_login_state.dart';
import '../states/user_signup_state.dart';
import '../states/user_state.dart';

part 'login_cubit.dart';
part 'signup_cubit.dart';
abstract class FormValidatorCubit<T extends UserState, M extends BaseHelper> extends Cubit<T> {
  FormValidatorCubit({required T userState, required this.helper}) : super(userState);

  final M helper;
  final AuthClient authClient = AuthClient();

  void initForm() => emit(state);
  void reset();
  Future<void> submit();
  bool get rebuildCondition;

  void _updateResultState(ResultState? s) => emit(state.copyWith(newRS: s) as T);
}
