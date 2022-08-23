import 'package:coupled/Utils/Modals/SMC/smc_bloc.dart';
import 'package:coupled/Utils/Modals/SMC/smc_widget.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';

import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/user.dart';

import 'package:coupled/registration_new/app_bar.dart';
import 'package:coupled/registration_new/get_bottom_button.dart';
import 'package:coupled/registration_new/helpers/get_baseSettings.dart';
import 'package:coupled/registration_new/helpers/get_section_data.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FamilyInfoB extends StatefulWidget {
  static String route = 'FamilyInfoB';

  @override
  _FamilyInfoBState createState() => _FamilyInfoBState();
}

class _FamilyInfoBState extends State<FamilyInfoB>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TextEditingController _countryCtrl = TextEditingController(),
      _stateCtrl = TextEditingController(),
      _cityCtrl = TextEditingController();
  bool isFamilyType = false;
  User user = User();
  bool hideBackButton = true;
  List<Item> _country = [], _state = [], _city = [];
  List<BaseSettings> familyTypes = [];
  List<BaseSettings> familyValues = [];
  SmcBloc _smcBloc = SmcBloc();

//  List<Item> _country, _state, _city;

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

  bool isCurrentLocation = false;

  BaseSettings listFamilyType = BaseSettings(options: []),
      listFamilyValues = BaseSettings(options: []);

  @override
  void didChangeDependencies() {
    _profileResponse = GlobalData.myProfile;

    _profileResponse.family = _profileResponse.family ??
        Family(
            fatherOccupationStatus: BaseSettings(options: []),
            cast: BaseSettings(options: []),
            familyType: BaseSettings(options: []),
            familyValues: BaseSettings(options: []),
            gothram: BaseSettings(options: []),
            motherOccupationStatus: BaseSettings(options: []),
            religion: BaseSettings(options: []),
            subcast: BaseSettings(options: []));
    _profileResponse.family!.familyType =
        _profileResponse.family!.familyType ?? BaseSettings(options: []);
    _profileResponse.family!.familyValues =
        _profileResponse.family!.familyValues ?? BaseSettings(options: []);

    _smcBloc = _smcBloc ?? SmcBloc();
    _smcBloc.add(SMCParams());
    _baseSettings = GlobalData.baseSettings;
    listFamilyType = getBaseSettingsByType(
        CoupledStrings.baseSettingsFamilyType, _baseSettings);
    listFamilyValues = getBaseSettingsByType(
        CoupledStrings.baseSettingsFamilyValue, _baseSettings);
    print("listFamilyType : $listFamilyType");
    print("listFamilyValues : $listFamilyValues");

    ///familyValues
    familyValues.clear();
    if (listFamilyValues != null) {
      listFamilyValues.options!.forEach((f) {
        familyValues.add(BaseSettings(
            id: f.id,
            value: f.value,
            isSelected: _profileResponse.family!.familyValues!.id == f.id
                ? true
                : false,
            options: []));
      });
    }

    ///familyTypes
    familyTypes.clear();
    if (listFamilyType != null) {
      listFamilyType.options!.forEach((f) {
        familyTypes.add(BaseSettings(
            id: f.id,
            value: f.value,
            isSelected:
                _profileResponse.family!.familyType!.id == f.id ? true : false,
            options: []));
      });
    }

    ///load previous location
    /* FamilyResponse address = _profileResponse?.family;
    if (_profileResponse.family != null) {
      inCurrentLocation = address.country == _profileResponse.info.country &&
          address.state == _profileResponse.info.state &&
          address.city == _profileResponse.info.city;
      _countryCtrl.text = address.country;
      _stateCtrl.text = address.state;
      _cityCtrl.text = address.city;
    }*/

    /// these area gets the data loaded automatically
    if (_profileResponse.family != null) {
      if (_profileResponse.family!.locationId ==
          _profileResponse.info!.locationId) {
        setState(() {
          isCurrentLocation = true;
        });
      }

      _countryCtrl.text = _profileResponse.family!.country.toString();
      _stateCtrl.text = _profileResponse.family!.state.toString();
      _cityCtrl.text = _profileResponse.family!.city.toString();
    }

    super.didChangeDependencies();
  }

  void _modalBottomSheetMenu({int page = 0}) {
    PageController _pageController;
    _pageController = PageController(initialPage: page, keepPage: true);

    Future.delayed(Duration(milliseconds: 150), () {
      _pageController.jumpToPage(page == null ? 0 : page);
      hideBackButton =
          _pageController.page == null || _pageController.page == 0;
    });
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Theme(
            data: CoupledTheme()
                .coupledTheme2()
                .copyWith(unselectedWidgetColor: Colors.black),
            child: StatefulBuilder(
              builder: (context, state) {
                return Stack(
                  children: <Widget>[
                    PageView(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        BlocBuilder<SmcBloc, SmcState>(
                            bloc: _smcBloc,
                            builder: (context, snapshot) {
                              if (snapshot is SmcLoading &&
                                  snapshot.extras == 'country') {
                                return Container(
                                    color: Colors.white,
                                    child:
                                        GlobalWidgets().showCircleProgress());
                              }
                              return SMCWidget(
                                title: "Country",
                                multipleChoice: false,
                                items: _country,
                                selectedItem: (isChecked, values) {
                                  if (values is Item) {
                                    state(() {
                                      print("country $values");
                                      _country
                                          .singleWhere((test) => test == values)
                                          .isSelected = isChecked;
                                      if (isChecked) {
                                        _countryCtrl.text = values.name;
                                        _stateCtrl.text = '';
                                        _cityCtrl.text = '';
                                        _profileResponse.family!.state = null;
                                        _profileResponse.family!.city = null;
                                        _profileResponse.family!.country =
                                            values.name;
                                        _profileResponse.family!.countryCode =
                                            values.code;
                                        _smcBloc.add(SMCParams(
                                            type: 'state',
                                            countryCode: values.code));
                                      } else {
                                        _profileResponse.family!.country = null;
                                        _countryCtrl.text = "";
                                        _stateCtrl.text = '';
                                        _cityCtrl.text = '';
                                      }
                                    });
                                  }
                                },
                                errorWidget: SizedBox(),
                              );
                            }),
                        BlocBuilder<SmcBloc, SmcState>(
                            bloc: _smcBloc,
                            builder: (context, snapshot) {
                              if (snapshot is SmcLoading &&
                                  snapshot.extras == 'state') {
                                return Container(
                                    color: Colors.white,
                                    child:
                                        GlobalWidgets().showCircleProgress());
                              }
                              return SMCWidget(
                                title: "State",
                                multipleChoice: false,
                                items: _state,
                                selectedItem: (isChecked, values) {
                                  if (values is Item) {
                                    state(() {
                                      _state
                                          .singleWhere((test) => test == values)
                                          .isSelected = isChecked;
                                      if (isChecked) {
                                        _stateCtrl.text = values.name;
                                        _cityCtrl.text = '';
                                        _profileResponse.family!.city = null;
                                        _profileResponse.family!.locationId = 0;
                                        _profileResponse.family!.state =
                                            values.name;
                                        _smcBloc.add(SMCParams(
                                            type: 'city',
                                            stateCode: values.name));
                                      } else {
                                        _profileResponse.family!.state = null;
                                        _stateCtrl.text = "";
                                        _cityCtrl.text = '';
                                      }
                                    });
                                  }
                                },
                                errorWidget: SizedBox(),
                              );
                            }),
                        BlocBuilder<SmcBloc, SmcState>(
                            bloc: _smcBloc,
                            builder: (context, snapshot) {
                              if (snapshot is SmcLoading &&
                                  snapshot.extras == 'city') {
                                return Container(
                                    color: Colors.white,
                                    child:
                                        GlobalWidgets().showCircleProgress());
                              }
                              return SMCWidget(
                                title: "City",
                                multipleChoice: false,
                                items: _city,
                                selectedItem: (isChecked, values) {
                                  if (values is Item) {
                                    state(() {
                                      _city
                                          .singleWhere((test) => test == values)
                                          .isSelected = isChecked;
                                      print("city $values");
                                      if (isChecked) {
                                        _cityCtrl.text = values.name;
                                        _profileResponse.family!.city =
                                            values.name;
                                        setState(() {
                                          _profileResponse.family!.locationId =
                                              int.parse(values.id);
                                          //GlobalData.myProfile.family?.locationId= int.parse(values.id);
                                        });
                                      } else {
                                        _profileResponse.family!.city = null;
                                        _cityCtrl.text = "";
                                      }
                                    });
                                  }
                                },
                                errorWidget: SizedBox(),
                              );
                            }),
                      ],
                      onPageChanged: (index) {
                        state(() {
                          hideBackButton = index == 0;
                          print(
                              "pageD ${_pageController.page} $hideBackButton");
                        });
                      },
                    ),
                    Align(
                      alignment: Alignment(0, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            hideBackButton
                                ? Container()
                                : InkWell(
                                    onTap: () {
                                      if (_pageController.page!.round() > 0) {
                                        _pageController.previousPage(
                                            duration:
                                                Duration(milliseconds: 350),
                                            curve: Curves.easeInOut);
                                      }
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 20.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color:
                                                CoupledTheme().primaryPinkDark),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: TextView(
                                            "Back",
                                            color: Colors.black,
                                            size: 18.0,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                          ),
                                        )),
                                  ),
                            InkWell(
                              onTap: () {
                                if (_pageController.page!.round() < 2) {
                                  _pageController.nextPage(
                                      duration: Duration(milliseconds: 350),
                                      curve: Curves.easeInOut);
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 20.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: CoupledTheme().primaryPinkDark),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextView(
                                      "Next",
                                      color: Colors.black,
                                      size: 18.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }

  //familyType and familyValue
  List<Widget> selectionBuilder(
      {List<BaseSettings> statusItems = const <BaseSettings>[],
      bool isFamilyValue = false}) {
    print('statusItems------');
    print('$statusItems');
    bool selectedFamilyIndex = false;
    List<Widget> _maritalStatusItems = [];

    var family = _profileResponse.family;
    print("family ::: $family");
    statusItems.forEach((item) {
      selectedFamilyIndex = item.isSelected;
      _maritalStatusItems.add(SelectionBox(
        onTap: () {
          setState(() {
            statusItems.forEach((item) {
              item.isSelected = false;
            });
            item.isSelected = true;
            isFamilyValue
                ? _profileResponse.family!.familyValues = item
                : _profileResponse.family!.familyType = item;
          });
        },
        borderColor: selectedFamilyIndex != null && selectedFamilyIndex
            ? CoupledTheme().primaryPinkDark
            : null,
        innerColor: selectedFamilyIndex != null && selectedFamilyIndex
            ? CoupledTheme().primaryPinkDark
            : null,
        child: TextView(
          item.value,
          color: Colors.white,
          size: 18.0,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          textScaleFactor: .8,
        ),
      ));
    });
    return _maritalStatusItems;
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
            progress: 0.86,
            title: 'Family (Optional)',
            step: 12,
            params: getSectionTwelve()),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: BlocListener(
                bloc: _smcBloc,
                listener: (context, snapshot) {
                  if (snapshot is SmcCountry) {
                    setState(() {
                      _country = snapshot.countries;
                      print("Countries : $_country");
                    });
                  }
                  if (snapshot is SmcStates) {
                    _state = snapshot.states;
                  }
                  if (snapshot is SmcCity) {
                    _city = snapshot.cities;
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextView(
                      "My Family Type",
                      size: 18.0,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .9,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Wrap(
                      children: selectionBuilder(statusItems: familyTypes),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextView(
                      "My Family Values",
                      size: 18.0,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .9,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Wrap(
                      children: selectionBuilder(
                          statusItems: familyValues, isFamilyValue: true),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextView(
                          "My Family Location",
                          size: 18.0,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .9,
                        ),
                        CustomCheckBox(
                          value: isCurrentLocation,
                          text: "My current location",
                          textSize: 12.0,
                          textColor: CoupledTheme().primaryBlue,
                          onChanged: (isChecked) {
                            setState(() {
                              isCurrentLocation = isChecked!;
                              if (isCurrentLocation) {
                                print("****INFO***");
                                print(_profileResponse.info.toString());
                                _countryCtrl.text =
                                    (_profileResponse.info!.country).toString();
                                _stateCtrl.text = (_profileResponse.info!.state).toString();
                                _cityCtrl.text = (_profileResponse.info!.city).toString();
                                _profileResponse.family!.countryCode =
                                    _profileResponse.info!.countryCode;
                                _profileResponse.family!.locationId =
                                    _profileResponse.info!.locationId;

                                _profileResponse.family!.country =
                                    _profileResponse.info!.country;
                                _profileResponse.family!.state =
                                    _profileResponse.info!.state;
                                _profileResponse.family!.city =
                                    _profileResponse.info!.city;
                                print(_countryCtrl.text);
                                print(_stateCtrl.text);
                                print(_cityCtrl.text);
                              } else {
                                _countryCtrl.text = "";
                                _stateCtrl.text = "";
                                _cityCtrl.text = "";
                                _profileResponse.family!.countryCode = "";
                                _profileResponse.family!.locationId = 0;
                              }
                            });
                          },
                          secondary: SizedBox(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    IgnorePointer(
                      ignoring: isCurrentLocation,
                      child: InkWell(
                        splashColor: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {
                          setState(() {
                            _modalBottomSheetMenu();
                          });
                        },
                        child: EditTextBordered(
                          enabled: false,
                          hint: "Country",
                          size: 16.0,
                          controller: _countryCtrl,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    IgnorePointer(
                      ignoring: isCurrentLocation,
                      child: InkWell(
                        splashColor: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {
                          setState(() {
                            _modalBottomSheetMenu();
                          });
                        },
                        child: EditTextBordered(
                          enabled: false,
                          hint: "State",
                          size: 16.0,
                          controller: _stateCtrl,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    IgnorePointer(
                      ignoring: isCurrentLocation,
                      child: InkWell(
                        splashColor: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {
                          setState(() {
                            _modalBottomSheetMenu();
                          });
                        },
                        child: EditTextBordered(
                          enabled: false,
                          hint: "City",
                          size: 16.0,
                          controller: _cityCtrl,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            getBottomNavigationButtons(step: 12, params: getSectionTwelve())
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FamilyValues {
//  final MaritalModel maritalModel;
//  bool isSelected;
  final Map status;
  final GestureTapCallback onTap;

  FamilyValues(this.status, {required this.onTap});
}
