part of 'mom_bloc.dart';

@immutable
abstract class MomState extends Equatable {
  const MomState([props]) : super();
}

class InitialMomState extends MomState {
  @override
  List<Object> get props => [];
}

class LoadedMomData extends MomState {
  final MatchOMeterModel matchOMeterModel;

  LoadedMomData(this.matchOMeterModel) : super(matchOMeterModel);

  @override
  List<Object> get props => [this.matchOMeterModel];
}

class LoadedSpecially extends MomState {
  @override
  List<Object> get props => [];
}

class MoMErrorState extends MomState {
  final String? errorMessage;

  MoMErrorState(this.errorMessage) : super(errorMessage);

  @override
  List<Object> get props => [this.errorMessage.toString()];
}
