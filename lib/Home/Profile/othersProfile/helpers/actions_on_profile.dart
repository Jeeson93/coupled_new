import 'package:coupled/Home/Profile/othersProfile/helpers/action_buttons.dart';
import 'package:coupled/Home/Profile/othersProfile/helpers/mom_status.dart';
import 'package:coupled/Utils/blur_text.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:date_format/date_format.dart';
import 'package:coupled/Home/MatchBoard/view/couplingMatches.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:coupled/Home/Profile/othersProfile/OtherProfile.dart';
import '../bloc/others_profile_bloc.dart';

Widget getProfileActions(
    BuildContext context, OthersProfileBloc othersProfileBloc) {
  print(
      'momActionType-----------${getMomStatus(GlobalData.othersProfile.mom)}');
  switch (getMomStatus(GlobalData.othersProfile.mom)) {
    case actionType.blockByMe:
    case actionType.blockMe:
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    'You have blocked ${GlobalData.othersProfile.name}\'s profile',
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    size: 12,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Visibility(
                      visible: GlobalData.othersProfile.mom!.momType != "block",
                      child: TextView(
                        GlobalData.othersProfile.blockMe!.message ?? '',
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        size: 12,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      )),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: getActionBtn(
                    othersProfileBloc: othersProfileBloc,
                    context: context,
                    type: btnType.UNBLOCK,
                    roundBackGround: false)),
          ],
        ),
      );
    case actionType.reported:
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    'You have reported ${GlobalData.othersProfile.name}\'s profile to Coupled admin',
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    size: 12,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextView(
                    GlobalData.othersProfile.reportMe!.message ?? '',
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    size: 12,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

    case actionType.requestSent:
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: TextView(
                      GlobalData.othersProfile.mom!.message == null
                          ? "You have sent a connect request to ${GlobalData.othersProfile.name}"
                          : GlobalData.othersProfile.mom!.message,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      size: 12,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    )),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        getActionBtn(
                          othersProfileBloc: othersProfileBloc,
                          context: context,
                          type: btnType.REMINDER,
                          roundBackGround: false,
                        ),
                      ],
                    )),
              ],
            ),
            TextView(
              GlobalData.othersProfile.mom!.snoozeAt != null
                  ? GlobalData.othersProfile.mom!.snoozeAt
                          .isAfter(DateTime.now())
                      ? '${GlobalData.othersProfile.name} has snoozed your Interest till '
                          '${formatDate(GlobalData.othersProfile.mom!.snoozeAt, [
                              dd,
                              '.',
                              mm,
                              '.',
                              yyyy
                            ])} ⏰'
                      : ''
                  : '',
              color: CoupledTheme().primaryBlue,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              size: 12,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
          ],
        ),
      );

    case actionType.requestReceived:
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: BlurFilter(
                    enable: GlobalData.othersProfile.mom!.message != null &&
                        !(GlobalData.myProfile.membership!.paidMember ?? false),
                    child: TextView(
                      GlobalData.othersProfile.mom!.message == null
                          ? "You have received a connect request from ${GlobalData.othersProfile.name}"
                          : GlobalData.othersProfile.mom!.message,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      size: 12,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            TextView(
              GlobalData.othersProfile.mom!.snoozeAt != null
                  ? "You have snoozed ${GlobalData.othersProfile.name}\'s  request till ${formatDate(GlobalData.othersProfile.mom!.snoozeAt, [
                          dd,
                          '.',
                          mm,
                          '.',
                          yyyy
                        ])} ⏰"
                  : '',
              color: CoupledTheme().primaryBlue,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              size: 12,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
            Visibility(
              visible: GlobalData.othersProfile.mom!.message != null &&
                  !(GlobalData.myProfile.membership!.paidMember ?? false),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => MembershipPlans()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextView(
                    CoupledStrings.becomeMember,
                    color: CoupledTheme().primaryBlue,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    size: 12,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                ),
              ),
            )
          ],
        ),
      );

    case actionType.rejectedByMe:
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                flex: 8,
                child: TextView(
                  GlobalData.othersProfile.mom!.message ??
                      'You have declined ${GlobalData.othersProfile.name}\'s proposal.',
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  overflow: TextOverflow.visible,
                  size: 12,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                )),
            Expanded(
                flex: 2,
                child: getActionBtn(
                    othersProfileBloc: othersProfileBloc,
                    context: context,
                    type: btnType.RE_ACCEPT,
                    roundBackGround: false)),
          ],
        ),
      );

    case actionType.rejectedMe:
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    flex: 8,
                    child: BlurFilter(
                      enable: GlobalData.othersProfile.mom!.message != null &&
                          !(GlobalData.myProfile.membership!.paidMember ??
                              false),
                      child: TextView(
                        GlobalData.othersProfile.mom!.message ??
                            'Uh oh,${GlobalData.othersProfile.name} has declined your proposal',
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        size: 12,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: GlobalWidgets().iconCreator(
                      "assets/MatchMeter/Rejected.png",
                      size: FixedIconSize.MEDIUM),
                ),
              ],
            ),
            Visibility(
              visible: GlobalData.othersProfile.mom!.message != null &&
                  !(GlobalData.myProfile.membership!.paidMember ?? false),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => MembershipPlans()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextView(
                    CoupledStrings.becomeMember,
                    color: CoupledTheme().primaryBlue,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    size: 12,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                ),
              ),
            )
          ],
        ),
      );

    case actionType.connected:
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: BlurFilter(
                    enable: GlobalData.othersProfile.mom!.message != null &&
                        !(GlobalData.myProfile.membership!.paidMember ?? false),
                    child: TextView(
                      GlobalData.othersProfile.mom!.message ??
                          'You and ${GlobalData.othersProfile.name} are connected',
                      color: CoupledTheme().primaryBlue,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      size: 12,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GlobalWidgets().iconCreator(
                      "assets/Profile/Connected.png",
                      size: FixedIconSize.MEDIUM),
                ),
              ],
            ),
            Visibility(
              visible: GlobalData.othersProfile.mom!.message != null &&
                  !(GlobalData.myProfile.membership!.paidMember ?? false),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => MembershipPlans()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextView(
                    CoupledStrings.becomeMember,
                    color: CoupledTheme().primaryBlue,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    size: 12,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                ),
              ),
            )
          ],
        ),
      );

    default:
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: Container(
                    child: GestureDetector(
                      onTap: () {
                        dialogs.connectWithMsgRequest(
                          context,
                          message: (val) {},
                          othersProfileBloc: othersProfileBloc,
                          memberShipCode:
                              GlobalData.othersProfile.membershipCode,
                          partnerId: GlobalData.othersProfile.id.toString(),
                        );
                      },
                      child: InterestWithMsg(
                        hint: "Connect with a message (optional)",
                        backgroundColor: CoupledTheme().backgroundColor,
                        borderVisibility: false,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: getActionBtn(
                        othersProfileBloc: othersProfileBloc,
                        context: context,
                        type: btnType.CONNECT,
                        roundBackGround: false))
              ],
            ),
            Visibility(
              visible: GlobalData.othersProfile.shortlistByMe != null ||
                  GlobalData.othersProfile.shortlistMe != null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextView(
                    GlobalData.othersProfile.shortlistByMe != null
                        ? 'You have shortlisted ${GlobalData.othersProfile.name}\'s profile'
                        : '',
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    size: 12,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextView(
                    GlobalData.othersProfile.shortlistMe != null
                        ? '${GlobalData.othersProfile.name} has shortlisted your profile'
                        : '',
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    size: 12,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
