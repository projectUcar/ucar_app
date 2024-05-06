library base_helper;
import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../env/env.dart';
import '../../blocs/blocs.dart';
import 'authentication_api.dart';
part 'sign_up_helper.dart';
part 'log_in_helper.dart';
abstract class BaseHelper<T extends UserData>{
  final AuthenticationAPI _client = AuthenticationAPI();
  final String endpoint;

  BaseHelper({required this.endpoint});

  Future<Response<String>> submit(T data) async {
    final response = await _client.postData(endpoint, jsonEncode(data.toJson()));
    return response;
  }

  String getToken(String response){
    Map<String, dynamic> json = jsonDecode(response) as Map<String, dynamic>;
    return json["token"];
  }
}