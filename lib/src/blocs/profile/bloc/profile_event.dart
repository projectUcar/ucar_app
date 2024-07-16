part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileFetching extends ProfileEvent{}

class UploadImage extends ProfileEvent{
  final ProfileModel model;
  final ImageOrigin _origin;

  const UploadImage._({required this.model, required ImageOrigin origin}) : _origin = origin;

  factory UploadImage.fromCamera(ProfileModel model) => UploadImage._(model: model, origin: ImageOrigin.camera);

  factory UploadImage.fromGallery(ProfileModel model) => UploadImage._(model: model, origin: ImageOrigin.gallery);

  bool get originFromCamera => _origin == ImageOrigin.camera;
}

class ResultEvent extends ProfileEvent{
  final DriverResponseStatus driverResponseStatus;

  const ResultEvent({required this.driverResponseStatus});
}

enum ImageOrigin{camera, gallery}