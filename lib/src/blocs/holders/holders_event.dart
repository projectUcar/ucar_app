part of 'holders_bloc.dart';

abstract class HoldersEvent extends Equatable {
  const HoldersEvent();

  @override
  List<Object> get props => [];
}

class HoldersFetching extends HoldersEvent {}
