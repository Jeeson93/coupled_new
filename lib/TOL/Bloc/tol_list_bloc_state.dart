part of 'tol_list_bloc_bloc.dart';

abstract class TolListBlocState extends Equatable {
  const TolListBlocState([props]);
}

class InitialTolListBlocState extends TolListBlocState {
  InitialTolListBlocState() : super();

  @override
  List<Object> get props => [];
}

class TolLoadedLoad extends TolListBlocState {
//  final List<TolModel> tolItems;
  final TolProductModel tolItems;

  TolLoadedLoad(this.tolItems) : super(tolItems);

  @override
  List<Object> get props => [this.tolItems];
}

class TolErrorState extends TolListBlocState {
   String errorMessage='';

  TolErrorState({this.errorMessage=''});

  @override
  List<Object> get props => [this.errorMessage];
}

class TolChangeNotifyState extends TolListBlocState {
  @override
  List<Object> get props => [];
}

class OrderCheckOutState extends TolListBlocState {
  @override
  List<Object> get props => [];
}

class OrderHistoryLoaded extends TolListBlocState {
  @override
  List<Object> get props => [];
}

class TolLoadedTracking extends TolListBlocState {
  @override
  List<Object> get props => [];
}
