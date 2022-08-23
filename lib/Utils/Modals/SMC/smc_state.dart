part of 'smc_bloc.dart';

abstract class SmcState extends Equatable {
  SmcState([props = const []]) : super();
}

class InitialSmcState extends SmcState {
  @override
  List<Object> get props => [];
}

class SmcLoading extends SmcState {
  final extras;

  SmcLoading([this.extras]);

  @override
  List<Object> get props => [extras];
}

class SmcError extends SmcState {
  final String error;

  SmcError(this.error) : super([error]);

  @override
  List<Object> get props => [error];
}

class SmcCountry extends SmcState {
  final List<Item> countries;

  SmcCountry(this.countries) : super(countries);

  @override
  List<Object> get props => [countries];
}

class SmcStates extends SmcState {
  final List<Item> states;

  SmcStates(this.states) : super(states);

  @override
  List<Object> get props => [states];
}

class SmcCity extends SmcState {
  final List<Item> cities;

  SmcCity(this.cities) : super(cities);

  @override
  List<Object> get props => [cities];
}
