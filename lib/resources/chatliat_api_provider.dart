import 'package:coupled/Chat/Model/message_model.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/src/coupled_global.dart';

class ChatListApiProvider {
  Future<MessageModel> getchatList(String memberShipCode) async {
    try {
      final response =
          await await RestAPI().get("${APis.chatUrl}/${memberShipCode}");
      GlobalData.recievemsg = 3;
      return MessageModel.fromMap(response);
    } on RestException catch (e) {
      return throw e;
    }
  }
}
