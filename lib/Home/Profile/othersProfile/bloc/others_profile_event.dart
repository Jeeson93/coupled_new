part of 'others_profile_bloc.dart';

abstract class OthersProfileEvent extends Equatable {
  const OthersProfileEvent([List props = const []]) : super();
}

class LoadOthersProfile extends OthersProfileEvent {
  final String memberShipCode;

  LoadOthersProfile(this.memberShipCode) : super([memberShipCode]);

  @override
  List<Object> get props => [this.memberShipCode];
}

class OtherProfileChangeNotifier extends OthersProfileEvent {
  @override
  List<Object> get props => [];
}
