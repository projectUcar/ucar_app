part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileFailed extends ProfileState {
  final String message;

  const ProfileFailed({required this.message});
}

abstract class ProfileReturned extends ProfileState {
  final ProfileModel model;
  
  const ProfileReturned({required this.model});
  
  Genders? get match {
    for (Genders element in Genders.values) {
      if (element.name == model.gender) {
        return element;
      }
    }
    return null;
  }

  @override
  List<Object> get props => [model];
}

class PartiallyReturned extends ProfileReturned {
  const PartiallyReturned({required super.model});
}

class ImageUploadFailed extends ProfileReturned {
  final String message;

  const ImageUploadFailed({required this.message, required super.model});

  @override
  List<Object> get props => [...super.props, message];
}

class CompletelyReturned extends ProfileReturned {
  final Uint8List imageBytes;

  const CompletelyReturned({required super.model, required this.imageBytes});

  @override
  List<Object> get props => [...super.props, imageBytes];
}