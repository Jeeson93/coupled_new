import 'package:coupled/Chat/ChatBloc/chat_bloc.dart';
import 'package:coupled/Chat/Model/ChatModel.dart';
import 'package:coupled/Home/MatchBoard/view/couplingMatches.dart';
import 'package:coupled/Home/Profile/othersProfile/OtherProfile.dart';
import 'package:coupled/Home/Profile/othersProfile/helpers/mom_status.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/resources/settings_and_cms_provider.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

Widget getActionBtnChat(ChatResponse? chatResponse, ChatBloc chatBloc,
    BuildContext context, btnType type,
    {bool roundBackGround = true, enable = true}) {
  switch (type) {
    case btnType.RECOMMEND:
      return Stack(
        children: <Widget>[
          BtnWithText(
            roundBackGround: true,
            bgColor: CoupledTheme().tabColor2,
            img: "assets/MatchBoard/Recommendation.png",
            text: "Recommend",
            onTap: () {},
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

    case btnType.BLOCK:
      return BtnWithText(
        roundBackGround: true,
        enabled: getMomStatus(GlobalData.messageModel.response!.mom) ==
            actionType.connected,
        bgColor: CoupledTheme().tabColor2,
        img: "assets/Profile/Block.png",
        text: "Block",
        onTap: () {
          //  var s = GlobalData().getBaseSettingsType(baseType: 'block_cause');
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
          // var s = GlobalData().getBaseSettingsType(baseType: 'report_cause');
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
            "partner_id": chatResponse?.partnerId.toString(),
            "message": ""
          }, "MoMConnect").then((onValue) {
            GlobalWidgets().showToast(msg: "Request Sent");
          }, onError: (err) {
            GlobalWidgets().showToast(msg: "Something went wrong");
          });
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
              memberShipCode: chatResponse?.partner?.membershipCode ??
                  GlobalData?.othersProfile.membershipCode,
              partnerId: chatResponse?.partner?.id?.toString() ??
                  GlobalData?.othersProfile.id.toString());
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
              partnerId: chatResponse?.partner?.id?.toString() ??
                  GlobalData?.othersProfile.id.toString(),
              param: 'reject_me',
              message: (msg) {});
        },
      );
    case btnType.SNOOZE:
      return BtnWithText(
        enabled: enable,
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
            memberShipCode: chatResponse?.partner?.membershipCode ??
                GlobalData?.othersProfile.membershipCode,
            partnerId: chatResponse?.partner?.id?.toString() ??
                GlobalData?.othersProfile.id.toString(),
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
            memberShipCode: chatResponse?.partner?.membershipCode ??
                GlobalData?.othersProfile.membershipCode,
            partnerId: chatResponse?.partner?.id?.toString() ??
                GlobalData?.othersProfile.id.toString(),
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
            "partner_id": chatResponse?.partnerId.toString() ??
                GlobalData.othersProfile.id.toString(),
            "message": ""
          }, "MoMCancel").then(
            (onValue) {
              GlobalWidgets().showToast(msg: "Request Cancelled");
            },
            onError: (err) {
              GlobalWidgets().showToast(msg: "Something went wrong");
            },
          );
        },
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
              partnerId: chatResponse?.partner?.id?.toString() ??
                  GlobalData?.othersProfile.id.toString(),
              name:
                  "${chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} ",
              img: APis().imageApi(
                chatResponse?.partner?.dp?.photoName ??
                    GlobalData.othersProfile.dp?.photoName.toString(),
                imageConversion: ImageConversion.MEDIA,
                //imageSize: 200,
              ),
              memberCode: chatResponse?.partner?.membershipCode ??
                  GlobalData?.othersProfile.membershipCode,
              param: 'block',
              reason: chatResponse?.mom?.message ?? '');
        },
      );
    case btnType.REMINDER:
      return BtnWithText(
        roundBackGround: roundBackGround,
        bgColor: CoupledTheme().tabColor2,
        enabled: true,
//        enabled: (CoupledGlobal.othersProfile?.mom?.remindAt == null) &&
//            (CoupledGlobal.othersProfile?.mom?.seenAt != null) &&
//            /*    (CoupledGlobal.othersProfile.mom.seenAt.difference(DateTime.now()) >
//                Duration(days: 3)) &&
//            (CoupledGlobal.othersProfile.mom.snoozeAt
//                    .difference(DateTime.now()) >
//                Duration(days: 1)),*/
//
//            (DateTime.now().isAfter(CoupledGlobal.othersProfile.mom.seenAt
//                .add(Duration(days: 3)))) &&
//            (DateTime.now().isAfter(CoupledGlobal.othersProfile.mom.snoozeAt)),
        img: "assets/MatchMeter/Reminder.png",
        text: "Remind",
        onTap: () {
          SettingsAndCmsProvider().doAction({
            "keyword": "partnerProfile",
            "mom_type": "remind",
            "partner_id": chatResponse?.id.toString(),
            "message": ""
          }, "MoMReminder").then(
            (onValue) {},
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
