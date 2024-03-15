import 'dart:convert';

class Session{
  final String _token, _name, _lastname, _email, _id;
  final int _iat, _exp;
  final List<Role> _role;
  final DateTime _sessionCreatedAt;
  final bool _logged;
  
  Session({required String name, required String lastname, required String email, required String id, required int iat, required int exp, required String token, DateTime? sessionCreatedAt, required List<Role> role, required bool logged}):
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
  List<Role> get role => _role;
  int get iat => _iat;
  int get exp => _exp;
  bool get logged => _logged;

  factory Session.fromJson(Map<String, dynamic> json){
    return Session(
      token: json["token"], 
      name: json["name"],
      lastname: json["lastname"],
      email: json["email"],
      id: json["id"],
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
      "role": List<dynamic>.from(_role.map((x) => jsonEncode(x.toJson()))),
      "iat": _iat,
      "exp": _exp,
      "sessionCreatedAt": _sessionCreatedAt.toString(),
      "logged":_logged
    };
  }

  static List<Role> roles(List<dynamic> roleList) {
    List<Role> roles = [];
    for (dynamic element in roleList) {
      if (element is Role) roles.add(element);
    }
    return roles;
  }
}

class Role {
  String name;
  Role({required this.name});
  factory Role.fromJson(Map<String, dynamic> json) => Role(name: json["name"]);
  Map<String, dynamic> toJson() => {
    "name": name,
  };
}