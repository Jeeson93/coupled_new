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
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';

const kGoogleApiKey = "AIzaSyDAcIc_0VyEmcN_S4i1zpBpYUi4qRC0LMo";

// to get places detail (lat/lng)
class SectionFive extends StatefulWidget {
  static String route = 'SectionFive';

  _SectionFiveState createState() => _SectionFiveState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _SectionFiveState extends State<SectionFive>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TextEditingController dobCtrl = TextEditingController(),
      locationCtrl = TextEditingController();
  SmcBloc _smcBloc = SmcBloc();
  bool hideBackButton = true;
  String _selectedCountry = "", _selectedState = "", _selectedCity = "";
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  TextEditingController timeCtrl = TextEditingController();
  List<Item> _country = [] /*, _state = List(), _city = List()*/;

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
  DateTime selectedTime = DateTime(0);

  // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  @override
  void didChangeDependencies() {
    if (_profileResponse.info != null) {
      print("jok${_profileResponse.info!.bornPlace}");
      locationCtrl.text = _profileResponse.info!.bornPlace.toString() != 'null'
          ? _profileResponse.info!.bornPlace.toString()
          : 'born location';
      var time = _profileResponse.info!.bornTime.toString() != ''
          ? GlobalWidgets().timeFormatter(
              context, _profileResponse.info!.bornTime.toString())
          : '';
      timeCtrl.text = time;
      var formatter = DateFormat('dd-MM-yyyy');
      dobCtrl.text = formatter.format(_profileResponse.info?.dob as DateTime);
    }

    super.didChangeDependencies();
  }

  @override
  void initState() {
    _profileResponse = GlobalData.myProfile;
    print("noel");
    print(_profileResponse.info?.bornPlace.toString());

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
            progress: 0.36,
            title: 'Personal Details (Optional)',
            step: 5,
            params: getSectionFive()),
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
                  if (snapshot is SmcCountry) {
                    setState(() {
                      _country = snapshot.countries;
                      print("Countries : $_country");
                    });
                  }
                  /*   if (snapshot is SmcStates) {
                    _state = snapshot.states;
                  }
                  if (snapshot is SmcCity) {
                    _city = snapshot.cities;
                  }*/
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextView(
                      "My Birth Details",
                      size: 18.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .9,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /* Container(
                          height:60,
                          width: 280,
                          child: TextField(
                            enabled: false,
                            readOnly: true,
                            showCursor: true,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Bariol',
                              fontWeight: FontWeight.bold,
                            ),
                            controller: locationCtrl,
                            autocorrect: true,
                            decoration: InputDecoration(
                              hintText: 'Location',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1),
                              ),
                              fillColor: Colors.white,
                            ),
                          ),
                        ),*/
                        Flexible(
                          flex: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                handlePressButton();
                              },
                              child: EditTextBordered(
                                enabled: false,
                                controller: locationCtrl,
                                hint: "Location",
                                size: 16.0,
                                hintColor: Colors.white,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        //SizedBox(width: 5,),

                        Flexible(
                          flex: 1,
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  locationCtrl.clear();
                                  _profileResponse.info!.bornPlace = '';
                                });
                                setState(() {});
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Icon(
                                    Icons.delete_forever,
                                    color: CoupledTheme().primaryBlue,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "delete",
                                    style: TextStyle(
                                      color: CoupledTheme().primaryBlue,
                                      fontFamily: 'Bariol',
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: EditTextBordered(
                                enabled: false,
                                controller: dobCtrl,
                                hint: "DOB",
                                size: 16.0,
                                hintColor: Colors.white,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        Flexible(
                          flex: 1,
                          child: Builder(
                            builder: (context) => Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectTime(context);
                                  });
                                },
                                child: EditTextBordered(
                                  enabled: false,
                                  hint: "Time",
                                  controller: timeCtrl,
                                  size: 16.0,
                                  hintColor: Colors.white,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    /*  SizedBox(
                      height: 16,
                    ),
                    TextView(
                      "Double tap on location field to set birth location",
                      size: 13.0,
                      color: CoupledTheme().primaryBlue,
                    ),*/
                  ],
                ),
              ),
            ),
            getBottomNavigationButtons(step: 5, params: getSectionFive()),
          ],
        ),
      ),
    );
  }

  void setLocation() {
    setState(() {
      List<String> completeLoc = [];
      Map<int, String> comLocation = Map();
      comLocation = {0: _selectedCity, 1: _selectedState, 2: _selectedCountry};
      comLocation.forEach((f, l) {
        if (l.isNotEmpty) completeLoc.add(l);
      });
      locationCtrl.text = completeLoc.join(", ");
      _profileResponse.info?.bornPlace = locationCtrl.text;
    });
  }

  void _selectTime(BuildContext context) {
    DatePicker.showTime12hPicker(context,
        theme: DatePickerTheme(
          containerHeight: 210.0,
        ),
        showTitleActions: true,
        currentTime: selectedTime,
        onChanged: (time) {
          timeFormat(time);
        },
        locale: LocaleType.en,
        onConfirm: (time) {
          timeFormat(time);
        });
  }

  void timeFormat(DateTime time) {
    setState(() {
      selectedTime = time;
      DateFormat dateFormat = DateFormat("hh:mm a");
      var t = dateFormat.format(selectedTime);
      print('confirm $t');
      timeCtrl.text = "$t";
      String timeToDate = DateFormat("HH:mm:ss").format(time);
      _profileResponse.info!.bornTime = timeToDate;
      print("dobController ${_profileResponse.info!.bornTime}");
    });
  }

/*  void _modalBottomSheetMenu({int page = 0}) {
    PageController _pageController;
    _pageController = PageController(initialPage: page, keepPage: true);

    Future.delayed(Duration(milliseconds: 150), () {
      _pageController.jumpToPage(page == null ? 0 : page);
      hideBackButton = _pageController.page == null || _pageController.page == 0;
    });
  }*/

  Future<void> handlePressButton() async {
    Mode _mode = Mode.overlay;

    // show input autocomplete with selected mode
    // then get the Prediction selected

    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        logo: Container(
          color: Colors.white,
          height: 0,
        ),
        language: "en",
        components: [Component(Component.country, "IN")],
        types: ["(regions)"],
        strictbounds: false);

    displayPrediction(
      p!,
    );
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState!.showSnackBar(
      SnackBar(content: Text(response.errorMessage.toString())),
    );
  }

  Future<void> displayPrediction(
    Prediction p,
  ) async {
    if (p != null) {
      // get detail (lat/lng)
      // PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      // final lat = detail.result.geometry.location.lat;
      // final lng = detail.result.geometry.location.lng;

      // scaffold.showSnackBar(
      //  // SnackBar(content: Text("${p.description} - $lat/$lng")),
      // );
      setState(() {
        locationCtrl.text = p.description!;
        _profileResponse.info?.bornPlace = locationCtrl.text;
      });
      print(_profileResponse.info?.bornPlace);
      print(locationCtrl.text);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
