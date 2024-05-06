import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../env/env.dart';
import '../../blocs/blocs.dart';
import 'authentication_api.dart';

class ProfileHelper{
  final AuthenticationAPI _client = AuthenticationAPI();
  final String _profileEndpoint, _uploadImageEndpoint;
  ProfileHelper():_profileEndpoint = Env.profileEndpoint, _uploadImageEndpoint = Env.uploadImageEndpoint;

  Future<ProfileModel?> getProfile(String token) async {
    final response = await _client.getRequestWithToken(_profileEndpoint, token);
    final dataMap = jsonDecode(response.data!) as Map<String, dynamic>;
    return ProfileModel.fromJson(dataMap);
  }

  Future<Uint8List?> getPhoto(String token) async {
    final response = await _client.getImage("$_profileEndpoint-image", token);
    final Uint8List image = response.data!;
    return image;
  }

  Future<Response> postPhoto(String token, XFile file) async {
    final formatted = await file.readAsBytes();
    final filename = file.name;
    final response = await _client.postImage(_uploadImageEndpoint, token, formatted, filename);
    return response;
  }
}