part of 'mom_bloc.dart';

@immutable
abstract class MomEvent extends Equatable {
  const MomEvent([List props = const []]) : super();
}

class LoadMomData extends MomEvent {
  final String param;
  final int page;

  LoadMomData(this.param, this.page) : super([param]);

  @override
  List<Object> get props => [this.param];
}

class LoadSpecially extends MomEvent {
  @override
  List<Object> get props => [];
}

class MoMChangeNotifier extends MomEvent {
  @override
  List<Object> get props => [];
}

class MomAction extends MomEvent {
  final int itemId;
  final List<MomDatum> momData;

  MomAction(this.itemId, this.momData);

  @override
  List<Object> get props => [this.itemId, this.momData];
}
