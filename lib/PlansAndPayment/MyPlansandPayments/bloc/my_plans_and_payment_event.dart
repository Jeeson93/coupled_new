part of 'my_plans_and_payment_bloc.dart';

abstract class MyPlansAndPaymentEvent extends Equatable {
  const MyPlansAndPaymentEvent([List props = const []]) : super();
}

class LoadMyPlans extends MyPlansAndPaymentEvent {
  @override
  List<Object> get props => [];
}

class LoadTransactionHistory extends MyPlansAndPaymentEvent {
  @override
  List<Object> get props => [];
}
