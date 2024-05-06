import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/auth_response.dart';
import '../models/session.dart';

class AuthClient{
  final FlutterSecureStorage _storage;
  AuthClient._internal(): _storage = const FlutterSecureStorage();
  static final AuthClient _instance = AuthClient._internal();
  factory AuthClient() => _instance;

  Future<Session?> get session => _storage.read(key: "SESSION").then((value) => (value != null) ? Session.fromJson(jsonDecode(value) as Map<String, dynamic>) : null);
  Future<String?> get accessToken async{
    final current = await session;
    return current?.token;
  }

  Future<void> saveAuth(AuthResponse authResponse) async{
    final list = <Role>[];
    for (Map<String, dynamic> element in authResponse.role) {
      list.add(Role(name: element["name"]));
    }
    final Session session = Session(
      token: authResponse.token,
      name: authResponse.name,
      lastname: authResponse.lastname,
      email: authResponse.email,
      id: authResponse.id,
      role: list,
      iat: authResponse.iat,
      exp: authResponse.exp,
      logged: authResponse.logged
    );
    await _storage.write(key: "SESSION", value: jsonEncode(session.toJson()));
  }

  Future<bool> logout() async => await session.then((value) {
    if (value != null){
      try {
        _storage.write(key: "SESSION", value: jsonEncode(value.copyWith(logged: false).toJson()));
        return true;
      } catch (_) {
        return false;
      }
    }
    return false;
  });
}