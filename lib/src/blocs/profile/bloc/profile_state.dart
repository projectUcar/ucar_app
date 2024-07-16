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
  final DriverResponseStatus requestState;
  final bool displayMessage;
  
  const ProfileReturned({required this.model, this.requestState = DriverResponseStatus.missing, this.displayMessage = false});
  
  Genders? get match {
    for (Genders element in Genders.values) {
      if (element.name == model.gender) {
        return element;
      }
    }
    return null;
  }

  ProfileReturned copyWith({DriverResponseStatus? requestState, required bool displayMessage});

  @override
  List<Object> get props => [model, requestState];
}

class PartiallyReturned extends ProfileReturned {
  const PartiallyReturned({required super.model, required super.requestState, super.displayMessage});

  @override
  PartiallyReturned copyWith({DriverResponseStatus? requestState, required bool displayMessage}) => PartiallyReturned(
    model: model,
    requestState: requestState ?? this.requestState,
    displayMessage: displayMessage
  );
}

class ImageUploadFailed extends ProfileReturned {
  final String message;

  const ImageUploadFailed({required this.message, required super.model, required super.requestState, super.displayMessage});

  @override
  ImageUploadFailed copyWith({DriverResponseStatus? requestState, required bool displayMessage}) => ImageUploadFailed(
    message: message,
    model: model,
    requestState: requestState ?? this.requestState,
    displayMessage: displayMessage
  );
  
  @override
  List<Object> get props => [...super.props, message];
}

class CompletelyReturned extends ProfileReturned {
  final Uint8List imageBytes;

  const CompletelyReturned({required super.model, required this.imageBytes, required super.requestState, super.displayMessage});

  @override
  List<Object> get props => [...super.props, imageBytes];
  
  @override
  CompletelyReturned copyWith({DriverResponseStatus? requestState, required bool displayMessage}) => CompletelyReturned(
    imageBytes: imageBytes,
    model: model,
    requestState: requestState ?? this.requestState,
    displayMessage: displayMessage
  );
}

