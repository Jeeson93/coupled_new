import 'package:coupled/Utils/Modals/SMC/smc_bloc.dart';
import 'package:coupled/Utils/Modals/SMC/smc_widget.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';

import 'package:coupled/registration_new/app_bar.dart';
import 'package:coupled/registration_new/get_bottom_button.dart';
import 'package:coupled/registration_new/helpers/get_section_data.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionFour extends StatefulWidget {
  static String route = 'SectionFour';

  _SectionFourState createState() => _SectionFourState();
}

class _SectionFourState extends State<SectionFour>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  SmcBloc _smcBloc = SmcBloc();
  bool hideBackButton = true;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  TextEditingController _countryCtrl = TextEditingController(),
      _stateCtrl = TextEditingController(),
      _cityCtrl = TextEditingController();
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
  List<Item> _country = [], _state = [], _city = [];
  Info info = Info(maritalStatus: BaseSettings(options: []));

  @override
  void initState() {
    _profileResponse = GlobalData.myProfile;
    info =
        _profileResponse.info ?? Info(maritalStatus: BaseSettings(options: []));

    ///INITIALIZE
    _countryCtrl.text =
        info.country.toString() == 'null' ? 'Country' : info.country.toString();
    _stateCtrl.text =
        info.state.toString() == 'null' ? 'State' : info.state.toString();
    _cityCtrl.text =
        info.city.toString() == 'null' ? 'City' : info.city.toString();
    print('Country.........................${_countryCtrl.text}');

    _smcBloc = _smcBloc != _smcBloc ? SmcBloc() : _smcBloc;
    _smcBloc.add(SMCParams());
    super.initState();
  }

  @override
  void dispose() {
    _smcBloc.close();
    super.dispose();
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
            progress: 0.288,
            title: 'Personal Details',
            step: 4,
            params: getSectionFour()),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 100.0, left: 15.0, right: 15.0),
              child: BlocListener<SmcBloc, SmcState>(
                bloc: _smcBloc,
                listener: (context, snapshot) {
                  setState(() {
                    if (snapshot is SmcCountry) {
                      _country = snapshot.countries;

                      Item isCountry = _country.singleWhere(
                          (element) =>
                              element.name.toLowerCase() ==
                              info.country.toString().toLowerCase(),
                          orElse: () => _country.first);
                      if (isCountry != null) {
                        isCountry.isSelected = true;

                        _smcBloc.add(SMCParams(
                            type: 'state', countryCode: isCountry.code));
                      }

                      print("Countries : $isCountry");
                    }
                    if (snapshot is SmcStates) {
                      _state = snapshot.states;
                      Item isState = _state.singleWhere(
                          (element) =>
                              element.name.toLowerCase() ==
                              info.state?.toLowerCase(),
                          orElse: () => _state.first);
                      if (isState != null) {
                        isState.isSelected = true;
                        _smcBloc.add(
                            SMCParams(type: 'city', stateCode: isState.name));
                      }
                      print("State : $isState   ${info.state}");
                    }
                    if (snapshot is SmcCity) {
                      _city = snapshot.cities;
                      bool item = _city
                          .singleWhere(
                              (element) =>
                                  element.name.toLowerCase() ==
                                  info.city?.toLowerCase(),
                              orElse: () => _city.first)
                          .isSelected = true;
                      print("City : $item");
                    }
                  });
                },
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextView(
                      "My Current Location",
                      size: 18.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          showBottomSheet1();
                        },
                        child: EditTextBordered(
                          enabled: false,
                          hint: "Country",
                          controller: _countryCtrl,
                          size: 16.0,
                          hintColor: Colors.white,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          showBottomSheet1(page: 1);
                        },
                        child: EditTextBordered(
                          enabled: false,
                          hint: "State",
                          controller: _stateCtrl,
                          size: 16.0,
                          hintColor: Colors.white,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          showBottomSheet1(page: 2);
                        },
                        child: EditTextBordered(
                          enabled: false,
                          hint: "City",
                          controller: _cityCtrl,
                          size: 16.0,
                          hintColor: Colors.white,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //if(_countryCtrl.text.isNotEmpty&&_stateCtrl.text.isNotEmpty&&_cityCtrl.text.isNotEmpty)
            getBottomNavigationButtons(step: 4, params: getSectionFour())
          ],
        ),
      ),
    );
  }

  void showBottomSheet1({int page = 0}) {
    PageController _pageController;
    _pageController = PageController(initialPage: page, keepPage: true);

    Future.delayed(Duration(milliseconds: 150), () {
      _pageController.jumpToPage(page == null ? 0 : page);
      hideBackButton =
          _pageController.page == null || _pageController.page == 0;
    });
    showModalBottomSheet(
      enableDrag: false,
      isDismissible: false,
      context: context,
      builder: (context) {
        return Theme(
          data: CoupledTheme()
              .coupledTheme2()
              .copyWith(unselectedWidgetColor: Colors.black),
          child: WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
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
                              print(snapshot.props);
                              print(snapshot.hashCode);
                              print(snapshot);
                              print(_country);
                              if (snapshot is SmcLoading) {
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
                                      _country
                                          .singleWhere((test) => test == values)
                                          .isSelected = isChecked;

                                      print("country $values");
                                      if (isChecked) {
                                        _countryCtrl.text = values.name;
                                        _stateCtrl.text = '';
                                        _cityCtrl.text = '';
                                        _profileResponse.info!.state = null;
                                        _profileResponse.info!.city = null;
                                        _profileResponse.info!.country =
                                            values.name;
                                        _profileResponse.info!.countryCode =
                                            values.code;
                                        _smcBloc.add(SMCParams(
                                            type: 'state',
                                            countryCode: values.code));
                                      } else {
                                        _profileResponse.info!.country = null;
                                        _countryCtrl.text = "";
                                        _stateCtrl.text = '';
                                        _cityCtrl.text = '';
                                      }
                                    });
                                  }
                                },
                                errorWidget: Container(),
                              );
                            }),
                        BlocBuilder<SmcBloc, SmcState>(
                            bloc: _smcBloc,
                            builder: (context, snapshot) {
                              if (snapshot is SmcLoading) {
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
                                        _profileResponse.info!.city = null;
                                        _profileResponse.info!.state =
                                            values.name;
                                        _smcBloc.add(SMCParams(
                                            type: 'city',
                                            stateCode: values.name));
//																				_city.addAll(getCities(values.name));
                                      } else {
                                        _profileResponse.info!.state = null;
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
                                  if (values is Item)
                                    state(() {
                                      _city
                                          .singleWhere((test) => test == values)
                                          .isSelected = isChecked;
                                      print("city $values");
                                      if (isChecked) {
                                        setState(() {
                                          _profileResponse.info!.locationId =
                                              int.parse(values.id);
                                        });

                                        _cityCtrl.text = values.name;
                                        _profileResponse.info!.city =
                                            values.name;
                                        print(GlobalData
                                            .myProfile.info!.locationId);
                                      } else {
                                        _profileResponse.info!.city = null;
                                        _cityCtrl.text = "";
                                      }
                                    });
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
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                        )),
                                  ),
                            InkWell(
                              onTap: () {
                                if (_pageController.page!.round() == 0 &&
                                    _profileResponse.info!.country != null) {
                                  _pageController.nextPage(
                                      duration: Duration(milliseconds: 350),
                                      curve: Curves.easeInOut);
                                } else if (_pageController.page!.round() == 1 &&
                                    _profileResponse.info!.state != null) {
                                  _pageController.nextPage(
                                      duration: Duration(milliseconds: 350),
                                      curve: Curves.easeInOut);
                                } else if (_pageController.page!.round() == 2 &&
                                    _profileResponse.info!.city != null) {
                                  _pageController.nextPage(
                                      duration: Duration(milliseconds: 350),
                                      curve: Curves.easeInOut);
                                } else {
                                  GlobalWidgets()
                                      .showToast(msg: "All fields mandatory");
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
                                    child: _profileResponse.info!.country !=
                                                null &&
                                            _profileResponse.info!.state !=
                                                null &&
                                            _profileResponse.info!.city != null
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: TextView(
                                              "Close",
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.visible,
                                              textAlign: TextAlign.center,
                                              textScaleFactor: .8,
                                              color: Colors.white,
                                              size: 12,
                                            ))
                                        : TextView(
                                            "Next",
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            color: Colors.white,
                                            size: 12,
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
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
