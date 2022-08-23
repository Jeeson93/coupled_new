part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchQuery extends SearchEvent {
  final Map<String, dynamic> searchParams;

  SearchQuery(this.searchParams);

  @override
  List<Object> get props => [searchParams];
}
