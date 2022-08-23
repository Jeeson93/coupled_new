import 'dart:async';

import 'package:coupled/Home/Profile/othersProfile/bloc/others_profile_bloc.dart';

import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isChecked = true;
  bool isActive = false;
  Dialogs dialogs = Dialogs();

  ProfileResponse profileResponse = ProfileResponse(
      usersBasicDetails: UsersBasicDetails(),
      mom: Mom(),
      info: Info(maritalStatus: BaseSettings(options: <BaseSettings>[])),
      preference:
          Preference(complexion: BaseSettings(options: <BaseSettings>[])),
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

  Future initiatePreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var a = preferences.getBool("notification");
    setState(() {
      isChecked = a ?? true;
    });
  }

  @override
  void initState() {
    GlobalData.othersProfileBloc = OthersProfileBloc();
    initiatePreference();
    profileResponse = GlobalData.myProfile;
    super.initState();
  }

  /*  void getUserData(ProfileResponse user) async {
    profileResponse = user;
    setState(() {
      isActive = user.hideAt == '';
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: CoupledTheme().backgroundColor,
      appBar: AppBar(
        backgroundColor: CoupledTheme().backgroundColor,
        title: Padding(
          padding: const EdgeInsets.all(2.0),
          child: TextView(
            "Settings",
            size: 22,
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
          ),
        ),
      ),
      body: BlocBuilder(
          bloc: GlobalData.othersProfileBloc,
          builder: (context, snapshot) {
            print('settings snapshot-----------');
            print(snapshot);
            return ListView(
              shrinkWrap: true,
              children: <Widget>[
                ///notification
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextView(
                        "Get Notification",
                        size: 16,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                    ],
                  ),
                  trailing: Switch(
                    value: isChecked,
                    onChanged: (value) async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      setState(() {
                        isChecked = value;
                        preferences.setBool("notification", isChecked);

                        ///notification subscription
                        Repository()
                            .getNotification(status: isChecked ? 1 : 0)
                            .then((CommonResponseModel value) {
                          GlobalWidgets().showToast(msg: value.response?.msg);
                        }, onError: (e) {
                          GlobalWidgets()
                              .showToast(msg: CoupledStrings.errorMsg);
                        });
                      });
                    },
                    activeTrackColor: CoupledTheme().primaryPinkDark,
                    activeColor: Colors.white,
                  ),
                ),
                Divider(
                  height: 10,
                  color: CoupledTheme().inactiveColor,
                ),

                ///change password
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextView(
                        "Password",
                        size: 16,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                      Container(
                        height: 20,
                        child: GestureDetector(
                          onTap: () {
                            dialogs.showDialogChangePassWord(
                              context,
                            );
                          },
                          child: Image.asset("assets/square-edit-outline.png"),
                        ),
                      )
                    ],
                  ),
                  subtitle: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextView(
                      "••••••••",
                      size: 12.0,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      textScaleFactor: .8,
                    ),
                  ),
                ),
                Divider(
                  height: 10,
                  color: CoupledTheme().inactiveColor,
                ),

                ///change mobile number
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextView(
                        "Mobile Number",
                        size: 16,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                      Container(
                        height: 20,
                        child: GestureDetector(
                          onTap: () {
                            dialogs.showDialogChangePhoneNo(context,
                                user: profileResponse);
                          },
                          child: Image.asset("assets/square-edit-outline.png"),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextView(
                      profileResponse.userPhone ?? '',
                      size: 12.0,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      textScaleFactor: .8,
                    ),
                  ),
                ),
                Divider(
                  height: 10,
                  color: CoupledTheme().inactiveColor,
                ),

                ///change email Id
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextView(
                        "Email ID",
                        size: 16,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                      Container(
                          height: 20,
                          child: GestureDetector(
                              onTap: () {
                                dialogs.showDialogChangeEmail(context,
                                    user: profileResponse);
                              },
                              child: Image.asset(
                                  "assets/square-edit-outline.png")))
                    ],
                  ),
                  subtitle: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextView(
                      profileResponse.userEmail ?? '',
                      size: 12.0,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      textScaleFactor: .8,
                    ),
                  ),
                ),

                Divider(
                  height: 10,
                  color: CoupledTheme().inactiveColor,
                ),
                /* Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: GestureDetector(
                        onTap: () {
                          dialogs.showDialogActivateAccount(
                            context,
                          );
                        },
                        child: TextView(
                          "Log Out",
                          size: 18,
                          color: CoupledTheme().primaryPinkDark,
                        )),
                  ),*/
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: GestureDetector(
                    onTap: () async {
                      /* dialogs.showDialogDeleteAccount(
                            context,
                          );*/

                      List<BaseSettings> reasons = [];

                      BaseSettings deleteCause = GlobalData()
                          .getBaseSettingsType(baseType: 'delete_cause');

                      print('deleteCause------------');
                      print('${GlobalData.baseSettings}');
                      print('$deleteCause');

                      deleteCause.options!.forEach((value) {
                        reasons.add(BaseSettings(
                            value: value.value,
                            id: value.id,
                            others: value.others,
                            options: []));
                      });
                      dialogs.profileDialogs(context, 'delete', '1',
                          reasons: reasons,
                          momType: 'deleteAccount',
                          multiSelection: false,
                          callBack: (String value) {});
                      /* SharedPreferences preferences = await SharedPreferences.getInstance();
                    await preferences.clear();*/
                    },
                    child: TextView(
                      "Delete Account",
                      size: 18,
                      color: CoupledTheme().primaryPinkDark,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                  ),
                ),
                Divider(
                  height: 10,
                  color: CoupledTheme().inactiveColor,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: GestureDetector(
                      onTap: () {
//                          _userBloc.add(UpdateUser(userDb));
                        // _userBloc.add(UpdateUser(ProfileResponse()));
                        (profileResponse.hideAt != null)
                            ? dialogs.showDialogActivateAccount(context,
                                user: profileResponse,
                                hideDate: profileResponse.hideAt)
                            : dialogs.showDialogHideAccount(context,
                                user: profileResponse);
                      },
                      child: TextView(
                        (profileResponse.hideAt != null)
                            ? "Unhide Account"
                            : "Hide Account",
                        size: 18,
                        color: CoupledTheme().primaryPinkDark,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      )),
                ),
                Divider(
                  height: 10,
                  color: CoupledTheme().inactiveColor,
                ),
              ],
            );
          }),
    );
  }
}
