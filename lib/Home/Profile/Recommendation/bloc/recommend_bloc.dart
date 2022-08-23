import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/models/match_o_meter_model.dart';
import 'package:coupled/resources/repository.dart';
import 'package:equatable/equatable.dart';

import './bloc.dart';
part 'recommend_state.dart';
part 'recommend_event.dart';

// class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {
//   RecommendBloc({RecommendState initialState}) : super(initialState);

//   @override
//   Stream<RecommendState> mapEventToState(
//     RecommendEvent event,
//   ) async* {
//     if (event is LoadRecommendation) {
//       yield InitialRecommendState();

//       try {
//         MatchOMeterModel matchOMeterModel = await Repository()
//             .getMatchOMeterList(path: event.momType, perPageCount: 50, page: 1);
//         yield RecommendationLoaded(matchOMeterModel);
//       } catch (e) {
//         var a = CommonResponseModel.fromJson(e);
//         yield RecommendErrorState(a.response.msg);
//       }
//     }
//   }
// }

class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {
  RecommendBloc() : super(InitialRecommendState()) {
    on<LoadRecommendation>((event, emit) async {
      if (event is LoadRecommendation) {
        emit(InitialRecommendState());

        try {
          MatchOMeterModel matchOMeterModel = await Repository()
              .getMatchOMeterList(
                  path: event.momType, perPageCount: 50, page: 1);
          emit(RecommendationLoaded(matchOMeterModel));
        } catch (e) {
          var a = CommonResponseModel.fromJson(e as Map<String, dynamic>);
          emit(RecommendErrorState((a.response?.msg).toString()));
        }
      }
    });
  }
}
