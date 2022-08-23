import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/StartScreen/start_main.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/registration_new/controller/registration_redirection.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class FacebookLogincreate {
  Future<void> handleFacebookSignIn(
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) async {
    final fb = FacebookLogin(debug: true);
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in
        // Send this access token to server for validation and auth
        final accessToken = res.accessToken;
        print('Access Token: ${accessToken!.token}');
        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');
        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');
        GlobalWidgets().showSnackBar(
            scaffoldKey, 'Facebook Login to ${profile.name} is success');
        Map<String, String> params = {
          "access_token": accessToken.token,
          "grant_type": "social",
          "provider": "facebook",
          "client_id": RestAPI.clientId,
          "client_secret": RestAPI.clientSecret,
          "born_place": FacebookPermission.userHometown.toString(),
          "dob": FacebookPermission.userBirthday.toString(),
          "gender": FacebookPermission.userGender.toString(),
        };
        signIN(APis.facebookLogin, params, scaffoldKey, context);

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        GlobalWidgets()
            .showSnackBar(scaffoldKey, 'Facebook Login to  is Cancelled');
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        GlobalWidgets().showSnackBar(
            scaffoldKey, 'Facebook Login has  ${res.error}  occured');
        break;
    }
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
