import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/Modals/SMC/SMC.dart';
import 'package:coupled/Utils/Modals/SMC/smc_widget.dart';
import 'package:equatable/equatable.dart';

part 'smc_event.dart';
part 'smc_state.dart';

final smcBloC = SmcBloc();

// class SmcBloc extends Bloc<SmcEvent, SmcState> with DoSomething {
//   SmcBloc({SmcState initialState}) : super(initialState);

//   @override
//   Stream<SmcState> mapEventToState(
//     SmcEvent event,
//   ) async* {
//     if (event is SMCParams) {
//       yield SmcLoading(event.type);
//       yield* fetchPlaces(event);
//     }
//   }
// }

// mixin DoSomething {
//   Stream<SmcState> fetchPlaces(SMCParams smc) async* {
//     print("_fetchByType....");
//     try {
//       Map response = await RestAPI().get(
//         "${APis.getPlace}?type=${smc.type}&country_code=${smc.countryCode}"
//         "&state_code=${smc.stateCode}&search=${smc.search}",
//       );
//       print("data : $response");
//       SMCItem data = SMCItem.fromJson(smc.type, response);
//       List<Item> _item = List();
//       switch (smc.type) {
//         case 'country':
//           data.country.forEach((item) {
//             _item.add(Item(
//                 id: item.id.toString(),
//                 code: item.code,
//                 name: item.name,
//                 type: smc.type));
//           });
//           yield SmcCountry(_item);
//           break;
//         case 'state':
//           List<Item> _item = List();
//           data.state.forEach((item) {
//             _item.add(Item(
//                 id: item.id.toString(),
//                 code: item.countryCode,
//                 name: item.state,
//                 type: smc.type));
//           });
//           yield SmcStates(_item);
//           break;
//         case 'city':
//           List<Item> _item = List();
//           data.city.forEach((item) {
//             _item.add(Item(
//                 id: item.id.toString(),
//                 code: item.state,
//                 name: item.locality,
//                 type: smc.type));
//           });
//           yield SmcCity(_item);
//           break;
//       }
//     } catch (e) {
//       print('$e');
//       yield SmcError(e);
//     }
//   }
// }

class SmcBloc extends Bloc<SmcEvent, SmcState> with DoSomething {
  SmcBloc() : super(InitialSmcState()) {
    SmcEvent event;
    on<SMCParams>((event, emit) async {
      emit(SmcLoading(event.type));
      await _fetchPlaces(event, emit, event);
      //yield* fetchPlaces(event);
    });
  }
}

mixin DoSomething {
  _fetchPlaces(SmcEvent event, Emitter<SmcState> emit, SMCParams smc) async {
    print("_fetchByType....");
    try {
      Map response = await RestAPI().get(
        "${APis.getPlace}?type=${smc.type}&country_code=${smc.countryCode}"
        "&state_code=${smc.stateCode}&search=${smc.search}",
      );
      print("data : $response");
      SMCItem data =
          SMCItem.fromJson(smc.type, response as Map<String, dynamic>);

      List<Item> _item = [];
      switch (smc.type) {
        case 'country':
          data.country.forEach((item) {
            _item.add(Item(
                id: item.id.toString(),
                code: item.code,
                name: item.name,
                type: smc.type));
          });
          emit(SmcCountry(_item));
          break;
        case 'state':
          List<Item> _item = [];
          data.state.forEach((item) {
            _item.add(Item(
                id: item.id.toString(),
                code: item.countryCode,
                name: item.state,
                type: smc.type));
          });
          emit(SmcStates(_item));
          break;
        case 'city':
          List<Item> _item = [];
          data.city.forEach((item) {
            _item.add(Item(
                id: item.id.toString(),
                code: item.state,
                name: item.locality,
                type: smc.type));
          });
          emit(SmcCity(_item));
          break;
      }
    } catch (e) {
      print('$e');
      emit(SmcError(e.toString()));
    }
  }

  // Stream<SmcState> _fetchPlaces(
  //     SmcEvent event, Emitter<SmcState> emit, SMCParams smc) async* {
  //   print("_fetchByType....");
  //   try {
  //     Map response = await RestAPI().get(
  //       "${APis.getPlace}?type=${smc.type}&country_code=${smc.countryCode}"
  //       "&state_code=${smc.stateCode}&search=${smc.search}",
  //     );
  //     print("data : $response");
  //     SMCItem data = SMCItem.fromJson(smc.type, response);
  //     List<Item> _item = List();
  //     switch (smc.type) {
  //       case 'country':
  //         data.country.forEach((item) {
  //           _item.add(Item(
  //               id: item.id.toString(),
  //               code: item.code,
  //               name: item.name,
  //               type: smc.type));
  //         });
  //         yield SmcCountry(_item);
  //         break;
  //       case 'state':
  //         List<Item> _item = List();
  //         data.state.forEach((item) {
  //           _item.add(Item(
  //               id: item.id.toString(),
  //               code: item.countryCode,
  //               name: item.state,
  //               type: smc.type));
  //         });
  //         yield SmcStates(_item);
  //         break;
  //       case 'city':
  //         List<Item> _item = List();
  //         data.city.forEach((item) {
  //           _item.add(Item(
  //               id: item.id.toString(),
  //               code: item.state,
  //               name: item.locality,
  //               type: smc.type));
  //         });
  //         yield SmcCity(_item);
  //         break;
  //     }
  //   } catch (e) {
  //     print('$e');
  //     yield SmcError(e);
  //   }
  // }
}
