import 'package:coupled/models/profile.dart';
import 'package:coupled/src/coupled_global.dart';

bool registerValidator({required int step}) {
  print("PAGENO. $step");
  switch (step) {
    case 1:
      return checkSectionOne(GlobalData.myProfile);
    case 2:
      return checkSectionTwo(GlobalData.myProfile);
    case 3:
      return checkSectionThree(GlobalData.myProfile);
    case 4:
      return checkSectionFour(GlobalData.myProfile);
    case 5:
      return true;
      return checkSectionFive(GlobalData.myProfile);
    case 6:
      return checkSectionSix(GlobalData.myProfile);
    case 7:
      return checkSectionSeven(GlobalData.myProfile);
    case 8:
      return checkSectionEight(GlobalData.myProfile);
    case 9:
      var v = checkSectionNine(GlobalData.myProfile);
      print(v);
      return v;
    case 10:
      //TODO
      return checkPhotoSection(GlobalData.myProfile);
    //return true;
    case 11:

      ///familyA is an optional case
      return true;
    case 12:

      ///familyB is an optional case
      return true;
    case 13:
      return checkSectionThirteen(GlobalData.myProfile);
    case 14:
      return checkSectionFourteen(GlobalData.myProfile);
    case 15:
      return checkSectionFifteen(GlobalData.myProfile);

    ///TODO Coupling question shit
    case 16:
      return true;
    case 32:
      return checkMOEVSection(GlobalData.myProfile);
    case 33:
      return true;
  }
  if (step >= 16 && step <= 31) {
    print("pageSubmitter");
    //return checkCouplingSection(page - 16, GlobalData.myProfile.couplingQProfileResponse);
    return true;
  }
  return false;
}

bool checkSectionOne(ProfileResponse profileResponse) {
  if (profileResponse.gender != null &&
      (profileResponse.info?.height)! > 0 &&
      profileResponse.info!.weight! > 0 &&
      profileResponse.info!.dob != null &&
      (profileResponse.preference?.heightMin)!.toInt() > 0 &&
      (profileResponse.preference!.heightMax)!.toInt() > 0)
    return true;
  else
    return false;
}

bool checkSectionTwo(ProfileResponse profileResponse) {
  if (profileResponse.info!.complexion?.id != 0 /*&& pComplexion != ''*/ &&
      profileResponse.info!.bodyType?.id != 0 /*&& pBodyType != ''*/)
    return true;
  else
    return false;
}

bool checkSectionThree(ProfileResponse profileResponse) {
  var done = 0;
  if (profileResponse.info?.maritalStatus!.id != 0) {
    done = 1;
  } else {
    done = 0;
  }

  if (profileResponse.info!.specialCase == 1) {
    if (profileResponse.info?.specialCaseType?.id != 0) {
      done += 1;
    } else {
      done = 0;
    }
  }
  return done > 0;
}

bool checkSectionFour(ProfileResponse profileResponse) {
  if (profileResponse.info!.countryCode != null &&
      profileResponse.info!.locationId != null) {
    print(
        "Country INfo :: ${profileResponse.info?.countryCode} ${profileResponse.info?.locationId}");
    return true;
  } else
    return false;
}

bool checkSectionFive(ProfileResponse profileResponse) {
  if (profileResponse.info!.bornPlace.isNotEmpty &&
      profileResponse.info!.dob!.toIso8601String().isNotEmpty &&
      profileResponse?.info?.bornTime != null)
    return true;
  else
    return false;
}

bool checkSectionSix(ProfileResponse profileResponse) {
  // if (profileResponse.officialDocuments.govtIdType == 0)
  //    return true;
  //  else if (profileResponse.officialDocuments.govtIdType != 0 &&
  //      profileResponse.officialDocuments.govtIdFront != null &&
  //      profileResponse.officialDocuments.govtIdBack != null)
  //    return true;
  //  else
  return true;
}

bool checkSectionSeven(ProfileResponse profileResponse) {
  if (profileResponse.info?.aboutPartner?.trim() != null)
    return true;
  else
    return false;
}

bool checkSectionEight(ProfileResponse profileResponse) {
  if (profileResponse.info?.aboutSelf?.trim() != null)
    return true;
  else
    return false;
}

bool checkSectionNine(ProfileResponse profileResponse) {
  print("address : ${profileResponse.address}");
  if (profileResponse.address!.tolStatus == 1) {
    if (profileResponse.address!.country != null &&
        profileResponse.address!.state != null &&
        profileResponse.address!.city != null &&
        profileResponse.address!.address.trim().isNotEmpty &&
        profileResponse.address!.pincode.toString().length > 5 &&
        profileResponse.address!.pincode.toString().length < 9)
      return true;
    else
      return false;
  } else
    return true;
}

bool checkSectionTen(ProfileResponse profileResponse) {
  print("profileResponse.photos.length");
  print(profileResponse.photoData.length);
  if (profileResponse.photoData.length != null &&
      profileResponse.photoData.length >= 3)
    return true;
  else
    return false;
}

bool checkPhotoSection(ProfileResponse profileResponse) {
  if (GlobalData.myProfile.photoData.length > 3) {
    return true;
  } else {
    return false;
  }
}

bool checkSectionThirteen(ProfileResponse profileResponse) {
  print(profileResponse.family?.religion?.id);
  if (profileResponse.family?.religion?.id != null &&
      profileResponse.family?.religion?.id.toString() != '')
    return true;
  else
    return false;
}

bool checkSectionFourteen(ProfileResponse profileResponse) {
  print(
      "PRINT checkSectionFourteen ${profileResponse?.educationJob?.companyName?.isNotEmpty}"
      " ${profileResponse.educationJob?.industry?.value?.isNotEmpty}"
      " ${profileResponse.educationJob?.profession?.value?.isNotEmpty}");
  if (profileResponse.educationJob?.industry?.id != null &&
      profileResponse.educationJob?.profession?.id != null)
    return true;
  else
    return false;
}

bool checkSectionFifteen(ProfileResponse profileResponse) {
  if (profileResponse.educationJob?.experience != null &&
      profileResponse.educationJob?.incomeRange != null &&
      profileResponse.educationJob?.highestEducation != null)
    return true;
  else
    return false;
}

bool checkCouplingSection(int index, List<UserCoupling> userCoupling) {
  print('checkCouplingSection :: $index $userCoupling');
  if (userCoupling != null && userCoupling.isNotEmpty) {
    if (userCoupling.any((element) => element.qType == 'multi') &&
        userCoupling.length != 2)
      return false;
    else
      return true;
  } else {
    return false;
  }
}

bool checkMOEVSection(ProfileResponse profileResponse) {
  if (profileResponse.userEmail.isNotEmpty ||
      profileResponse.userPhone.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
