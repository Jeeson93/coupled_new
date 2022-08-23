import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:equatable/equatable.dart';

import './bloc.dart';
part 'others_profile_event.dart';
part 'others_profile_state.dart';

// class OthersProfileBloc extends Bloc<OthersProfileEvent, OthersProfileState> {
//   OthersProfileBloc({OthersProfileState initialState}) : super(initialState);

//   @override
//   Stream<OthersProfileState> mapEventToState(
//     OthersProfileEvent event,
//   ) async* {
//     if (event is LoadOthersProfile) {
//       yield InitialOthersProfileState();
//       try {
//         GlobalData.othersProfile =
//             await Repository().fetchProfile(event.memberShipCode);
//         yield LoadedOthersProfile();
//       } catch (e) {
//         print('e--------');
//         print(e['response']['msg']);
//         yield OtherProfileErrorState(e['response']['msg'] == 'block'
//             ? 'Sorry, ${GlobalData.othersProfile.name} has blocked your profile. You can view this profile again once ${GlobalData.othersProfile.name} Unblocks you.'
//             : e['response']['msg'] == 'report'
//                 ? 'Sorry, ${GlobalData.othersProfile.name} has blocked your profile. You would not be able to view her profile.'
//                 : CoupledStrings.errorMsg);
//       }
//     }
//     if (event is OtherProfileChangeNotifier) {
//       yield LoadedOthersProfile();
//       yield OtherProfileChangeNotifierState();
//     }
//   }
// }

class OthersProfileBloc extends Bloc<OthersProfileEvent, OthersProfileState> {
  OthersProfileBloc() : super(InitialOthersProfileState()) {
    on<LoadOthersProfile>((event, emit) async {
      if (event is LoadOthersProfile) {
        emit(InitialOthersProfileState());
        try {
          GlobalData.othersProfile =
              await Repository().fetchProfile(event.memberShipCode);
          emit(LoadedOthersProfile());
        } catch (e) {
          print('e--------');
          print(e);
          emit(OtherProfileErrorState(e == 'block'
              ? 'Sorry, ${GlobalData.othersProfile.name} has blocked your profile. You can view this profile again once ${GlobalData.othersProfile.name} Unblocks you.'
              : e == 'report'
                  ? 'Sorry, ${GlobalData.othersProfile.name} has blocked your profile. You would not be able to view her profile.'
                  : CoupledStrings.errorMsg));
        }
      }
    });
    on<OtherProfileChangeNotifier>((event, emit) async {
      emit(LoadedOthersProfile());
      emit(OtherProfileChangeNotifierState());
    });
  }
}
