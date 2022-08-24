import 'package:coupled/Home/Profile/MyProfile/Profile.dart';
import 'package:coupled/Home/Profile/othersProfile/OtherProfile.dart';
import 'package:coupled/Utils/custom_tool_tip.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:flutter/material.dart';

class ProfileSwitch extends StatefulWidget {
  final String? memberShipCode;
  UserShortInfoModel userShortInfoModel = UserShortInfoModel();
  final int index;

  ProfileSwitch({
    this.memberShipCode,
    required this.userShortInfoModel,
    this.index = 0,
  });

  @override
  _ProfileSwitchState createState() => _ProfileSwitchState();
}

class _ProfileSwitchState extends State<ProfileSwitch> {
  ProfileSwitch profileSwitch = ProfileSwitch(
    memberShipCode: '',
    userShortInfoModel:
        UserShortInfoModel(response: UserShortInfoResponse.fromJson({})),
  );
  List<Widget> profileList = [];
  late PageController pageController;
  double pageOffset = 0;
  int pageIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  ///casting basic details from userShortInfo model to profileResponse Model
  buildProfiles() {
    profileSwitch.userShortInfoModel.response != null
        ? profileSwitch.userShortInfoModel.response?.data?.forEach(
            (element) {
              profileList.add(
                OthersProfile(
                  offset: pageOffset,
                  membershipCode: element.membershipCode,
                  profileResponse: ProfileResponse(),
                ),
              );
            },
          )
        : SizedBox();
  }

  @override
  void didChangeDependencies() {
    print(profileSwitch.userShortInfoModel.response?.data);
    profileSwitch =
        ModalRoute.of(context)!.settings.arguments as ProfileSwitch ??
            ProfileSwitch(
              memberShipCode: "",
              userShortInfoModel: UserShortInfoModel(
                  response: UserShortInfoResponse.fromJson({})),
            );

    profileList.clear();
    setState(() {
      pageIndex = profileSwitch.index;
    });

    pageController = PageController(
      initialPage: profileSwitch.index,
    );

    pageController.addListener(() {
      setState(() => pageOffset = pageController.page!);
    });
    buildProfiles();

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('profileList-------');
    print(profileList.length);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: profileSwitch.memberShipCode == 'null'
            ? Profile()
            : Stack(
                children: [
                  PageView(
                    physics: profileList.length > 1
                        ? AlwaysScrollableScrollPhysics()
                        : NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        pageIndex = index;
                      });
                    },
                    controller: pageController,
                    children: profileList,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedOpacity(
                          opacity: pageIndex != 0 ? 1 : 0,
                          duration: Duration(milliseconds: 500),
                          child: InkWell(
                            onTap: () {
                              pageController.animateToPage(pageIndex--,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white24,
                              size: 40,
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: pageIndex == profileList.length - 1 ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          child: InkWell(
                              onTap: () {
                                pageController.animateToPage(pageIndex++,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white24,
                                size: 35,
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class CommonThings {
  List<Widget> verifiedProfileChecking(
      OfficialDocuments officialDocuments, Function isVerified) {
    int count = 0;
    List<Widget> textWidgets = [];
    List<Map<String, dynamic>> items = [];
    if (officialDocuments != null) {
      items = [
        {
          "title": "• Government ID",
          "status": officialDocuments.govtIdStatus == 1
        },
        {
          "title": "• Office ID",
          "status": officialDocuments.officeIdStatus == 1
        },
        /*   {
          "title": "• Google ID",
          "status": officialDocuments.linkedinIdStatus == 1
        },*/
      ];
    }
    items.forEach((item) {
      if (item["status"]) {
        count++;
        textWidgets.add(TextView(
          item["title"],
          color: CoupledTheme().primaryBlue,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible,
          size: 12,
          textAlign: TextAlign.center,
          textScaleFactor: .8,
        ));
      } else
        textWidgets.add(TextView(
          item["title"],
          color: Colors.grey,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible,
          size: 12,
          textAlign: TextAlign.center,
          textScaleFactor: .8,
        ));
      textWidgets.add(SizedBox(
        width: 5.0,
      ));
    });
    print("count : $count");
    isVerified(count == 2);
    return textWidgets;
  }

  Widget customToolTip(
    OfficialDocuments? officialDocuments,
  ) {
    bool isVerified = false;
    return CustomTooltip(
      preferBelow: false,
      margin: EdgeInsets.only(bottom: 0.0),
      showDuration: Duration(milliseconds: 3000),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: Color(0xfff5f2d0)),
      tooltipWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: verifiedProfileChecking(
            officialDocuments!, (verified) => isVerified = verified),
      ),
      height: 0,
      child: Image.asset(
          isVerified
              ? "assets/Profile/Verifid2.png"
              : "assets/Profile/Verifid.png",
          height: CoupledTheme().smallIcon),
    );
  }

  String convertFeet(int? centi) {
    String value = '';
    if (centi != null) {
      double val = 0.3937 * centi.roundToDouble();
      int foot = (val / 12).truncate();
      int inch = (val % 12).truncate();
      value = "$foot\'$inch\"";
    }
    return value;
  }
}
