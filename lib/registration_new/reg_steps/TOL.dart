import 'dart:ui';
import 'package:circle_list/circle_list.dart';
import 'package:coupled/Utils/Modals/SMC/smc_bloc.dart';
import 'package:coupled/Utils/Modals/SMC/smc_widget.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/snow_effect.dart';
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

class TOL extends StatefulWidget {
  static String route = 'TOL';

  // final ValueChanged<bool> valueChanged;
  //
  // TOL({this.valueChanged});

  @override
  _TOLState createState() => _TOLState();
}

class _TOLState extends State<TOL>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? _controller, _iconController;
  SmcBloc _smcBloc = SmcBloc();
  bool hideBackButton = true;
  TextEditingController _countryCtrl = TextEditingController(),
      _stateCtrl = TextEditingController(),
      _cityCtrl = TextEditingController(),
      _pincodeCtrl = TextEditingController(),
      _addressCtrl = TextEditingController();
  Animation<double>? _fadeIn, _fadeOut;
  PageController? pageController;
  bool isVisible = false;
  double _padding = 20.0;
  Info info = Info(maritalStatus: BaseSettings(options: []));
  List<Map<String, String>> tolTitles = [
    {'title': 'Start Chatting', 'icon': 'assets/TOL/Start-Chating.png'},
    {
      'title': 'Make Lasting Impression',
      'icon': 'assets/TOL/Make-Lasting-Impression.png'
    },
    {'title': 'Earn Three Hearts', 'icon': 'assets/TOL/Earn-Three-Hearts.png'},
    {
      'title': 'Unlock Token Of Love',
      'icon': 'assets/TOL/Unlock-Token-of-Love.png'
    },
    {
      'title': 'Get Eligible To Send A Gift',
      'icon': 'assets/TOL/Purchase-Icon.png'
    },
    {'title': 'Choose Pay And Send', 'icon': 'assets/TOL/Choose-Pay-Send.png'},
  ];

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

  Widget _buildItem(int i) {
    return Center(
      child: ClipRRect(
        child: Container(
          child: Center(
            child: Column(children: <Widget>[
              Container(
                width: 205,
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(tolTitles[i]['icon'].toString()),
                        fit: BoxFit.fitHeight)),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(),
                child: TextView(
                  tolTitles[i]['title'].toString(),
                  textAlign: TextAlign.center,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible,
                  size: 13,
                  textScaleFactor: .8,
                  maxLines: 2,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  /*Widget _buildItem(int i) {
    return Column(children: <Widget>[
      */ /* Container(
        child: TextView("Hello World"),
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), border: Border.all(color: Colors.white, width: 1.0)),
      ),
      SizedBox(
        height: 10.0,
      ),*/ /*
      Container(
        height: 50,
        decoration:
            BoxDecoration(image: DecorationImage(image: AssetImage(tolIcons[i]), fit: BoxFit.fitHeight)),
        padding: EdgeInsets.all(20),
      ),
    ]);
  }
*/
  Animation<Offset> slideTransmit(
      Offset _begin, Offset _end, AnimationController _controller) {
    Animation<Offset> anime;
    Animatable<Offset> animeOffset = Tween<Offset>(
      begin: _begin,
      end: _end,
    ).chain(
      CurveTween(
        curve: Curves.easeInOutCirc,
      ),
    );
    anime = _controller.drive(animeOffset);
    return anime;
  }

  bool isSelected = false, isWished = false;
  List<Item> _country = [], _state = [], _city = [];

  void _modalBottomSheetMenu({int page = 0}) {
    PageController _pageController =
        PageController(initialPage: page, keepPage: true);
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
                                return GlobalWidgets().showCircleProgress();
                              }
                              print("Country : ${_country.length}");
                              return SMCWidget(
                                title: "Country",
                                multipleChoice: false,
                                items: _country,
                                errorWidget: snapshot is SmcError
                                    ? Center(
                                        child: TextView(
                                        snapshot.error,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                        overflow: TextOverflow.visible,
                                        size: 12,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: .8,
                                      ))
                                    : SizedBox(),
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
                                        _profileResponse.info!.state = null;
                                        _profileResponse.info!.city = null;
                                        setState(() {
                                          _profileResponse.info!.countryCode =
                                              values.code;
                                        });
                                        _profileResponse.info!.country =
                                            values.name;
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
                              );
                            }),
                        BlocBuilder<SmcBloc, SmcState>(
                            bloc: _smcBloc,
                            builder: (context, snapshot) {
                              print("State : ${snapshot.toString()}");
                              if (snapshot is SmcLoading &&
                                  snapshot.extras == 'state') {
                                return GlobalWidgets().showCircleProgress();
                              }
                              return SMCWidget(
                                title: "State",
                                multipleChoice: false,
                                items: _state,
                                errorWidget: snapshot is SmcError
                                    ? Center(
                                        child: TextView(
                                        snapshot.error,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                        overflow: TextOverflow.visible,
                                        size: 12,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: .8,
                                      ))
                                    : SizedBox(),
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
                              );
                            }),
                        BlocBuilder<SmcBloc, SmcState>(
                            bloc: _smcBloc,
                            builder: (context, snapshot) {
                              print("City : ${snapshot.toString()}");
                              if (snapshot is SmcLoading &&
                                  snapshot.extras == 'city') {
                                return GlobalWidgets().showCircleProgress();
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
                                        print('values.id------');
                                        print(values.id);
                                        setState(() {
                                          GlobalData.myProfile.address!
                                                  .locationId =
                                              int.parse(values.id);
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
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.visible,
                                            size: 12,
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
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                      overflow: TextOverflow.visible,
                                      size: 12,
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

  buildAddressForm() => FadeTransition(
        opacity: _fadeIn!,
        child: Visibility(
          visible: isVisible,
          replacement: Container(),
          child: Container(
            margin: EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                TextView(
                  "That's great!",
                  size: 24.0,
                  fontWeight: FontWeight.bold,
                  color: CoupledTheme().primaryBlue,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .9,
                ),
                TextView(
                  "Share your complete postal address,\nyou may receive a surprise from someone too.",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  color: CoupledTheme().primaryBlue,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.visible,
                  size: 12,
                  textScaleFactor: .8,
                ),
                SizedBox(
                  height: _padding,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        _modalBottomSheetMenu();
                      });
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
                  height: _padding,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _modalBottomSheetMenu();
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
                  height: _padding,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _modalBottomSheetMenu();
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
                SizedBox(
                  height: _padding,
                ),
                Column(
                  children: <Widget>[
                    EditTextBordered(
                      hint: "Address",
                      maxLength: 300,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.go,
                      maxLines: 6,
                      size: 14.0,
//                        errorText: _addressCtrl.text.isEmpty ? "" : null,
                      setDecoration: true,
                      //textInputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      controller: _addressCtrl,
                      onChange: (value) {
                        setState(() {
                          _profileResponse.address!.address = _addressCtrl.text;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: _padding,
                ),
                EditTextBordered(
                  hint: "Pincode",
                  controller: _pincodeCtrl,
                  textInputAction: TextInputAction.go,
                  errorText: (_pincodeCtrl.text.length == 6)
                      ? null
                      : "Enter 6 digits Pincode",
                  size: 16.0,
                  maxLength: 6,
//                  errorText: _pincodeCtrl.text.isEmpty ? "" : null,`
                  keyboardType: TextInputType.number,
//                   keyboardType: TextInputType.numberWitshOptions(
//                       signed: true, decimal: true),
                  hintColor: Colors.white,
                  color: Colors.white,
                  onChange: (value) {
                    setState(() {
                      GlobalData.myProfile.address!.pincode =
                          int.parse(_pincodeCtrl.text);
                    });
                  },
                  /* onChange: (value) {
                    print('_pincodeCtrl.text-------');
                    print(_pincodeCtrl.text);
                    // _profileResponse.address.pincode = int.parse(
                    //     _pincodeCtrl.text.isEmpty ? "0" : _pincodeCtrl.text);
                    GlobalData.myProfile.address.pincode = int.parse(_pincodeCtrl.text);

                    print(GlobalData.myProfile.address.pincode);
                  },*/
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: <Widget>[
                    TextView(
                      "Your address information is secured with us and would not be visible to anyone.",
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      size: 12,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                      maxLines: 2,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
  bool isPreValueSet = false;

/*  @override
  void didChangeDependencies() {


    super.didChangeDependencies();
  }*/

  void preValue(bool tolStatus) {
    Address? address = _profileResponse.address;
    if (tolStatus) {
      info = _profileResponse.info!;

      if (address == null) address = Address();
      print("*****address****");
      print(address);
      address.tolStatus = 1;
      _countryCtrl.text = (address.country = address.country) == null
          ? (_countryCtrl.text = info.country!.toString())
          : (address.country).toString();
      address.countryCode =
          address.countryCode == null ? info.countryCode.toString() : address.countryCode;
      _stateCtrl.text = address.state = address.state == null
          ? (_stateCtrl.text = info.state.toString())
          : address.state;
      _cityCtrl.text = address.city =
          address.city == null ? (_cityCtrl.text = info.city.toString()) : address.city;
      address.locationId =
          address.locationId == 0 ? info.locationId : address.locationId;
      _addressCtrl.text = address.address;
      _pincodeCtrl.text =
          GlobalData.myProfile.address!.pincode.toString() ?? '';
      // _pincodeCtrl.text =
      //     address.pincode == 0 ? "" : address.pincode.toString();

      print("WORKED $address");
      print("WORKED ${_profileResponse.info}");
      print(
          "WORKED ${_pincodeCtrl.text == ""} ${address.pincode == 0} ${address.pincode.toString()}");

      //   widget.valueChanged(true);
      _controller!.forward();
      _iconController!.forward();
      isWished = isVisible = true;
    } else {
      address!.tolStatus = 0;
      address.address = "";
      //  address.pincode = 0;
      //widget.valueChanged(false);
    }
  }

  @override
  void dispose() {
    _smcBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    _smcBloc = _smcBloc ?? SmcBloc();
    _smcBloc.add(SMCParams());
    _controller = AnimationController(
      vsync: this,
      reverseDuration: Duration(milliseconds: 350),
      duration: Duration(milliseconds: 750),
    );
    _iconController = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
      reverseDuration: Duration(milliseconds: 250),
      duration: Duration(milliseconds: 250),
    );
    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(_controller!);
    _fadeOut = Tween(begin: 1.0, end: 0.0).animate(_iconController!);
    pageController = PageController(initialPage: 0, keepPage: true);

    _profileResponse = GlobalData.myProfile;
    if (_profileResponse.address == null) _profileResponse.address = Address();

    Info? info = _profileResponse.info;
    Address? address = _profileResponse.address;
    print("TOL WORKED ");
    print(_profileResponse.address ?? '');
    print(address);
    print(info != null);
    print(address!.tolStatus == 1);
    if (_profileResponse.address != null &&
        info != null &&
        address.tolStatus == 1) {
      print("WORKED ");
      preValue(true);
    } else {
      preValue(false);
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
            progress: 0.64,
            title: 'Personal Details',
            step: 9,
            params: getSectionNine()),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
            ),
            BlocListener<SmcBloc, SmcState>(
              bloc: _smcBloc,
              listener: (context, snapshot) {
                //  setState(() {
                if (snapshot is SmcCountry) {
                  _country = snapshot.countries;
                  Item isCountry = _country.singleWhere(
                    (element) =>
                        element.name.toLowerCase() ==
                        _profileResponse.address!.country.toLowerCase(),
                  );
                  if (isCountry != null) {
                    isCountry.isSelected = true;
                    _smcBloc.add(
                        SMCParams(type: 'state', countryCode: isCountry.code));
                  }
                  print("Countries : $isCountry");
                }
                if (snapshot is SmcStates) {
                  _state = snapshot.states;
                  Item isState = _state.singleWhere(
                    (element) =>
                        element.name.toLowerCase() ==
                        _profileResponse.address!.state.toLowerCase(),
                  );
                  if (isState != null) {
                    isState.isSelected = true;
                    _smcBloc
                        .add(SMCParams(type: 'city', stateCode: isState.name));
                  }
                  print(
                      "State : $isState   ${_profileResponse.address!.state}");
                }
                if (snapshot is SmcCity) {
                  _city = snapshot.cities;
                  bool item = _city
                      .singleWhere(
                        (element) =>
                            element.name.toLowerCase() ==
                            _profileResponse.address!.city.toLowerCase(),
                      )
                      .isSelected = true;
                  print("City : $item");
                }
                //   });
              },
              child: Stack(
                alignment: Alignment(0, 1),
                children: <Widget>[
                  //SnowEffect....................
                  SnowWidget(
                    totalSnow: 250,
                    speed: 5,
                  ),
                  Positioned(
                    left: -10.0,
                    right: -10.0,
                    child: SlideTransition(
                      position: slideTransmit(const Offset(0.0, 0.5),
                          const Offset(0.0, -0.5), _controller!),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/TOL/Globe.png'),
                                colorFilter: ColorFilter.mode(
                                    CoupledTheme().inactiveColor,
                                    BlendMode.srcIn),
                                fit: BoxFit.fitWidth)),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.width * 0.2,
                    left: MediaQuery.of(context).size.width * 0.0,
                    width: MediaQuery.of(context).size.width + 100,
                    height: 350.0,
                    child: FadeTransition(
                      opacity: _fadeOut!,
//              position: slideTransmit(const Offset(0.0, 0.0), const Offset(0.0, -2.4), controller),
                      child: CircleList(
                        //physics: CircleFixedExtentScrollPhysics(),
                        //renderChildrenOutsideViewport: false,
                        //axis: Axis.horizontal,
                        //clipToSize: true,
                        //itemExtent: 150,
                        innerRadius: 60,
                        childrenPadding: 10,
                        children: List.generate(tolTitles.length, _buildItem),
                        //radius: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 100.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected
                                    ? _controller!.forward()
                                    : _controller!.reverse();
                                isSelected = !isSelected;
                              });
                            },
                            child: TextView(
                              "Token Of Love",
                              size: 32.0,
                              color: CoupledTheme().primaryPink,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextView(
                            "Surprise the special one\nwith a gift and take the proposal to next level",
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.visible,
                            size: 12,
                            textScaleFactor: .8,
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          CustomCheckBox(
                            textSize: 14.0,
                            value: isWished,
                            onChanged: (value) {
                              setState(() {
                                isWished = value!;
                                _profileResponse.address!.tolStatus =
                                    value ? 1 : 0;

                                //  widget.valueChanged(value);
                                if (isWished) {
                                  _controller!.forward();
                                  _iconController!.forward();
                                  isVisible = true;
                                  preValue(true);
                                } else {
                                  _controller!.reverse();
                                  _iconController!.reverse();
                                  isVisible = false;
                                  preValue(false);
                                }
                              });
                            },
                            text:
                                "Yes I wish to send and receive Token of Love",
                            secondary: SizedBox(),
                          ),
                          buildAddressForm()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //     data['country_code'] = GlobalData.myProfile.address?.countryCode;
            //     data['location_id'] = GlobalData.myProfile.address?.locationId;
            // data['address'] = GlobalData.myProfile.address?.address;
            //     data['pincode'] = GlobalData.myProfile.address?.pincode;
            // data['tol_status'] = GlobalData.myProfile.address?.tolStatus;

            getBottomNavigationButtons(step: 9, params: {
              "country_code": _profileResponse.info!.countryCode,
              "location_id": GlobalData.myProfile.address!.locationId,
              "address": GlobalData.myProfile.address!.address,
              "pincode": _pincodeCtrl.text,
              "tol_status": GlobalData.myProfile.address!.tolStatus
            })
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
