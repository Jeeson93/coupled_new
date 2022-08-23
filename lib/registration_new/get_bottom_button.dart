import 'package:coupled/REST/RestAPI.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';

import 'package:coupled/registration_new/controller/page_controller.dart';
import 'package:coupled/registration_new/helpers/getAppStep.dart';
import 'package:coupled/registration_new/helpers/section_validator.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

///bottom navigation button
Widget getBottomNavigationButtons(
    {Map<String, dynamic> params = const {}, int step = 0}) {
  print('section---- $step');
  bool isLoading = false;
  return StatefulBuilder(builder: (context, setState1) {
    return Positioned(
      bottom: 5,
      left: 15,
      right: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///previous button
          CustomButton(
            enabled: !isLoading && (step != 1),
            child: Icon(
              Icons.chevron_left,
              size: 30.0,
              color: Colors.white,
            ),
            onPressed: () {
              //  Navigator.pop(context);
              Navigator.pushNamed(context, registrationPages[step - 2]);
            },
            height: 40.0,
            width: 40.0,
            borderRadius: BorderRadius.circular(100.0),
            gradient: LinearGradient(colors: [
              CoupledTheme().primaryBlue,
              CoupledTheme().primaryBlue
            ]),
          ),

          ///next button
          CustomButton(
            enabled: !isLoading,
            child: isLoading
                ? GlobalWidgets().showCircleProgress()
                : Icon(
                    Icons.chevron_right,
                    size: 30.0,
                    color: Colors.white,
                  ),
            onPressed: () {
              print('step-----$step');

              print('params---- $params ');
              if (registerValidator(step: step)) {
                setState1(() {
                  isLoading = true;
                });

                ///multi part
                if (step == 10 || step == 14 || step == 6 || step == 16) {
                  if ((step == 10) || (step == 16)) {
                    Navigator.pushNamed(context, registrationPages[step]);
                  } else {
                    print('params----------------');
                    print(params);

                    RestAPI()
                        .multiPart('${APis.register}${getSteps(step)}',
                            params: params)
                        .then((value) {
                      Repository().fetchProfile('').then((value) {
                        setState1(() {
                          GlobalData.myProfile = value;
                          isLoading = false;
                        });
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Navigator.pushNamed(context, registrationPages[step]);
                        });
                      });
                    }, onError: (e) {
                      print("jakob");
                      print(e);
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
                    ///optional profile fetch
                    Repository().fetchProfile('').then((value) {
                      setState1(() {
                        GlobalData.myProfile = value;
                        isLoading = false;
                      });
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Navigator.pushNamed(context, registrationPages[step]);
                      });
                    });
                  }, onError: (e) {
                    print("jake");

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
            },
            height: 40.0,
            width: 40.0,
            borderRadius: BorderRadius.circular(100.0),
            gradient: LinearGradient(colors: [
              CoupledTheme().primaryBlue,
              CoupledTheme().primaryBlue
            ]),
          ),
        ],
      ),
    );
  });
}
