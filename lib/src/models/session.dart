import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';

class Session{
  final String _token, _name, _lastname, _email, _id;
  final String? _refreshToken;
  final int _iat, _exp;
  final List<Role> _role;
  final DateTime _sessionCreatedAt;
  final bool _logged;
  
  Session({required String? refreshToken, required String name, required String lastname, required String email, required String id, required int iat, required int exp, required String token, DateTime? sessionCreatedAt, required List<Role> role, required bool logged}):
  _refreshToken = refreshToken,
  _role = role,
  _exp = exp,
  _iat = iat,
  _id = id,
  _email = email,
  _lastname = lastname,
  _name = name,
  _token = token,
  _sessionCreatedAt = sessionCreatedAt ?? DateTime.now(),
  _logged = logged;

  String get token => _token;
  DateTime get sessionCreatedAt => _sessionCreatedAt;
  String get name => _name;
  String get lastname => _lastname;
  String get email => _email;
  String get id => _id;
  String? get refreshToken => _refreshToken;
  List<Role> get role => _role;
  int get iat => _iat;
  int get exp => _exp;
  bool get logged => _logged;
  bool get sessionExpired => JwtDecoder.isExpired(_token);

  bool isDriver() {
    for (Role element in role) {
      if (element.isDriver) return true;
    }
    return false;
  }

  bool isAdmin() {
    for (Role element in role) {
      if (element.isAdmin) return true;
    }
    return false;
  }
  
  factory Session.fromJson(Map<String, dynamic> json){
    return Session(
      token: json["token"], 
      name: json["name"],
      lastname: json["lastname"],
      email: json["email"],
      id: json["id"],
      refreshToken: json["refreshToken"],
      role: List<Role>.from(json["role"].map((x) => Role.fromJson(jsonDecode(x)))),
      iat: json["iat"],
      exp: json["exp"],
      sessionCreatedAt: DateTime.parse(json["sessionCreatedAt"]),
      logged: json['logged']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "token": _token,
      "name": _name,
      "lastname": _lastname,
      "email": _email,
      "id": _id,
      "refreshToken": _refreshToken,
      "role": List<dynamic>.from(_role.map((x) => jsonEncode(x.toJson()))),
      "iat": _iat,
      "exp": _exp,
      "sessionCreatedAt": _sessionCreatedAt.toString(),
      "logged":_logged,
    };
  }

  Session copyWith({String? name, String? lastname, String? email, String? id, int? iat, int? exp, String? token, String? refreshToken, List<Role>? role, bool? logged}) => Session(
    name: name ?? _name,
    lastname: lastname ?? _lastname,
    email: email ?? _email,
    id: id ?? _id,
    iat: iat ?? _iat,
    exp: exp ?? _exp,
    token: token ?? _token,
    sessionCreatedAt: _sessionCreatedAt,
    role: role ?? _role,
    logged: logged ?? _logged,
    refreshToken: refreshToken ?? _refreshToken
  );
}

class Role {
  String _name;
  static const _driverRole = "driver", _adminRole = "admin";
  Role({required String name}) : _name = name;
  factory Role.fromJson(Map<String, dynamic> json) => Role(name: json["name"]);
  Map<String, dynamic> toJson() => {
    "name": _name,
  };

  bool get isDriver => _name == _driverRole;
  bool get isAdmin => _name == _adminRole;
}