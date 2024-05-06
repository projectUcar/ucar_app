part of 'form_validator_cubit.dart';
class LogInCubit extends FormValidatorCubit<UserLoginState, LogInHelper> {
  LogInCubit({required super.userState}):super(helper: LogInHelper());

  void updateEmailOrPhonenumber(String? s) => emit(state.copyWith(emailOrPhonenumber: s));
  void updatePassword(String? s) => emit(state.copyWith(password: s));

  @override
  void reset() => emit(UserLoginState.newUser());

  @override
  Future<void> submit() async{
    try {
      Response<String> response = await helper.submit(state.getUserData);
      if (response.statusCode! >= 400) {
        _updateResultState(ResultState.rejected(message: BadResponseModel.fromAPI(response).message));
      }else{
        await authClient.saveAuth(AuthResponse.fromJWT(jwt: helper.getToken(response.data!), logged: true));
        _updateResultState(ResultState.accepted());
      }
    } on DioException catch (e) {
      _updateResultState(ResultState.rejected(message: '${e.getMessage()}.'));
    }
  }
  
  @override
  bool get rebuildCondition => !(state.isAccepted);
  
}
