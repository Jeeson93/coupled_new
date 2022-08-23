import 'package:coupled/Home/DashBoard/dashboard_data.dart';
import 'package:coupled/MatchMaker/match_maker_page.dart';
import 'package:coupled/PlansAndPayment/MembershipPlans/view/MembershipPlans.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  static String route = 'Dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  buildRegProgress(String section, String assetImage, double status,
          {GestureTapCallback? onTap}) =>
      Column(
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Stack(
                alignment: Alignment(0, 0),
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: CoupledTheme().backgroundColor,
                      ),
                      child: CircularProgressIndicator(
                        strokeWidth: 4.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: CoupledTheme().backgroundColor,
                        value: status,
                      ),
                    ),
                  ),
                  Image.asset(
                    assetImage,
                    color: Colors.white,
                    height: 20.0,
                    width: 20.0,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
              child: TextView(
            section,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
            size: 21.0,
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.visible,
          ))
        ],
      );

  buildMatchMakerCard(String title, String imgAsset) => Card(
        color: CoupledTheme().primaryBlue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: SizedBox(
          height: 80.0,
          width: 80.0,
          child: GestureDetector(
            onTap: () {
              switch (title) {
                case 'General':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MatchMakerPage(index: 0)));
                  break;
                case 'Coupling':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MatchMakerPage(index: 1)));
                  break;
                case 'Mix':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MatchMakerPage(index: 2)));
                  break;
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GlobalWidgets()
                    .iconCreator(imgAsset, size: FixedIconSize.LARGE_30),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextView(
                      title,
                      size: 16.0,
                      textScaleFactor: .8,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                    ),
                    TextView(
                      "Matches",
                      size: 12.0,
                      textScaleFactor: .8,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  int bgImageCount = -1;
  List<String> cardBgImages = [
    "assets/PlansAndPayment/Silver.png",
    "assets/PlansAndPayment/Gold.png",
    "assets/PlansAndPayment/Diamond.png",
    "assets/PlansAndPayment/Platinum.png",
  ];

  List<Widget> planCards = [];

  DashBoardData dashBoardData = DashBoardData();
  MembershipPlansModel plansAndPaymentModel = MembershipPlansModel();

  double personalStatus = 0.0;
  double photographStatus = 0.0;
  double officeStatus = 0.0;
  double familyStatus = 0.0;
  double religionStatus = 0.0;

  @override
  void initState() {
    dashBoardData = DashBoardData();

    /**
     * store base settings & profile as global static variable
     *
        my profile called in

        1-splash screen
        2-my profile
        3-dashboard*/

    ///Coupling questions
    RestAPI()
        .get(APis.getCouplingQuestions)
        .then((value) => GlobalData.couplingQuestion = value);
    dashBoardData.getDashBoardData();

    super.initState();
  }

  int checkValue(List checkValues) {
    print('checkValues----');
    print(checkValues);
    Iterable s = checkValues.where(
        (test) => (test is String && test != null || test is int && test > 0));
    return s.length;
  }

  ///TODO dash board
  void navigate(int onPage) {
    // Navigator.of(context).pushNamed('/personDetailPage',
    //     arguments: PersonalDetails(
    //       profileEdit: true,
    //       onPage: onPage,
    //     ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoupledTheme().backgroundColor,
      body: SafeArea(
        child: StreamBuilder(
            stream: dashBoardData.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                if (snapshot.data is MembershipPlansModel) {
                  plansAndPaymentModel = snapshot.data as MembershipPlansModel;
                  setData();
                  plansAndPaymentModel.response?.plans?.forEach((f) {
                    if (int.parse(f.amount) > 0) {
                      planCards.add(
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MembershipPlans()));
                            },
                            child: PlanCards(
                              backgroundImg: getBgImage(),
                              planName: f.planName,
                              planPrice: f.amount,
                              offerCard: <Widget>[
                                buildOfferCard(f.profilesCount.toString(),
                                    "Contact views & chat credits"),
                                buildOfferCard(
                                    f.validity, "Days expiry of credits"),
                                buildOfferCard(f.csStatistics.toString(),
                                    "Free coupling score predictions Credit"),
                              ],
                              cardColor: Color(0xffb3b3b3),
                            ),
                          ),
                        ),
                      );
                    }
                  });
                }

                return Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 100.0),
                      child: Column(
                        children: <Widget>[
                          Card(
                            color: CoupledTheme().dashboardCardColor,
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: "Hello ",
                                              style: TextStyle(fontSize: 24.0)),
                                          TextSpan(
                                              text:
                                                  GlobalData?.myProfile.name ??
                                                      '',
                                              style: TextStyle(
                                                  fontSize: 24.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: CoupledTheme()
                                                      .primaryPink)),
                                        ],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Bariol',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 24.0)),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  TextView(
                                    "Let's Couple you Up!",
                                    textScaleFactor: .8,
                                    size: 21.0,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  TextView(
                                    "Putting up a complete profile shows your seriousness and result in genuine responses.",
                                    textScaleFactor: .8,
                                    size: 21.0,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    height: 100.0,
                                    child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemExtent: 85.0,
                                      children: <Widget>[
                                        buildRegProgress(
                                            "Personal",
                                            "assets/MatchBoard/Personal.png",
                                            personalStatus, onTap: () {
                                          Navigator.pushNamed(
                                              context, '/profileSwitch');
                                        }),
                                        buildRegProgress(
                                            "Photograph",
                                            "assets/MatchBoard/Photograph.png",
                                            photographStatus, onTap: () {
                                          Navigator.pushNamed(
                                              context, '/profileSwitch');
                                        }),
                                        buildRegProgress(
                                            "Family",
                                            "assets/MatchBoard/Family.png",
                                            familyStatus, onTap: () {
                                          Navigator.pushNamed(
                                              context, '/profileSwitch');
                                        }),
                                        buildRegProgress(
                                            "Religion",
                                            "assets/MatchBoard/Religion.png",
                                            religionStatus, onTap: () {
                                          Navigator.pushNamed(
                                              context, '/profileSwitch');
                                        }),
                                        buildRegProgress(
                                            "Profession\n& Education",
                                            "assets/MatchBoard/Profession-_.png",
                                            officeStatus, onTap: () {
                                          Navigator.pushNamed(
                                              context, '/profileSwitch');
                                        }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: CoupledTheme().dashboardCardColor,
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    right: -20.0,
                                    top: -30.0,
                                    child: Container(
                                      height: 75.0,
                                      width: 75.0,
                                      padding: EdgeInsets.all(15.0),
                                      alignment: Alignment(-3, 5),
                                      decoration: BoxDecoration(
                                          color: Color(0xffcfcfd7),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Image.asset(
                                        "assets/MatchBoard/Match-Maker.png",
                                        height: 40.0,
                                        width: 40.0,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      TextView(
                                        "Match Maker",
                                        size: 18.0,
                                        textScaleFactor: .8,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      TextView(
                                        "Recieve better profile recommendations.\nSet your matches preferences & expectations now",
                                        textScaleFactor: .8,
                                        size: 21.0,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          buildMatchMakerCard("General",
                                              "assets/MatchBoard/General-Matches.png"),
                                          buildMatchMakerCard("Coupling",
                                              "assets/MatchBoard/Coupling-Matches.png"),
                                          buildMatchMakerCard("Mix",
                                              "assets/MatchBoard/Mix-Matches.png"),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: CoupledTheme().dashboardCardColor,
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  TextView(
                                    "Membership",
                                    size: 18.0,
                                    textScaleFactor: .8,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  TextView(
                                    "Economical | One-time Membership | Recharge with Contact Credits",
                                    textScaleFactor: .8,
                                    size: 21.0,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                      height: 185,
                                      child: ListView(
                                          itemExtent: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              75,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: planCards))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed("/mainBoard");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          color: CoupledTheme().primaryPink,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GlobalWidgets().iconCreator(
                                  "assets/MatchBoard/Next.png",
                                  size: FixedIconSize.SMALL),
                              SizedBox(
                                width: 10.0,
                              ),
                              TextView(
                                "Matchboard".toUpperCase(),
                                textScaleFactor: .8,
                                size: 21.0,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Center(child: GlobalWidgets().showCircleProgress());
              }
            }),
      ),
    );
  }

  void setData() {
    int personalLength = 0;
    int photoLength = 10;
    int professionLength = 7;
    int familyLength = 8;
    int religionLength = 2;
    GlobalData.myProfile.photos != null
        ? photoLength = GlobalData.myProfile.photos.length
        : photoLength = 0;

    ///personal
    var personal = GlobalData.myProfile.info;
    if (GlobalData.myProfile.info != null) {
      personalLength = checkValue([
        GlobalData.myProfile.gender == null ? "" : GlobalData.myProfile.gender,
        personal?.dob == null ? "" : personal?.dob?.toIso8601String(),
        personal?.weight,
        personal?.height,
        personal?.complexion == null ? '' : personal?.complexion?.value,
        personal?.bodyType == null ? '' : personal?.bodyType?.value,
        personal?.maritalStatus == null ? '' : personal?.maritalStatus?.value,
        personal?.country,
        personal?.state,
        personal?.city,
        personal?.bornPlace,
        personal?.bornTime,
        personal?.aboutSelf,
        personal?.aboutPartner,
        GlobalData.myProfile.officialDocuments?.govtIdFront
      ]);
    } else {
      professionLength = 0;
    }

    print('professionLength');
    print(personalLength);

//                  if (GlobalData.myProfile.officialDocuments != null) {
//                    personalLength = checkValue([GlobalData.myProfile.officialDocuments.officeId,
//                    GlobalData.myProfile.officialDocuments]);
//                  }
    ///profession
    var prof = GlobalData.myProfile.educationJob;
    if (GlobalData.myProfile.educationJob != null) {
      professionLength = checkValue([
        prof?.companyName,
        prof?.industry == null ? "" : prof?.industry?.value,
        prof?.profession == null ? "" : prof?.profession?.value,
        prof?.experience == null ? "" : prof?.experience?.value,
        prof?.highestEducation == null ? "" : prof?.highestEducation?.value,
        prof?.incomeRange == null ? "" : prof?.incomeRange?.value,
        GlobalData.myProfile.officialDocuments?.govtIdFront,
        GlobalData.myProfile.officialDocuments?.govtIdBack
      ]);
    } else {
      professionLength = 0;
    }

    ///family
    var family = GlobalData.myProfile.family;
    if (GlobalData.myProfile.family != null) {
      familyLength = checkValue([
        family?.fatherOccupationStatus == null
            ? ''
            : family?.fatherOccupationStatus?.value,
        family?.motherOccupationStatus == null
            ? ''
            : family?.motherOccupationStatus?.value,
        family?.familyType == null ? '' : family?.familyType?.value,
        family?.familyValues == null ? '' : family?.familyValues?.value,
        family?.country,
        family?.state,
        family?.city,
      ]);

      ///religion
      familyLength = GlobalData.myProfile.siblings.length == 0
          ? familyLength++
          : familyLength;
      religionLength = checkValue([
        GlobalData.myProfile.family?.religion == null
            ? ''
            : GlobalData.myProfile.family?.religion?.value,
        GlobalData.myProfile.family?.cast == null
            ? ''
            : GlobalData.myProfile.family?.cast?.value,
      ]);
    } else {
      familyLength = 0;
    }

    personalStatus = ((personalLength * 100) / 16) / 100;
    photographStatus = ((photoLength * 100) / 10) / 100;
    officeStatus = ((professionLength * 100) / 7) / 100;
    familyStatus = ((familyLength * 100) / 8) / 100;
    religionStatus = ((religionLength * 100) / 2) / 100;
  }

  getBgImage() {
    bgImageCount++;
    if (bgImageCount == 4) bgImageCount = 0;
    return cardBgImages[bgImageCount];
  }
}
