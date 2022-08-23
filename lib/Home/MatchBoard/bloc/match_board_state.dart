part of 'match_board_bloc.dart';

abstract class MatchBoardState extends Equatable {
  const MatchBoardState([props]) : super();
}

class InitialMatchBoardState extends MatchBoardState {
  @override
  List<Object> get props => [];
}

class MatchBoardError extends MatchBoardState {
  final RestException error;

  MatchBoardError(this.error);

  @override
  List<Object> get props => [error];
}

class LoadedMatchData extends MatchBoardState {
//  final UserShortInfoModel userShortInfoModel;
  final List userShortInfoModel;

  LoadedMatchData(this.userShortInfoModel) : super(userShortInfoModel);

  @override
  List<Object> get props => [userShortInfoModel];
}
