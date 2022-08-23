import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coupled/Home/Search/bloc/bloc.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:coupled/resources/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_event.dart';
part 'search_state.dart';

// class SearchBloc extends Bloc<SearchEvent, SearchState> {
//   SearchBloc({SearchState initialState}) : super(initialState);

//   @override
//   Stream<SearchState> mapEventToState(
//     SearchEvent event,
//   ) async* {
//     if (event is SearchQuery) {
//       yield InitialSearchState();
//       try {
//         UserShortInfoModel userShortModel =
//             await Repository().getSearchByID(params: event.searchParams);
//         yield SearchResponse(userShortModel);
//       } on RestException catch (e) {
//         yield SearchError(e);
//       }
//     }
//   }
// }

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialSearchState()) {
    on<SearchQuery>((event, emit) async {
      emit(InitialSearchState());
      try {
        UserShortInfoModel userShortModel =
            await Repository().getSearchByID(params: event.searchParams);
        emit(SearchResponse(userShortModel));
      } on RestException catch (e) {
        emit(SearchError(e));
      }
    });
  }
}
