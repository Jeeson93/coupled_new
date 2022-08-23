import 'package:coupled/Home/Profile/othersProfile/OtherProfile.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/src/coupled_global.dart';

//shortlist, view, report, connect, block (mom_type)
// sent,seen,remind,snooze, accept,reject, cancel (mom_status)

actionType getMomStatus(Mom? mom) {
  ///[isMyAction]=>actionable by user
  bool isMyAction = mom?.userId != GlobalData.myProfile.id;
  String momType = mom?.momType ?? '';
  String momStatus = mom?.momStatus ?? '';

  if (momType == "connect") {
    if (momStatus == "sent" || momStatus == "seen") {
      return isMyAction ? actionType.requestReceived : actionType.requestSent;
    } else if (momStatus == "remind") {
      return isMyAction ? actionType.request : actionType.remind;
    } else if (momStatus == "snooze") {
      return isMyAction ? actionType.request : actionType.snooze;
    } else if (momStatus == "accept") {
      return actionType.connected;
    } else if (momStatus == "reject") {
      return isMyAction ? actionType.rejectedByMe : actionType.rejectedMe;
    } else {
      return actionType.DEFAULT;
    }
  } else if (momType == "block") {
    return isMyAction ? actionType.blockByMe : actionType.blockMe;
  } else if (momType == "report") {
    return actionType.reported;
  } else if (GlobalData.othersProfile.shortlistByMe != null) {
    return actionType.shortlistByMe;
  } else if (GlobalData.othersProfile.shortlistMe != null) {
    return actionType.shortlistMe;
  } else {
    return actionType.DEFAULT;
  }
}
