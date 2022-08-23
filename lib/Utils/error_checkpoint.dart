import 'package:coupled/Utils/global_widgets.dart';
import 'package:flutter/material.dart';

class ErrorCheckPoint {
  bool validatePassword(
      GlobalKey<ScaffoldState> _scaffoldKey, String password) {
    if (password.length < 8) {
      GlobalWidgets()
          .showSnackBar(_scaffoldKey, 'Password should be 8 characters');
      return false;
    } else
      return true;
  }

  bool validateEmailId(GlobalKey<ScaffoldState> _scaffoldKey, String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(email)) {
      GlobalWidgets().showSnackBar(_scaffoldKey, 'Enter Valid Email');
      return false;
    } else
      return true;
  }

  bool validatePhone(GlobalKey<ScaffoldState> _scaffoldKey, String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10) {
      GlobalWidgets()
          .showSnackBar(_scaffoldKey, 'Mobile Number must be of 10 digit');
      return false;
    } else
      return true;
  }

  bool validateEoM(GlobalKey<ScaffoldState> _scaffoldKey, String value) {
    Pattern pattern = r'^[0-9]+$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value))
      return validateEmailId(_scaffoldKey, value);
    else
      return validatePhone(_scaffoldKey, value);
  }
}
