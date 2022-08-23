import 'dart:async';

import 'package:coupled/Actions/share_view.dart';
import 'package:coupled/Home/Profile/MyProfile/PhotoView.dart';
import 'package:coupled/Home/Profile/MyProfile/profile_items.dart';
import 'package:coupled/Home/Profile/Recommendation/Recommendations.dart';
import 'package:coupled/Home/Profile/othersProfile/helpers/profileItem_card.dart';
import 'package:coupled/Home/Profile/profile_switch.dart';
import 'package:coupled/MatchMeter/view/specially_abled.dart';

import 'package:coupled/REST/RestAPI.dart';

import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/custom_progress_bar.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/profile.dart';

import 'package:coupled/registration_new/controller/page_controller.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:coupled/Utils/capitalize_string.dart';

class Profile extends StatefulWidget {
  Profile();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late ProfileResponse profileResponse;
  Dialogs dialogs = Dialogs();
  late Info info;
  dynamic educationJob;
  Family? family;
  late OfficialDocuments officialDocuments;
  ScrollController nestedScrollController =
      ScrollController(keepScrollOffset: true);
  bool isVerified = false;
  bool isOnline = false;
  List<Sibling> siblings = [], brother = [], sister = [];
  double roundBtnSize = 35.0;
  double screenWidth = 0.0;
  var _pagerPosition = 0;
  List<Widget> profileImages = <Widget>[];
  PageController pageController = PageController(initialPage: 1);
  int i = 0;
  List<Dp?> photos = [];
  late AnimationController _controller;
  late Animation<double> _fadeOut;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

/*
  gotoEditPage(GotoPage goto) async {
    final profileResponse =
        await Navigator.of(context).pushNamed('/personDetailPage',
            arguments: PersonalDetails(
              profileEdit: true,
              gotoPage: goto,
            ));
    //_userBloc.add(InitialCall());

    if (profileResponse != null) {
      profileImages = List();
      _pagerPosition = 0;
    }

//	  if (profileResponse != null) setState(() {
//		  print("LoadUser in gotoEditPage\n${(profileResponse as ProfileResponse).info.weight}");
//		  initiateData(profileResponse as ProfileResponse);
//	  });
  }
*/

  void initiateData() {
    profileResponse = GlobalData.myProfile;
    info = profileResponse.info!;
    educationJob = profileResponse.educationJob;
    family = profileResponse.family;
    siblings = profileResponse.siblings;
    officialDocuments = profileResponse.officialDocuments!;
    photos = profileResponse.photos;

    ///adding image to a list, order by dp_status
    if (photos != null && profileImages.length == 0) {
      photos.forEach((photo) {
        print(
          APis().imageApi(
            photo?.photoName,
          ),
        );

        photo?.dpStatus == 1
            ? profileImages.insert(
                0,
                Container(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 3 / 3,
                        child: FadeInImage.assetNetwork(
                          height: 400,
                          fit: BoxFit.cover,
                          placeholder: "assets/logo/mini_logo_pink.png",
                          fadeInDuration: Duration(milliseconds: 350),
                          alignment: FractionalOffset.topCenter,
                          image: APis().imageApi(
                            photo?.photoName,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.black12,
                                  Colors.transparent,
                                  Colors.black,
                                ],
                                stops: [
                                  0.25,
                                  0.75,
                                  1.0
                                ],
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter)),
                      ),
                    ],
                  ),
                ))
            : profileImages.add(
                Container(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 3 / 3,
                        child: FadeInImage.assetNetwork(
                          height: 400,
                          fit: BoxFit.cover,
                          placeholder: "assets/logo/mini_logo_pink.png",
                          fadeInDuration: Duration(milliseconds: 350),
                          alignment: FractionalOffset.topCenter,
                          image: APis().imageApi(
                            photo?.photoName,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.black12,
                                  Colors.transparent,
                                  Colors.black,
                                ],
                                stops: [
                                  0.25,
                                  0.75,
                                  1.0
                                ],
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter)),
                      ),
                    ],
                  ),
                ),
              );
      });

      print("profileImages No:${photos.length} ${profileImages.length}");
    }
    //  if (siblings != null && brother.length == 0 && sister.length == 0)
    brother.clear();
    sister.clear();
    siblings.forEach((item) {
      if (item.role != null) {
        if (item.role!.value.toLowerCase().contains("brother")) {
          brother.add(item);
        } else {
          sister.add(item);
        }
      }
    });
    print("bro ${brother.length} sis ${sister.length}");
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies Profile");

    super.didChangeDependencies();
  }

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    _fadeOut = Tween(begin: 0.0, end: 1.0).animate(_controller);

    nestedScrollController.addListener(() {
      if (nestedScrollController.position.pixels != 0)
        nestedScrollController.position.userScrollDirection ==
                    ScrollDirection.reverse &&
                !nestedScrollController.position.atEdge
            ? _controller.reverse()
            : _controller.forward();
      else
        _controller.reverse();
    });
    initiateData();
    return super.initState();
  }

  ///TODO update user profile
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CoupledTheme().backgroundColor,
      body: SafeArea(
          child: Scaffold(
        floatingActionButton: floatingBtn(),
        body: NestedScrollView(
          controller: nestedScrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: CoupledTheme().backgroundColor,
                expandedHeight: MediaQuery.of(context).size.height * .62,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: StatefulBuilder(
                    builder: (context, state) => Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PhotoView(
                                  pageIndex: pageController.page!.toDouble(),
                                  photos: photos,
                                ),
                              ),
                            );
                          },
                          child: PageView.builder(
                              controller: pageController,
                              onPageChanged: onPageChanged,
                              itemCount: profileImages.length,
                              itemBuilder: (context, position) {
                                return profileImages[position];
                              }),
                        ),
                        SafeArea(
                          child: Container(
                            height: 6,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: Container(
                                    height: 6,
                                    width: screenWidth / profileImages.length,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      child: CustomProgressBar(
                                        value: _pagerPosition == index ? 1 : 0,
                                        backgroundColor: Colors.white,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                CoupledTheme().primaryBlue),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: profileImages.length,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                ShareProfileBtn(
                                    membershipCode:
                                        profileResponse.membershipCode),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    regPageController(context, step: 10);
                                  },
                                  child: Image.asset(
                                    "assets/Profile/Edit-.png",
                                    height: CoupledTheme().mediumIcon,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Stack(
            children: <Widget>[
              Container(
                color: CoupledTheme().backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        TextView(
                                          "${profileResponse.name.toString().capitalize} ${profileResponse.lastName.toString().capitalize}",
                                          size: 18,
                                          color: isOnline
                                              ? CoupledTheme().greenOnline
                                              : Colors.white,
                                          decoration: TextDecoration.none,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        TextView(
                                          ", ${info.dob != null ? GlobalWidgets().getAge(info.dob) : ''}",
                                          size: 18,
                                          decoration: TextDecoration.none,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CommonThings()
                                            .customToolTip(officialDocuments)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    TextView(
                                      profileResponse.membershipCode ?? '',
                                      decoration: TextDecoration.none,
                                      overflow: TextOverflow.visible,
                                      size: 12,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )
                                  ],
                                ),
                                BtnWithText(
                                  img: "assets/Profile/Badge.png",
                                  text: profileResponse.membership?.planName ??
                                      '',
                                  textSize: 12,
                                  onTap: () {
                                    _showDialogPlanDetails(profileResponse);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              //   physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                ///Buzz About My Perfect Partner
                                ProfileItems(
                                  img:
                                      "assets/Profile/Buzz-About-My-Perfect-Partner.png",
                                  title: "Buzz About My Perfect Partner",
                                  onTap: () {
                                    regPageController(context, step: 7);
                                  },
                                  card: GlobalWidgets().card(
                                      strings: [info.aboutPartner],
                                      onTap: () {}),
                                ),

                                ///My Personal Fact Sheet
                                ProfileItems(
                                  img:
                                      "assets/Profile/My-Personal-Fact-Sheet.png",
                                  title: "My Personal Fact Sheet",
                                  onTap: () {
                                    regPageController(context, step: 1);
                                  },
                                  card: Wrap(
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      ProfileItemCard(
                                          title:
                                              "${info.dob != null ? GlobalWidgets().getAge(info.dob) : ''} yrs",
                                          img: "assets/Profile/Age.png"),
                                      ProfileItemCard(
                                          title: "${CommonThings().convertFeet(
                                                    info.height,
                                                  ) + " ft"}\n${info.height.toString()}" +
                                              " cm",
                                          img: "assets/Profile/height.png"),
                                      ProfileItemCard(
                                          title: info.weight.toString() + " kg",
                                          img: "assets/Profile/Kg.png"),
                                      ProfileItemCard(
                                        title: toBeginningOfSentenceCase(
                                                info.complexion?.value)
                                            .toString(),
                                        img: "assets/Profile/Wheatish.png",
                                        color: GlobalWidgets().complexionColor(
                                            info.complexion?.value),
                                      ),
                                      ProfileItemCard(
                                        title: toBeginningOfSentenceCase(
                                                info.bodyType?.value)
                                            .toString(),
                                        img: GlobalWidgets().getBodyTypeImg(
                                            info.bodyType?.value),
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 22),
                                  child: TextView(
                                    'Hello! Date of Birth can be edited one time only. Please make sure you enter the correct information.',
                                    color: CoupledTheme().primaryBlue,
                                    decoration: TextDecoration.none,
                                    overflow: TextOverflow.visible,
                                    size: 12,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                ///my location
                                ProfileItems(
                                  img: "assets/Profile/My-Location.png",
                                  title: "My Location",
                                  onTap: () {
                                    regPageController(context, step: 4);
                                  },
                                  card: GlobalWidgets().card(strings: [
                                    "${toBeginningOfSentenceCase(info.city)}\n"
                                        "${toBeginningOfSentenceCase(info.state)}, "
                                        "${toBeginningOfSentenceCase(info.country)}",
                                  ], onTap: () {}),
                                ),

                                ///profession
                                ProfileItems(
                                  img: "assets/Profile/My-Job-&-Education.png",
                                  title:
                                      "My Job & Education ${educationJob?.jobStatus == 1 ? "(Present Job)" : ""}",
                                  onTap: () {
                                    regPageController(context, step: 14);
                                  },
                                  card: Wrap(
                                    children: [
                                      GlobalWidgets().card(strings: [
                                        profileResponse
                                                .educationJob!.companyName ??
                                            '',
                                        profileResponse.educationJob
                                                ?.profession!.value ??
                                            '',
                                        profileResponse.educationJob!.industry!
                                                .value ??
                                            '',
                                        profileResponse
                                                .educationJob!.experience!.value
                                                .toString() ??
                                            '',
                                        profileResponse.educationJob!
                                                .incomeRange!.value ??
                                            '',
                                      ], onTap: () {}),
                                      GlobalWidgets().card(strings: [
                                        profileResponse.educationJob
                                                ?.highestEducation!.value ??
                                            '',
                                        profileResponse.educationJob
                                                ?.educationBranch!.value ??
                                            '',
                                      ], onTap: () {}),
                                    ],
                                  ),
                                ),

                                ///Coupling Score Predictions
                                ProfileItems(
                                    img: "assets/Profile/Coupling-Score.png",
                                    title: "Coupling Score Q & A's",
                                    onTap: () {
                                      regPageController(context, step: 17);
                                    },
                                    card: Container()),

                                ///cast & religion
                                ProfileItems(
                                  img: "assets/Profile/My-Religion-&-Cast.png",
                                  title: "My Religion & Caste",
                                  onTap: () {
                                    regPageController(context, step: 13);
                                  },
                                  card: GlobalWidgets().card(strings: [
                                    family == null
                                        ? ""
                                        : family!.religion == null
                                            ? ""
                                            : family!.religion!.value,
                                    family == null
                                        ? ""
                                        : family!.cast == null
                                            ? ""
                                            : family!.cast!.value,
                                    family == null
                                        ? ""
                                        : family!.subcast == null
                                            ? ""
                                            : family!.subcast!.value,
                                    family == null
                                        ? ""
                                        : family!.gothram == null
                                            ? ""
                                            : family!.gothram!.value
                                  ], onTap: () {}),
                                ),

                                ///marital status
                                ProfileItems(
                                  img: "assets/Profile/My-Marital-Status.png",
                                  title: "My Marital Status",
                                  onTap: () {
                                    regPageController(context, step: 3);
                                  },
                                  card: GlobalWidgets().card(strings: [
                                    info.maritalStatus == null ||
                                            info.maritalStatus!.value == null
                                        ? ""
                                        : info.maritalStatus!.value,
                                    info.numberOfChildren == 0
                                        ? ""
                                        : "${info.numberOfChildren} ${info.numberOfChildren == 1 ? "Child" : "Children"}",
                                    info.childLivingStatus == null ||
                                            info.childLivingStatus?.value == null
                                        ? ""
                                        : info.childLivingStatus?.value
                                  ], onTap: () {}),
                                ),

                                ///my family
                                ProfileItems(
                                  img: "assets/Profile/Meet-My-Family.png",
                                  title: "My Family",
                                  onTap: () {
                                    regPageController(context, step: 11);
                                  },
                                  card: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Wrap(
                                        children: <Widget>[
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            color: CoupledTheme().tabColor1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 8),
                                              child: Column(
                                                children: <Widget>[
                                                  TextView(
                                                    "Father",
                                                    decoration:
                                                        TextDecoration.none,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    size: 12,
                                                    textAlign: TextAlign.center,
                                                    textScaleFactor: .8,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  TextView(
                                                    family == null ||
                                                            family!.fatherOccupationStatus ==
                                                                null ||
                                                            family!.fatherOccupationStatus!
                                                                    .value ==
                                                                null
                                                        ? "Not specified"
                                                        : family!
                                                            .fatherOccupationStatus!
                                                            .value,
                                                    decoration:
                                                        TextDecoration.none,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    size: 12,
                                                    textAlign: TextAlign.center,
                                                    textScaleFactor: .8,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            color: CoupledTheme().tabColor1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 10),
                                              child: Column(
                                                children: <Widget>[
                                                  TextView(
                                                    "Mother",
                                                    decoration:
                                                        TextDecoration.none,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    size: 12,
                                                    textAlign: TextAlign.center,
                                                    textScaleFactor: .8,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  TextView(
                                                    family == null ||
                                                            family!.motherOccupationStatus ==
                                                                null ||
                                                            family!.motherOccupationStatus!
                                                                    .value ==
                                                                null
                                                        ? "Not specified"
                                                        : family!
                                                            .motherOccupationStatus!
                                                            .value,
                                                    decoration:
                                                        TextDecoration.none,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    size: 12,
                                                    textAlign: TextAlign.center,
                                                    textScaleFactor: .8,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Wrap(
                                            children: <Widget>[
                                              brother.length == 0
                                                  ? Container()
                                                  : Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      color: CoupledTheme()
                                                          .tabColor1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 12,
                                                                horizontal: 8),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                TextView(
                                                                  "Brothers",
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .visible,
                                                                  size: 12,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  textScaleFactor:
                                                                      .8,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Container(
                                                                  height: 18,
                                                                  width: 18,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    color: CoupledTheme()
                                                                        .primaryBlue,
                                                                  ),
                                                                  child:
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            GlobalWidgets().familyMembersBottomSheet(
                                                                                context,
                                                                                brother,
                                                                                sister);
                                                                          },
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Icon(
                                                                              Icons.keyboard_arrow_down,
                                                                              size: 15,
                                                                              color: Colors.white,
                                                                            ),
                                                                          )),
                                                                ),
                                                              ],
                                                            ),
                                                            TextView(
                                                              brother.length
                                                                  .toString(),
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              size: 12,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textScaleFactor:
                                                                  .8,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                              sister.length == 0
                                                  ? Container()
                                                  : Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      color: CoupledTheme()
                                                          .tabColor1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 12,
                                                                horizontal: 10),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                TextView(
                                                                  "Sisters",
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .visible,
                                                                  size: 12,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  textScaleFactor:
                                                                      .8,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Container(
                                                                  height: 18,
                                                                  width: 18,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    color: CoupledTheme()
                                                                        .primaryBlue,
                                                                  ),
                                                                  child: GestureDetector(
                                                                      onTap: () {
                                                                        GlobalWidgets().familyMembersBottomSheet(
                                                                            context,
                                                                            brother,
                                                                            sister);
                                                                      },
                                                                      child: Center(
                                                                          child: Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down,
                                                                        size:
                                                                            15,
                                                                        color: Colors
                                                                            .white,
                                                                      ))),
                                                                ),
                                                              ],
                                                            ),
                                                            TextView(
                                                              sister.length
                                                                  .toString(),
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              size: 12,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textScaleFactor:
                                                                  .8,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          GlobalWidgets().card(strings: [
                                            family?.familyType?.value
                                                .toString(),
                                            family?.familyValues?.value
                                                .toString(),
                                            family?.country != null
                                                ? ("${family?.city} , ${family?.state} ,${family?.country}")
                                                : '',
                                          ], onTap: () {}),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                ///Gossip About Myself
                                ProfileItems(
                                  img: "assets/Profile/Gossip-About-Myself.png",
                                  title: "Gossip About Myself",
                                  onTap: () {
                                    regPageController(context, step: 8);
                                  },
                                  card: GlobalWidgets().card(
                                      strings: [info.aboutSelf], onTap: () {}),
                                ),

                                ///My Kundali
                                ProfileItems(
                                  img: "assets/Profile/My-Kundali.png",
                                  title: "My Kundali",
                                  onTap: () {
                                    regPageController(context, step: 5);
                                  },
                                  card: GlobalWidgets().card(strings: [
                                    info.bornPlace,
                                    info.dob != null
                                        ? formatDate(
                                            info.dob as DateTime, [dd, '.', mm, '.', yyyy])
                                        : '',
                                    GlobalWidgets()
                                        .timeFormatter(context, info.bornTime)
                                  ], onTap: () {}),
                                ),

                                ///Specially Abled
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SpeciallyAbledList()));
                                  },
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: TextView(
                                      "Partner Requests",
                                      size: 15,
                                      decoration: TextDecoration.underline,
                                      color: CoupledTheme().primaryPink,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ProfileItems(
                                  img: "assets/Profile/Specially-Abled.png",
                                  title: "Specially Abled",
                                  onTap: () {
                                    regPageController(context, step: 3);
                                  },
                                  card: GlobalWidgets().card(
                                      strings: [
                                        info.specialCase == 0 ? "No" : "Yes",
                                        info.specialCase == 0
                                            ? ""
                                            : "${info.specialCaseType?.value}"
                                                "\n${info.specialCaseNotify == 0 ? "Visible" : "Hidden"}"
                                      ],
                                      card2Color: CoupledTheme().tabColor2,
                                      onTap: () {}),
                                ),

                                SizedBox(
                                  height: 25,
                                ),

                                ///recommendation
                                Visibility(
                                  visible: true,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      recommendation(
                                          profileResponse.recommendGiven
                                                  .toString() ??
                                              '',
                                          profileResponse.recommendReceived
                                                  .toString() ??
                                              ''),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 8.0),
                                        child: TextView(
                                          CoupledStrings.recommendationNote,
                                          maxLines: 2,
                                          size: 11,
                                          decoration: TextDecoration.none,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  void onPageChanged(int value) {
    setState(() {
      _pagerPosition = value;
    });
  }

  floatingBtn() {
    return FadeTransition(
      opacity: _fadeOut,
      child: FloatingActionButton(
        onPressed: () {
          nestedScrollController.animateTo(0,
              duration: Duration(milliseconds: 350), curve: Curves.decelerate);
        },
        mini: true,
        backgroundColor: CoupledTheme().primaryBlue,
        child: Center(
          child: Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget recommendation(String given, String received) {
    return Container(
      child: Table(
        defaultColumnWidth: FractionColumnWidth(.27),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        columnWidths: {
          0: FractionColumnWidth(.05),
          1: FractionColumnWidth(.7),
          2: FractionColumnWidth(.2)
        },
        children: [
          TableRow(
            children: <Widget>[
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Image.asset("assets/Profile/Recommendations.png",
                      height: CoupledTheme().smallIcon),
                ),
              ),
              TableCell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 5),
                      child: TextView(
                        "Recommendations",
                        size: 16,
                        color: CoupledTheme().primaryBlue,
                        decoration: TextDecoration.none,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              color: CoupledTheme().primaryBlue,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 8),
                                child: Column(
                                  children: <Widget>[
                                    TextView(
                                      given,
                                      maxLines: 10,
                                      decoration: TextDecoration.none,
                                      overflow: TextOverflow.visible,
                                      size: 12,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    TextView(
                                      "Given",
                                      maxLines: 10,
                                      decoration: TextDecoration.none,
                                      overflow: TextOverflow.visible,
                                      size: 12,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              color: CoupledTheme().primaryBlue,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                child: Column(
                                  children: <Widget>[
                                    TextView(
                                      received,
                                      decoration: TextDecoration.none,
                                      overflow: TextOverflow.visible,
                                      size: 12,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    TextView(
                                      "Received",
                                      decoration: TextDecoration.none,
                                      overflow: TextOverflow.visible,
                                      size: 12,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TableCell(
                child: CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/recommendation',
                        arguments:
                            Recommendations(profileResponse: profileResponse));
                  },
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: LinearGradient(colors: [
                    CoupledTheme().primaryPinkDark,
                    CoupledTheme().primaryPink
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextView(
                      "View More",
                      size: 14,
                      decoration: TextDecoration.none,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDialogPlanDetails(ProfileResponse profileResponse) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            title: Row(
              children: <Widget>[
                Image.asset("assets/Profile/Badge.png",
                    height: CoupledTheme().largeIcon),
                SizedBox(
                  width: 5,
                ),
                TextView(
                  "${(profileResponse.membership!.planName ?? 'Free')} Member",
                  color: CoupledTheme().primaryBlue,
                  size: 18,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            content: Container(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (profileResponse.membership!.paidMember ?? false)
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    flex: 7,
                                    child: TextView(
                                      "Contact & Chat Credits",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                      overflow: TextOverflow.visible,
                                      size: 12,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: TextView(
                                      "${profileResponse.pendingCredits}",
//                            "${profileResponse.membership.chat} ${profileResponse.membership.chat > 1 ? "Nos." : "No."} left",
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      overflow: TextOverflow.visible,
                                      size: 12,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,

                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    flex: 7,
                                    child: TextView(
                                      "Coupling Score Credits",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                      overflow: TextOverflow.visible,
                                      size: 12,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: TextView(
                                      "${profileResponse.membership!.statistics}",
//                            "${profileResponse.membership.chat} ${profileResponse.membership.chat > 1 ? "Nos." : "No."} left",
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      overflow: TextOverflow.visible,
                                      size: 12,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,

                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 7,
                                  child: TextView(
                                    "Contact & Chat credits\nvalidity",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    overflow: TextOverflow.visible,
                                    size: 12,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TextView(
                                    ///TODO need shows only plan validity
                                    '${formatDate(profileResponse.planExpiry, [
                                          dd,
                                          '.',
                                          mm,
                                          '.',
                                          yyyy
                                        ]).toString()}',

                                    /*
                              "${profileResponse.membership.expiredAt == null || profileResponse.membership.expiredAt.isBefore(DateTime.now()) ? 0 : purchasePlan.expiredAt.difference(
                                    DateTime.now(),
                                  ).inDays} "
                              "${purchasePlan.expiredAt == null ? "Day" : purchasePlan.expiredAt.difference(
                                    DateTime.now(),
                                  ).inDays > 1 ? "Days" : "Day"} left",*/
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    overflow: TextOverflow.visible,
                                    size: 12,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            /*  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    flex: 7,
                                    child: TextView(
                                      "Coupling Score validity",
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    )),
                                Expanded(
                                  flex: 3,
                                  child: TextView(
                                    ///TODO need shows only plan validity
                                    '${formatDate(profileResponse.membership.expiredAt, [
                                      dd,
                                      '.',
                                      mm,
                                      '.',
                                      yyyy
                                    ]).toString()}',
                                    color: Colors.black,

                                    */ /* child: TextView(
                              "${purchasePlan.expiredAt == null || purchaseCoupling?.expiredAt != null ? purchaseCoupling.expiredAt.isBefore(DateTime.now()) ? 0 : purchaseCoupling.expiredAt.difference(DateTime.now()).inDays : ''}"
                              "${purchasePlan?.expiredAt == null ? "Day" : purchaseCoupling?.expiredAt != null ? purchaseCoupling.expiredAt.difference(DateTime.now()).inDays > 1 ? "Days" : "Day" : '0'} left",
                              color: Colors.black,
                            ),*/ /*
                                  ),
                                )
                              ],
                            ),*/
                          ],
                        )
                      : TextView(
                          CoupledStrings.memberFeature,
                          color: Colors.black,
                          size: 14,
                          decoration: TextDecoration.none,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                          fontWeight: FontWeight.bold,
                        ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomButton(
                    borderRadius: BorderRadius.circular(5.0),
                    gradient: LinearGradient(colors: [
                      CoupledTheme().primaryPinkDark,
                      CoupledTheme().primaryPink
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextView(
                        (profileResponse.membership?.paidMember ?? false)
                            ? "Top Up Plan"
                            : "Become A Member ",
                        size: 16,
                        decoration: TextDecoration.none,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      (profileResponse.membership!.paidMember ?? false)
                          ? Navigator.of(context).pushNamed('/myPlanPayments')
                          : Navigator.of(context).pushNamed('/membershipPlans');
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {});

    return null;
  }
}

/*class ProfileItemCard extends StatelessWidget {
  final String img, title;

  ProfileItemCard({this.img = "", this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: CoupledTheme().tabColor1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Visibility(
              visible: img == "" ? false : true,
              child: GlobalWidgets().iconCreator(img, size: FixedIconSize.LARGE_30),
            ),
            SizedBox(
              width: 5,
            ),
            TextView(
              title,
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }
}*/
