import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/models/match_o_meter_model.dart';

class MatchOMeterApiProvider {
  String getType(
      {String? type,
      int? page,
      int? perPageCount,
      Map<String, String>? params}) {
    String pagination = "";
    page != null
        ? pagination = "&page=$page&perPageCount=$perPageCount"
        : pagination = "";

    switch (type) {
      case "sent":
        return '${APis.momListMain}?mom_type=sent$pagination';
      case "receive":
        return '${APis.momListMain}?mom_type=receive$pagination';
      case "accept_me":
        return '${APis.momListMain}?mom_type=accept_me$pagination';
      case "accept_partner":
        return '${APis.momListMain}?mom_type=accept_partner$pagination';
      case "shortlist_me":
        return '${APis.momListMain}?mom_type=shortlist_me$pagination';
      case "shortlist_partner":
        return '${APis.momListMain}?mom_type=shortlist_partner$pagination';
      case "reject_me":
        return '${APis.momListMain}?mom_type=reject_me$pagination';
      case "reject_partner":
        return '${APis.momListMain}?mom_type=reject_partner$pagination';
      case "view_me":
        return '${APis.momListMain}?mom_type=view_me$pagination';
      case "view_partner":
        return '${APis.momListMain}?mom_type=view_partner$pagination';
      case "block":
        return '${APis.momListMain}?mom_type=block$pagination';
      case "report":
        return '${APis.momListMain}?mom_type=report$pagination';
      case "given":
        return '${APis.momListMain}?mom_type=recommend_me$pagination';
      case "received":
        return '${APis.momListMain}?mom_type=recommend_partner$pagination';
      case "specially":
        return '${APis.momListMain}?mom_type=specially';

      ///MoM actions
      case "MoMConnect":
        return '${APis.momActions}connect';
      default:
        return '';
    }
  }

  Future<MatchOMeterModel> matchOMeterList(Map<String, String>? params,
      String? path, int? page, int? perPageCount) async {
    try {
      print('path..............$path');
      Map<String, dynamic> res = await RestAPI().get(getType(
          type: path, page: page, perPageCount: perPageCount, params: params));
      print('res(1)..............$res');
      return MatchOMeterModel.fromJson(res);
    } on RestException catch (e) {
      throw (e.message);
    }
  }

  Future<Map<String, dynamic>> speciallyAbledAction(
      Map<String, String> params) async {
    try {
      Map<String, dynamic> res =
          await RestAPI().post('${APis.momSpecially}', params: params);
      print(res);
      return res;
    } on RestException catch (e) {
      throw (e.message);
    }
  }
}
