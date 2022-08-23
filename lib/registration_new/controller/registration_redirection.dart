import 'package:coupled/StartScreen/IntroSlider.dart';
import 'package:coupled/StartScreen/welcome_screen.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///2 pages to redirect asp appRegistrationStep & registrationStatus from profile response
///1.WelcomeScreen
///2.Dashboard
///TODO navigation to main page with access token
registrationReDirect(BuildContext context) async {
  // print(
  //     'GlobalData.myProfile.usersBasicDetails.appRegistrationStep-----------');
  // print(GlobalData.myProfile.usersBasicDetails.appRegistrationStep ?? '');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var a = prefs.getString('accessToken');
  print(a);

  ///intro slider
  if (prefs.getString('accessToken') == null) {
    Navigator.pushNamed(context, IntroSlider.route);
  }

  ///main board for already existing user
  else if (GlobalData.myProfile.usersBasicDetails?.registrationStatus == 1 &&
      prefs.getString('accessToken') != null) {
    Navigator.pushNamed(context, '/mainBoard');
  }

  ///welcome screen if reg step not completed
  else if (GlobalData.myProfile.usersBasicDetails?.appRegistrationStep ==
          null ||
      (GlobalData.myProfile.usersBasicDetails?.registrationStatus ?? 0) == 0) {
    Navigator.pushNamed(context, WelcomeScreen.route);
  } else {
    Navigator.pushNamed(context, '/startMain');
  }
}
