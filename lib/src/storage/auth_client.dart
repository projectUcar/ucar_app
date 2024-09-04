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

  Future<String?> get refreshToken async{
    final current = await session;
    return current?.refreshToken;
  }

  Future<bool?> get isDriver async{
    final current = await session;
    if (current != null) {
      return current.role.length > 1;
    }
    return null;
  }

  Future<String?> get userId async{
    final current = await session;
    return current?.id;
  }

  Future<void> saveAuth(AuthResponse authResponse) async{
    final list = <Role>[];
    for (var element in authResponse.role) {
      if (element is Map<String, dynamic>) {
        list.add(Role(name: element['name']));
      }else{
        list.add(Role(name: element));
      }
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
      logged: authResponse.logged,
      refreshToken: authResponse.refreshToken
    );
    await _storage.write(key: "SESSION", value: jsonEncode(session.toJson()));
  }

  Future<void> updateToken(String newToken) async{
    final refToken = await refreshToken;
    final logged = await session.then((session) => session?.logged);
    await saveAuth(AuthResponse.fromJWT(jwt: newToken, refreshToken: refToken, logged: logged ?? false));
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