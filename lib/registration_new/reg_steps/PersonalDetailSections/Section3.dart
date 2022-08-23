import 'dart:core';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/amimations.dart';
import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';

import 'package:coupled/registration_new/app_bar.dart';
import 'package:coupled/registration_new/get_bottom_button.dart';
import 'package:coupled/registration_new/helpers/get_baseSettings.dart';
import 'package:coupled/registration_new/helpers/get_section_data.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SectionThree extends StatefulWidget {
  static String route = 'SectionThree';

  _SectionThreeState createState() => _SectionThreeState();
}

class _SectionThreeState extends State<SectionThree>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  bool isSpecialCase = false,
      isRequest = false,
      isChildren = false,
      isLiving = false;
  int _children=0;
  BaseSettings listMarital = BaseSettings(options: []),
      listSpecialCase = BaseSettings(options: []),
      listChildStatus = BaseSettings(options: []);
  List<BaseSettings> specialCaseItems = [];
  List<BaseSettings> maritalStatusList = [];
  List<BaseSettings> childLivingList = [];
  List<BaseSettings> _baseSettings = [];
  ProfileResponse _profileResponse = ProfileResponse(
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
  void initState() {
    _baseSettings = GlobalData.baseSettings;
    _profileResponse = GlobalData.myProfile;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);

    ///MARITAL STATUS
    listMarital = getBaseSettingsByType(
        CoupledStrings.baseSettingsMaritalStatus, _baseSettings);
    maritalStatusList.clear();
    listMarital.options!.forEach((data) {
      if (data.value != 'Married')
        maritalStatusList.add(BaseSettings(
            id: data.id, value: data.value, isSelected: false, options: []));
    });

    ///SPECIAL CASES
    listSpecialCase = getBaseSettingsByType(
        CoupledStrings.baseSettingsSpecial, _baseSettings);
    specialCaseItems.clear();
    listSpecialCase.options!.forEach((data) {
      specialCaseItems.add(BaseSettings(
          id: data.id,
          value: toBeginningOfSentenceCase(data.value).toString(),
          isSelected: false,
          options: []));
    });

    ///CHILDREN LIVING STATUS
    if (childLivingList.length == 0) {
      listChildStatus = getBaseSettingsByType(
          CoupledStrings.baseSettingsChildStatus, _baseSettings);
      listChildStatus.options!.forEach((item) {
        childLivingList.add(BaseSettings(
            id: item.id,
            value: toBeginningOfSentenceCase(item.value).toString(),
            isSelected: false,
            options: []));
      });
    }

    ///INITIALIZE
    /* if(_profileResponse.info.maritalStatus==null)
    	_profileResponse.info.maritalStatus = Data();
    if(_profileResponse.info.specialCaseType ==null)
	    _profileResponse.info.specialCaseType = Data();
    if(_profileResponse.info.childLivingStatus==null)
	    _profileResponse.info.childLivingStatus = Data();*/
    print("INFO :: ${_profileResponse.info}");
    maritalStatusList.forEach((item) {
      print("${item.id}  ${_profileResponse.info!.maritalStatus}");
      if (_profileResponse.info?.maritalStatus?.id != null &&
          item.id == _profileResponse.info?.maritalStatus?.id) {
        item.isSelected = true;
        if (item.value == "Awaiting Divorce" ||
            item.value == "Divorced" ||
            item.value == "Widowed") {
          isChildren = true;
        }
      } else {
        if (_profileResponse.info?.maritalStatus?.value == null ||
            _profileResponse.info?.maritalStatus?.value == "bachelor" &&
                item.value.toLowerCase() == "bachelor") {
          print("inside");
          item.isSelected = true;
          _profileResponse.info?.maritalStatus = item;
        } else
          item.isSelected = false;
      }
    });

    if (_profileResponse.info?.numberOfChildren != null &&
        _profileResponse.info!.numberOfChildren! > 0) {
      _children = (_profileResponse.info!.numberOfChildren)!.toInt();
    }
    if (_profileResponse.info?.childLivingStatus != null) {
      if (childLivingList.length > 0) {
        isLiving = childLivingList[0].id ==
            _profileResponse.info?.childLivingStatus?.id;
      }
    }
    if (_profileResponse.info?.specialCaseType != null) {
      specialCaseItems.forEach((f) {
        f.isSelected = f.id == _profileResponse.info?.specialCaseType?.id;
      });
    }
    if (_profileResponse.info?.specialCase == 1) {
      _controller.forward();
      isSpecialCase = true;
    } else {
      _controller.reverse();
      isSpecialCase = false;
    }
    isRequest = _profileResponse.info?.specialCaseNotify == 1;
    // maritalStatusList[0].isSelected = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () {
        return Dialogs().showDialogExitApp(context);
      },
      child: Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        appBar: getRegAppBar(context,
            progress: 0.216,
            title: 'Personal Details',
            step: 3,
            params: getSectionThree()),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 100.0, left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextView(
                    "My Marital Status",
                    size: 18.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Wrap(
                    children: maritalBuilder(maritalStatusList),
                  ),
                  isChildren
                      ? Container(
                          margin: EdgeInsets.only(top: 10.0, left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: TextView(
                                  "How many children do you have?",
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(top: 5.0),
                                      child: TextView(
                                        "No.of Children",
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: .8,
                                        color: Colors.white,
                                        size: 12,
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: SelectionBox(
                                        child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (_children! > 0) {
                                                _children--;
                                                _profileResponse.info
                                                        ?.numberOfChildren =
                                                    _children;
                                              }
                                              _profileResponse
                                                      .info?.childLivingStatus =
                                                  childLivingList[1];
                                            });
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.0,
                                                horizontal: 10.0),
                                            child: TextView(
                                              "-",
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.visible,
                                              textAlign: TextAlign.center,
                                              textScaleFactor: .8,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.0,
                                                horizontal: 10.0),
                                            child: TextView(
                                              _children.toString(),
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.visible,
                                              textAlign: TextAlign.center,
                                              textScaleFactor: .8,
                                              color: Colors.white,
                                              size: 12,
                                            )),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (_children >= 0 &&
                                                  _children <= 4) {
                                                _children++;
                                                _profileResponse.info
                                                        ?.numberOfChildren =
                                                    _children;
                                                _profileResponse.info
                                                        ?.childLivingStatus =
                                                    childLivingList[1];
                                              }
                                            });
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.0,
                                                horizontal: 10.0),
                                            child: TextView(
                                              "+",
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.visible,
                                              textAlign: TextAlign.center,
                                              textScaleFactor: .8,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                  )
                                ],
                              ),
                              _children > 0
                                  ? Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isLiving = true;
                                              _profileResponse
                                                      .info?.childLivingStatus =
                                                  childLivingList[0];
                                            });
                                          },
                                          child: SelectionBox(
                                            innerColor: !isLiving
                                                ? CoupledTheme()
                                                    .thirdSelectionColor
                                                : Colors.transparent,
                                            borderColor: isLiving
                                                ? CoupledTheme()
                                                    .thirdSelectionColor
                                                : Colors.white,
                                            child: TextView(
                                              childLivingList[0].value,
                                              color: !isLiving
                                                  ? Colors.black
                                                  : Colors.white,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.visible,
                                              textAlign: TextAlign.center,
                                              textScaleFactor: .8,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isLiving = false;
                                              _profileResponse
                                                      .info?.childLivingStatus =
                                                  childLivingList[1];
                                            });
                                          },
                                          child: SelectionBox(
                                            innerColor: !isLiving
                                                ? CoupledTheme()
                                                    .thirdSelectionColor
                                                : Colors.transparent,
                                            borderColor: isLiving
                                                ? Colors.white
                                                : Color(0xff717483),
                                            child: TextView(
                                              childLivingList[1].value,
                                              color: !isLiving
                                                  ? Colors.black
                                                  : Colors.white,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.visible,
                                              textAlign: TextAlign.center,
                                              textScaleFactor: .9,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextView(
                    "Special Case",
                    size: 18.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: FadeTransition(
                          opacity: CustomAnimation().fadeIn(_controller),
                          child: Material(
                            color: Colors.transparent,
                            child: SelectionBox(
                              onTap: () {
                                setState(() {
                                  _controller.forward();
                                  isSpecialCase = true;
                                  _profileResponse.info!.specialCase = 1;
                                });
                              },
                              borderColor: isSpecialCase
                                  ? CoupledTheme().primaryPinkDark
                                  : Colors.white,
                              innerColor: isSpecialCase
                                  ? CoupledTheme().primaryPinkDark
                                  : null,
                              child: Material(
                                color: Colors.transparent,
                                child: TextView(
                                  "Yes",
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: FadeTransition(
                          opacity: CustomAnimation().fadeOut(_controller),
                          child: Material(
                            color: Colors.transparent,
                            child: SelectionBox(
                              onTap: () {
                                setState(() {
                                  _controller.reverse();
                                  isSpecialCase = false;
                                  isRequest = false;
                                  _profileResponse.info?.specialCaseNotify = 0;
                                  _profileResponse.info?.specialCaseType?.id =
                                      0;
                                  _profileResponse.info?.specialCase = 0;
                                  specialCaseItems.forEach((specialCase) {
                                    specialCase.isSelected = false;
                                  });
                                });
                              },
                              borderColor: isSpecialCase
                                  ? Colors.white
                                  : CoupledTheme().primaryPinkDark,
                              innerColor: isSpecialCase
                                  ? null
                                  : CoupledTheme().primaryPinkDark,
                              child: TextView(
                                "No",
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  isSpecialCase
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                direction: Axis.horizontal,
                                verticalDirection: VerticalDirection.up,
                                runAlignment: WrapAlignment.start,
                                alignment: WrapAlignment.start,
                                children: specialCase(specialCaseItems)),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 30.0,
                                    height: 30.0,
                                    child: Checkbox(
                                        activeColor:
                                            CoupledTheme().primaryPinkDark,
                                        value: isRequest,
                                        onChanged: (isChecked) {
                                          setState(() {
                                            isRequest = isChecked!;
                                            _profileResponse
                                                    .info?.specialCaseNotify =
                                                isRequest ? 1 : 0;
                                          });
                                        }),
                                  ),
                                  TextView(
                                    "Visible to other user only on request",
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,
                                    color: Colors.white,
                                    size: 12,
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      : Wrap(),
                ],
              ),
            ),
            getBottomNavigationButtons(step: 3, params: getSectionThree())
          ],
        ),
      ),
    );
  }

  List<Widget> specialCase(List<BaseSettings> specialCaseItems) {
    List<Widget> _specialCaseItems = [];
    specialCaseItems.forEach(
      (specialCase) {
        _specialCaseItems.add(
          SelectionBox(
            onTap: () {
              setState(() {
                setState(() {
                  specialCaseItems.forEach((_specialCase) {
                    _specialCase.isSelected = false;
                  });
                  specialCase.isSelected = true;
                  _profileResponse.info?.specialCaseType = specialCase;
                });
              });
            },
            borderColor: specialCase.isSelected
                ? CoupledTheme().thirdSelectionColor
                : null,
            innerColor: specialCase.isSelected
                ? CoupledTheme().thirdSelectionColor
                : null,
            child: TextView(
              specialCase.value,
              color: specialCase.isSelected ? Colors.black : Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
              size: 12,
            ),
          ),
        );
      },
    );
    return _specialCaseItems;
  }

  List<Widget> maritalBuilder(List<BaseSettings> maritalStatusItems) {
    List<Widget> _maritalStatusItems = [];
    maritalStatusItems.asMap().forEach(
      (index, f) {
        _maritalStatusItems.add(
          SelectionBox(
            onTap: () {
              setState(() {
                maritalStatusList.forEach((BaseSettings maritalModel) {
                  maritalModel.isSelected = false;
                });
                maritalStatusList[index].isSelected = true;

                _profileResponse.info?.maritalStatus = maritalStatusList[index];

                if (maritalStatusList[index].value == "Awaiting Divorce" ||
                    maritalStatusList[index].value == "Divorced" ||
                    maritalStatusList[index].value == "Widowed") {
                  isChildren = true;
                } else {
                  isChildren = false;
                  _profileResponse.info!.childLivingStatus =
                      BaseSettings(options: []);
                  _profileResponse.info!.numberOfChildren = 0;
                  _children = 0;
                }
              });
            },
            borderColor: maritalStatusList[index].isSelected
                ? CoupledTheme().primaryPinkDark
                : null,
            innerColor: maritalStatusList[index].isSelected
                ? CoupledTheme().primaryPinkDark
                : null,
            child: TextView(
              maritalStatusList[index].value,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .9,
              color: Colors.white,
              size: 12,
            ),
          ),
        );
      },
    );
    return _maritalStatusItems;
  }

  @override
  bool get wantKeepAlive => true;
}
