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
  final List<TripModel> tripList;
  const HistoryReturned(this.tripList);
  @override
  List<Object> get props => [List.generate(tripList.length, (index) => tripList.elementAt(index).props)];

  HistoryReturned copyWith(int newIndex) => HistoryReturned(tripList);
}

class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);
}
