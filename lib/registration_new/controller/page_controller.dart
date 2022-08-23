import 'package:coupled/registration_new/reg_steps/Family/FamilyInfoA.dart';
import 'package:coupled/registration_new/reg_steps/Family/FamilyInfoB.dart';
import 'package:coupled/registration_new/reg_steps/MOEVerification.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section1.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section2.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section3.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section4.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section5.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section6.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section7.dart';
import 'package:coupled/registration_new/reg_steps/PersonalDetailSections/Section8.dart';
import 'package:coupled/registration_new/reg_steps/PhotoGraphs/PhotoA.dart';
import 'package:coupled/registration_new/reg_steps/Pro_Edu/Pro_EduA.dart';
import 'package:coupled/registration_new/reg_steps/Pro_Edu/Pro_EduB.dart';
import 'package:coupled/registration_new/reg_steps/Religion/ReligionA.dart';
import 'package:coupled/registration_new/reg_steps/SecondWelcomeScreen.dart';
import 'package:coupled/registration_new/reg_steps/TOL.dart';
import 'package:coupled/registration_new/reg_steps/coupling_questions/coupling_question.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

List registrationPages = [
  ///gender,height,weight
  SectionOne.route,

  ///complexion
  SectionTwo.route,

  ///marital status
  SectionThree.route,

  ///location
  SectionFour.route,

  ///kundali
  SectionFive.route,

  ///user id
  SectionSix.route,

  ///about partner
  SectionSeven.route,

  ///about me
  SectionEight.route,

  ///9
  TOL.route,

  ///10
  PhotoA.route,

  ///11
  FamilyInfoA.route,

  ///12
  FamilyInfoB.route,

  ///13
  ReligionA.route,

  ///14
  ProEduA.route,

  ///15
  ProEduB.route,

  ///16
  SecondWelcomeScreen.route,

  ///17
  CouplingScoreQuestions.route,

  ///18
  MOEVerification.route,
];

regPageController(BuildContext context, {int step = 1}) {
  print('appRegistrationStep----------');
  print(GlobalData.myProfile.usersBasicDetails?.appRegistrationStep);

  if ((GlobalData.myProfile.usersBasicDetails?.appRegistrationStep ?? 0) >=
      17) {
    GlobalData.myProfile.usersBasicDetails?.appRegistrationStep = 18;
  }

  ///profile edit section
  if (step != null) {
    print('1');
    Navigator.pushNamed(context, registrationPages[step - 1]);
  } else if (GlobalData.myProfile.usersBasicDetails?.appRegistrationStep ==
      null) {
    print('2');
    Navigator.pushNamed(context, registrationPages[0]);
  } else {
    print('appRegistrationStep----------');
    print('3');
    Navigator.pushNamed(
        context,
        registrationPages[
            GlobalData.myProfile.usersBasicDetails?.appRegistrationStep - 1]);
    // 15]);
  }
}
