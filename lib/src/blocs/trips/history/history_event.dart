part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class GetHistoryToU extends HistoryEvent {
  const GetHistoryToU();
}

class GetHistoryFromU extends HistoryEvent {
  const GetHistoryFromU();
}