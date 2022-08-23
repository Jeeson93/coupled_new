import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/models/user_short_info_model.dart';

class MatchBoardApiProvider {
  String getType({required String type /*, int page, int perPageCount*/
      }) {
    //   String pagination;
    //  page != null ? pagination = "&page=$page&perPageCount=$perPageCount" : pagination = "";
    switch (type) {
      case "general":
        return 'general_match';
      case "coupling":
        return 'coupling_match';
      case "mix":
        return 'paid_mix_match';
      case "mix2":
        return 'free_mix_match';
      case "latest":
        return 'latest_match';
      default:
        return '';
    }
  }

  Future<UserShortInfoModel> matchBoardList(
      Map<String, String> params, String path) async {
    try {
      final response = await RestAPI().get(
        '${APis.matchBoard}${getType(type: path)}',
      );

      return UserShortInfoModel.fromJson(response);
    } on RestException catch (e) {
      if (path != 'mix2') return throw e;
    }
    return UserShortInfoModel.fromJson({});
  }

  Future<UserShortInfoModel> getSearchByID(Map<String, dynamic> params) async {
    print("api getSearchByID------ $params");

    try {
      final Map<String, dynamic> response = await RestAPI().get(
        "${APis.getSearchById}/?search_key=${params["query"]}&limit=${params["limit"]}",
      );

      print("getSearchByID : ${response.toString()}");
      return UserShortInfoModel.fromJson(response);
    } on RestException catch (exception) {
      throw exception;
    }
  }
}
