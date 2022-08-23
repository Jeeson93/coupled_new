import 'package:coupled/Chat/chat_main_view_1.dart';
import 'package:coupled/Home/MatchBoard/view/couplingMatches.dart';
import 'package:coupled/Home/Profile/CouplingScore/bloc/coupling_score_bloc.dart';
import 'package:coupled/Home/Profile/othersProfile/OtherProfile.dart';
import 'package:coupled/Home/Profile/othersProfile/helpers/mom_status.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/resources/settings_and_cms_provider.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

import '../bloc/others_profile_bloc.dart';

///all profile action buttons
Widget getActionBtn(
    {required OthersProfileBloc othersProfileBloc,
    required BuildContext context,
    required btnType type,
    bool roundBackGround = true,
    enable = true}) {
  switch (type) {
    case btnType.RECOMMEND:
      return Stack(
        children: <Widget>[
          BtnWithText(
            enabled: getMomStatus(GlobalData.othersProfile.mom) !=
                    actionType.blockByMe &&
                getMomStatus(GlobalData.othersProfile.mom) !=
                    actionType.blockMe &&
                getMomStatus(GlobalData.othersProfile.mom) !=
                    actionType.reported,
            roundBackGround: true,
            bgColor: CoupledTheme().tabColor2,
            img: "assets/MatchBoard/Recommendation.png",
            text: "Recommend",
            onTap: () {
              Dialogs().profileRecommendation(
                profileResponse: GlobalData.othersProfile,
                isReloadOthersProfile: true,
                context: context,
                partnerId: GlobalData.othersProfile.id,
                recommendCause: GlobalData.othersProfile.recomendCause,
                othersProfileBloc: null,
              );
            },
            customSize: 25.0,
            imgColor: Colors.white,
          ),
          Visibility(
            visible: GlobalData.othersProfile.recomendCauseCount != 0,
            child: Positioned(
              top: 0,
              right: 10,
              child: NotificationBadge(
                count: GlobalData.othersProfile.recomendCauseCount ?? 0,
                radius: 20,
                bgcolor: CoupledTheme().primaryBlue,
              ),
            ),
          ),
        ],
      );
    case btnType.SHORTLIST:
      return BtnWithText(
        enabled: getMomStatus(GlobalData?.othersProfile.mom) == null ||
            getMomStatus(GlobalData.othersProfile.mom) !=
                actionType.shortlistByMe,
        img: "assets/Profile/Shortlist.png",
        text: "Shortlist",
        roundBackGround: true,
        bgColor: CoupledTheme().tabColor3,
        onTap: () {
          var s = GlobalData().getBaseSettingsType(baseType: 'shortlist_cause');
          Dialogs().profileDialogs(
              context, 'Shortlisting', GlobalData.othersProfile.id.toString(),
              multiSelection: true,
              othersProfileBloc: othersProfileBloc,
              momType: 'shortlist',
              reasons: s.options,
              callBack: (String value) {});
        },
        customSize: null,
        imgColor: null,
      );
    case btnType.CONTACT:
      return BtnWithText(
        enabled: getMomStatus(GlobalData.othersProfile.mom) ==
                actionType.connected &&
            (GlobalData.myProfile.membership!.paidMember ?? false),
        onTap: () {
          Repository()
              .getContactNo(GlobalData.othersProfile.id.toString())
              .then((value) {
            if (value.response!.name != null) {
              value != null
                  ? Dialogs().showContactNumber(context, value)
                  : Dialogs().profileTopUpPlan(context);
            }
          });
        },
        img: "assets/Profile/Call.png",
        text: "Contact",
        roundBackGround: roundBackGround,
        bgColor: CoupledTheme().tabColor3,
      );
    case btnType.SHARE:
      return BtnWithText(
        enabled: getMomStatus(GlobalData.othersProfile.mom) !=
                actionType.blockByMe &&
            getMomStatus(GlobalData.othersProfile.mom) != actionType.blockMe &&
            getMomStatus(GlobalData.othersProfile.mom) != actionType.reported,
        roundBackGround: true,
        bgColor: CoupledTheme().tabColor2,
        img: "assets/Profile/Share.png",
        text: "Share",
        onTap: () {
          RestAPI().shareProfile(
            GlobalData.othersProfile.membershipCode,
          );
        },
      );
    case btnType.BLOCK:
      return BtnWithText(
        roundBackGround: true,
        enabled:
            getMomStatus(GlobalData.othersProfile.mom) == actionType.connected,
        bgColor: CoupledTheme().tabColor2,
        img: "assets/Profile/Block.png",
        text: "Block",
        onTap: () {
          var s = GlobalData().getBaseSettingsType(baseType: 'block_cause');
          Dialogs().profileDialogs(
              context, 'Blocking', GlobalData.othersProfile.id.toString(),
              multiSelection: false,
              description: CoupledStrings.blockMsg,
              othersProfileBloc: othersProfileBloc,
              momType: 'block',
              reasons: s.options,
              callBack: (String value) {});
        },
      );
    case btnType.REPORT:
      return BtnWithText(
        enabled: enable,
        roundBackGround: true,
        bgColor: CoupledTheme().tabColor2,
        img: "assets/Profile/Report.png",
        text: "Report",
        onTap: () {
          var s = GlobalData().getBaseSettingsType(baseType: 'report_cause');
          Dialogs().profileDialogs(
              context, 'Reporting', GlobalData.othersProfile.id.toString(),
              multiSelection: false,
              othersProfileBloc: othersProfileBloc,
              description: CoupledStrings.reportMsg,
              momType: 'report',
              reasons: s.options,
              callBack: (String value) {});
        },
      );
    case btnType.CONNECT:
      return BtnWithText(
        enabled: true,
        roundBackGround: roundBackGround,
        bgColor: CoupledTheme().tabColor2,
        img: 'assets/Profile/Connect.png',
        text: 'Connect',
        onTap: () {
          SettingsAndCmsProvider().doAction({
            "keyword": "partnerProfile",
            "mom_type": "connect",
            "partner_id": GlobalData.othersProfile.id.toString(),
            "message": ""
          }, "MoMConnect").then((onValue) {
            if (onValue.code == 200) {
              GlobalWidgets().showToast(msg: "Request Sent");
              print(onValue.response!.data!.mom);
              try {
                GlobalData.othersProfile.mom = onValue.response!.data!.mom;
                othersProfileBloc.add(OtherProfileChangeNotifier());
              } on NoSuchMethodError {
                GlobalData.couplingScoreModel.response!.mom =
                    onValue.response!.data!.mom!;
                GlobalData.couplingScoreBloc.add(CSChangeNotify());
              }
            } else {
              GlobalWidgets().showToast(
                  msg: onValue.response!.msg ?? CoupledStrings.errorMsg);
            }
          });
        },
      );
    case btnType.CONNECT_WITH_MESSAGE:
      return BtnWithText(
        enabled: true,
        roundBackGround: roundBackGround,
        bgColor: CoupledTheme().tabColor2,
        img: 'assets/Profile/Connect.png',
        text: 'Connect',
        onTap: () {
          dialogs.connectWithMsgRequest(
            context,
            othersProfileBloc: othersProfileBloc,
            memberShipCode: GlobalData.othersProfile.membershipCode,
            partnerId: GlobalData.othersProfile.id.toString(),
          );
        },
      );
    case btnType.REJECT:
      return BtnWithText(
        text: "Reject",
        textSize: 12,
        img: "assets/MatchMeter/Rejected.png",
        roundBackGround: true,
        bgColor: CoupledTheme().primaryPink,
        textColor: Colors.black,
        onTap: () {
          dialogs.rejectWithMsgRequest(context,
              memberShipCode: GlobalData.othersProfile.membershipCode,
              partnerId: GlobalData.othersProfile.id.toString(),
              othersProfileBloc: othersProfileBloc);
        },
      );
    case btnType.RE_ACCEPT:
      return BtnWithText(
        bgColor: CoupledTheme().tabColor2,
        roundBackGround: roundBackGround,
        img: "assets/MatchMeter/Reaccept.png",
        text: "Reaccept",
        onTap: () {
          dialogs.reAcceptWithMsgRequest(context,
              othersProfileBloc: othersProfileBloc,
              partnerId: GlobalData.othersProfile.id.toString(),
              param: 'reject_me',
              message: (msg) {});
        },
      );
    case btnType.SNOOZE:
      return BtnWithText(
        enabled: GlobalData.othersProfile.mom!.snoozeAt == null,
        text: "Snooze",
        textSize: 12,
        img: "assets/MatchMeter/Snooze.png",
        imgColor: Colors.white,
        roundBackGround: true,
        bgColor: CoupledTheme().primaryPink,
        textColor: Colors.black,
        onTap: () {
          dialogs.snoozeRequest(
            context,
            memberShipCode: GlobalData.othersProfile.membershipCode,
            partnerId: GlobalData.othersProfile.id.toString(),
            othersProfileBloc: othersProfileBloc,
          );
        },
      );
    case btnType.ACCEPT:
      return BtnWithText(
        text: "Accept",
        textSize: 12,
        img: "assets/MatchMeter/Accepted.png",
        roundBackGround: true,
        bgColor: CoupledTheme().primaryPink,
        textColor: Colors.black,
        onTap: () {
          dialogs.acceptWithMsgRequest(
            context,
            memberShipCode: GlobalData.othersProfile.membershipCode,
            partnerId: GlobalData.othersProfile.id.toString(),
            othersProfileBloc: othersProfileBloc,
          );
        },
      );
    case btnType.CANCEL:
      return BtnWithText(
        img: "assets/Profile/Cancel.png",
        text: "Cancel",
        roundBackGround: roundBackGround,
        bgColor: CoupledTheme().tabColor2,
        onTap: () {
          SettingsAndCmsProvider().doAction({
            "mom_type": "cancel",
            "keyword": "partnerProfile",
            "partner_id": GlobalData.othersProfile.id.toString(),
            "message": ""
          }, "MoMCancel").then(
            (onValue) {
              GlobalWidgets().showToast(msg: "Request Cancelled");
              GlobalData.othersProfile.mom = onValue.response!.data!.mom;
              othersProfileBloc.add(OtherProfileChangeNotifier());
            },
            onError: (err) {
              GlobalWidgets().showToast(msg: "Something went wrong");
            },
          );
        },
      );
    case btnType.CHAT:
      return Stack(
        children: <Widget>[
          Container(
            width: 50.0,
            child: BtnWithText(
              enabled: getMomStatus(GlobalData.othersProfile.mom) ==
                      actionType.blockByMe ||
                  getMomStatus(GlobalData.othersProfile.mom) ==
                      actionType.blockMe ||
                  getMomStatus(GlobalData.othersProfile.mom) ==
                      actionType.rejectedMe ||
                  getMomStatus(GlobalData.othersProfile.mom) ==
                      actionType.rejectedByMe ||
                  getMomStatus(GlobalData.othersProfile.mom) ==
                      actionType.connected ||
                  getMomStatus(GlobalData.othersProfile.mom) ==
                      actionType.reported ||
                  getMomStatus(GlobalData.othersProfile.mom) ==
                      actionType.shortlistByMe ||
                  getMomStatus(GlobalData.othersProfile.mom) ==
                      actionType.shortlistMe ||
                  getMomStatus(GlobalData.othersProfile.mom) ==
                      actionType.requestReceived ||
                  getMomStatus(GlobalData.othersProfile.mom) ==
                      actionType.requestSent,
              roundBackGround: roundBackGround,
              bgColor: CoupledTheme().tabColor2,
              img: "assets/Profile/Chat.png",
              text: "Chat",
              onTap: () {
                print(GlobalData.othersProfile.dp?.photoName);
                print(GlobalData.othersProfile.name);
                print(GlobalData.othersProfile.membershipCode);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatViewMain(
                      photoName:
                          (GlobalData.othersProfile.dp?.photoName).toString(),
                      name: GlobalData.othersProfile.name,
                      memberShipCode: GlobalData.othersProfile.membershipCode,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Visibility(
              visible: (GlobalData?.othersProfile.chatCount ?? 0) == 0
                  ? false
                  : true,
              child: NotificationBadge(
                count: GlobalData?.othersProfile.chatCount ?? 0,
                radius: 20,
                bgcolor: CoupledTheme().primaryBlue,
              ),
            ),
          ),
        ],
      );
    case btnType.UNBLOCK:
      return BtnWithText(
        enabled: enable,
        roundBackGround: roundBackGround,
        bgColor: CoupledTheme().tabColor2,
        img: "assets/MatchMeter/Unblock.png",
        text: "Unblock",
        onTap: () {
          dialogs.showUnblock(context,
              partnerId: GlobalData.othersProfile.id.toString(),
              othersProfileBloc: othersProfileBloc,
              name:
                  "${GlobalData.othersProfile.name} ${GlobalData.othersProfile.lastName}",
              img: APis().imageApi(
                GlobalData.othersProfile.dp!.photoName ?? '',
                imageConversion: ImageConversion.MEDIA,
                //imageSize: 200,
              ),
              memberCode: GlobalData.othersProfile.membershipCode,
              reason: GlobalData.othersProfile.blockMe!.message,
              param: 'block');
        },
      );
    case btnType.REMINDER:
      return BtnWithText(
        roundBackGround: roundBackGround,
        bgColor: CoupledTheme().tabColor2,
        enabled: (GlobalData.othersProfile.mom!.remindAt == null) &&
            (GlobalData.othersProfile.mom!.seenAt != null) &&
            (DateTime.now().isAfter(
                GlobalData.othersProfile.mom!.seenAt.add(Duration(days: 3)))) &&
            (GlobalData.othersProfile.mom!.snoozeAt != null
                ? (DateTime.now().isAfter(
                    GlobalData.othersProfile.mom!.snoozeAt != ''
                        ? GlobalData.othersProfile.mom!.snoozeAt
                        : DateTime.now()))
                : true),
        img: "assets/MatchMeter/Reminder.png",
        text: "Remind",
        onTap: () {
          SettingsAndCmsProvider().doAction({
            "keyword": "partnerProfile",
            "mom_type": "remind",
            "partner_id": GlobalData.othersProfile.id.toString(),
            "message": ""
          }, "MoMReminder").then(
            (onValue) {
              GlobalWidgets().showToast(msg: "Request Sent");
              GlobalData.othersProfile.mom = onValue.response!.data!.mom;
              othersProfileBloc.add(OtherProfileChangeNotifier());
            },
            onError: (err) {
              GlobalWidgets().showToast(msg: "Something went wrong");
            },
          );
        },
      );
    default:
      return Container();
  }
}

/**
 * Others Profile
    Action buttons’ placement and state for various cases


    Header – At the bottom of the Photo

    Share Profile icon to be always present on the top-right corner of the profile photo

    Normal
    The profile should have the Connect message box and Connect icon
    In case of Profile is Shortlisted, related message to be shown for both the Users

    Sent
    The profile should have the related message with Reminder icon - Inactive mode (first) & Active mode (after 3 days on 4th day)
    Related message with Snooze icon - If partner snoozed user’s request (clock)
    Active Reminder icon after the Snooze time is completed


    Received
    The profile should have the related message
    Reject, Snooze and Accept icons will be floating, bottom of the screen, till the user takes action.

    Accepted
    The profile should have the related message with Connected Icon

    Rejected
    User 1 – The profile should have the related message with Reaccept icon – Active
    User 2 – The profile should have the related message with the Rejected icon

    Blocked
    User 1 – The profile should have the related message/Reason with Unblock - Active
    User 2 – The profile will not be visible it will show the message as “ sorry this person has blocked you”

    Reported
    User 1 – The profile should have the related message
    User 2 – The profile will not be visible it will show the message as “ sorry this person has blocked you”


    Body – Below about My Partner box

    Normal
    Contact icon - Inactive Mode
    Shortlist icon - Active Mode
    Recommend icon - Active Mode (Only for paid member) / active Mode (For Non-paid member but not able to recommend)

    Shortlisted
    Contact icon - Inactive Mode
    Chat icon - Active Mode (But not actionable, only events will be captured)
    Recommend icon - Active Mode (Only for paid member) / active Mode (For Non-paid member but not able to recommend)

    Sent
    Contact icon - Inactive Mode
    Chat icon - Active Mode (But not actionable until the Request is accepted – Applicable to Paid members only)
    Recommend icon - Active Mode (Only for paid member) / active Mode (For Non-paid member but not able to recommend)


    Received
    Contact icon - Inactive Mode
    Chat icon - Active Mode (Actionable with Reject, Snooze and Accept icons inside – User’s Interest message to be visible to Paid members only)
    Recommend icon - Active Mode (Only for paid member) / active Mode (For Non-paid member but not able to recommend)


    Accepted
    Contact icon - Active Mode (Only for paid member) / Inactive Mode (For Non-paid member)
    Chat icon - Active Mode (Actionable and Interest message/s to be visible to Paid member/ s only)
    Recommend icon - Active Mode (Only for paid member) / active Mode (For Non-paid member but not able to recommend)


    Rejected
    Contact icon - Inactive Mode
    Chat icon - Active Mode (Actionable with Reaccept button inside for User 1 // Nonactionable with Rejected message for User 2)
    Recommend icon - Active Mode (Only for paid member) / active Mode (For Non-paid member but not able to recommend)


    Blocked
    Contact icon - Inactive Mode
    Chat icon - Active Mode but Nonactionable
    Recommend icon - Inactive Mode

    Reported
    Contact icon - Inactive Mode
    Chat icon - Active Mode but Nonactionable
    Recommend icon – Inactive Mode


    Footer – At the end of User Profile

    Normal
    Connect Icon - Active
    Contact - Inactive
    Share - Active
    Shortlist - Active (if already shortlisted then inactive mode)
    Recommend - Active Mode (Only for paid member) / active Mode (For Non-paid member but not able to recommend)
    Block - Inactive
    Report - Active

    Sent
    Reminder - Inactive mode (first) & Active mode (after 3 days on 4th day). Active Reminder icon after the Snooze time is completed
    Request Cancel - Active
    Contact - Inactive
    Share - Active
    Recommend - Active Mode (Only for paid member) / active Mode (For Non-paid member but not able to recommend)
    Shortlist - Inactive
    Block - Inactive
    Report - Active

    Received
    Contact - Inactive
    Share - Active
    Recommend - Active Mode (Only for paid member) / active Mode (For Non-paid member but not able to recommend)
    Shortlist - Inactive
    Block - Inactive
    Report – Active

    Accepted
    Chat icon - Active Mode (Actionable and Interest message/s to be visible to Paid member/ s only)
    Contact - Active Mode (Only for paid member) / Inactive Mode (For Non-paid member)
    Share - Active
    Recommend - Active Mode (Only for paid member) / active Mode (For Non-paid member but not able to recommend)
    Block - active
    Report – Active

    Rejected
    Chat icon - Active Mode (Actionable with Reaccept button inside for User 1 // Nonactionable with Rejected message for User 2)
    Reaccept - Active
    Contact - Inactive
    Share - Active
    Recommend - Active Mode (Only for paid member) / active Mode (For Non-paid member but not able to recommend)
    Block - Inactive
    Report – Active

    Blocked
    Unblock Icon – Active Mode
    Chat icon - Active Mode but Nonactionable
    Contact - Inactive Mode
    Share - Inactive
    Shortlist - Inactive
    Recommend - Inactive Mode
    Report - Inactive

    Reported
    Chat icon - Active Mode but Nonactionable
    Contact - Inactive Mode
    Share - Inactive
    Shortlist - Inactive
    Recommend - Inactive Mode
    Report - Inactive*/
