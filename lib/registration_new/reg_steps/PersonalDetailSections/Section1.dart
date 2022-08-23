import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/amimations.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';

import 'package:coupled/registration_new/app_bar.dart';
import 'package:coupled/registration_new/get_bottom_button.dart';
import 'package:coupled/registration_new/helpers/get_section_data.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SectionOne extends StatefulWidget {
  static String route = 'SectionOne';

  @override
  _SectionOneState createState() => _SectionOneState();
}

class _SectionOneState extends State<SectionOne>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<SectionOne> {
  late AnimationController _controller;
  var age = "Age";
  TextEditingController dobController = TextEditingController();
  late DateTime initialDate;
  late DateTime selectedDate;
  bool colour = false;

  ProfileResponse profileResponse = ProfileResponse(
      usersBasicDetails: UsersBasicDetails(),
      mom: Mom(),
      info: Info(maritalStatus: BaseSettings(options: [])),
      preference: Preference(complexion: BaseSettings(options: [])),
      officialDocuments: OfficialDocuments(),
      address: Address(),
      photoData: [],
      photos: [],
      family: Family(
          fatherOccupationStatus: BaseSettings(options: []),
          cast: BaseSettings(options: []),
          familyType: BaseSettings(options: []),
          familyValues: BaseSettings(options: []),
          gothram: BaseSettings(options: []),
          motherOccupationStatus: BaseSettings(options: []),
          religion: BaseSettings(options: []),
          subcast: BaseSettings(options: [])),
      educationJob: EducationJob(
          educationBranch: BaseSettings(options: []),
          experience: BaseSettings(options: []),
          highestEducation: BaseSettings(options: []),
          incomeRange: BaseSettings(options: []),
          industry: BaseSettings(options: []),
          profession: BaseSettings(options: [])),
      membership: Membership.fromMap({}),
      userCoupling: [],
      dp: Dp(
          photoName: '',
          imageType: BaseSettings(options: []),
          imageTaken: BaseSettings(options: []),
          userDetail: UserDetail(membership: Membership(paidMember: false))),
      blockMe: Mom(),
      reportMe: Mom(),
      freeCoupling: [],
      recomendCause: [],
      shortlistByMe: Mom(),
      shortlistMe: Mom(),
      photoModel: PhotoModel(),
      currentCsStatistics: CurrentCsStatistics(),
      siblings: []);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);
    profileResponse = GlobalData.myProfile;

    print("linger");
    print(profileResponse.info?.dob ?? '');
    print(profileResponse.preference?.heightMin ?? '');
    print(profileResponse.preference?.heightMax ?? "");
    profileResponse.gender.toLowerCase() == 'male'
        ? _controller.reverse()
        : _controller.forward();
    int startYearFrom =
        profileResponse.gender.toLowerCase() == 'male' ? 21 : 18;
    initialDate = DateTime(DateTime.now().year - startYearFrom,
        DateTime.now().month, DateTime.now().day);
    selectedDate = DateTime(DateTime.now().year - startYearFrom,
        DateTime.now().month, DateTime.now().day);
    if (profileResponse.info != null) {
      print("rttt");
      profileResponse.info?.dob == null
          ? dobController.text = ""
          : dateFormatter(profileResponse.info?.dob);

      profileResponse.info = Info(
        maritalStatus: BaseSettings(options: []),
        dob: profileResponse.info?.dob,
        dobStatus: profileResponse.info!.dobStatus,
        height: profileResponse.info?.height ?? 165,
        weight: profileResponse.info?.weight ?? 50,
      );
      profileResponse.preference = Preference(
          heightMin: profileResponse.preference!.heightMin ?? 165,
          heightMax: profileResponse.preference!.heightMax ?? 200,
          weightMin: profileResponse.preference!.weightMin ?? 45,
          weightMax: profileResponse.preference!.weightMax ?? 70,
          complexion: BaseSettings(options: []));
    } else {
      print("rick");
      profileResponse.info = Info(
        maritalStatus: BaseSettings(options: []),
        height: 165,
        weight: 50,
      );

      profileResponse.preference = Preference(
          heightMin: 165,
          heightMax: 200,
          weightMin: 45,
          weightMax: 70,
          complexion: BaseSettings(options: []));
    }

/*
    if (profileResponse.info != null) {
      print('info not null : ${profileResponse?.info?.dob}');

      profileResponse?.info?.dob == null
          ? dobController.text = ""
          : dateFormatter(profileResponse?.info?.dob);
    } else {
      profileResponse?.info = Info(
        height: 165,
        weight: 50,
      );

      profileResponse?.preference = Preference(
          heightMin: 165, heightMax: 200, weightMin: 45, weightMax: 70);
    }*/

    super.initState();
  }

  String convertFeet(double centi) {
    String value;
//    setState(() {
    double val = 0.3937 * centi;
    int foot = (val / 12).truncate();
    int inch = (val % 12).truncate();
//    double feet = 0.0328 * centi;
//      String inch = (0.3937 * centi).round().toString();
//      List<String> feet = val.split('.');
    value = "$foot\'$inch\"";
//      print("Feet is: $foot\'$inch\"");
//    });

    return value;
  }

  dateFormatter(DateTime? date) {
    setState(() {
      selectedDate = date!;
      dobController.text = "${GlobalWidgets().dateFormatter(selectedDate)}";
      print("dobController ${dobController.text}");
      age = "${GlobalWidgets().getAge(selectedDate)}";
      profileResponse.info!.dob = selectedDate;
    });
  }

  _selectDate(BuildContext context) {
    int startYearFrom =
        profileResponse.gender.toLowerCase() == 'male' ? 21 : 18;
    initialDate = DateTime(DateTime.now().year - startYearFrom,
        DateTime.now().month, DateTime.now().day);
    DatePicker.showDatePicker(context,
        theme: DatePickerTheme(
          containerHeight: 210.0,
        ),
        showTitleActions: true,
        onChanged: (date) {
          dateFormatter(date);
        },
        minTime: DateTime(DateTime.now().year - 50),
        maxTime: initialDate,
        currentTime: selectedDate,
        locale: LocaleType.en,
        onConfirm: (date) {
          dateFormatter(date);
          if (GlobalData.myProfile.usersBasicDetails!.registrationStatus == 1) {
            profileResponse.info!.dobStatus = 1;
          }
        });
  }

  ///TODO bloc for save registration data
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("jangi");

    print(profileResponse.preference!.heightMin ?? "");
    print(profileResponse.preference!.heightMax ?? "");
    return WillPopScope(
      onWillPop: () {
        return Dialogs().showDialogExitApp(context);
      },
      child: Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        appBar: getRegAppBar(context,
            title: 'Personal Details',
            progress: 0.072,
            step: 1,
            params: getSectionOne()),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 100.0, left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextView(
                        "Hey I Am",
                        size: 18.0,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Visibility(
                        visible: GlobalData.myProfile.usersBasicDetails
                                    ?.registrationStatus ==
                                1
                            ? false
                            : true,
                        child: TextView(
                          "Click on the icon to select gender",
                          size: 13.0,
                          color: CoupledTheme().primaryBlue,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  IgnorePointer(
                    ignoring: GlobalData
                            .myProfile.usersBasicDetails?.registrationStatus ==
                        1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FadeTransition(
                            opacity: CustomAnimation().fadeOut(_controller),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  age = '21';
                                  dobController.clear();
                                  profileResponse.gender = "male";
                                  _controller.reverse();
                                });
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/ic_male.png',
                                    height: 100.0,
                                    width: 100.0,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  TextView(
                                    'Man',
                                    size: 14,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,
                                  )
                                ],
                              ),
                            )),
                        FadeTransition(
                            opacity: CustomAnimation().fadeIn(
                                _controller) /* profileResponse.gender.toLowerCase() == 'male'
                                    ?
                                    :CustomAnimation().fadeOut(_controller)*/
                            ,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  age = '18';
                                  dobController.clear();
                                  profileResponse.gender = "female";
                                  _controller.forward();
                                });
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/ic_female.png',
                                    height: 100.0,
                                    width: 100.0,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  TextView(
                                    'Woman',
                                    size: 14,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            primaryColor: CoupledTheme().primaryBlue,
                            //color of the main banner
                            accentColor: CoupledTheme().primaryPink,
                            //color of circle indicating the selected date
                            dialogBackgroundColor: Colors.white,
                            textTheme: TextTheme(
                              bodyText2: TextStyle(color: Colors.black),
                            ),
                            buttonBarTheme: ButtonBarThemeData(
                                buttonTextTheme: ButtonTextTheme.accent),
                            buttonTheme: ButtonThemeData(
                                textTheme: ButtonTextTheme
                                    .accent //color of the text in the button "OK/CANCEL"
                                ),
                          ),
                          child: Builder(
                            builder: ((context) {
                              return Material(
                                color: Colors.transparent,
                                child: IgnorePointer(
                                  ignoring: GlobalData
                                          .myProfile
                                          .usersBasicDetails
                                          ?.registrationStatus ==
                                      1,
                                  //ignoring: profileResponse.info.dobStatus == 1,
                                  child: InkWell(
                                      onTap: () {
                                        // print(
                                        //     "isProfileEdit :: ${GlobalData.myProfile.isEditProfile}");
                                        _selectDate(context);
                                      },
                                      child: EditTextBordered(
                                        enabled: false,
                                        controller: dobController,
                                        hint: "Date Of Birth",
                                        size: 14.0,
                                        hintColor: Colors.white,
                                        color: Colors.white,
                                      )),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 10.0,
                          child: Container(
                            color: CoupledTheme().backgroundColor,
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: TextView(
                              age,
                              size: 22.0,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextView(
                        "My Weight",
                        size: 18.0,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                      TextView(
                        "${profileResponse.info?.weight?.toDouble().round() ?? 0.0} kg",
                        size: 18.0,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomSlider(
                    value: profileResponse.info?.weight?.toDouble() ?? 0.0,
                    min: 30.0,
                    max: 200.0,
                    onChanged: (value) {
                      setState(() {
                        profileResponse.info?.weight =
                            value.roundToDouble().toInt();
                      });
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextView(
                        "My Height",
                        size: 18.0,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                      TextView(
                        "${convertFeet(profileResponse.info?.height?.roundToDouble() ?? 0.0)}",
                        size: 18.0,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomSlider(
                      value:
                          profileResponse.info?.height?.roundToDouble() ?? 0.0,
                      min: 120.0,
                      max: 252.0,
                      onChanged: (value) {
                        setState(() {
                          profileResponse.info?.height =
                              value.roundToDouble().toInt();
                        });
                      }),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: TextView(
                          "Partner's Preferred Height",
                          size: 18.0,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: TextView(
                          '${convertFeet(profileResponse.preference?.heightMin?.roundToDouble() ?? 0.0)} to ${convertFeet(profileResponse.preference?.heightMax?.roundToDouble() ?? 0.0)}',
                          size: 18.0,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: CustomSlider(
                          rangeSlider: true,
                          min: 120.0,
                          max: 252.0,
                          rangeValues: RangeValues(
                              (profileResponse.preference?.heightMin)!.roundToDouble(),
                              (profileResponse.preference?.heightMax)!.roundToDouble()),
                          onRangeChanged: (_value) {
//
                            setState(() {
                              profileResponse.preference?.heightMin =
                                  _value.start.roundToDouble().toInt();
                              profileResponse.preference?.heightMax =
                                  _value.end.roundToDouble().toInt();
                            });
                          })),
                ],
              ),
            ),

            ///next and previous navigator
            getBottomNavigationButtons(step: 1, params: getSectionOne()),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
