part of 'membership_plan_bloc.dart';

abstract class MembershipPlanEvent extends Equatable {
  const MembershipPlanEvent([List props = const []]) : super();
}

class LoadMembershipPlans extends MembershipPlanEvent {
  @override
  List<Object> get props => [];
}
