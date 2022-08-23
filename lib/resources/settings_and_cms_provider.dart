

import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/models/common_response_model.dart';

class SettingsAndCmsProvider {
  String getPath(String path) {
    switch (path) {
      case "logoutFromOther":
        return APis.settingsLogoutFromOther;
      case "password":
        return APis.settingsChangePw;
      case "phone":
        return APis.settingsVerifyPhone;
      case "otpphone":
        return APis.settingsConformPhone;
      case "email":
        return APis.settingsVerifyEmail;
      case "otpemail":
        return APis.settingsConformEmail;
      case "delete":
        return APis.settingsDeleteAccount;
      case "hide":
        return APis.settingsHideAccount;
      case "activate":
        return APis.settingsActivateAccount;
      case "enquiry":
        return APis.cmsEnquiry;

      ///mom actions
      case "MoMCancel":
        return '${APis.momActions}cancel';
      case "MoMConnect":
        return '${APis.momActions}connect';
      case "MoMAccept":
        return '${APis.momActions}accept';
      case "MoMReject":
        return '${APis.momActions}reject';
      case "MoMUnblock":
        return '${APis.momActions}unblock';
      case "MoMSnooz":
        return '${APis.momActions}snooze';
      case "MoMReminder":
        return '${APis.momActions}remind';
      case "MoMSeen":
        return '${APis.momActions}seen';
      case "MoMView":
        return '${APis.momActions}view';
      case "MoMShortlist":
        return '${APis.momActions}shortlist';
      case "MoMBlock":
        return '${APis.momActions}block';
      case "MoMReport":
        return '${APis.momActions}report';
      case "MoMRecommend":
        return '${APis.momActions}recommend';
      case "MoMSpeciallyRequest":
        return '${APis.momActions}speciallyrequest';
      case "MoMSpeciallyRequestAction":
        return '${APis.momActions}specially';
      case "momDelete":
        return '${APis.momClear}';

      default:
        throw Exception("[getPath] is Empty");
    }
  }

  Future<CommonResponseModel> doAction(
      Map<String, dynamic> params, String path) async {
    try {
      Map<String, dynamic> res =
          await RestAPI().post(getPath(path), params: params);
      return CommonResponseModel.fromJson(res);
    } on RestException catch (e) {
      return CommonResponseModel.fromJson(e.message);
    }
  }
}
