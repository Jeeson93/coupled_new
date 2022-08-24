import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/models/match_o_meter_model.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';
part 'mom_event.dart';
part 'mom_state.dart';

// class MomBloc extends Bloc<MomEvent, MomState> {
//   MomBloc({MomState initialState}) : super(initialState);

//   @override
//   Stream<MomState> mapEventToState(
//     MomEvent event,
//   ) async* {
//     if (event is LoadMomData) {
//       print('state-------------LoadedMoMData ${event.param}');
//       yield InitialMomState();
//       try {
//         MatchOMeterModel matchOMeterModel = await Repository()
//             .getMatchOMeterList(path: event.param, perPageCount: 50, page: 1);

//         print('matchOMeterModel--------');
//         print(matchOMeterModel);

//         yield LoadedMomData(matchOMeterModel);
//       } catch (e) {
//         /* var a = CommonResponseModel.fromJson(e);
//         print('a.response.msg----------------------');
//         print(a.response.msg);
//         yield MoMErrorState(a.response.msg);*/
//       }
//     }
//     if (event is LoadSpecially) {
//       yield InitialMomState();
//       try {
//         GlobalData.speciallyAbled = await Repository()
//             .getMatchOMeterList(path: 'specially', perPageCount: 50, page: 1);
//         yield LoadedSpecially();
//       } catch (e) {
//         var a = CommonResponseModel.fromJson(e);
//         print('a.response.msg----------------------');
//         print(a.response.msg);
//         yield MoMErrorState(a.response.msg);
//       }
//     }
//     if (event is MoMChangeNotifier) {
//       yield InitialMomState();
//       yield LoadedSpecially();
//     }
//   }
// }

class MomBloc extends Bloc<MomEvent, MomState> {
  MomBloc() : super(InitialMomState()) {
    on<LoadMomData>((event, emit) async {
      print('state-------------LoadedMoMData ${event.param}');
      emit(InitialMomState());
      try {
        GlobalData.matchmeter = await Repository()
            .getMatchOMeterList(path: event.param, perPageCount: 50, page: 1);
        print('responsed....................');
        emit(LoadedMomData(GlobalData.matchmeter));
      } catch (e) {
        // var error = json.decode(e.toString());
        // var a = CommonResponseModel.fromJson(error);
        // print('a.response.msg----------------------');
        // print(a.response.msg);

        emit(MoMErrorState(e.toString()));

        //print('fgfgggfgf$a');

      }
    });
    on<LoadSpecially>((event, emit) async {
      emit(InitialMomState());
      try {
        GlobalData.speciallyAbled = await Repository()
            .getMatchOMeterList(path: 'specially', perPageCount: 50, page: 1);
        emit(LoadedSpecially());
      } catch (e) {
        var a = CommonResponseModel.fromJson(e as Map<String, dynamic>);
        print('a.response.msg----------------------');
        print(a.response!.msg);
        emit(MoMErrorState(a.response?.msg));
      }
    });
    on<MoMChangeNotifier>((event, emit) {
      emit(InitialMomState());
      emit(LoadedSpecially());
    });
  }
}
