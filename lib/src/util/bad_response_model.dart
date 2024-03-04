import 'dart:convert';

import 'package:dio/dio.dart';

class BadResponseModel{

  final String _message;

  BadResponseModel._(this._message);
  
  factory BadResponseModel.fromAPI(Response<String>? response){
    String message = '';
    Map<String, dynamic> decoded = jsonDecode(response!.data ?? '{}');
    if (decoded.isNotEmpty) message = decoded['message']! as String;
    return BadResponseModel._(message);
  }

  String get message => _message;
}