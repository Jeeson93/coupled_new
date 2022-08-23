import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:coupled/resources/repository.dart';
import 'package:equatable/equatable.dart';
import 'bloc.dart';
part 'match_board_event.dart';
part 'match_board_state.dart';

class MatchBoardBloc extends Bloc<MatchBoardEvent, MatchBoardState> {
  MatchBoardBloc() : super(InitialMatchBoardState()) {
    on<LoadMatchData>((event, emit) async {
      emit(InitialMatchBoardState());
      UserShortInfoModel userShortModelFree =
          UserShortInfoModel(response: UserShortInfoResponse.fromJson({}));
      try {
        if (event.param == 'mix') {
          userShortModelFree = await Repository().getMatchBoardList(
            path: 'mix2',
            params: {},
          );
        }

        UserShortInfoModel userShortModel =
            await Repository().getMatchBoardList(path: event.param, params: {});

        emit(LoadedMatchData([userShortModel, userShortModelFree]));
      } on RestException catch (e) {
        emit(MatchBoardError(e));
      }
    });
    on<MatchBoardActions>((event, emit) async {
      emit(InitialMatchBoardState());

      /// updating recommendation
      if (event.isRecommended) {
        event.userShortInfoModel[0].response.data.forEach((element) {
          if (element.id == event.id) {
            element.recommend = true;
          }
        });
      } else {
        event.userShortInfoModel[0].response.data
            .removeWhere((item) => item.id == event.id);
      }

      ///mix match contains two data objects(free & premium)
      if (event.userShortInfoModel.length == 2) {
        emit(LoadedMatchData(
            [event.userShortInfoModel[0], event.userShortInfoModel[1]]));
      } else {
        emit(LoadedMatchData([event.userShortInfoModel[0]]));
      }
    });
  }
}
