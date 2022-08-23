part of 'match_maker_bloc.dart';

abstract class MatchMakerEvent extends Equatable {
  const MatchMakerEvent();
}

enum Counter { increment, decrement, clearAll, initial }

class CounterEvent extends MatchMakerEvent {
  final Counter counter;

  CounterEvent(bool count)
      : this.counter = count == null
            ? Counter.clearAll
            : count
                ? Counter.increment
                : Counter.decrement;

  @override
  List<Object> get props => [counter];
}

class GetMatchMaker extends MatchMakerEvent {
  final String type;

  GetMatchMaker({required this.type});

  @override
  List<Object> get props => [type];
}

class SetMatchMaker extends MatchMakerEvent {
  final Map<String, dynamic> params;
  final String type;

  SetMatchMaker({
    required this.type,
    required this.params,
  });

  @override
  List<Object> get props => [type, params];
}
