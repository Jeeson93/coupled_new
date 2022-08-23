import 'dart:convert';
import 'dart:io';

import 'package:coupled/models/questions.dart';
import 'package:coupled/models/user.dart';
import 'package:coupled/src/coupled_global.dart';

Map<String, dynamic> getSectionOne() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['gender'] = GlobalData.myProfile.gender.toString();
  data['dob'] = GlobalData.myProfile.info!.dob.toString();
  data['dob_status'] = GlobalData.myProfile.info!.dobStatus.toString();
  data['weight'] = GlobalData.myProfile.info!.weight?.round();
  data['height'] = GlobalData.myProfile.info!.height?.round() ?? "";
  data['partner_height_min'] =
      GlobalData.myProfile.preference!.heightMin?.round() ?? "";
  data['partner_height_max'] =
      GlobalData.myProfile.preference!.heightMax?.round() ?? "";
  return data;
}

Map<String, dynamic> getSectionTwo() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['body_type'] = GlobalData?.myProfile.info!.bodyType?.id;
  data['complexion'] = GlobalData?.myProfile.info!.complexion?.id;
  data['partner_body_type'] = GlobalData.myProfile.preference!.bodyType?.id;
  data['partner_complexion'] = GlobalData.myProfile.preference!.complexion?.id;
  return data;
}

Map<String, dynamic> getSectionThree() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['marital_status'] = GlobalData.myProfile.info!.maritalStatus!.id;
  data['number_of_children'] = GlobalData.myProfile.info!.numberOfChildren;
  data['child_living_status'] =
      GlobalData.myProfile.info!.childLivingStatus?.id;
  data['special_case'] = GlobalData.myProfile.info!.specialCase;
  data['special_case_type'] = GlobalData.myProfile.info!.specialCaseType?.id;
  data['special_case_notify'] = GlobalData.myProfile.info!.specialCaseNotify;
  return data;
}

Map<String, dynamic> getSectionFour() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['country_code'] = GlobalData.myProfile.info!.countryCode;
  data['location_id'] = GlobalData.myProfile.info!.locationId;
  return data;
}

Map<String, dynamic> getSectionFive() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['born_place'] = GlobalData.myProfile.info!.bornPlace;
  data['dob'] = GlobalData.myProfile.info!.dob.toString();
  data['born_time'] = GlobalData.myProfile.info!.bornTime;
  return data;
}

Map<String, dynamic> getSectionSix(
    {bool isEdited = false,
    bool isDeleted = false,
    bool isDeletedback = false}) {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['file'] = {
    'govt_id_front': isEdited
        ? GlobalData?.myProfile?.officialDocuments?.govtIdFront ?? ""
        : isDeleted
            ? null
            : "hi",
    'govt_id_back': isEdited
        ? GlobalData?.myProfile?.officialDocuments?.govtIdBack ?? ""
        : isDeletedback
            ? null
            : "hi",
  };
  data['fields'] = {
    "govt_id_type":
        GlobalData.myProfile.officialDocuments!.govtIdType.toString(),
    "govt_id_front": isDeleted ? "null" : "hi",
    "govt_id_back": isDeletedback ? "null" : "hi",
  };
  return data;
}

Map<String, dynamic> getSectionSeven() {
  final Map<String, dynamic> data = Map<String, dynamic>();

  data['about_partner'] = GlobalData.myProfile.info!.aboutPartner;
  print(data);
  return data;
}

Map<String, dynamic> getSectionEight() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['about_self'] = GlobalData.myProfile.info!.aboutSelf;
  return data;
}

Map<String, dynamic> getSectionNine() {
  print('GlobalData.myProfile.address?.pincode----');
  print(GlobalData.myProfile.address?.pincode);
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['country_code'] = GlobalData.myProfile.address?.countryCode;
  data['location_id'] = GlobalData.myProfile.address?.locationId;
  data['address'] = GlobalData.myProfile.address?.address;
  data['pincode'] = GlobalData.myProfile.address?.pincode;
  data['tol_status'] = GlobalData.myProfile.address?.tolStatus;
  return data;
}

Map<String, dynamic> getSectionTen() {
  /// photoUpload Section
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['file'] = {'photo': GlobalData.myProfile.photoModel?.profileImageFile};

  ///TODO shit add,edit
  data['fields'] = UserPhotoModel(profileImageFile: File('')).toJson();
  print("Photograph output-------$data");
  return data;
}

Map<String, dynamic> getSectionEleven() {
  /* {
	"father_name": "FAU",
	"father_occupation_status": 26,
	"mother_name": "MAU",
	"mother_occupation_status": 26,
	"user_siblings": [{
			"sibling_name": "SNU",
			"profession": 26,
			"marital_status": 114
		},
		{
			"sibling_name": "BNU",
			"profession": 26,
			"marital_status": 114
		}
	]
}*/
  final Map<String, dynamic> data = Map<String, dynamic>();
  data["father_occupation_status"] =
      GlobalData.myProfile.family?.fatherOccupationStatus?.id;
  data["mother_occupation_status"] =
      GlobalData.myProfile.family?.motherOccupationStatus?.id;
  List<Map<String, dynamic>> siblingsList = [];
  GlobalData.myProfile.siblings?.forEach((f) {
    siblingsList.add({
      "sibling_role": f.role?.id,
      "profession": f.profession?.id,
      "marital_status": f.maritalStatus?.id
    });
  });
  data["user_siblings"] = json.encode(siblingsList);
  print("FamilyInfo A output-------$data");
  return data;
}

Map<String, dynamic> getSectionTwelve() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['family_type'] = GlobalData.myProfile.family?.familyType?.id ?? "";
  data['family_values'] = GlobalData.myProfile.family?.familyValues?.id ?? "";
  data['country_code'] = GlobalData.myProfile.family?.countryCode ?? "";
  data['location_id'] = GlobalData?.myProfile.family?.locationId == 0
      ? ""
      : GlobalData?.myProfile.family!.locationId ?? '';
  print("Section12 output-------$data");
  return data;
}

Map<String, dynamic> getSectionThirteen() {
  final Map<String, dynamic> data = Map();
  data['religion'] = GlobalData.myProfile.family?.religion?.id.toString() ?? "";
  data['cast'] = GlobalData.myProfile.family?.cast?.id.toString() ?? "";
  data['subcast'] = GlobalData.myProfile.family?.subcast?.id.toString() ?? "";
  data['gothram'] = GlobalData.myProfile.family?.gothram?.id.toString() ?? "";
  return data;
}

Map<String, dynamic> getProfEducationA(
    {bool isEdited = false,
    bool isDeleted = false,
    bool isTextedited = false}) {
  final Map<String, dynamic> data = Map<String, dynamic>();
  print("officeId");
  print(GlobalData.myProfile.officeId);
  print(isDeleted);
  var defaultparam;

  data['file'] = {
    'office_id': isEdited
        ? GlobalData.myProfile.officialDocuments?.officeId ?? ''
        : isDeleted
            ? null
            : "hi"
  };
  data['fields'] = {
    ///TODO api not responding

    //"company_name":GlobalData?.myProfile?.educationJob?.companyName.toString()=="null"?"Company name optional":GlobalData?.myProfile?.educationJob?.companyName,
    "company_name":
        GlobalData?.myProfile.educationJob?.companyName.toString() == "null"
            ? " "
            : GlobalData.myProfile.educationJob?.companyName.toString(),
    "industry": GlobalData?.myProfile.educationJob?.industry?.id.toString(),
    "profession": GlobalData?.myProfile.educationJob?.profession?.id.toString(),
    "job_status": GlobalData?.myProfile.educationJob?.jobStatus.toString(),
    "office_id": isDeleted ? "null" : "hi",
    // "type": ((GlobalData?.myProfile?.officialDocuments?.officeId!=null)&&
    //     (GlobalData?.myProfile?.officeId==null))?"save":"",
  };
  print("ProfEducationA------------");
  print(data);
  return data;
}

Map<String, dynamic> getProfEducationB() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['experience'] =
      GlobalData.myProfile.educationJob?.experience?.id.toString() ?? "";
  data['income_range'] =
      GlobalData.myProfile.educationJob?.incomeRange?.id.toString() ?? "";
  data['highest_education'] =
      GlobalData?.myProfile.educationJob?.highestEducation?.id.toString() ?? "";
  data['education_branch'] =
      GlobalData?.myProfile.educationJob?.educationBranch?.id.toString();
  print("ProfEducationB data------------ $data");
  return data;
}

///TODO all answers to be added to this shit
Map<String, dynamic> getCouplingSection() {
  Map<String, dynamic> data = Map<String, dynamic>();
  data["question_id"] = "1";
  data["answer"] = "1";
  print("object ::::: $data");
  Map<String, dynamic> a = {"question_id": "1", "answer": "1"};
  return a;
}
