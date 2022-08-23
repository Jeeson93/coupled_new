import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/cms_model.dart';
import 'package:coupled/src/coupled_global.dart';

class BaseSettingsApiProvider {
  Future<List<BaseSettings>> getBaseSettings() async {
    List<BaseSettings> list = [];
    var res = await RestAPI().get(Uri.encodeFull(APis.baseSettings));
    print('base settings api calling---------');
    if (res != null) {
//      print("base settings res : $res");
      try {
        var rest = res["response"] as List;
        list = rest
            .map<BaseSettings>((json) => BaseSettings.fromJson(json))
            .toList();
      } on Exception catch (e) {
        print("base settings err : $e");
      }
    }

    ///Coupling questions
    try {
      GlobalData.couplingQuestion =
          await RestAPI().get(APis.getCouplingQuestions);
    } on RestException catch (e) {
      //GlobalWidgets().showToast(msg: 'Coupling Questions not loaded');
    }

    ///cms
    try {
      var a = await RestAPI().get(APis.cms);
      GlobalData.cmsModel = CmsModel.fromMap(a);
    } on RestException catch (e) {
      //GlobalWidgets().showToast(msg: 'Coupling Questions not loaded');
    }

    return list;
  }
}
