import 'dart:io';

import 'package:coupled/Utils/Modals/SMC/smc_widget.dart';
import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  /// S= status
  /// T = Type
  /// Tn = Taken
  /// N = Notify
  /// V = value

  String token = '',
      id = '',
      fName = '',
      lName = '',
      email = '',
      gossip = '',
      pGossip = '',
      gender = '',
      dob = '',
      bornLocation = '',
      bornTime = '',
      childLivingS = '',
      country = '',
      city = '',
      state = '';
  String bodyType = '',
      pBodyType = '',
      complexion = '',
      pComplexion = '',
      isSpecialCase = '',
      specialCaseType = '',
      specialCaseNotify = '',
      maritalS = '',
      children = '',
      govtIdType = '';

  //familyInfoB
  String familyType = '',
      familyValues = '',
      familyCountry = '',
      familyLocationId = '';

  //ProfessionEducation A
  String companyName = '', industry = '', profession = '', isPresentJob = '';
  File officeId = File(''), govtIdFront = File(''), govtIdBack = File('');

//ProfessionEducation B
  String incomeRage = '', education = '', educationBranch = '';
  bool isOtpMatch = false;

  //living_seperate living_together
  double number = 0.0,
      pMinAge = 0.0,
      pMaxAge = 0.0,
      height = 0.0,
      weight = 0.0,
      pHeightMin = 0.0,
      pHeightMax = 0.0,
      pWeightMin = 0.0,
      pWeightMax = 0.0;
  CouplingQuestions couplingQuestions = CouplingQuestions();
  FamilyInfo familyInfo = FamilyInfo();
  UserPhotoModel profilePhoto = UserPhotoModel(profileImageFile: File(''));

//  Religious religious = Religious.initial();
  Location userLocation = Location(), familyLocation = Location();

  //EducationPro educationPro = EducationPro();
//  TOLInfo tolInfo = TOLInfo();

  //matchMaker
  List<String> mmBodyType = [];
  List<String> mmComplexion = [];
  List<String> mmCountry = [];
  List<String> mmState = [];
  List<String> mmCity = [];
  List<String> mmMaritalStatus = [];
  List<String> mmReligion = [];
  List<String> mmCast = [];
  List<String> mmOccupation = [];
  List<String> mmEducation = [];
  List<String> mmIncome = [];
  List<String> experience = [];
  List<String> mmFamilyType = [];
  List<String> mmFamilyValues = [];
  String mmQuestion_1 = '',
      mmQuestion_2 = '',
      mmAnswer_1 = '',
      mmAnswer_2 = '',
      mmScoreMin = '',
      mmScoreMax = '';

  User();

  User.initial() {
    dob = '';
    gender = 'male';
    pMinAge = 21;
    pMaxAge = 25;
    height = 165.0;
    weight = 50.0;
    complexion = '';
    pComplexion = '';
    isSpecialCase = '0';
    specialCaseType = '';
    specialCaseNotify = '0';
    pHeightMin = 165.0;
    pHeightMax = 200.0;
    pWeightMin = 45.0;
    pWeightMax = 70.0;
    bodyType = '';
    pBodyType = '';
    maritalS = '';
    children = '';
    childLivingS = '';
    gossip = '';
    pGossip = '';
  }

  /* bool checkSectionOne() {
    if (gender.isNotEmpty && height > 0 && weight > 0.0 && dob.isNotEmpty && pHeightMin > 0 && pHeightMax > 0)
      return true;
    else
      return false;
  }

  bool checkSectionTwo() {
    if (complexion != '' */ /*&& pComplexion != ''*/ /* && bodyType != '' */ /*&& pBodyType != ''*/ /*)
      return true;
    else
      return false;
  }

  bool checkPhotoSection() {
    if (profilePhoto.profileImageFile != null)
      return true;
    else
      return false;
  }

  bool checkSectionThree() {
    var done = 0;
    if (maritalS != '') {
      done = 1;
    } else {
      done = 0;
    }

    if (isSpecialCase == "1") {
      if (specialCaseType != '') {
        done += 1;
      } else {
        done = 0;
      }
    }
    return done > 0;
  }

  bool checkSectionFour() {
  	print(userLocation);
    if ( userLocation.country.name != null || userLocation.country.name.isNotEmpty && userLocation.state.name != null || userLocation.state.name.isNotEmpty && userLocation.city.name != null || userLocation.city.name.isNotEmpty)
      return true;
    else
      return false;
  }

  bool checkSectionFive() {
    if (bornLocation != '' && dob != '' && bornTime != null)
      return true;
    else
      return false;
  }

  bool checkSectionSix() {
    if (govtIdType == '0')
      return true;
    else if (govtIdType != '0' && govtIdFront != null && govtIdBack != null)
      return true;
    else
      return false;
  }

  bool checkSectionSeven() {
    if (pGossip.length > 0)
      return true;
    else
      return false;
  }

  bool checkSectionEight() {
    if (gossip.length > 0)
      return true;
    else
      return false;
  }

  bool checkSectionNine() {
    print(tolInfo.pincode.length>5);
    print(tolInfo.pincode);
    if (tolInfo.country != null &&
        tolInfo.state != null &&
        tolInfo.city != null &&
        tolInfo.address != null &&
        (tolInfo.pincode.length>5))
      return true;
    else
      return false;
  }*/

//  bool checkSectionThirteen() {
//    if (religious != null && religious.religion != '')
//      return true;
//    else
//      return false;
//  }

  /* bool checkSectionFourteen() {
	  print("PRINT checkSectionFourteen ${companyName.isNotEmpty} ${industry.isNotEmpty} ${profession.isNotEmpty}");
    if (companyName!=null && industry!=null && profession!=null)
      return true;
    else
      return false;
  }

  bool checkSectionFifteen() {
    if (experience.isNotEmpty && incomeRage.isNotEmpty && education.isNotEmpty)
      return true;
    else
      return false;
  }

  bool checkCouplingSection() {
    if (couplingQuestions.questionId != '' && couplingQuestions.answer != '' ||
        couplingQuestions.multiAnswer != null) {
      return true;
    }
    return false;
  }

  bool checkMOEVSection() {
    if (isOtpMatch) {
      return true;
    } else {
      return false;
    }
  }

  bool checkSectionSixteen() {
    return dob == '0';
  }*/

  String matchMakerParams() {
    return 'age_min=${pMinAge.round()}&age_max=${pMaxAge.round()}&height_min=${pHeightMin.round()}&height_max=${pHeightMax.round()}&'
        'weight_min=${pWeightMin.round()}&weight_max=${pWeightMax.round()}&body_type=$mmBodyType&complexion=$mmComplexion&'
        'country=$mmCountry&state=$mmState&city=$mmCity&marital_status=$mmMaritalStatus&'
        'religion=$mmReligion&cast=$mmCast&occupation=$mmOccupation&experience=$experience&'
        'education=$mmEducation&income=$mmIncome&family_type=$mmFamilyType&family_values=$mmFamilyValues&'
        'question_1=$mmQuestion_1&answer_1=$mmAnswer_1&question_2=$mmQuestion_2&answer_2=$mmAnswer_2&'
        'min_score=$mmScoreMin&max_score=$mmScoreMax';
  }

/*
  /// String:api_token,gender,dob;
  /// Int : height;partner_height_min; partner_height_max;
  /// weight;body_type; partner_body_type;complexion;
  /// partner_complexion;special_case;special_case_type;
  /// special_case_notify
  Map getPersonalInfo() {
    return {
      */
/*'api_token': token,*/ /*
      'gender': gender,
      'dob': dob,
      'height': height.round().toString(),
      'partner_height_min': pHeightMin.round().toString(),
      'partner_height_max': pHeightMax.round().toString(),
      'weight': weight.round().toString(),
      'body_type': bodyType.toString(),
      'partner_body_type': pBodyType.toString(),
      'complexion': complexion.toString(),
      'partner_complexion': pComplexion.toString(),
      'special_case': isSpecialCase.toString(),
      'special_case_type': specialCaseT.toString(),
      'special_case_notify': specialCaseN.toString(),
    };
  }

  ///String: api_token; Int : country; state;city
  Map getLocation() {
    return {'country': country.toString(), 'state': state.toString(), 'city': city.toString()};
  }

  ///String:api_token;child_living_status
  ///Int:number_of_children,marital_status;
  Map getMaritalStatus() {
    return {
      'marital_status': maritalS.toString(),
      'number_of_children': children.toString(),
      'child_living_status': childLivingS
    };
  }

  /// String:api_token;about_self
  Map getAboutYourSelf() {
    return {'about_self': gossip};
  }

  /// String:api_token;about_partner
  Map getAboutPartner() {
    return {'about_partner': pGossip};
  }

  ///Int:ids; fatherstatus;motherstatus; ftype; fvalue;
  ///json String contains multiple siblings(int:relation;estatus,mstatus,string:name)
  Map<String, Object> getFamilyInfo() {
    return {
      "father_name": familyInfo.fatherName,
      "fatherstatus": familyInfo.fatherS,
      "mother_name": familyInfo.motherName,
      "motherstatus": familyInfo.motherS,
      "ftype": familyInfo.familyT,
      "fvalue": familyInfo.familyV,
      "relation": json.encode(familyInfo.siblings),
      "country": familyInfo.country,
      "state": familyInfo.state,
      "city": familyInfo.city,
    };
  }

  Map<String, Object> getReligion() {
    return {
      "religion": religious.religion == '' ? '0' : religious.religion,
      "caste": religious.caste == 'Select Caste' ? '0' : religious.caste,
      "subcaste": religious.subCaste == 'Select Sub Caste' ? '0' : religious.subCaste,
      "gothram": religious.gothram == 'Select Gothram' ? '0' : religious.gothram,
    };
  }*/

//  @override
//  String toString() {
//    return 'User{token: $token, id: $id, fName: $fName, lName: $lName, email: $email, gossip: $gossip,'
//        ' pGossip: $pGossip, gender: $gender, dob: $dob,'
//        ' childLivingS: $childLivingS, bodyType: $bodyType, pBodyType: $pBodyType,'
//        ' complexion: $complexion, pComplexion: $pComplexion, isSpecialCase: $isSpecialCase,'
//        ' specialCaseT: $specialCaseT, specialCaseN: $specialCaseN, maritalS: $maritalS,'
//        ' children: $children, country: $country, city: $city, state: $state, number: $number,'
//        ' height: $height, weight: $weight, pHeightMin: $pHeightMin, pHeightMax: $pHeightMax,'
//        ' bornLocation: $bornLocation, bornTime: $bornTime, familyInfo: $familyInfo,'
//        ' religious: $religious, userLocation: $userLocation, familyLocation: $familyLocation,'
//        ' }';
//  }
}

class CouplingQuestions {
  String questionId = '', answer = '';
  Map<String, String> multiAnswer = {};

  @override
  String toString() {
    return 'CouplingQuestions{questionId: $questionId, answer: $answer, multiAnswer: $multiAnswer}';
  }
}

/*class TOLInfo {
  Item country = Item(), state = Item(), city = Item();
  String address, pincode;

  @override
  String toString() {
    return 'TOL{country: $country, state: $state, city: $city, address: $address, pincode: $pincode}';
  }
}*/

/*class FamilyInfo {
  String fatherName, motherName, fatherS, motherS, country, state, city, familyT, familyV;
  List<Map> siblings;
  var siblingJson = {};

  String getJsonSibling() {
    return json.encode(siblingJson);
  }

  @override
  String toString() {
    return 'FamilyInfo{fatherS: $fatherS, motherS: $motherS, country: $country,'
        ' state: $state, city: $city, familyT: $familyT, familyV: $familyV, siblings: $siblings}';
  }
}*/

class FamilyInfo {
  String fatherOccupationStatus;
  String motherOccupationStatus;
  List<UserSiblings> userSiblings = [];

  FamilyInfo(
      {this.fatherOccupationStatus = '',
      this.motherOccupationStatus = '',
      this.userSiblings = const <UserSiblings>[]});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    data['father_occupation_status'] = this.fatherOccupationStatus;
    data['mother_occupation_status'] = this.motherOccupationStatus;
    if (this.userSiblings != null) {
      data['user_siblings'] = this.userSiblings.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'FamilyInfo{ fatherOccupationStatus: $fatherOccupationStatus,'
        ' motherOccupationStatus: $motherOccupationStatus, userSiblings: $userSiblings}';
  }
}

class UserSiblings {
  String siblingName = '';
  String profession;
  String maritalStatus;
  String siblingRole;

  UserSiblings(
      {this.siblingRole = '', this.profession = '', this.maritalStatus = ''});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sibling_role'] = this.siblingRole;
    data['profession'] = this.profession;
    data['marital_status'] = this.maritalStatus;
    return data;
  }

  @override
  String toString() {
    return 'UserSiblings{ profession: $profession, maritalStatus: $maritalStatus, siblingType: $siblingRole}';
  }
}

class Location {
  Item country = Item(), state = Item(), city = Item();

  @override
  String toString() {
    return 'Location{country: $country, state: $state, city: $city}';
  }
}

class UserPhotoModel {
  final int id;
  bool isSelected, isProPic = false, isDelete = false;
  String imgName;
  File profileImageFile;
  String networkImgUrl;
  int photoT, photoTn;
  String photoT1, photoTn1;

  UserPhotoModel(
      {this.id = 0,
      this.isSelected = false,
      this.isProPic = false,
      this.imgName = '',
      required this.profileImageFile,
      this.networkImgUrl = '',
      this.photoT = 0,
      this.photoTn = 0,
      this.photoT1 = "",
      this.photoTn1 = ""});

  Map<String, String> toJson() {
    final Map<String, String> data = Map();
    data['type'] = "add";
    data['from_type'] = "gallery";
    data['image_type'] = this.photoT.toString();
    data['image_taken'] = this.photoTn.toString();
    print("image_type------------------------");
    print(data);
    return data;
  }

  String getPhotoT() {
    if (photoT == 0) {
      return 'Add Picture';
    } else {
      return photoT1;
    }
  }

  String getPhotoTn() {
    return photoTn1;
  }

  @override
  String toString() {
    return 'PhotoModel{id: $id, isSelected: $isSelected, isProPic: $isProPic, isDelete: $isDelete, imgName: $imgName, imageFile: $profileImageFile, networkImgUrl: $networkImgUrl, photoT: $photoT, photoTn: $photoTn, photoT1: $photoT1, photoTn1: $photoTn1}';
  }

/* *index: $index,*/
}

/*
class Religious {
  bool isSelected;
  String religion = '', caste = 'Select Cast', subCaste = 'Select Sub Cast', gothram = 'Select Gothram';
  String imagePath, name, id;

//  List<String> subCaste = ['Nair', 'Ezhava', 'Namboori', 'Kudumbi'];
//  List<String> gothram = ['Nair', 'Ezhava', 'Namboori', 'Kudumbi'];

  Religious.initial();

  Religious(
    this.isSelected,
    this.id,
    this.imagePath,
    this.name,
  );
}
*/

/*class EducationPro {
  ///String:api_token;company;desig;office;
  ///int:exp;occupation;edu,income;career_status,profession,ugc;pgc
  File officeId;
  String companyName, industry, profession, experience, occupation, education, income, ugc, pgc,isPresentJob;

  EducationPro({this.officeId, this.companyName, this.industry, this.profession, this.experience, this.occupation,
      this.education, this.income, this.ugc, this.pgc, this.isPresentJob});


  Map<String, dynamic> professionAtoJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['company_name'] = this.companyName;
    data['industry'] = this.industry;
    data['profession'] = this.profession;
    data['job_status'] = this.isPresentJob;
    return data;
  }

  @override
  String toString() {
    return 'EducationPro{companyName: $companyName, industry: $industry, profession: $profession, isPresentJob: $isPresentJob}';
  }


}*/

//Recommendations
//TODO add recommendation to user
class ReasonsModel {
  String text;
  int count, id;
  bool isChecked;

  ReasonsModel(
      {this.id = 0, this.text = '', this.count = 0, this.isChecked = false});

  @override
  String toString() {
    return 'ReasonsModel{id: $id,text: $text, count: $count, isChecked: $isChecked}';
  }
}

//TopUpPlans
////TODO add TopUpPlans to user
//class TopUpPlans {
//  String plans, validity, credits, id;
//  bool isChecked;
//
//  TopUpPlans({this.plans, this.validity, this.credits, this.isChecked, this.id});
//
//  @override
//  String toString() {
//    return 'TopUpPlans{plans: $plans, validity: $validity, credits: $credits, isChecked: $isChecked}';
//  }
//}
