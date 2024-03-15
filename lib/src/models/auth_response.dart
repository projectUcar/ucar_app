import 'dart:convert';

class AuthResponse {
  final String _token, _name, _lastname, _email, _id;
  final int _iat, _exp;
  final List<dynamic>_role;
  final bool _logged;
  
  AuthResponse._({
    required String token,
    required String name,
    required String lastname,
    required String email,
    required String id,
    required List<dynamic> role,
    required int iat,
    required int exp,
    required bool logged
  }) : _token = token, _exp = exp, _iat = iat, _id = id, _email = email, _lastname = lastname, _name = name, _role = role, _logged = logged;

  String get token => _token;
  String get name => _name;
  String get lastname => _lastname;
  String get email => _email;
  String get id => _id;
  List<dynamic> get role => _role;
  int get iat => _iat;
  int get exp => _exp;
  bool get logged => _logged;
  
  factory AuthResponse.fromJWT({required String jwt, required bool logged}) {
    final json = _parseJWT(jwt);
    return AuthResponse._(
      token: jwt,
      name: json["name"],
      lastname: json["lastname"],
      email: json["email"],
      id: json["id"],
      role: json["role"],
      iat: json["iat"],
      exp: json["exp"],
      logged: logged
    );
  }

  Map<String, dynamic> toJson() => {
    "token": _token,
    "name": _name,
    "lastname": _lastname,
    "email": _email,
    "id": _id,
    "role": _role,
    "iat": _iat,
    "exp": _exp,
    "logged": _logged
  };

  static Map<String, dynamic> _parseJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = jsonDecode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64 string!');
    }
    return utf8.decode(base64Url.decode(output));
  }
}