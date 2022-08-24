import 'dart:async';

import 'package:coupled/Actions/share_view.dart';
import 'package:coupled/Home/Profile/profile_switch.dart';
import 'package:coupled/MatchMeter/bloc/mom_bloc.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/blur_text.dart';
import 'package:coupled/Utils/capitalize_string.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/models/match_o_meter_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

enum Pager {
  SENT,
  RECEIVED,
  ACCEPTED,
  SHORTLISTED,
  SHORTLISTED_BY_HER,
  REJECTED_BY_HER,
  REJECTED,
  VIEWS,
  BLOCKED,
  REPORT,
  GIVEN,
  RECOMMENDATIONS
}

class MomCard extends StatefulWidget {
  final Key? key;
  final String param;
  final Pager page;
  final MomDatum? data;
  final bool? partner;
  final GestureLongPressCallback? onLongPress;
  final StreamController? streamController;
  final int? index;
  final MatchOMeterModel matchMeterModel;

  MomCard({
    this.key,
    required this.page,
    required this.data,
    this.partner,
    this.streamController,
    this.onLongPress,
    this.param = '',
    this.index,
    required this.matchMeterModel,
  }) : super(key: key);

  @override
  _MomCardState createState() => _MomCardState();
}

class _MomCardState extends State<MomCard> {
  Dialogs dialogs = Dialogs();
  String snoozedDuration = "";
  String shortListHint = "Connect with message (optional)",
      viewsHint = "Connect with message (optional)";
  String photoName = '';
  String name = '',
      placeAndAge = '',
      message = '',
      membershipCode = '',
      createTime = '',
      profileImage = CoupledStrings.dummyProfile,
      seenTime = '';
  int lastSeenStatus = 0;
  bool isSnooze = false;
  bool reminderVisible = true;
  String userId = '';
  late Future<CommonResponseModel> res;
  var formatter = new DateFormat('dd-MM-yyyy');
  List<Widget> shortListReasons = [];
  late MomDatum? momDatum;

  bottomActionSheet(Pager page) {
    print("lastSeenStatus");
    print(lastSeenStatus);

    switch (page) {
      case Pager.SENT:
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 5.0,
                ),
                Icon(
                  Icons.done_all,
                  size: 15.0,
                  color: momDatum?.seenAt != null
                      ? CoupledTheme().primaryBlue
                      : Colors.white,
                ),
                SizedBox(
                  width: 5.0,
                ),
                TextView(
                  seenTime.toString(),
                  size: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                ),
                SizedBox(
                  width: 5.0,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            TextView(
              message == null
                  ? "You have sent a connect request to $name"
                  : message,
              size: 12,
              fontWeight: FontWeight.normal,
              maxLines: 60,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              color: Colors.white,
              decoration: TextDecoration.none,
              textScaleFactor: .8,
            ),
            SizedBox(
              height: 10,
            ),
            TextView(
//              message ?? '',
              (momDatum?.snoozeAt != null &&
                      momDatum?.snoozeAt.isAfter(DateTime.now()))
                  ? '$name has snoozed your Interest till ${formatDate(momDatum?.snoozeAt, [
                          dd,
                          '.',
                          mm,
                          '.',
                          yyyy
                        ])} ⏰'
                  : '',
              size: 12,
              color: CoupledTheme().primaryBlue,
              fontWeight: FontWeight.normal,
              maxLines: 60,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start, decoration: TextDecoration.none,
              textScaleFactor: .8,
            ),
          ],
        );
      case Pager.RECEIVED:
        return Column(
          children: <Widget>[
            BlurFilter(
              enable: message != null &&
                  !(GlobalData.myProfile.membership!.paidMember ?? false),
              child: TextView(
                message ?? "You have received a connect request from $name",
                size: 12,
                fontWeight: FontWeight.normal,
                maxLines: 60,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                color: Colors.white,
                decoration: TextDecoration.none,
                textScaleFactor: .8,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                CustomButton(
                  buttonType: ButtonType.FLAT,
                  shape: ButtonType.BUTTON_ROUND,
                  child: GlobalWidgets().iconCreator(
                      "assets/MatchMeter/Rejected.png",
                      size: FixedIconSize.SMALL),
                  onPressed: () {
                    dialogs.rejectWithMsgRequest(context,
                        param: widget.param,
                        name: name,
                        partnerId: userId,
                        message: (msg) {});
                  },
                  width: 30.0,
                  height: 30.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                CustomButton(
                  buttonType: ButtonType.FLAT,
                  enabled: momDatum?.snoozeAt == null,
                  child: GlobalWidgets().iconCreator(
                    "assets/MatchMeter/Snooze.png",
                    color: Colors.white,
                    size: FixedIconSize.SMALL,
                  ),
                  onPressed: () {
                    dialogs.snoozeRequest(context,
                        partnerId: userId,
                        param: widget.param, snoozed: (duration) {
                      setState(() {
//                        snoozedDuration = duration;
                        print("duration $snoozedDuration");
                      });
                    });
                  },
                  width: 30.0,
                  height: 30.0,
                  shape: ButtonType.BUTTON_ROUND,
                ),
                SizedBox(
                  width: 10.0,
                ),
                CustomButton(
                  buttonType: ButtonType.FLAT,
                  child: GlobalWidgets().iconCreator(
                    "assets/MatchMeter/Accepted.png",
                    size: FixedIconSize.SMALL,
                  ),
                  onPressed: () {
                    dialogs.acceptWithMsgRequest(context,
                        partnerId: userId,
                        param: widget.param,
                        name: name,
                        message: (msg) {});
                  },
                  width: 30.0,
                  height: 30.0,
                  shape: ButtonType.BUTTON_ROUND,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
                visible: snoozedDuration != "",
                child: TextView(
                  "You have snoozed $name\'s  request till $snoozedDuration ⏰",
                  color: CoupledTheme().primaryBlue,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                  fontWeight: FontWeight.bold,
                  size: 12,
                ))
          ],
        );
      case Pager.ACCEPTED:
        return Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (widget.data?.loveRecieve >= 3) {
                  GlobalData.othersProfile = ProfileResponse(
                      name: name,
                      membershipCode: membershipCode,
                      dp: Dp(
                          photoName: photoName,
                          imageTaken: BaseSettings(options: []),
                          imageType: BaseSettings(
                            options: [],
                          ),
                          userDetail: UserDetail(membership: Membership())),
                      mom: Mom(),
                      usersBasicDetails: UsersBasicDetails(),
                      info: Info(maritalStatus: BaseSettings(options: [])),
                      preference:
                          Preference(complexion: BaseSettings(options: [])),
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
                      blockMe: Mom(),
                      reportMe: Mom(),
                      freeCoupling: [],
                      recomendCause: [],
                      shortlistByMe: Mom(),
                      shortlistMe: Mom(),
                      photoModel: PhotoModel(),
                      currentCsStatistics: CurrentCsStatistics(),
                      siblings: []);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ChatViewMain(
                  //       photoName: photoName,
                  //       name: name,
                  //       memberShipCode: membershipCode,
                  //     ),
                  //   ),
                  // );
                } else {
                  dialogs.tolDialog(context);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                    color: widget.data?.loveRecieve >= 3
                        ? CoupledTheme().primaryPink
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(50.0)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GlobalWidgets().iconCreator(
                      "assets/MatchMeter/Token-Of-Love.png",
                      size: FixedIconSize.SMALL,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    TextView(
                      "Token of love",
                      size: 12,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ///love received
                SizedBox(
                  height: 15.0,
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GlobalWidgets().iconCreator(
                          "assets/heart.png",
                          color: CoupledTheme().primaryBlue.withOpacity(
                              widget.data?.loveRecieve >= index + 1 ? 1 : 0.5),
                          size: FixedIconSize.EXTRASMALL,
                        ),
                      );
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),

                ///love given
                SizedBox(
                  height: 15.0,
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GlobalWidgets().iconCreator(
                          "assets/heart.png",
                          color: CoupledTheme().primaryPink.withOpacity(
                              widget.data?.loveGiven >= index + 1 ? 1 : 0.5),
                          size: FixedIconSize.EXTRASMALL,
                        ),
                      );
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            )
          ],
        );
      case Pager.SHORTLISTED:
        return Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            ListView.builder(
                itemCount: shortListReasons.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return shortListReasons[index];
                }),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: GestureDetector(
                    onTap: () {
                      dialogs.connectWithMsgRequest(context,
                          partnerId: userId,
                          param: widget.param, message: (msg) {
                        setState(() {
                          viewsHint = msg;
                          print('msg');
                          print(msg);
                        });
                      });
                    },
                    child: InterestWithMsg(
                      hint: shortListHint,
                      textSize: 12.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      connectWithoutMsg(userId, widget.param);
                    },
                    child: GlobalWidgets().iconCreator(
                      "assets/MatchMeter/Connect.png",
                      size: FixedIconSize.LARGE_30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      case Pager.SHORTLISTED_BY_HER:
        return Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: GestureDetector(
                    onTap: () {
                      dialogs.connectWithMsgRequest(context,
                          partnerId: userId,
                          param: widget.param, message: (msg) {
                        setState(() {
                          viewsHint = msg;
                          print('msg');
                          print(msg);
                        });
                      });
                    },
                    child: InterestWithMsg(
                      hint: shortListHint,
                      textSize: 12.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      connectWithoutMsg(userId, widget.param);
                    },
                    child: GlobalWidgets().iconCreator(
                      "assets/MatchMeter/Connect.png",
                      size: FixedIconSize.LARGE_30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      case Pager.REJECTED:
        return Column(children: <Widget>[
          TextView(
            message ?? 'You have declined $name\'s proposal.',
            size: 12,
            fontWeight: FontWeight.normal,
            maxLines: 60,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            color: Colors.white,
            decoration: TextDecoration.none,
            textScaleFactor: .8,
          ),
        ]);
      case Pager.REJECTED_BY_HER:
        return Column(children: <Widget>[
          BlurFilter(
            enable: message != '' &&
                !(GlobalData?.myProfile.membership!.paidMember ?? false),
            child: TextView(
              message ?? 'Uh oh,$name has declined your proposal',
              size: 12,
              fontWeight: FontWeight.normal,
              maxLines: 60,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              color: Colors.white,
              decoration: TextDecoration.none,
              textScaleFactor: .8,
            ),
          ),
        ]);
      case Pager.VIEWS:
        return Container();
      case Pager.BLOCKED:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextView(
              "• $message",
              color: Colors.black,
              decoration: TextDecoration.none,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
              fontWeight: FontWeight.bold,
              size: 12,
            )
          ],
        );
      case Pager.REPORT:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextView(
              "• $message",
              color: Colors.white,
              decoration: TextDecoration.none,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
              fontWeight: FontWeight.bold,
              size: 12,
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              TextView(
                'Admin\'s Message',
                color: CoupledTheme().primaryBlue,
                decoration: TextDecoration.none,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
                fontWeight: FontWeight.bold,
                size: 12,
              ),
              SizedBox(
                height: 5.0,
              ),
              TextView(widget.data?.adminMessage ?? '',
                  size: 14,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                  fontWeight: FontWeight.bold),
            ])
          ],
        );
      case Pager.RECOMMENDATIONS:
        return Column(
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            ListView.builder(
                itemCount: shortListReasons.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return shortListReasons[index];
                }),
          ],
        );
      default:
        return Container();
    }
  }

  Widget moreOptionSheet(Pager page) {
    switch (page) {
      case Pager.SENT:
        return Column(
          children: <Widget>[
            TextView(
              createTime,
              size: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
              decoration: TextDecoration.none,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
            SizedBox(
              height: 20.0,
            ),
            CustomButton(
              gradient: LinearGradient(colors: <Color>[
                Colors.white12,
                Colors.white12,
              ]),
              enabled: (momDatum?.remindAt == null) &&
                  (momDatum?.seenAt != null) &&
                  (DateTime.now()
                      .isAfter(momDatum?.seenAt.add(Duration(days: 3)))) &&
                  (momDatum?.snoozeAt != null
                      ? (DateTime.now().isAfter(momDatum?.snoozeAt))
                      : true),
              buttonType: ButtonType.FLAT,
              shape: ButtonType.BUTTON_ROUND,
              child: GlobalWidgets().iconCreator(
                  "assets/MatchMeter/Reminder.png",
                  size: FixedIconSize.SMALL),
              onPressed: () {
                res = Repository()
                    .doAction({'partner_id': userId}, "MoMReminder");
                res.then((onValue) {
                  print(onValue);
                  if (onValue.code == 200) {
                    reminderVisible = false;

                    momBloc!.add(LoadMomData(widget.param, 1));

                    GlobalWidgets().showToast(msg: onValue.response?.msg);
                  } else {
                    GlobalWidgets().showToast(msg: onValue.response?.msg);
                  }
                });
              },
              width: 30.0,
              height: 30.0,
            ),
          ],
        );
      case Pager.RECEIVED:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextView(
              createTime,
              size: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
              decoration: TextDecoration.none,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
            SizedBox(
              height: 10.0,
            ),
            ShareProfileBtn(membershipCode: membershipCode)
          ],
        );
      case Pager.ACCEPTED:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print('name----');
                print(name);
                GlobalData.othersProfile = ProfileResponse(
                    name: name,
                    membershipCode: membershipCode,
                    dp: Dp(
                        photoName: photoName,
                        imageTaken: BaseSettings(options: []),
                        imageType: BaseSettings(options: []),
                        userDetail: UserDetail(
                            membership: Membership(paidMember: false))),
                    mom: Mom(),
                    info: Info(maritalStatus: BaseSettings(options: [])),
                    usersBasicDetails: UsersBasicDetails(),
                    preference:
                        Preference(complexion: BaseSettings(options: [])),
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
                    blockMe: Mom(),
                    reportMe: Mom(),
                    freeCoupling: [],
                    recomendCause: [],
                    shortlistByMe: Mom(),
                    shortlistMe: Mom(),
                    photoModel: PhotoModel(),
                    currentCsStatistics: CurrentCsStatistics(),
                    siblings: []);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ChatViewMain(
                //       photoName: photoName,
                //       name: name,
                //       memberShipCode: membershipCode,
                //     ),
                //   ),
                // );
              },
              child: Container(
                height: 30.0,
                width: 30.0,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.white12, shape: BoxShape.circle),
                child: GlobalWidgets().iconCreator(
                  "assets/MatchMeter/Chat.png",
                  size: FixedIconSize.SMALL,
                ),
              ),
            ),
          ],
        );
      case Pager.SHORTLISTED:
      case Pager.VIEWS:
        return Container();
      case Pager.REJECTED:
        return Container(
          child: Column(
            children: <Widget>[
              CustomButton(
                gradient: LinearGradient(colors: <Color>[
                  Colors.white12,
                  Colors.white12,
                ]),
                buttonType: ButtonType.FLAT,
                shape: ButtonType.BUTTON_ROUND,
                child: GlobalWidgets().iconCreator(
                    "assets/MatchMeter/Reaccept.png",
                    size: FixedIconSize.SMALL),
                onPressed: () {
                  dialogs.reAcceptWithMsgRequest(context,
                      partnerId: userId, param: widget.param, name: name);
                },
                width: 30.0,
                height: 30.0,
              ),
              SizedBox(
                height: 5.0,
              ),
              TextView(
                "Reaccept",
                size: 12.0,
                color: Colors.white,
                decoration: TextDecoration.none,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        );
      case Pager.REJECTED_BY_HER:
        return Container();
      case Pager.BLOCKED:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextView(
              createTime,
              size: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
              decoration: TextDecoration.none,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
            SizedBox(
              height: 10.0,
            ),
            CustomButton(
              gradient: LinearGradient(colors: <Color>[
                Colors.white12,
                Colors.white12,
              ]),
              buttonType: ButtonType.FLAT,
              shape: ButtonType.BUTTON_ROUND,
              child: GlobalWidgets().iconCreator(
                  "assets/MatchMeter/Unblock.png",
                  size: FixedIconSize.SMALL),
              onPressed: () {
                dialogs.showUnblock(context,
                    partnerId: userId,
                    name: name,
                    img: profileImage,
                    memberCode: membershipCode,
                    reason: message,
                    param: widget.param);
              },
              width: 30.0,
              height: 30.0,
            ),
            SizedBox(
              height: 5.0,
            ),
            TextView(
              "Unblock",
              size: 12.0,
              color: Colors.white,
              decoration: TextDecoration.none,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
              fontWeight: FontWeight.bold,
            )
          ],
        );
      case Pager.REPORT:
        return Container(
          child: TextView(
            createTime,
            size: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            decoration: TextDecoration.none,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
          ),
        );
      case Pager.RECOMMENDATIONS:
        return Container(
          child: Align(
            alignment: Alignment.topRight,
            child: TextView(
              createTime,
              size: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
              decoration: TextDecoration.none,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
          ),
        );
      default:
        return Container();
    }
  }

  moreOptionWidth() {
    if (widget.page == Pager.SHORTLISTED || widget.page == Pager.VIEWS) {
      return {
        0: FractionColumnWidth(.27),
        1: FractionColumnWidth(.70),
        2: FractionColumnWidth(0)
      };
    } else {
//      return {1: FractionColumnWidth(.53), 2: FractionColumnWidth(.23)};
      return {1: FractionColumnWidth(.60), 2: FractionColumnWidth(.16)};
//      return {0: FractionColumnWidth(.24),1: FractionColumnWidth(.60), 2: FractionColumnWidth(.16)};
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /* isSnooze = (momDatum.snoozeAt != null
        ? momDatum.snoozeAt.isAfter(DateTime.now())
        : false);*/

    isSnooze = (momDatum?.remindAt == null) &&
        (momDatum?.seenAt != null) &&
        (momDatum?.seenAt?.isAfter(DateTime.now().add(Duration(days: 3)))) &&
        (momDatum?.snoozeAt != null
            ? DateTime.now().isAfter(momDatum?.snoozeAt)
            : true);

    /* (CoupledGlobal.othersProfile?.mom?.remindAt == null) &&
        (CoupledGlobal.othersProfile?.mom?.seenAt != null) &&
        (DateTime.now().isAfter(CoupledGlobal.othersProfile.mom.seenAt
            .add(Duration(days: 3)))) &&
        CoupledGlobal.othersProfile.mom.snoozeAt != null
        ? (DateTime.now().isAfter(CoupledGlobal.othersProfile.mom.snoozeAt))
        : true,*/
  }

  MomBloc? momBloc;
  int? couplingScore;
  UserShortInfoModel? userShortInfoModel;

  @override
  void initState() {
    momBloc = BlocProvider.of<MomBloc>(context);
    print('partner...............${widget.partner}');
    print(widget.matchMeterModel);
    widget.partner == true ? true : false;

    ///prep data for profile to profile navigation
    List<Datum>? listDatum;
    widget.matchMeterModel.response?.data?.forEach((element) {
      listDatum?.add(
        Datum(
          membershipCode: widget.partner!
              ? element.partner?.membershipCode
              : element.user?.membershipCode,
          info: widget.partner! ? element.partner?.info : element.user?.info,
          name: widget.partner! ? element.partner?.name : element.user?.name,
          lastName: widget.partner!
              ? element.partner?.lastName
              : element.user?.lastName,
          dp: widget.partner! ? element.partner?.dp : element.user?.dp,
        ),
      );
    });
    print('Mom Card..............$listDatum');
    userShortInfoModel = UserShortInfoModel(
      response: UserShortInfoResponse(
        data: listDatum,
      ),
    );

    if (widget.data != null) {
      momDatum = widget.data;

      print('message---------');
      print(widget.data);
      print(message);

      message = (momDatum?.message).toString();
      createTime = GlobalWidgets().getTime(momDatum?.createdAt);

      seenTime = GlobalWidgets().getTime(momDatum?.createdAt);

      ///seen status
      if (momDatum?.seenAt != null) {
        print("momDatum");
        print(momDatum?.seenAt != null);

        lastSeenStatus = 2;
        setState(() {
          seenTime = GlobalWidgets().getTime(momDatum?.seenAt);
        });
      }

      ///check snooze
      //    var snoozeDuration = ((momDatum.snoozeAt.difference(DateTime.now()).inDays));
      //      isSnooze = (momDatum.seenAt != null) &&
      //              momDatum.snoozeAt == null &&
      //              momDatum.snoozeAt != null
      //          ? momDatum.snoozeAt.isAfter(DateTime.now())
      //          : true;

      isSnooze = (momDatum?.remindAt == null) &&
          (momDatum?.seenAt != null) &&
          (momDatum?.seenAt.isAfter(DateTime.now().add(Duration(days: 3)))) &&
          (momDatum?.snoozeAt != null
              ? DateTime.now().isAfter(momDatum?.snoozeAt)
              : true);

      snoozedDuration = momDatum?.snoozeAt != null
          ? formatter.format(momDatum?.snoozeAt)
          : '';
      //    enableSnooze = momDatum.snoozeAt == DateTime.now(); //check snooze for received section
      //enableSnooze = momDatum.snoozeAt == DateTime.now();
      //    print('snoozeDuration');
      //    print(isSnooze);

      ///check reminder & active after 4days
      reminderVisible = momDatum?.remindAt == null &&
          (momDatum?.snoozeAt == null
              ? true
              : momDatum?.snoozeAt.isBefore(DateTime.now())) &&
          DateTime.now().isAfter(
            momDatum?.createdAt.add(
              Duration(days: 4),
            ),
          );

      /*&& momDatum.snoozeAt!=null?momDatum.snoozeAt.isBefore(DateTime.now()):true;*/

      /*    &&
          dayDiff > 4 &&
          momDatum.snoozeAt!=null?(momDatum.snoozeAt.isAfter(DateTime.now())):true;*/

      //    reminderVisible = true;

      ///shortlist reason list
      momDatum?.momReasons?.forEach((f) {
        shortListReasons.add(TextView(
          '• ${f.reason?.value}',
          size: 12,
          color: Colors.white,
          decoration: TextDecoration.none,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          textScaleFactor: .8,
          fontWeight: FontWeight.bold,
        ));
      });

      ///partner & user

      if (widget.partner == true) {
        setState(() {
          PartnerDetails? partner = widget.data?.partner;

          ///coupling score
          couplingScore = momDatum?.partner?.score ?? 0;

          userId = (partner?.id).toString();
          name =
              '${partner?.name != null ? partner?.name.toString().capitalize : ''}'
              ' ${partner?.lastName != null ? partner?.lastName?.substring(0, 1).toString().capitalize : ''}';

          placeAndAge =
              '${GlobalWidgets().getAge(partner?.info?.dob)}, ${partner?.info?.city}';

          membershipCode = (partner?.membershipCode).toString();
          profileImage = APis().imageApi(partner?.dp?.photoName,
              imageConversion: ImageConversion.THUMB, imageSize: 100);
          photoName = partner?.dp?.photoName ?? '';

          ///delivered status
          if (partner?.lastActive != null) {
            //var diff = ((partner.lastActive.difference(momDatum.createdAt).inDays));
            if (momDatum?.createdAt.isAfter(partner?.lastActive)) {
              lastSeenStatus = 1;
              // seenTime = '';
            }
          }
        });
      } else if ((widget.partner == false)) {
        setState(() {
          PartnerDetails? user = widget.data?.user;

          ///coupling score
          couplingScore = momDatum?.user?.score ?? 0;

          userId = (user?.id).toString();

          name =
              '${user?.name != null ? toBeginningOfSentenceCase(user?.name) : ''}'
              ' ${user?.lastName != null ? toBeginningOfSentenceCase(user?.lastName?.substring(0, 1)) : ''}';

          placeAndAge =
              '${GlobalWidgets().getAge(user?.info?.dob)}, ${user?.info?.city}';
          membershipCode = (user?.membershipCode).toString();
          profileImage = APis().imageApi(user?.dp?.photoName,
              imageConversion: ImageConversion.THUMB, imageSize: 100);
          photoName = user?.dp?.photoName ?? '';

          ///delivered status
          //  var diff = ((user.lastActive.difference(momDatum.createdAt).inDays));

          if (momDatum?.createdAt != null &&
              user?.lastActive != null &&
              momDatum?.createdAt.isAfter(user?.lastActive)) {
            lastSeenStatus = 1;
            //  seenTime = '';
          }
        });
      }
      momDatum?.isSelected = false;
    }

    super.initState();
  }

  var isSelected = false;

//  Color myColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        userShortInfoModel?.response?.data?.length != null
            ? Navigator.pushNamed(
                context,
                '/profileSwitch',
                arguments: ProfileSwitch(
//              memberShipCode: membershipCode,
                  index: widget.index!,
                  userShortInfoModel: userShortInfoModel!,
                  memberShipCode: widget.partner!
                      ? widget.matchMeterModel.response?.data![widget.index!]
                          .partner?.membershipCode
                      : widget.matchMeterModel.response?.data![widget.index!]
                          .user?.membershipCode,
                ),
              )
            : SizedBox();
      },
      child: Container(
        color: cardColor,
        child: ListTile(
          contentPadding: EdgeInsets.all(8.0),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              defaultColumnWidth: FractionColumnWidth(.27),
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              columnWidths: moreOptionWidth(),
              children: [
                TableRow(
                  children: <Widget>[
                    TableCell(
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FadeInImage.assetNetwork(
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                              placeholder: 'assets/no_image.jpg',
                              image: profileImage,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextView(
                            membershipCode ?? '',
                            fontWeight: FontWeight.bold,
                            size: 14,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                          ),
                        ],
                      ),
                    ),
                    TableCell(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: HeartPercentage(
                                  '$couplingScore',
                                  userId: userId.toString(),
                                  profileImg: profileImage,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextView(
                                      name,
                                      size: 16.0,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    TextView(
                                      placeAndAge,
                                      size: 14.0,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Visibility(
                                visible: widget.page == null ||
                                    widget.page == Pager.SHORTLISTED ||
                                    widget.page == Pager.VIEWS,
                                child: TextView(
                                  createTime,
                                  size: 12.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Flexible(
                              fit: FlexFit.loose,
                              child: bottomActionSheet(widget.page)),
                        ],
                      ),
                    ),
                    TableCell(
                      child: moreOptionSheet(widget.page),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color cardColor = CoupledTheme().backgroundColor;

  void toggleSelection(bool isSelected) {
    setState(() {
      if (isSelected) {
        cardColor = Colors.black12;
      } else {
        cardColor = Colors.transparent;
      }
    });
  }

  void connectWithoutMsg(String userId, String param) async {
    momBloc = BlocProvider.of<MomBloc>(context);
    momBloc!.add(LoadMomData(param, 1));
    CommonResponseModel res = await Repository()
        .doAction({'mom_type': 'connect', 'partner_id': userId}, "MoMConnect");
    GlobalWidgets().showToast(msg: res.response!.msg);
  }
}
