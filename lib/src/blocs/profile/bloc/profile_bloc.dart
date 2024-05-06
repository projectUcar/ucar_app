import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../util/fail_to_message.dart';
import '../../../util/image_picker_utils.dart';
import '../../../util/options/genders.dart';
import '../../../helpers/authentication/profile_helper.dart';
import '../../blocs.dart';
import '../../token_validation.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> with TokenValidation<ProfileEvent, ProfileState>{
  ProfileBloc() : _helper = ProfileHelper(), _imagePickerUtils = ImagePickerUtils(), super(ProfileInitial()) {
    on<ProfileFetching>((event, emit) async{
      emit(ProfileLoading());
      final token = await verifyToken();
      bool control = false;
      ProfileModel? data;
      try {
        data = await _helper.getProfile(token!);
        if (data != null) {
          control = true;
        }
        final Uint8List? image = await _helper.getPhoto(token);
        if (image != null) {
          emit(CompletelyReturned(model: data!, imageBytes: image));
        }
      } on DioException catch (e) {
        if (control == true) {
          emit(PartiallyReturned(model: data!));
        }else{
          emit(ProfileFailed(message: e.getMessage()));
        }
      }
    });
    on<UploadImage>((event, emit) async{
      XFile? selectedFile = await selectImage(event);
      if (selectedFile != null) {
        final token = await verifyToken();
        Response response = await _helper.postPhoto(token!, selectedFile);
        if (response.statusCode != null && response.statusCode! < 300 && (state is ProfileReturned || state is ImageUploadFailed)) {
          await selectedFile.readAsBytes().then((value) => emit(CompletelyReturned(model: event.model, imageBytes: value)));
        }else{
          Map<String, dynamic> data = response.data as Map<String, dynamic>;
          emit(ImageUploadFailed(message: data["error"], model: event.model));
        }
      }
    });
  }

  final ProfileHelper _helper;
  final ImagePickerUtils _imagePickerUtils;

  Future<XFile?> selectImage(UploadImage event) async{
    XFile? file = (event.originFromCamera) ? await _imagePickerUtils.cameraCapture(): await _imagePickerUtils.imageFromGallery();
    return file;
  }
}
