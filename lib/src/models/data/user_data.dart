abstract class UserData{
  String formatPassword(String? s) => s != null ? '****' : '[empty]';
}