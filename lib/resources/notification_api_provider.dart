import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/models/notification_model.dart';

class NotificationApiProvider {
  String getType({String type = '', int page = 1, int perPageCount = 100}) {
    String pagination = "";
    page != null
        ? pagination = "&page=$page&perPageCount=$perPageCount"
        : pagination = "";

    switch (type) {
      case "mom":
        return '${APis.notificationByType}?type=match-o-meter$pagination';
      case "coupled":
        return '${APis.notificationByType}?type=from-coupled$pagination';
      case "count":
        return '${APis.notificationByType}?type=count';

      default:
        return '';
    }
  }

  Future<NotificationModel1> notifications(
      String path, int page, int perPageCount) async {
    try {
      Map<String, dynamic> res = await RestAPI()
          .get(getType(type: path, page: page, perPageCount: perPageCount));
      return NotificationModel1.fromJson(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }

  Future<CommonResponseModel> getNotification(int status) async {
    try {
      Map<String, dynamic> res = await RestAPI()
          .post(APis.getNotification, params: {'status': status});
      return CommonResponseModel.fromJson(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
