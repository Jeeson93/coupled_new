import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/models/tol_checkout_model.dart';
import 'package:coupled/models/tol_list_model.dart';
import 'package:coupled/models/tol_order_history.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:equatable/equatable.dart';

import './bloc.dart';
part 'tol_list_bloc_event.dart';
part 'tol_list_bloc_state.dart';

// class TolListBlocBloc extends Bloc<TolListBlocEvent, TolListBlocState> {
//   TolListBlocBloc({TolListBlocState initialState}) : super(initialState);

//   @override
//   Stream<TolListBlocState> mapEventToState(
//     TolListBlocEvent event,
//   ) async* {
//     TolProductModel tolListModel;
//     TolCheckOutItemModel tolCheckOutItemModel;
//     TolOrderHistoryModel tolOrderHistoryModel;
//     TrackOrderModel trackOrderModel;
//     print('event--------------');
//     print(event);
//     yield InitialTolListBlocState();

//     ///product
//     if (event is TolListLoadEvent) {
//       //  yield InitialTolListBlocState();

//       try {
//         tolListModel = await Repository().getTolList();
//         GlobalData.tolProducts = tolListModel;
//         yield TolLoadedLoad(tolListModel);
//       } catch (e) {
//         print('exception--$e');
//         GlobalWidgets().showToast(msg: e['response']['msg']);
//         yield TolErrorState(errorMessage: e['response']['msg']);
//       }
//     }

//     ///change notifier
//     if (event is TolChangeNotify) yield TolChangeNotifyState();

//     ///order checkout
//     if (event is OrderCheckOut) {
//       try {
//         tolCheckOutItemModel = await Repository().tolCheckout();
//         GlobalData.tolCheckout = tolCheckOutItemModel;
//         print('object--');
//         yield OrderCheckOutState();
//       } catch (e) {
//         print('object--');
//         var a = CommonResponseModel.fromJson(e);
//         yield TolErrorState(errorMessage: a.response.msg);
//       }
//     }

//     ///order history
//     if (event is TolListLoadHistory) {
//       try {
//         tolOrderHistoryModel = await Repository().tolGetHistory();
//         GlobalData.tolOrderHistory = tolOrderHistoryModel;
//         yield OrderHistoryLoaded();
//       } catch (e) {
//         var a = CommonResponseModel.fromJson(e);
//         yield TolErrorState(errorMessage: a.response.msg);
//       }
//     }

//     ///order tracking
//     if (event is TolLoadTracking) {
//       try {
//         trackOrderModel = await Repository().tolTrackOrder();
//         print('trackOrderModel---------------');
//         print(trackOrderModel);
//         GlobalData.trackOrderModel = trackOrderModel;
//         yield TolLoadedTracking();
//         GlobalData.selectedItem = TolProductDatum();
//         GlobalData.selectedItem.stock =
//             GlobalData.trackOrderModel.response.item.quantity;
//         GlobalData.selectedItem.price =
//             GlobalData.trackOrderModel.response.item.price ?? 1;
//         GlobalData.selectedItem.tax =
//             GlobalData.trackOrderModel.response.item.tax;
//         GlobalData.selectedItem.shippingFee =
//             GlobalData.trackOrderModel.response.item.shippingFee;
//         GlobalData.selectedItem.totalPrice =
//             GlobalData.trackOrderModel.response.item.totalPrice;
//       } catch (e) {
//         var a = CommonResponseModel.fromJson(e);
//         yield TolErrorState(errorMessage: a.response.msg);
//       }
//     }
//   }
// }

class TolListBlocBloc extends Bloc<TolListBlocEvent, TolListBlocState> {
  TolListBlocBloc() : super(InitialTolListBlocState()) {
    TolListBlocEvent event;
    TolProductModel tolListModel;
    TolCheckOutItemModel tolCheckOutItemModel;
    TolOrderHistoryModel tolOrderHistoryModel;
    TrackOrderModel trackOrderModel;
    on<TolListBlocEvent>((event, emit) {
      print('event--------------');
      //print('event is$event');
      emit(InitialTolListBlocState());
    });

    on<TolListLoadEvent>((event, emit) async {
      try {
        tolListModel = await Repository().getTolList();
        GlobalData.tolProducts = tolListModel;
        emit(TolLoadedLoad(tolListModel));
      } catch (e) {
        print('exception--$e');
        GlobalWidgets().showToast(msg: e.toString());
        emit(TolErrorState(errorMessage: e.toString()));
      }
    });

    ///change Nolifier
    on<TolChangeNotify>((event, emit) async {
      emit(TolChangeNotifyState());
    });

    ///order checkout
    on<OrderCheckOut>((event, emit) async {
      try {
        tolCheckOutItemModel = await Repository().tolCheckout();
        GlobalData.tolCheckout = tolCheckOutItemModel;
        print('object--');
        emit(OrderCheckOutState());
      } catch (e) {
        print('object--');
        var a = CommonResponseModel.fromJson(e as Map<String, dynamic>);
        emit(TolErrorState(errorMessage: (a.response?.msg).toString()));
      }
    });

    ///order history
    on<TolListLoadHistory>((event, emit) async {
      try {
        tolOrderHistoryModel = await Repository().tolGetHistory();
        GlobalData.tolOrderHistory = tolOrderHistoryModel;
        emit(OrderHistoryLoaded());
      } catch (e) {
        print(e);
        var a = CommonResponseModel.fromJson(e as Map<String, dynamic>);
        emit(TolErrorState(errorMessage: (a.response?.msg).toString()));
      }
    });

    ///order Tracking
    on<TolLoadTracking>((event, emit) async {
      try {
        trackOrderModel = await Repository().tolTrackOrder();
        print('trackOrderModel---------------');
        print(trackOrderModel);
        GlobalData.trackOrderModel = trackOrderModel;
        emit(TolLoadedTracking());
        GlobalData.selectedItem = TolProductDatum();
        GlobalData.selectedItem.stock =
            GlobalData.trackOrderModel.response!.item!.quantity;
        GlobalData.selectedItem.price =
            GlobalData.trackOrderModel.response!.item!.price ?? 1;
        GlobalData.selectedItem.tax =
            GlobalData.trackOrderModel.response!.item!.tax;
        GlobalData.selectedItem.shippingFee =
            GlobalData.trackOrderModel.response!.item!.shippingFee;
        GlobalData.selectedItem.totalPrice =
            GlobalData.trackOrderModel.response!.item!.totalPrice;
      } catch (e) {
        var a = CommonResponseModel.fromJson(e as Map<String, dynamic>);
        emit(TolErrorState(errorMessage: (a.response?.msg).toString()));
      }
    });
  }
}
