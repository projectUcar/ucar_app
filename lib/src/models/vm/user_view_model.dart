import '../data/user_data.dart';

abstract class UserViewModel<T extends UserData>{
  final T userData;

  const UserViewModel(this.userData);
  
  @override
  String toString() {
    return 'UserData: ${userData.toString()}';
  }

  bool isValid();

  UserViewModel copyWith(Enum field, String? s);
}