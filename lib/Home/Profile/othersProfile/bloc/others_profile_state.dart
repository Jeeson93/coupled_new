part of 'others_profile_bloc.dart';

abstract class OthersProfileState extends Equatable {
  const OthersProfileState([props]) : super();
}

class InitialOthersProfileState extends OthersProfileState {
  @override
  List<Object> get props => [];
}

class LoadedOthersProfile extends OthersProfileState {
  @override
  List<Object> get props => [];
}

class OtherProfileErrorState extends OthersProfileState {
  final String errorMessage;

  OtherProfileErrorState(this.errorMessage) : super(errorMessage);

  @override
  List<Object> get props => [this.errorMessage];
}

class OtherProfileChangeNotifierState extends OthersProfileState {
  @override
  List<Object> get props => [];
}
