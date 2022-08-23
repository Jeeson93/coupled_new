part of 'tol_list_bloc_bloc.dart';

abstract class TolListBlocEvent extends Equatable {
  const TolListBlocEvent([List props = const []]) : super();
}

class TolListLoadEvent extends TolListBlocEvent {
  TolListLoadEvent();
  @override
  List<Object> get props => throw [];
}

class TolChangeNotify extends TolListBlocEvent {
  @override
  List<Object> get props => [];
}

class OrderCheckOut extends TolListBlocEvent {
  @override
  List<Object> get props => [];
}

class TolListLoadHistory extends TolListBlocEvent {
  @override
  List<Object> get props => [];
}

class TolLoadTracking extends TolListBlocEvent {
  @override
  List<Object> get props => [];
}
