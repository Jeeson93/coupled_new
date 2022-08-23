part of 'coupling_score_bloc.dart';

abstract class CouplingScoreEvent extends Equatable {
  const CouplingScoreEvent([List props = const []]) : super();
}

class LoadCouplingScore extends CouplingScoreEvent {
  final String memberShipCode;

  LoadCouplingScore(this.memberShipCode) : super([memberShipCode]);

  @override
  List<Object> get props => [this.memberShipCode];
}

class CSChangeNotify extends CouplingScoreEvent {
  @override
  List<Object> get props => [];
}
