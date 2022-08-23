import 'package:bloc/bloc.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/models/match_maker_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import './bloc.dart';
part 'match_maker_state.dart';
part 'match_maker_event.dart';

class MatchMakerBloc extends Bloc<MatchMakerEvent, MatchMakerState> {
  MatchMakerBloc() : super(InitialMatchMakerState()) {
    MatchMakerEvent event;
    on<GetMatchMaker>((event, emit) => _GetMatchMaker(event, emit, event.type));
    on<SetMatchMaker>(
        (event, emit) => _SetMatchMaker(event, emit, event.params));
  }
  void _GetMatchMaker(
      MatchMakerEvent event, Emitter<MatchMakerState> emit, String type) async {
    try {
      final response =
          await RestAPI().get<Map>(Uri.encodeFull(_getSavedMatchType(type)));
      print("getMatchMaker ::: $response");
      final matchmaker = MatchMakerModel.fromJson(response["response"]);
      print("getMatchMaker ::: $matchmaker");
      emit(MatchMakerResponse(matchmaker));
    } on Exception catch (e) {
      print("MatchMakerError ::: $e");
      emit(MatchMakerError(e.toString()));
    }
  }

  void _SetMatchMaker(
    SetMatchMaker event,
    Emitter<MatchMakerState> emit,
    Map<String, dynamic> params,
  ) async {
    try {
      final response =
          await RestAPI().post<Map>(APis.postMatchMaker, params: params);
      print("SavedMatchMaker :: $response");
      emit(SavedMatchMakerResponse(response));
    } on RestException catch (e) {
      emit(MatchMakerError(e.message));
    }
  }

  String _getSavedMatchType(String type) {
    String _type = "";
    switch (type) {
      case "coupling":
        _type = "coupling_match";
        break;
      case "mix":
        _type = "mix_match";
        break;
      default:
        _type = "general_match";
        break;
    }
    return '${APis.getMatchMakerByType}?match_type=$_type';
  }
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    CounterEvent event;
    on<CounterEvent>((event, emit) async {
      switch (event.counter) {
        case Counter.increment:
          emit(CounterIncrement(
              DateTime.now().millisecondsSinceEpoch, event.counter));
          break;
        case Counter.decrement:
          emit(CounterDecrement(
              DateTime.now().millisecondsSinceEpoch, event.counter));
          break;
        case Counter.clearAll:
          emit(CounterClearAll(
              DateTime.now().millisecondsSinceEpoch, event.counter));
          break;
        default:
          break;
      }
    });
  }
}

// class MatchMakerBloc extends Bloc<MatchMakerEvent, MatchMakerState> {
//   MatchMakerBloc({MatchMakerState initialState}) : super(initialState);

//   @override
//   Stream<MatchMakerState> mapEventToState(
//     MatchMakerEvent event,
//   ) async* {
//     if (event is GetMatchMaker) {
//       print("is it loaing");
//       yield MatchMakerLoading();
//       yield* getMatchMakerList(event.type);
//     }
//     if (event is SetMatchMaker) {
//       yield MatchMakerLoading();
//       yield* setMatchMakerList(event.type, event.params);
//     }
//   }

//   Stream<MatchMakerState> setMatchMakerList(
//     String type,
//     Map<String, dynamic> params,
//   ) async* {
//     try {
//       final response =
//           await RestAPI().post<Map>(APis.postMatchMaker, params: params);
//       print("SavedMatchMaker :: $response");
//       yield SavedMatchMakerResponse(response);
//     } on RestException catch (e) {
//       yield MatchMakerError(e.message);
//     }
//   }

//   Stream<MatchMakerState> getMatchMakerList(String type) async* {
//     try {
//       final response =
//           await RestAPI().get<Map>(Uri.encodeFull(_getSavedMatchType(type)));
//       print("getMatchMaker ::: $response");
//       final matchmaker = MatchMakerModel.fromJson(response["response"]);
//       print("getMatchMaker ::: $matchmaker");
//       yield MatchMakerResponse(matchmaker);
//     } on Exception catch (e) {
//       print("MatchMakerError ::: $e");
//       yield MatchMakerError(e.toString());
//     }
//   }

//   String _getSavedMatchType(String type) {
//     String _type = "";
//     switch (type) {
//       case "coupling":
//         _type = "coupling_match";
//         break;
//       case "mix":
//         _type = "mix_match";
//         break;
//       default:
//         _type = "general_match";
//         break;
//     }
//     return '${APis.getMatchMakerByType}?match_type=$_type';
//   }
// }

// class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   CounterBloc({CounterState initialState}) : super(initialState);

//   @override
//   Stream<CounterState> mapEventToState(CounterEvent event) async* {
//     print("event :: $event   ${event.props}");
//     switch (event.counter) {
//       case Counter.increment:
//         yield CounterIncrement(
//             DateTime.now().millisecondsSinceEpoch, event.counter);
//         break;
//       case Counter.decrement:
//         yield CounterDecrement(
//             DateTime.now().millisecondsSinceEpoch, event.counter);
//         break;
//       case Counter.clearAll:
//         yield CounterClearAll(
//             DateTime.now().millisecondsSinceEpoch, event.counter);
//         break;
//       default:
//         break;
//     }
//   }
// }

