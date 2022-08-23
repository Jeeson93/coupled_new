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

class SectionSeven extends StatefulWidget {
  static String route = 'SectionSeven';

  _SectionSevenState createState() => _SectionSevenState();
}

class _SectionSevenState extends State<SectionSeven>
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
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _profileResponse = GlobalData.myProfile;
    print("aboutPartner :: ${_profileResponse.info!.aboutPartner}");
    textEditingController.text = _profileResponse.info!.aboutPartner ?? '';
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
            progress: 0.5,
            title: 'Personal Details',
            step: 7,
            params: getSectionSeven()),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextView(
                        "Buzz About Perfect Partner",
                        size: 18.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                        color: Colors.white,
                      ),
                      TextView(
                        "${textEditingController.text.length}/350",
                        size: 18.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
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
                  Container(
                    height: 300,
                    child: EditTextBordered(
                      maxLines: 10,
                      hint: "About Perfect Partner",
                      maxLength: 350,
                      //maxLines: 10,
                      size: 18.0,
                      borderColor: CoupledTheme().primaryPinkDark,
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      controller: textEditingController,
                      onChange: (value) {
                        setState(() {
                          if (textEditingController.text.toString().length >
                              350) {
                            GlobalWidgets()
                                .showToast(msg: "maximum limit reached");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        super.widget));
                          } else {
                            _profileResponse.info!.aboutPartner =
                                textEditingController.text;
                          }
                          /* textEditingController.text.length;
                          _profileResponse.info.aboutPartner = textEditingController.text;*/
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            getBottomNavigationButtons(step: 7, params: getSectionSeven())
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
