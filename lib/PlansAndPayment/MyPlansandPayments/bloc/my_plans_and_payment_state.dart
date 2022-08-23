part of 'my_plans_and_payment_bloc.dart';
abstract class MyPlansAndPaymentState extends Equatable {
  const MyPlansAndPaymentState([props]) : super();
}

class InitialMyPlansAndPaymentState extends MyPlansAndPaymentState {
  @override
  List<Object> get props => [];
}

class LoadedMyPlans extends MyPlansAndPaymentState {
  final MyPlansAndPaymentModel plansAndPayment;

  LoadedMyPlans(this.plansAndPayment) : super(plansAndPayment);

  @override
  List<Object> get props => [this.plansAndPayment];
}

class MyPlansErrorState extends MyPlansAndPaymentState {
  final String errorMessage;

  MyPlansErrorState(this.errorMessage) : super(errorMessage);

  @override
  List<Object> get props => [this.errorMessage];
}

class TransactionHistoryLoaded extends MyPlansAndPaymentState {
  final TransactionModel transactionModel;

  TransactionHistoryLoaded(this.transactionModel) : super(transactionModel);

  @override
  List<Object> get props => [this.transactionModel];
}
