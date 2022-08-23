import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:equatable/equatable.dart';

import './bloc.dart';
part 'coupling_score_state.dart';
part 'coupling_score_event.dart';
// class CouplingScoreBloc extends Bloc<CouplingScoreEvent, CouplingScoreState> {
//   CouplingScoreBloc({CouplingScoreState initialState}) : super(initialState);

//   @override
//   Stream<CouplingScoreState> mapEventToState(
//     CouplingScoreEvent event,
//   ) async* {
//     if (event is LoadCouplingScore) {
//       yield InitialCouplingScoreState();
//       try {
//         GlobalData.couplingScoreModel =
//             await Repository().fetchCouplingScore(event.memberShipCode);
//         yield LoadedCouplingScore();
//       } catch (e) {
//         CommonResponseModel commonResponseModel =
//             CommonResponseModel.fromJson(e);
//         if (commonResponseModel.response.msg == 'no topup' ||
//             commonResponseModel.response.msg == 'no plan') {
//           yield ErrorState(commonResponseModel.response.msg);
//         } else {
//           yield ErrorState(CoupledStrings.errorMsg);
//         }
//       }
//     }

//     if (event is CSChangeNotify) {
//       yield CouplingScoreNotifier();
//     }
//   }
// }

class CouplingScoreBloc extends Bloc<CouplingScoreEvent, CouplingScoreState> {
  CouplingScoreBloc() : super(InitialCouplingScoreState()) {
    on<LoadCouplingScore>((event, emit) async {
      if (event is LoadCouplingScore) {
        emit(InitialCouplingScoreState());
        try {
          GlobalData.couplingScoreModel =
              await Repository().fetchCouplingScore(event.memberShipCode);
          emit(LoadedCouplingScore());
        } catch (e) {
          CommonResponseModel commonResponseModel =
              CommonResponseModel.fromJson(e as Map<String, dynamic>);
          if (commonResponseModel.response?.msg == 'no topup' ||
              commonResponseModel.response?.msg == 'no plan') {
            emit(ErrorState((commonResponseModel.response?.msg).toString()));
          } else {
            emit(ErrorState(CoupledStrings.errorMsg));
          }
        }
      }
    });
    on<CSChangeNotify>((event, emit) async {
      emit(CouplingScoreNotifier());
    });
  }
}
