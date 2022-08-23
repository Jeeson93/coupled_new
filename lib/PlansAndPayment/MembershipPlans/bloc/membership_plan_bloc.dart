import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/resources/repository.dart';
import 'package:equatable/equatable.dart';

import './bloc.dart';
part 'membership_plan_event.dart';
part 'membership_plan_state.dart';

// class MembershipPlanBloc
//     extends Bloc<MembershipPlanEvent, MembershipPlanState> {
//   MembershipPlanBloc({MembershipPlanState initialState}) : super(initialState);

//   @override
//   Stream<MembershipPlanState> mapEventToState(
//     MembershipPlanEvent event,
//   ) async* {
//     if (event is LoadMembershipPlans) {
//       yield InitialMembershipPlanState();
//       try {
//         MembershipPlansModel plansAndPayment =
//             await Repository().fetchMembershipPlans();
//         yield LoadedPlansAndPayment(plansAndPayment);
//       } catch (e) {
//         var a = CommonResponseModel.fromJson(e);
//         yield PlansAndPaymentErrorState(a.response.msg);
//       }
//     }
//   }
// }

class MembershipPlanBloc
    extends Bloc<MembershipPlanEvent, MembershipPlanState> {
  MembershipPlanBloc() : super(InitialMembershipPlanState()) {
    on<LoadMembershipPlans>((event, emit) async {
      emit(InitialMembershipPlanState());
      try {
        MembershipPlansModel plansAndPayment =
            await Repository().fetchMembershipPlans();
        emit(LoadedPlansAndPayment(plansAndPayment));
      } catch (e) {
        var a = CommonResponseModel.fromJson(e as Map<String, dynamic>);
        emit(PlansAndPaymentErrorState((a.response?.msg).toString()));
      }
    });
  }
}
