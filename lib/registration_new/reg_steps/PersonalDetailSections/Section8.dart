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

import 'package:flutter/services.dart';

class SectionEight extends StatefulWidget {
  static String route = 'SectionEight';

  _SectionEightState createState() => _SectionEightState();
}

class _SectionEightState extends State<SectionEight>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TextEditingController textEditingController = TextEditingController();
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
  void didChangeDependencies() {
    /*_profileResponse = GlobalData.myProfile;
    //_profileResponse?.info = _profileResponse?.info ?? Info();

    textEditingController.text = _profileResponse?.info?.aboutSelf ?? '';*/
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _profileResponse = GlobalData.myProfile;
    //_profileResponse?.info = _profileResponse?.info ?? Info();

    textEditingController.text = _profileResponse.info!.aboutSelf ?? '';
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
            progress: 0.57,
            title: 'Personal Details',
            step: 8,
            params: getSectionEight()),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 100.0, left: 15.0, right: 15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextView(
                        "Gossip About Myself",
                        size: 18.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                        color: Colors.white,
                      ),
                      TextView(
                        "${textEditingController.text.length > 500 ? 500 : textEditingController.text.length}/500",
                        size: 18.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  EditTextBordered(
                    hint: "Gossip About Myself",
                    //maxLines: 500,
                    maxLength: 500,
                    maxLines: 12,
                    size: 18.0,
                    setDecoration: true,
                    borderColor: CoupledTheme().primaryPinkDark,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.multiline,
                    controller: textEditingController,
                    textCapitalization: TextCapitalization.sentences,
                    onChange: (value) {
                      setState(() {
                        if (textEditingController.text.toString().length >
                            500) {
                          //print("lll");
                          GlobalWidgets()
                              .showToast(msg: "maximum limit reached");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      super.widget));
                        } else {
                          _profileResponse.info!.aboutSelf =
                              textEditingController.text.toString();
                        }
                        /*textEditingController.text.length;
                          _profileResponse.info.aboutSelf =
                              textEditingController.text;*/
                      });
                    },
                  )
                ],
              ),
            ),
            getBottomNavigationButtons(step: 8, params: getSectionEight())
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
