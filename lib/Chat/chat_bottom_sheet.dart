import 'package:coupled/Chat/ChatBloc/chat_bloc.dart';
import 'package:coupled/Chat/Model/ChatModel.dart';
import 'package:coupled/Chat/get_action_button_chat.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:coupled/Home/Profile/othersProfile/OtherProfile.dart';

Widget bottomActionChat(
    BuildContext context, ChatBloc chatBloc, ChatResponse? chatResponse) {
  return Container(
    height: 75,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          getActionBtnChat(chatResponse!, chatBloc, context, btnType.REJECT),
          getActionBtnChat(chatResponse, chatBloc, context, btnType.SNOOZE,
              enable: GlobalData.messageModel.response!.mom?.snoozeAt == null),
          getActionBtnChat(chatResponse, chatBloc, context, btnType.ACCEPT),
        ],
      ),
    ),
  );
}
