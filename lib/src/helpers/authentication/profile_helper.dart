import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ucar_app/src/storage/auth_client.dart';

import '../../../env/env.dart';
import '../../blocs/blocs.dart';
import 'authentication_api.dart';

class ProfileHelper{
  final AuthenticationAPI _client = AuthenticationAPI();
  final String _profileEndpoint, _uploadImageEndpoint, _userByIdEndpoint;
  ProfileHelper():_profileEndpoint = Env.profileEndpoint, _uploadImageEndpoint = Env.uploadImageEndpoint, _userByIdEndpoint = Env.userByIdEndpoint;

  Future<ProfileModel?> getProfile(String token) async {
    final response = await _client.getRequestWithToken(_profileEndpoint, token);
    final dataMap = jsonDecode(response.data!) as Map<String, dynamic>;
    return ProfileModel.fromJson(dataMap.containsKey('rating') ? dataMap['user'] : dataMap);
  }

  Future<ProfileModel?> userById(String id) async {
    final token = await AuthClient().accessToken;
    final response = await _client.getRequestWithToken('$_userByIdEndpoint/$id', token!);
    final dataMap = jsonDecode(response.data!) as Map<String, dynamic>;
    return ProfileModel.fromJson(dataMap.containsKey('rating') ? dataMap['user'] : dataMap);
  }

  Future<Uint8List?> getPhoto(String token) async {
    final response = await _client.getImage("$_profileEndpoint-image", token);
    final Uint8List? image = response.statusCode! < 300 ? response.data! : null;
    return image;
  }

  Future<Response> postPhoto(String token, XFile file) async {
    final formatted = await file.readAsBytes();
    final filename = file.name;
    final response = await _client.postImage(_uploadImageEndpoint, token, formatted, filename);
    return response;
  }
}