

import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/models/coupling_score.dart';

class CouplingScoreApiProvider {
  Future<CouplingScoreModel> getCouplingScore(String otherUserId) async {
    try {
      Map<String, dynamic> res = await RestAPI().post(
          "${APis.getCouplingScore}",
          params: {"partner_id": '$otherUserId'});
      return CouplingScoreModel.fromMap(res);
    } on RestException catch (e) {
      throw e.message;
    }
  }

  Future<CommonResponseModel> getContactNo(String otherUserId) async {
    try {
      Map<String, dynamic> res = await RestAPI()
          .post("${APis.contactShow}", params: {"partner_id": '$otherUserId'});
      return CommonResponseModel.fromJson(res);
    } on RestException catch (e) {
      throw e.message;
    }
  }
}
