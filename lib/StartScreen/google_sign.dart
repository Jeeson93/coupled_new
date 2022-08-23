import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/StartScreen/start_main.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/registration_new/controller/registration_redirection.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dart:async';

class CoupledGoogleSignIn {
  Future<void> handleGoogleSignIn(
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      //Optional clientId
      // clientId:

      //     "84077684031-05h6fcgmijknn6b9aiks9g1onc65bpqc.apps.googleusercontent.com",
      scopes: <String>[
        'email',
      ],
    );

    try {
      _googleSignIn.signIn().then((value) {
        value!.authentication.then((googleKey) {
          print('google.accessToken--');
          print(googleKey.accessToken);

          Map<String, String> params = {
            "access_token": googleKey.accessToken.toString(),
            "grant_type": "social",
            "provider": 'google',
            "client_id": RestAPI.clientId,
            "client_secret": RestAPI.clientSecret,
            "firebase_token": GlobalData.fcmToken,
          };
          signIN(APis.signInSocial, params, scaffoldKey, context);
        });
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> googleSignOut() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    _googleSignIn.disconnect();
  }

  void signIN(String url, Map<String, String> params,
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) async {
    var response =
        await RestAPI().post(url, params: params).catchError((onError) {
      print("ERROR : ${onError.message}");
      GlobalWidgets().showSnackBar(scaffoldKey, onError.toString());
    });

    if (response != null) {
      await setAccessToken(response["access_token"]);
      Repository().fetchProfile('').then((onValue) async {
        GlobalData.myProfile = onValue;
        print('registration status------------');
        print(onValue.usersBasicDetails!.registrationStatus ?? '');
        print(onValue.usersBasicDetails!.appRegistrationStep ?? '');
        registrationReDirect(context);
      });
    }
  }
}
