import 'package:coupled/Home/Profile/profile_switch.dart';

import 'package:coupled/REST/RestAPI.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/user_short_info_model.dart';

import 'package:coupled/registration_new/helpers/section_validator.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

import 'helpers/getAppStep.dart';

AppBar getRegAppBar(BuildContext context,
    {String title = '',
    double progress = 0.0,
    int step = 0,
    Map params = const {}}) {
  bool _doneButton = false;
  bool isLoading = false;
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: CoupledTheme().backgroundColor,
    elevation: 0.0,
    title: TextView(
      title ?? '',
      size: 20.0,
      maxLines: 2,
      color: Colors.white,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      textScaleFactor: .8,
    ),
    actions: <Widget>[
      Visibility(
        visible:
            GlobalData.myProfile.usersBasicDetails?.registrationStatus == 1,
        child: StatefulBuilder(builder: (context, setState1) {
          return MaterialButton(
            onPressed: () {
              _doneButton = true;

              print('params---- $params ');
              if (registerValidator(step: step)) {
                setState1(() {
                  isLoading = true;
                });

                if (step == 10 || step == 14 || step == 6) {
                  if (step == 10) {
                    Repository().fetchProfile('').then((onValue) async {
                      setState1(() {
                        isLoading = false;
                        GlobalData.myProfile = onValue;
                      });
                      Navigator.pop(context);
                      // Navigator.of(context)
                      //     .popUntil(ModalRoute.withName('/profileSwitch'));
                      // Navigator.pushReplacementNamed(context, '/profileSwitch',
                      //     arguments: ProfileSwitch(
                      //       memberShipCode: "",
                      //       userShortInfoModel: UserShortInfoModel(
                      //           response: UserShortInfoResponse.fromJson({})),
                      //     ));
                    });
                  } else {
                    RestAPI()
                        .multiPart('${APis.register}${getSteps(step)}',
                            params: params as Map<String, dynamic>)
                        .then((value) {
                      Repository().fetchProfile('').then((onValue) async {
                        setState1(() {
                          isLoading = false;
                          GlobalData.myProfile = onValue;
                        });
                        Navigator.pop(context);
                        // Navigator.of(context)
                        //     .popUntil(ModalRoute.withName('/profileSwitch'));
                        // Navigator.pushReplacementNamed(
                        //     context, '/profileSwitch',
                        //     arguments: ProfileSwitch(
                        //       memberShipCode: "",
                        //       userShortInfoModel: UserShortInfoModel(
                        //           response: UserShortInfoResponse.fromJson({})),
                        //     ));
                      });
                    }, onError: (e) {
                      GlobalWidgets()
                          .showToast(msg: 'All fields are mandatory');
                      setState1(() {
                        isLoading = false;
                      });
                    });
                  }
                } else {
                  RestAPI()
                      .post('${APis.register}${getSteps(step)}', params: params)
                      .then((value) {
                    Repository().fetchProfile('').then((onValue) async {
                      setState1(() {
                        isLoading = false;
                        GlobalData.myProfile = onValue;
                      });
                      Navigator.pop(context);
                      // Navigator.of(context)
                      //     .popUntil(ModalRoute.withName('/profileSwitch'));
                      // Navigator.pushReplacementNamed(context, '/profileSwitch',
                      //     arguments: ProfileSwitch(
                      //       memberShipCode: "",
                      //       userShortInfoModel: UserShortInfoModel(
                      //           response: UserShortInfoResponse.fromJson({})),
                      //     ));
                    });
                  }, onError: (e) {
                    GlobalWidgets().showToast(msg: 'All fields are mandatory');
                    setState1(() {
                      isLoading = false;
                    });
                  });
                }
              } else {
                GlobalWidgets().showToast(
                    msg: (step == 10)
                        ? 'Please upload minimum 3 photos to continue registration. This would convince a prospective partner to connect with you faster'
                        : 'All fields are mandatory');
              }
              // onButtonPress();
            },
            child: isLoading
                ? GlobalWidgets().showCircleProgress()
                : TextView(
                    "Done",
                    size: 18.0,
                    color: CoupledTheme().primaryPink,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
          );
        }),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(0.0),
      child: LinearProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation<Color>(
          CoupledTheme().primaryBlue,
        ),
        value: progress,
      ),
    ),
  );
}
