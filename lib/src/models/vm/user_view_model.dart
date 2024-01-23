import '../data/user_data.dart';

abstract class UserViewModel<T extends UserData>{
  final T _userData;

  const UserViewModel(T userData): _userData = userData;

  T get getUserData => _userData;
  
  @override
  String toString() => 'UserData: ${_userData.toString()}';

  bool isValid();

  UserViewModel copyWith();
}