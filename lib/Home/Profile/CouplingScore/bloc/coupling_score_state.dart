part of 'coupling_score_bloc.dart';


abstract class CouplingScoreState extends Equatable {
  const CouplingScoreState([props]) : super();
}

class InitialCouplingScoreState extends CouplingScoreState {
  @override
  List<Object> get props => [];


}

class LoadedCouplingScore extends CouplingScoreState {
  @override
  List<Object> get props => [];
}

class ErrorState extends CouplingScoreState {
  final String errorMessage;

  ErrorState(this.errorMessage) : super(errorMessage);

  @override
  List<Object> get props => [this.errorMessage];
}

class CouplingScoreNotifier extends CouplingScoreState {
  @override
  List<Object> get props => [];
}
