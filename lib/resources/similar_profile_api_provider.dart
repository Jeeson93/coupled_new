import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/models/user_short_info_model.dart';

class SimilarProfileApiProvider {
  Future<UserShortInfoModel> similarProfile(String membershipCode) async {
    Map<String, dynamic> res =
        await RestAPI().get('${APis.similarProfile}$membershipCode');
    return UserShortInfoModel.fromJson(res);
  }
}
