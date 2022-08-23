part of 'match_board_bloc.dart';

abstract class MatchBoardEvent extends Equatable {
  const MatchBoardEvent([List props = const []]) : super();
}

class LoadMatchData extends MatchBoardEvent {
  final String param;

  LoadMatchData(this.param) : super([param]);

  @override
  List<Object> get props => [this.param];
}

class MatchBoardActions extends MatchBoardEvent {
  final int id;
  final List userShortInfoModel;
  final bool isRecommended;

  MatchBoardActions(
      {required this.id,
      required this.userShortInfoModel,
      this.isRecommended = false})
      : super([id, userShortInfoModel]);

  @override
  List<Object> get props => [this.id, this.userShortInfoModel];
}
