import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/slidu/complexion_slider.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SectionTwo extends StatefulWidget {
  static String route = 'SectionTwo';
  _SectionTwoState createState() => _SectionTwoState();
}

class _SectionTwoState extends State<SectionTwo>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<SectionTwo> {
  bool _isCompletionMatter = true;
  bool _isBodyTypeMatter = true;
  late AnimationController controller;
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
  List<BaseSettings> complexions = [];
  List<RadioModel> bodyType = [];
  List<RadioModel> partnerBodyType = [];
  var bodyTypeIcon = [
    'assets/unRegular.png',
    'assets/unSlim.png',
    'assets/unAthletic.png'
  ];
  var bodyTypeKey = ['regular', 'slim_fit', 'athletic'];
  int pComplexionDuplicate = 0;
  String pBody = '';

  @override
  void dispose() {
    // registerCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    _baseSettings = GlobalData.baseSettings;
    _profileResponse = GlobalData.myProfile;
    controller = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);

    ///COMPLEXIONS
    if (complexions.length == 0) {
      var complexion = getBaseSettingsByType(
          CoupledStrings.baseSettingsComplexion, _baseSettings);
      if (complexion != null) {
        complexion.options!.forEach((item) {
          complexions.add(BaseSettings(
              id: item.id,
              value: toBeginningOfSentenceCase(item.value).toString(),
              options: []));
        });
      }
    }

    ///BODY TYPE
    if (bodyType.length == 0 && partnerBodyType.length == 0) {
      var bodyTypes = getBaseSettingsByType(
          CoupledStrings.baseSettingsBodyType, _baseSettings);
      bodyTypes.options!.forEach((f) {
        bodyType.add(RadioModel(
            false,
            f.id,
            bodyTypeIcon[bodyTypeKey.indexOf(f.others)],
            bodyTypeIcon[bodyTypeKey.indexOf(f.others)],
            toBeginningOfSentenceCase(f.value)));
        partnerBodyType.add(RadioModel(
            false,
            f.id,
            bodyTypeIcon[bodyTypeKey.indexOf(f.others)],
            bodyTypeIcon[bodyTypeKey.indexOf(f.others)],
            f.value));
      });
    }

    ///INITIALIZATION
    _profileResponse.info!.complexion =
        _profileResponse.info!.complexion ?? complexions[0];
    _profileResponse.info!.bodyType = _profileResponse.info!.bodyType ??
        BaseSettings(id: bodyType[0].id, options: []);
    _profileResponse.preference?.bodyType =
        _profileResponse.preference!.bodyType ?? null;
    _profileResponse.preference?.complexion =
        _profileResponse.preference?.complexion ?? BaseSettings(options: []);

    ///data lDB
    if (_profileResponse.info != null) {
      if (_profileResponse.info?.bodyType != null) {
        bodyType.forEach((data) {
          if (data.id == _profileResponse.info?.bodyType?.id) {
            data.isSelected = true;
          } else
            data.isSelected = false;
        });
      }
      if (_profileResponse.info!.complexion != null) {
        complexions.forEach((data) {
          if (data.id == _profileResponse.info?.complexion?.id) {
            data.isSelected = true;
          } else
            data.isSelected = false;
        });
      }
    }

    ///Partner preference from localDB
    if (_profileResponse.preference != null) {
      if (_profileResponse.preference?.bodyType != null) {
        partnerBodyType.forEach((data) {
          if (data.id == _profileResponse.preference?.bodyType?.id) {
            _isBodyTypeMatter = false;
            data.isSelected = true;
          }
        });
      }
      if (_profileResponse.preference!.complexion != null) {
        complexions.forEach((data) {
          if (data.id == _profileResponse.preference?.complexion?.id) {
            _isCompletionMatter = false;
            data.isSelected = true;
          }
        });
      }
    }
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
            title: 'Personal Details',
            progress: 0.144,
            step: 2,
            params: getSectionTwo()),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 100.0, left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextView(
                    "My Complexion",
                    size: 18.0,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ComplexionSlider(
                    texts: complexions,
                    initialSlideValue: _profileResponse
                                .info?.complexion?.value ==
                            'Fair'
                        ? 3
                        : _profileResponse.info?.complexion?.value == 'Wheatish'
                            ? 2
                            : 1,
                    onChangeEnd: (d) {
                      _profileResponse.info?.complexion = d;

                      print("onDragEnd : $d");
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: Opacity(
                          opacity: _isCompletionMatter ? 0.5 : 1,
                          child: TextView(
                            "Partner's Preferred Complexion",
                            size: 18.0,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 30.0,
                                height: 20.0,
                                child: Checkbox(
                                    activeColor: CoupledTheme().primaryPink,
                                    value: _isCompletionMatter,
                                    onChanged: (isChecked) {
                                      setState(() {
                                        _isCompletionMatter = isChecked!;
                                        _profileResponse
                                                .preference?.complexion =
                                            BaseSettings(
                                                id: _isCompletionMatter
                                                    ? 0
                                                    : complexions[0].id,
                                                value: complexions[0].value,
                                                options: []);
                                      });
                                    }),
                              ),
                              TextView(
                                "Doesn't matter",
                                color: CoupledTheme().primaryBlue,
                                size: 12.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Opacity(
                    opacity: !_isCompletionMatter ? 1.0 : .5,
                    child: ComplexionSlider(
                      enabled: !_isCompletionMatter,
                      initialSlideValue: _profileResponse
                                  .preference?.complexion?.value ==
                              'Fair'
                          ? 3
                          : _profileResponse.preference?.complexion?.value ==
                                  'Wheatish'
                              ? 2
                              : 1,
                      onChangeEnd: (d) {
                        setState(() {
                          print(d.toString());
                        });
                        pComplexionDuplicate = d.id;
                        _profileResponse.preference?.complexion = d;
                      },
                      texts: complexions,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    child: TextView(
                      "My Body Type",
                      size: 18.0,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 125.0,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: bodyType.length,
                        itemExtent: 100.0,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                print("clicked");
                                bodyType.forEach((RadioModel element) {
                                  element.isSelected = false;
                                });
                                bodyType[index].isSelected = true;
                                _profileResponse.info?.bodyType?.id =
                                    bodyType[index].id;
                                _profileResponse.info?.bodyType?.value =
                                    bodyType[index].text;
                              });
                            },
                            child: BodyTypeItem(bodyType[index]),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: Opacity(
                          opacity: _isBodyTypeMatter ? 0.5 : 1,
                          child: TextView(
                            "Partner's Preferred Body Type",
                            size: 18.0,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 20.0,
                                width: 30.0,
                                child: Checkbox(
                                    activeColor: CoupledTheme().primaryPink,
                                    value: _isBodyTypeMatter,
                                    onChanged: (isChecked) {
                                      setState(() {
                                        _isBodyTypeMatter = isChecked!;
                                        partnerBodyType
                                            .forEach((RadioModel element) {
                                          element.isSelected = false;
                                        });
                                        _profileResponse.preference?.bodyType =
                                            BaseSettings(
                                                id: _isBodyTypeMatter
                                                    ? 0
                                                    : partnerBodyType[0].id,
                                                value: partnerBodyType[0].text,
                                                options: []);
                                        partnerBodyType[0].isSelected =
                                            !_isBodyTypeMatter;
                                      });
                                    }),
                              ),
                              TextView(
                                "Doesn't matter",
                                color: CoupledTheme().primaryBlue,
                                size: 12.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 120.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: partnerBodyType.length,
                      itemExtent: 100.0,
                      itemBuilder: (BuildContext context, int i) {
                        return Opacity(
                          opacity: !_isBodyTypeMatter ? 1.0 : .5,
                          child: GestureDetector(
                            onTap: _isBodyTypeMatter
                                ? null
                                : () {
                                    setState(() {
                                      partnerBodyType
                                          .forEach((RadioModel element) {
                                        element.isSelected = false;
                                      });
                                      partnerBodyType[i].isSelected = true;
                                      _profileResponse.preference?.bodyType =
                                          BaseSettings(
                                              id: bodyType[i].id, options: []);
                                    });
                                  },
                            child: BodyTypeItem(partnerBodyType[i]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            ///next and previous navigator
            getBottomNavigationButtons(step: 2, params: getSectionTwo()),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
