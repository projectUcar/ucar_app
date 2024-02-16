import 'package:dio/dio.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../states/user_state.dart';

abstract class FormValidatorCubit<T extends UserState> extends Cubit<T> {
  FormValidatorCubit({required T userState}) : super(userState);

  void initForm() => emit(state);
  void reset();
  Future<Response> submit(T userState);
  
  T update(T current) {
    emit(current);
    return current;
  }
}
