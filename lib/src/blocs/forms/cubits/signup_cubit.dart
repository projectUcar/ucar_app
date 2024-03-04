part of 'form_validator_cubit.dart';
class SignUpCubit extends FormValidatorCubit<UserSignupState> {
  SignUpCubit({required super.userState});

  void updateName(String? s) => emit(state.copyWith(name: s));
  void updatePhonenumber(String? s) => emit(state.copyWith(phonenumber: s));
  void updateLastname(String? s) => emit(state.copyWith(lastname: s));
  void updateEmail(String? s) => emit(state.copyWith(email: s));
  void updatePassword(String? s) => emit(state.copyWith(password: s));
  void updatePasswordConfirmation(String? s) => emit(state.copyWith(passwordConfirmation: s));
  void updateGroup(String? s) => emit(state.copyWith(group: s));
  void updateGender(String? s) => emit(state.copyWith(gender: s));
  
  @override
  void reset() => emit(UserSignupState.newUser());
  
  @override
  Future<void> submit() async {
    final helper = SignUpHelper();
    try {
      Response<String> response = await helper.submit(state.getUserData);
      if (response.statusCode! >= 400) {
        _updateResultState(ResultState.rejected(message: BadResponseModel.fromAPI(response).message));
      }else{
        _updateResultState(ResultState.accepted());
      }
    } on DioException catch (e) {
      _updateResultState(ResultState.rejected(message: e.getMessage()));
    }
  }
}