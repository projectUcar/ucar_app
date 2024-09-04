part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
  
  @override
  List<Object> get props => [];
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

class HistoryReturned extends HistoryState {
  final List<HistoryModel> tripList;
  const HistoryReturned(this.tripList);
  @override
  List<Object> get props => [List.generate(tripList.length, (index) => tripList.elementAt(index).tripModel.props)];

  HistoryReturned copyWith(List<HistoryModel> newList) => HistoryReturned(newList);
}

class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);
}
