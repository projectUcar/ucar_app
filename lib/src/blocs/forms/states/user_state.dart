import '../data/user_data.dart';

abstract class UserState<T extends UserData>{
  final T _userData;

  const UserState(T userData): _userData = userData;

  T get getUserData => _userData;
  
  @override
  String toString() => 'UserData: ${_userData.toString()}';

  bool isValid();

  UserState copyWith();
}