part of 'holders_bloc.dart';

abstract class HoldersState extends Equatable {
  const HoldersState();
  
  @override
  List<Object> get props => [];
}

class HoldersLoading extends HoldersState {}

class HoldersReturned extends HoldersState {
  final List<ProfileModel> holders;

  const HoldersReturned({required this.holders});
}

class HoldersFailed extends HoldersState {
  final String message;

  const HoldersFailed({required this.message});
}
