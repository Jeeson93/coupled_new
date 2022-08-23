part of 'match_maker_bloc.dart';

abstract class MatchMakerState extends Equatable {
  const MatchMakerState([List props = const []]);
}

abstract class CounterState extends Equatable {
  const CounterState([List props = const []]);
}

class CounterInitial extends CounterState {
  @override
  List<Object> get props => [];
}

class CounterClearAll extends CounterState {
  final Counter counterState;
  final int timeStamp;

  CounterClearAll(this.timeStamp, this.counterState);

  @override
  List<Object> get props => [timeStamp, counterState];
}

class CounterDecrement extends CounterState {
  final Counter counterState;
  final int timeStamp;

  CounterDecrement(this.timeStamp, this.counterState);

  @override
  List<Object> get props => [counterState, timeStamp];
}

class CounterIncrement extends CounterState {
  final Counter counterState;
  final int timeStamp;

  CounterIncrement(
    this.timeStamp,
    this.counterState,
  );

  @override
  List<Object> get props => [
        counterState,
        timeStamp,
      ];
}

class InitialMatchMakerState extends MatchMakerState {
  @override
  List<Object> get props => [];
}

class MatchMakerLoading extends MatchMakerState {
  @override
  List<Object> get props => [];
}

class MatchMakerError extends MatchMakerState {
  final String error;

  MatchMakerError(this.error) : super([error]);

  @override
  List<Object> get props => [error];
}

class MatchMakerResponse extends MatchMakerState {
  final MatchMakerModel matchMakerModel;

  MatchMakerResponse(this.matchMakerModel);

  @override
  List<Object> get props => [matchMakerModel];
}

class SavedMatchMakerResponse extends MatchMakerState {
  final Map savedMatchMakerResponse;

  SavedMatchMakerResponse(this.savedMatchMakerResponse);

  @override
  List<Object> get props => [savedMatchMakerResponse];
}
