part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {}

class InitialSearchState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchResponse extends SearchState {
  final UserShortInfoModel userShortInfoModel;

  SearchResponse(this.userShortInfoModel);

  @override
  List<Object> get props => [userShortInfoModel];
}

class SearchError extends SearchState {
  final RestException error;

  SearchError(this.error);

  @override
  List<Object> get props => [error];
}
