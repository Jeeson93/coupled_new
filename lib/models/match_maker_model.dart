import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'match_maker_model.g.dart';

@JsonSerializable(
    includeIfNull: true,
    createToJson: true,
    createFactory: true,
//		explicitToJson: true,
    disallowUnrecognizedKeys: false,
    fieldRename: FieldRename.snake)
class MatchMakerModel {
  @JsonKey(defaultValue: 0)
  int id;
  @JsonKey(defaultValue: 0)
  int userId;
  @JsonKey(defaultValue: "")
  String matchType;
  @JsonKey(defaultValue: 0)
  int ageMin;

  @JsonKey(defaultValue: 0)
  int ageMax;

  @JsonKey(defaultValue: 0)
  int heightMin;
  @JsonKey(defaultValue: 0)
  int heightMax;
  @JsonKey(defaultValue: 0)
  int weightMin;
  @JsonKey(defaultValue: 0)
  int weightMax;
  @JsonKey(defaultValue: [])
  List<String> bodyType;
  @JsonKey(defaultValue: [])
  List<String> complexion;
  @JsonKey(defaultValue: [])
  List<String> country;
  @JsonKey(defaultValue: [])
  List<String> state;
  @JsonKey(defaultValue: [])
  List<String> city;
  @JsonKey(defaultValue: [])
  List<String> maritalStatus;
  @JsonKey(defaultValue: [])
  List<String> religion;
  @JsonKey(defaultValue: [])
  List<String> cast;
  @JsonKey(defaultValue: [])
  List<String> occupation;
  @JsonKey(defaultValue: 0)
  int experience;
  @JsonKey(defaultValue: 0)
  int active;
  @JsonKey(defaultValue: [])
  List<String> education;
  @JsonKey(defaultValue: [])
  List<String> income;
  @JsonKey(defaultValue: [])
  List<String> familyType;
  @JsonKey(defaultValue: [])
  List<String> familyValues;
  @JsonKey(defaultValue: 0)
  int minScore;
  @JsonKey(defaultValue: 0)
  int maxScore;
  @JsonKey(defaultValue: 0)
  int question_1;
  @JsonKey(defaultValue: 0)
  int answer_1;
  @JsonKey(defaultValue: 0)
  int question_2;
  @JsonKey(defaultValue: 0)
  int answer_2;
  @JsonKey(defaultValue: 0)
  int deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  @JsonKey(ignore: true)
  int generalCount = 0;
  @JsonKey(ignore: true)
  int couplingCount = 0;
  @JsonKey(ignore: true)
  int mixCount = 0;

  MatchMakerModel.initial(
      {this.id = 0,
      this.userId = 0,
      this.matchType = '',
      this.ageMin = 0,
      this.ageMax = 0,
      this.heightMin = 0,
      this.heightMax = 0,
      this.weightMin = 0,
      this.weightMax = 0,
      this.experience = 0,
      this.active = 0,
      this.minScore = 0,
      this.maxScore = 0,
      this.question_1 = 0,
      this.answer_1 = 0,
      this.question_2 = 0,
      this.answer_2 = 0,
      this.deletedAt = 0,
      this.createdAt,
      this.updatedAt})
      : bodyType = [],
        complexion = [],
        country = [],
        state = [],
        city = [],
        maritalStatus = [],
        religion = [],
        cast = [],
        occupation = [],
        education = [],
        income = [],
        familyType = [],
        familyValues = [];

  MatchMakerModel.clearAll(
      {this.id = 0,
      this.userId = 0,
      this.matchType = '',
      this.ageMin = 0,
      this.ageMax = 0,
      this.heightMin = 0,
      this.heightMax = 0,
      this.weightMin = 0,
      this.weightMax = 0,
      this.experience = 0,
      this.active = 0,
      this.minScore = 0,
      this.maxScore = 0,
      this.question_1 = 0,
      this.answer_1 = 0,
      this.question_2 = 0,
      this.answer_2 = 0,
      this.deletedAt = 0,
      this.createdAt,
      this.updatedAt})
      : bodyType = [],
        complexion = [],
        country = [],
        state = [],
        city = [],
        maritalStatus = [],
        religion = [],
        cast = [],
        occupation = [],
        education = [],
        income = [],
        familyType = [],
        familyValues = [];

  MatchMakerModel({
    required this.id,
    required this.userId,
    required this.matchType,
    required this.ageMin,
    required this.ageMax,
    required this.heightMin,
    required this.heightMax,
    required this.weightMin,
    required this.weightMax,
    required this.bodyType,
    required this.complexion,
    required this.country,
    required this.state,
    required this.city,
    required this.maritalStatus,
    required this.religion,
    required this.cast,
    required this.occupation,
    required this.experience,
    required this.education,
    required this.income,
    required this.active,
    required this.familyType,
    required this.familyValues,
    required this.minScore,
    required this.maxScore,
    required this.question_1,
    required this.answer_1,
    required this.question_2,
    required this.answer_2,
    required this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory MatchMakerModel.fromJson(Map<String, dynamic> json) =>
      _$MatchMakerModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchMakerModelToJson(this);

  /*String matchMakerParams() {
    var cities;

    print("machu");


    if(city.isEmpty){
      cities="&city=";
    }
    else{
      cities= "&city[]=";
    }
    print(state.toString().replaceAll("[", "").replaceAll("]", ""));









    return 'match_type=$matchType&age_min=${json.encode(ageMin)}&'
        'age_max=${json.encode(ageMax)}&height_min=${json.encode(heightMin)}&height_max=${json.encode(heightMax)}&weight_min=${json.encode(weightMin)}&'
        'weight_max=${json.encode(weightMax)}&body_type[]=${bodyType.toString().replaceAll("[", "").replaceAll("]", "")}&complexion[]=${complexion.toString().replaceAll("[", "").replaceAll("]", "")}&country[]=${country.isEmpty ? '' : country.toString().replaceAll("[", "").replaceAll("]", "")}&'
        'state[]=${state.isEmpty ? '' : state.toString().replaceAll("[", "").replaceAll("]", "")}${cities.toString()}${city.isEmpty ? "": city.toString().replaceAll("[", "").replaceAll("]", "")}&marital_status[]=${maritalStatus.toString().replaceAll("[", "").replaceAll("]", "")}&religion[]=${religion.toString().replaceAll("[", "").replaceAll("]", "")}&'
        'cast[]=${cast.toString().replaceAll("[", "").replaceAll("]", "")}&occupation[]=${occupation.toString().replaceAll("[", "").replaceAll("]", "")}&experience=${json.encode(experience)}&education[]=${education.toString().replaceAll("[", "").replaceAll("]", "")}&'
        'income[]=${income.toString().replaceAll("[", "").replaceAll("]", "")}&active=${json.encode(active)}&family_type[]=${familyType.toString().replaceAll("[", "").replaceAll("]", "")}&family_values[]=${familyValues.toString().replaceAll("[", "").replaceAll("]", "")}&min_score=${json.encode(minScore)}&'
        'max_score=${json.encode(maxScore)}&question_1=${json.encode(question_1)}&answer_1=${json.encode(answer_1)}&question_2=${json.encode(question_2)}&'
        'answer_2=${json.encode(answer_2)}';


  }*/

  String matchMakerParams() {
    fetchData();

    /*  return 'match_type=$matchType&age_min=${json.encode(ageMin)}&'
        'age_max=${json.encode(ageMax)}&height_min=${json.encode(heightMin)}&height_max=${json.encode(heightMax)}&weight_min=${json.encode(weightMin)}&'
        'weight_max=${json.encode(weightMax)}&body_type[]=${json.encode(bodyType)}&complexion[]=${json.encode(complexion)}&country[]=${country.isEmpty ? '' : json.encode(country)}&'
        'state[]=$state&city[]=${city.isEmpty ? '' : json.encode(city)}&marital_status[]=${json.encode(maritalStatus)}&religion[]=${json.encode(religion)}&'
        'cast[]=${json.encode(cast)}&occupation[]=${json.encode(occupation)}&experience[]=${json.encode(experience)}&education[]=${json.encode(education)}&'
        'income[]=${json.encode(income)}&active=${json.encode(active)}&family_type[]=${json.encode(familyType)}&family_values[]=${json.encode(familyValues)}&min_score=${json.encode(minScore)}&'
        'max_score=${json.encode(maxScore)}&question_1=${json.encode(question_1)}&answer_1=${json.encode(answer_1)}&question_2=${json.encode(question_2)}&'
        'answer_2=${json.encode(answer_2)}';*/
    return '';
  }

  Future fetchData() async {
    var states;
    var cities;
    var bodytpes;
    var complexions;
    var actives;
    var maritalstatuses;
    var religions;
    var casts;
    var minscores;
    var maxscores;
    var questions1;
    var answers1;
    var questions2;
    var answers2;
    var occupations;
    var experiences;
    var educations;
    var incomes;
    var familytypes;
    var familyvalues;

    if (familyValues.isEmpty) {
      familyvalues = "family_value[]";
    } else {
      familyvalues = "family_values[]";
    }

    if (familyType.isEmpty) {
      familytypes = "family_types[]";
    } else {
      familytypes = "family_type[]";
    }
    if (income.isEmpty) {
      incomes = "incomes[]";
    } else {
      incomes = "income[]";
    }

    if (occupation.isEmpty) {
      occupations = "occupations[]";
    } else {
      occupations = "occupation[]";
    }

    if (education.isEmpty) {
      educations = "educations[]";
    } else {
      educations = "education[]";
    }

    if (experience.toString().isEmpty) {
      experiences = "experiences[]";
    } else {
      experiences = "experience[]";
    }
    if (question_1.toString().isEmpty) {
      questions1 = "questions_1";
    } else {
      questions1 = "question_1";
    }

    if (answer_1.toString().isEmpty) {
      answers1 = "answers_1";
    } else {
      answers1 = "answer_1";
    }

    if (question_2.toString().isEmpty) {
      questions2 = "questions_2";
    } else {
      questions2 = "question_2";
    }

    if (answer_2.toString().isEmpty) {
      answers2 = "answers_2";
    } else {
      answers2 = "answer_2";
    }

    if (minScore.toString().isEmpty) {
      minscores = "min_scores";
    } else {
      minscores = "min_score";
    }

    if (maxScore.toString().isEmpty) {
      maxscores = "max_scores";
    } else {
      maxscores = "max_score";
    }

    if (cast.isEmpty) {
      casts = "casts[]";
    } else {
      casts = "cast[]";
    }

    if (religion.isEmpty) {
      religions = "religions[]";
    } else {
      religions = "religion[]";
    }

    if (maritalStatus.isEmpty) {
      maritalstatuses = "marital_statuses[]";
    } else {
      maritalstatuses = "marital_status[]";
    }

    if (active.toString().isEmpty) {
      actives = "actives";
    } else {
      actives = "active";
    }

    if (complexion.isEmpty) {
      complexions = "complexions[]";
    } else {
      complexions = "complexion[]";
    }

    if (bodyType.isEmpty) {
      bodytpes = "body_types[]";
    } else {
      bodytpes = "body_type[]";
    }

    if (state.isEmpty) {
      states = "states[]";
    } else {
      states = "state[]";
    }

    print("machu");

    if (city.isEmpty) {
      cities = "cities[]";
    } else {
      cities = "city[]";
    }

    try {
      String newagemin = ageMin.toString();
      String newagemax = ageMax.toString();

      String newheightmin = heightMin.toString();
      String newheightmax = heightMax.toString();

      String newweightmin = weightMin.toString();
      String newweightmax = weightMax.toString();

      String newactive = active.toString();

      String newminscore = minScore.toString();
      String newmaxscore = maxScore.toString();

      String newquestion1 = question_1.toString();
      String newanswer1 = answer_1.toString();

      String newquestion2 = question_2.toString();
      String newanswer2 = answer_2.toString();

      String newexperience = experience.toString();

      print("origi");
      print(newagemin);
      print(newagemax);
      print(newheightmin);
      print(newheightmax);
      print(newweightmin);
      print(newweightmax);
      print(state);
      print(city);
      print(bodyType);
      print(complexion);
      print(maritalStatus);
      print(religion);
      print(cast);
      print(newminscore);
      print(newmaxscore);
      print(newquestion1);
      print(newanswer1);
      print(newquestion2);
      print(newanswer2);

      print(occupation);
      print(experience);
      print(education);
      print(income);
      print(familyType);
      print(familyValues);

      var uri = Uri(
        scheme: 'https',
        host: 'admin.coupled.in',
        path: '/api/advancesearch',
        queryParameters: {
          // 'match_type': matchType,
          'age_min': newagemin,
          'age_max': newagemax,
          'height_min': newheightmin,
          'height_max': newheightmax,
          'weight_min': newweightmin,
          'weight_max': newweightmax,
          'country[]': 'IN',
          states: state,
          cities: city,
          bodytpes: bodyType,
          complexions: complexion,

          maritalstatuses: maritalStatus,
          religions: religion,
          casts: cast,
          minscores: newminscore,
          maxscores: newmaxscore,
          questions1: newquestion1,
          answers1: newanswer1,
          questions2: newquestion2,
          answers2: newanswer2,

          occupations: occupation,
          actives: newactive,
          experiences: newexperience,
          educations: education,
          incomes: income,
          familytypes: familyType,
          familyvalues: familyValues,
        },
      );
      print("hghghg");
      print(uri);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("uri", uri.toString());

      print('uri====$uri');
      /*Response response = await http.get(uri, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });

      var data = jsonDecode(response.body);
      var UserData = data['response']['data'];

      print('user======$UserData');
      return UserData;*/
    } catch (Exception) {
      print("Exception");
      print(Exception);
    }
  }

  @override
  String toString() {
    return 'MatchMakerModel{id: $id, userId: $userId, matchType: $matchType, ageMin: $ageMin,'
        ' ageMax: $ageMax, heightMin: $heightMin, heightMax: $heightMax, weightMin: $weightMin,'
        ' weightMax: $weightMax, bodyType: $bodyType, complexion: $complexion, country: $country,'
        ' state: $state, city: $city, maritalStatus: $maritalStatus, religion: $religion,'
        ' cast: $cast, occupation: $occupation, experience: $experience, education: $education,'
        ' income: $income,active: $active, familyType: $familyType, familyValues: $familyValues, minScore: $minScore,'
        ' maxScore: $maxScore, question1: $question_1, answer1: $answer_1, question2: $question_2,'
        ' answer2: $answer_2, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
