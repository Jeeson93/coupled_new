import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/models/transaction_model.dart';
import 'package:coupled/resources/repository.dart';
import 'package:equatable/equatable.dart';

part 'my_plans_and_payment_event.dart';
part 'my_plans_and_payment_state.dart';

// class MyPlansAndPaymentBloc
//     extends Bloc<MyPlansAndPaymentEvent, MyPlansAndPaymentState> {
//   MyPlansAndPaymentBloc({MyPlansAndPaymentState initialState})
//       : super(initialState);

//   @override
//   Stream<MyPlansAndPaymentState> mapEventToState(
//     MyPlansAndPaymentEvent event,
//   ) async* {
//     if (event is LoadMyPlans) {
//       yield InitialMyPlansAndPaymentState();
//       try {
//         MyPlansAndPaymentModel plansAndPayment =
//             await Repository().fetchMyPlansAndPayment();
//         yield LoadedMyPlans(plansAndPayment);
//       } catch (e) {
//         var a = CommonResponseModel.fromJson(e);
//         yield MyPlansErrorState(a.response.msg);
//       }
//     }
//     if (event is LoadTransactionHistory) {
//       yield InitialMyPlansAndPaymentState();
//       try {
//         TransactionModel transactionModel =
//             await Repository().getTransactionHistory();
//         yield TransactionHistoryLoaded(transactionModel);
//       } catch (e) {
//         var a = CommonResponseModel.fromJson(e);
//         yield MyPlansErrorState(a.response.msg);
//       }
//     }
//   }
// }

class MyPlansAndPaymentBloc
    extends Bloc<MyPlansAndPaymentEvent, MyPlansAndPaymentState> {
  MyPlansAndPaymentBloc() : super(InitialMyPlansAndPaymentState()) {
    on<LoadMyPlans>((event, emit) async {
      emit(InitialMyPlansAndPaymentState());
      try {
        MyPlansAndPaymentModel plansAndPayment =
            await Repository().fetchMyPlansAndPayment();
        emit(LoadedMyPlans(plansAndPayment));
      } catch (e) {
        var a = CommonResponseModel.fromJson(e as Map<String, dynamic>);
        emit(MyPlansErrorState((a.response?.msg).toString()));
      }
    });
    on<LoadTransactionHistory>((event, emit) async {
      emit(InitialMyPlansAndPaymentState());
      try {
        TransactionModel transactionModel =
            await Repository().getTransactionHistory();
        emit(TransactionHistoryLoaded(transactionModel));
      } catch (e) {
        var a = CommonResponseModel.fromJson(e as Map<String, dynamic>);
        emit(MyPlansErrorState((a.response?.msg).toString()));
      }
    });
  }
}
