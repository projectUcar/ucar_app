import '../data/user_data.dart';

abstract class UserState<T extends UserData>{
  UserState(T userData,{required ResultState resultState, required bool submitted}): _resultState = resultState, _userData = userData, _submitted = submitted;
  
  final T _userData;
  final ResultState _resultState;
  final bool _submitted;

  T get getUserData => _userData;
  ResultState get getResultState => _resultState;
  bool get getSubmitted => _submitted;

  @override
  String toString() => 'UserData: ${_userData.toString()}';

  bool isValid();

  bool get isMissing => _resultState._result == Results.missing;
  bool get isRejected => _resultState._result == Results.rejected;
  bool get isAccepted => _resultState._result == Results.accepted;

  UserState<T> copyWith({ResultState? newRS, bool? submitted});
}

class ResultState{
  final String message;
  final Results _result;

  ResultState._(this.message, this._result);

  factory ResultState.missing() => ResultState._("No entregado", Results.missing);
  factory ResultState.rejected({required String message}) => ResultState._(message, Results.rejected);
  factory ResultState.accepted() => ResultState._("Operación exitosa", Results.accepted);
}

enum Results{missing, rejected, accepted}