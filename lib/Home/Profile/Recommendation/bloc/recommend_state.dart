
part of 'recommend_bloc.dart';

abstract class RecommendState extends Equatable {
  const RecommendState([props]) : super();
}

class InitialRecommendState extends RecommendState {
  @override
  List<Object> get props => [];
}

class RecommendationLoaded extends RecommendState {
  final MatchOMeterModel momData;

  RecommendationLoaded(this.momData) : super([momData]);

  @override
  List<Object> get props => [momData];
}

class RecommendErrorState extends RecommendState {
  final String errorMessage;

  RecommendErrorState(this.errorMessage) : super([errorMessage]);

  @override
  List<Object> get props => [this.errorMessage];
}
