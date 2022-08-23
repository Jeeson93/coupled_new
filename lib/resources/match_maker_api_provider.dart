import 'dart:convert';

import 'package:coupled/models/user_short_info_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class MatchMakerApiProvider {
  ///advance search result
  Future<UserShortInfoModel> getAdvanceSearch(params) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _token = prefs.getString('accessToken');
    print("api matchMaker------");
    var newUrl = prefs.getString("uri");

    /*final response = await http
        .get(Uri.parse('${APis.getAdvanceSearch}?$params'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $_token"
    });*/
    final response = await http.get(Uri.parse(newUrl!), headers: {
      "Accept": "application/json",
      'Content-type': 'application/json',
      "Authorization": "Bearer $_token"
    });

    /* print('${APis.getAdvanceSearch}?$params');
    print(response.body);*/
    if (response.statusCode == 200) {
      return UserShortInfoModel.fromJson(json.decode(response.body));
    } else {
      //GlobalWidgets().showToast(msg: 'No data found');
      Fluttertoast.showToast(
        fontSize: 18,
        backgroundColor: Colors.black,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        msg: "No matching profiles found",
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );

      throw Exception(response.body);
    }
  }
}

/*class MatchMakerGeneralPost {
  int ageMin;
  int ageMax;
  int heightMin;
  int heightMax;
  int weightMin;
  int weightMax;
  List<String> bodyType;
  List<String> complexion;
  List<String> country;
  List<String> state;
  List<String> city;
  List<String> maritalStatus;
  List<String> religion;
  List<String> cast;
  List<String> occupation;
  int experience;
  List<String> education;
  List<String> income;
  List<String> familyType;
  List<String> familyValues;
  String matchType;

  MatchMakerGeneralPost({
    this.ageMin,
    this.ageMax,
    this.heightMin,
    this.heightMax,
    this.weightMin,
    this.weightMax,
    this.bodyType,
    this.complexion,
    this.country,
    this.state,
    this.city,
    this.maritalStatus,
    this.religion,
    this.cast,
    this.occupation,
    this.experience,
    this.education,
    this.income,
    this.familyType,
    this.familyValues,
    this.matchType,
  });


  @override
  String toString() {
    return 'age_min=$ageMin&age_max=$ageMax&height_min=$heightMin&height_max=$heightMax&'
'weight_min=$weightMin&weight_max=$weightMax&body_type=$bodyType&complexion=$complexion&'
'country=$country&state=$state&city=$city&marital_status=$maritalStatus&'
'religion=$religion&cast=$cast&occupation=$occupation&experience=$experience&'
'education=$education&income=$income&family_type=$familyType&family_values=$familyValues&'
'match_type=$matchType';
  }

}*/
