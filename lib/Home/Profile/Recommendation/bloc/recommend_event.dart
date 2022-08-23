
part of 'recommend_bloc.dart';

abstract class RecommendEvent extends Equatable {
  const RecommendEvent([List props = const []]) : super();
}

class LoadRecommendation extends RecommendEvent {
  final String momType;

  LoadRecommendation(this.momType) : super([momType]);

  @override
  List<Object> get props => [this.momType];
}
