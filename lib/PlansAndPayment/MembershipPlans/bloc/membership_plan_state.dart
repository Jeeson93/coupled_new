part of 'membership_plan_bloc.dart';

abstract class MembershipPlanState extends Equatable {
  const MembershipPlanState([props]) : super();
}

class InitialMembershipPlanState extends MembershipPlanState {
  @override
  List<Object> get props => [];
}

class LoadedPlansAndPayment extends MembershipPlanState {
  final MembershipPlansModel plansAndPayment;

  LoadedPlansAndPayment(this.plansAndPayment) : super(plansAndPayment);

  @override
  List<Object> get props => [this.plansAndPayment];
}

class PlansAndPaymentErrorState extends MembershipPlanState {
  final String errorMessage;

  PlansAndPaymentErrorState(this.errorMessage) : super(errorMessage);

  @override
  List<Object> get props => [this.errorMessage];
}
