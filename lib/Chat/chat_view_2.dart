import 'package:coupled/Chat/ChatBloc/chat_bloc.dart';
import 'package:coupled/Chat/Model/ChatModel.dart';
import 'package:coupled/Chat/Model/message_model.dart';
import 'package:coupled/Chat/chat_bottom_sheet.dart';
import 'package:coupled/Chat/get_action_button_chat.dart';
import 'package:coupled/Home/Profile/othersProfile/helpers/mom_status.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/chat_bubble.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:coupled/Home/Profile/othersProfile/OtherProfile.dart';
import 'package:shimmer/shimmer.dart';

class ChatView extends StatefulWidget {
  final ChatResponse? chatResponse;
  final String membershipCode;

  const ChatView(
      {Key? key, required this.chatResponse, required this.membershipCode})
      : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ScrollController _scrollController = ScrollController();
  ScrollController scrollController = ScrollController();

  /// for icon click scroll
  //ScrollController listScrollController = ScrollController();

  MessageModel _list = MessageModel(response: ChatModelResponse(mom: Mom()));
  var position;
  String oldDate = '';
  double _defaultPadding = 10.0;
  String displayMessage = '';

  Widget chatBubbly(
      {required Alignment alignment,
      Message? chats,
      int? unreadIndex,
      int? messageIndex}) {
    return Align(
        alignment: alignment,
        child: alignment == Alignment.topCenter
            ? TextView(
                showEventMessages(chats!),
                textAlign: TextAlign.center,
                size: 15.0,
                color: (displayMessage
                            .toString()
                            .contains("You have received connect request") ||
                        displayMessage.toString().contains(
                            "Tap on TOL icon to initiate a Request.") ||
                        displayMessage
                            .toString()
                            .contains("has declined your connect request") ||
                        displayMessage
                            .toString()
                            .contains("snoozed your profile") ||
                        displayMessage
                            .toString()
                            .contains("has blocked your profile") ||
                        displayMessage
                            .toString()
                            .contains("have unblocked your profile") ||
                        displayMessage
                            .toString()
                            .contains("have cancelled the connect request") ||
                        displayMessage
                            .toString()
                            .contains("have reported your  profile") ||
                        displayMessage
                            .toString()
                            .contains("have shortlisted your  profile") ||
                        displayMessage
                            .toString()
                            .contains("Tap on Accept icon to respond") ||
                        displayMessage.toString().contains(
                            "has declined your Token of Love request.") ||
                        displayMessage.toString().contains(
                            "has accepted your token of love request") ||
                        displayMessage.toString().contains(
                            "has sent you a surprise on your address") ||
                        displayMessage.toString().contains("are connected"))
                    ? CoupledTheme().primaryPink
                    : CoupledTheme().primaryBlue,
                fontWeight: FontWeight.normal,
                maxLines: 60,
                overflow: TextOverflow.ellipsis,
                decoration: TextDecoration.none,
                textScaleFactor: .8,
              )
            : Column(
                children: <Widget>[
                  Visibility(
                    visible: messageIndex == unreadIndex,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'You have unread messages',
                        style: TextStyle(color: Colors.purple, fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    margin: alignment == Alignment.topLeft
                        ? EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 4)
                        : EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 4),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: chats?.mode == 'sticker'
                              ? Container(
                                  margin: EdgeInsets.only(
                                      left: alignment == Alignment.topLeft
                                          ? 0
                                          : _defaultPadding,
                                      right: alignment == Alignment.topRight
                                          ? 15
                                          : _defaultPadding,
                                      top: _defaultPadding - 3,
                                      bottom: _defaultPadding - 3),
                                  child: Stack(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Visibility(
                                                  visible: alignment ==
                                                      Alignment.topRight,
                                                  child: Spacer(
                                                    flex: 2,
                                                  )),
                                              Image.network(
                                                APis.stickerImagePath +
                                                    chats!.message.toString(),
                                                height: 90,
                                                width: 90,
                                              ),
                                              Visibility(
                                                  visible: alignment ==
                                                      Alignment.topLeft,
                                                  child: Spacer(
                                                    flex: 2,
                                                  ))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                alignment == Alignment.topLeft
                                                    ? MainAxisAlignment.start
                                                    : MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: TextView(
                                                  getTime(
                                                      chats.createdAt, false),
                                                  size: 12.0,
                                                  textAlign: TextAlign.end,
                                                  fontWeight: FontWeight.normal,
                                                  maxLines: 60,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.none,
                                                  textScaleFactor: .8,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3.0,
                                              ),
                                              Visibility(
                                                  //chats?.partner?.lastActive
                                                  visible: chats.userId !=
                                                          widget.chatResponse
                                                              ?.partner?.id ??
                                                      GlobalData.othersProfile
                                                              .id !=
                                                          null,
                                                  child: chats.read == 1
//                                                      ((chats?.partner?.lastActive??DateTime.now()).difference(chats
//                                                                  .createdAt)
//                                                              .inDays) >
//                                                          0
                                                      ? Icon(
                                                          Icons.done_all,
                                                          size: 15.0,
                                                          color: Colors.blue,
                                                        )
                                                      : Icon(
                                                          Icons.done_all,
                                                          size: 15.0,
                                                          color: Colors.white,
                                                        )),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : CustomPaint(
                                  painter: ChatBubble(
                                      color: alignment == Alignment.topLeft
                                          ? CoupledTheme().myChatColor
                                          : CoupledTheme().patnerChatColor,
                                      alignment: alignment),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: alignment == Alignment.topLeft
                                            ? 20
                                            : _defaultPadding,
                                        right: alignment == Alignment.topRight
                                            ? 15
                                            : _defaultPadding,
                                        top: _defaultPadding - 3,
                                        bottom: _defaultPadding - 3),
                                    child: GlobalData.recievemsg == 3
                                        ? Stack(
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  TextView(
                                                    chats?.message != null
                                                        ? chats!.message
                                                            .toString()
                                                        : CoupledStrings
                                                            .becomeAMemberChat,
                                                    lineSpacing: 1,
                                                    size: 19.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    maxLines: 60,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none,
                                                    textScaleFactor: .8,
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      TextView(
                                                        getTime(
                                                            chats?.createdAt,
                                                            false),
                                                        size: 12.0,
                                                        textAlign:
                                                            TextAlign.end,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        maxLines: 60,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: Colors.white,
                                                        decoration:
                                                            TextDecoration.none,
                                                        textScaleFactor: .8,
                                                      ),
                                                      SizedBox(
                                                        width: 3.0,
                                                      ),
                                                      Visibility(
                                                          //chats?.partner?.lastActive
                                                          visible: chats
                                                                      ?.userId !=
                                                                  widget
                                                                      .chatResponse
                                                                      ?.partner
                                                                      ?.id ??
                                                              GlobalData
                                                                      .othersProfile
                                                                      .id !=
                                                                  null,
                                                          child: chats?.read ==
                                                                  1
//                                                      ((chats?.partner?.lastActive??DateTime.now()).difference(chats
//                                                                  .createdAt)
//                                                              .inDays) >
//                                                          0
                                                              ? Icon(
                                                                  Icons
                                                                      .done_all,
                                                                  size: 15.0,
                                                                  color: Colors
                                                                      .blue,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .done_all,
                                                                  size: 15.0,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        : Stack(
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey,
                                                    highlightColor:
                                                        Colors.black26,
                                                    child: TextView(
                                                      chats?.message != null
                                                          ? chats!.message
                                                              .toString()
                                                          : CoupledStrings
                                                              .becomeAMemberChat,
                                                      lineSpacing: 1,
                                                      size: 19.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      maxLines: 60,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.start,
                                                      color: Colors.white,
                                                      decoration:
                                                          TextDecoration.none,
                                                      textScaleFactor: .8,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Shimmer.fromColors(
                                                          baseColor:
                                                              Colors.grey,
                                                          highlightColor:
                                                              Colors.black26,
                                                          child: TextView(
                                                            getTime(
                                                                chats
                                                                    ?.createdAt,
                                                                false),
                                                            size: 12.0,
                                                            textAlign:
                                                                TextAlign.end,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            maxLines: 60,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: Colors.white,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            textScaleFactor: .8,
                                                          )),
                                                      SizedBox(
                                                        width: 3.0,
                                                      ),
                                                      Shimmer.fromColors(
                                                          baseColor:
                                                              Colors.grey,
                                                          highlightColor:
                                                              Colors.black26,
                                                          child: Visibility(
                                                              //chats?.partner?.lastActive
                                                              visible: chats
                                                                          ?.userId !=
                                                                      widget
                                                                          .chatResponse
                                                                          ?.partner
                                                                          ?.id ??
                                                                  GlobalData
                                                                          .othersProfile
                                                                          .id !=
                                                                      null,
                                                              child:
                                                                  chats?.read ==
                                                                          1
                                                                      ? Icon(
                                                                          Icons
                                                                              .done_all,
                                                                          size:
                                                                              15.0,
                                                                          color:
                                                                              Colors.blue,
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .done_all,
                                                                          size:
                                                                              15.0,
                                                                          color:
                                                                              Colors.white,
                                                                        ))),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                  ),
                                ),
                        ),
                        Visibility(
                          visible: chats?.love == 1,
                          child: Align(
                              alignment: alignment ==
                                      Alignment
                                          .topLeft /*&& chats.mode=='sticker'*/
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: GlobalWidgets().iconCreator(
                                  "assets/heart.png",
                                  color: alignment == Alignment.topLeft
                                      ? CoupledTheme().primaryPink
                                      : CoupledTheme().primaryBlue,
                                  size: FixedIconSize.SMALL)),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }

  @override
  void didChangeDependencies() {
    setState(() {
      GlobalData.chatResponse = widget.chatResponse;

      GlobalData.chatBloc = BlocProvider.of<ChatBloc>(context);
      GlobalData.chatBloc.add(GetChat(
          GlobalData.chatResponse?.partner?.membershipCode ??
              widget.membershipCode));
    });

    super.didChangeDependencies();
  }

  @override
  void initState() {
    print("$_list");
    didChangeDependencies();
    scrollController.addListener(_scrollListener);

    super.initState();
  }

  var count = 0;
  String momMessage = '';
  @override
  void dispose() {
    GlobalData.messageModel.response?.messages = [];

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatBlocState>(
        bloc: GlobalData.chatBloc,
        builder: (context, state) {
          print(
              'stst.......${GlobalData.messageModel.response?.messages?.length}');
          if (state is InitialChatBlocState) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                //controller: getScrollController(),
                //reverse: true,
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          top: count > 0 ? 5.0 : 10.0,
                          bottom: 0.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    right:
                                        MediaQuery.of(context).size.width / 4),
                                child: CustomPaint(
                                  painter: ChatBubble(
                                      color: CoupledTheme().myChatColor,
                                      alignment: Alignment.topLeft),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.black26,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '     .............................   ',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    right:
                                        MediaQuery.of(context).size.width / 4),
                                child: CustomPaint(
                                  painter: ChatBubble(
                                      color: CoupledTheme().myChatColor,
                                      alignment: Alignment.topLeft),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.black26,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '     ................................   ',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 4),
                                child: CustomPaint(
                                  painter: ChatBubble(
                                      color: CoupledTheme().myChatColor,
                                      alignment: Alignment.topRight),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.black26,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '     .......................................   ',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 4),
                                child: CustomPaint(
                                  painter: ChatBubble(
                                      color: CoupledTheme().myChatColor,
                                      alignment: Alignment.topRight),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.black26,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '     ............................. ...  ',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 4),
                                child: CustomPaint(
                                  painter: ChatBubble(
                                      color: CoupledTheme().myChatColor,
                                      alignment: Alignment.topRight),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.black26,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '     .............................   ',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ));
                });
          } else if (state is ChatMessageLoaded) {
            print(
                'userStatus--${GlobalData.messageModel.response?.userStatus}');

            return Scaffold(
                floatingActionButton: FloatingActionButton(
                  mini: true,
                  backgroundColor: CoupledTheme().primaryBlue,
                  onPressed: () {
                    if (scrollController.hasClients) {
                      position = scrollController.position.maxScrollExtent;
                      print("position");
                      print(position);

                      print(scrollController.hasClients);
                      scrollController.jumpTo(position);
                    }
                  },
                  isExtended: true,
                  tooltip: "Scroll to Bottom",
                  child: Icon(Icons.arrow_downward),
                ),
                bottomNavigationBar: getMomStatus(
                                GlobalData.messageModel.response?.mom) ==
                            (actionType.requestReceived) &&
                        getMomStatus(GlobalData.messageModel.response?.mom) !=
                            (actionType.sent)
                    /*&&
                      GlobalData?.messageModel?.response?.mom?.snoozeAt == null*/
                    ? bottomActionChat(
                        context,
                        GlobalData.chatBloc,
                        widget.chatResponse,
                      )
                    : getMomStatus(GlobalData.messageModel.response?.mom) ==
                            actionType.blockMe
                        ? getActionBtnChat(widget.chatResponse,
                            GlobalData.chatBloc, context, btnType.UNBLOCK)
                        : getMomStatus(GlobalData.messageModel.response!.mom) ==
                                actionType.rejectedByMe
                            ? getActionBtnChat(widget.chatResponse,
                                GlobalData.chatBloc, context, btnType.RE_ACCEPT)
                            : getMomStatus(GlobalData
                                        .messageModel.response!.mom) ==
                                    actionType.snooze
                                ? getActionBtnChat(
                                    widget.chatResponse,
                                    GlobalData.chatBloc,
                                    context,
                                    btnType.REMINDER)
                                : null,
                backgroundColor: Colors.transparent,
                body: Stack(
                  alignment: Alignment(0, -1),
                  children: <Widget>[
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      controller: scrollController,
                      //reverse: true,
                      child: GlobalData
                                  .messageModel.response?.messages?.length !=
                              0
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              //controller: getScrollController(),
                              //reverse: true,
                              shrinkWrap: true,
                              itemCount: GlobalData
                                  .messageModel.response?.messages?.length,
                              itemBuilder: (context, index) {
                                if (index + 1 !=
                                        GlobalData.messageModel.response
                                            ?.messages?.length &&
                                    GlobalData.messageModel.response
                                            ?.messages?[index].id ==
                                        1) {
                                  count++;
                                  if (GlobalData.messageModel.response
                                          ?.messages?[index + 1].id ==
                                      0) {
                                    count = 0;
                                  }
                                } else if (index + 1 !=
                                        GlobalData.messageModel.response
                                            ?.messages?.length &&
                                    GlobalData.messageModel.response
                                            ?.messages?[index].id ==
                                        1) {
                                  count++;
                                  if (GlobalData.messageModel.response
                                          ?.messages?[index + 1].id ==
                                      1) {
                                    count = 0;
                                  }
                                }
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                      top: count > 0 ? 5.0 : 10.0,
                                      bottom: 0.0),
                                  child: GestureDetector(
                                    onDoubleTap: () {
                                      if (GlobalData.myProfile.id ==
                                          GlobalData.messageModel.response
                                              ?.messages?[index].partnerId) {
                                        if (GlobalData.messageModel.response
                                                ?.messages?[index].message !=
                                            null) {
                                          if (GlobalData.messageModel
                                                      .response?.mom?.momStatus !=
                                                  'sent' &&
                                              GlobalData.messageModel.response
                                                      ?.mom?.momType !=
                                                  'block' &&
                                              GlobalData.messageModel.response
                                                      ?.mom?.momType !=
                                                  'report' &&
                                              GlobalData.messageModel.response
                                                      ?.userStatus ==
                                                  'active') {
                                            if (GlobalData
                                                    .messageModel
                                                    .response!
                                                    .messages![index]
                                                    .type !=
                                                'company') {
                                              setState(() {
                                                GlobalData.chatBloc.add(
                                                    SendLove(
                                                        GlobalData
                                                                .messageModel
                                                                .response
                                                                ?.messages?[
                                                                    index]
                                                                .id
                                                                ?.toInt() ??
                                                            0,
                                                        1));

                                                GlobalData.chatBloc.add(GetChat(
                                                    widget.chatResponse?.partner
                                                            ?.membershipCode ??
                                                        widget.membershipCode));
                                              });
                                            }
                                          }
                                        }
                                      }
                                    },
                                    child: chatBubbly(
                                      alignment: getAlignment(index),
                                      chats: GlobalData.messageModel.response
                                          ?.messages?[index],
                                      unreadIndex: GlobalData.messageModel
                                          .response?.messagesUnreadIndex,
                                      messageIndex: GlobalData.messageModel
                                          .response?.messages?[index].id,
                                    ),
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              //controller: getScrollController(),
                              //reverse: true,
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        top: count > 0 ? 5.0 : 10.0,
                                        bottom: 0.0),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4),
                                              child: CustomPaint(
                                                painter: ChatBubble(
                                                    color: CoupledTheme()
                                                        .myChatColor,
                                                    alignment:
                                                        Alignment.topLeft),
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey,
                                                  highlightColor:
                                                      Colors.black26,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '     .............................   ',
                                                      style: TextStyle(
                                                          fontSize: 22),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4),
                                              child: CustomPaint(
                                                painter: ChatBubble(
                                                    color: CoupledTheme()
                                                        .myChatColor,
                                                    alignment:
                                                        Alignment.topLeft),
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey,
                                                  highlightColor:
                                                      Colors.black26,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '     .............................   ',
                                                      style: TextStyle(
                                                          fontSize: 22),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4),
                                              child: CustomPaint(
                                                painter: ChatBubble(
                                                    color: CoupledTheme()
                                                        .myChatColor,
                                                    alignment:
                                                        Alignment.topRight),
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey,
                                                  highlightColor:
                                                      Colors.black26,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '     .............................   ',
                                                      style: TextStyle(
                                                          fontSize: 22),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4),
                                              child: CustomPaint(
                                                painter: ChatBubble(
                                                    color: CoupledTheme()
                                                        .myChatColor,
                                                    alignment:
                                                        Alignment.topRight),
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey,
                                                  highlightColor:
                                                      Colors.black26,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '     .............................   ',
                                                      style: TextStyle(
                                                          fontSize: 22),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4),
                                              child: CustomPaint(
                                                painter: ChatBubble(
                                                    color: CoupledTheme()
                                                        .myChatColor,
                                                    alignment:
                                                        Alignment.topRight),
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey,
                                                  highlightColor:
                                                      Colors.black26,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '     .............................   ',
                                                      style: TextStyle(
                                                          fontSize: 22),
                                                    ),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ));
                              }),
                    ),
                  ],
                )

                // Center(
                //     child: GlobalWidgets().showCircleProgress(),
                //   ),
                );
          }

          if (state is ChatError) {
            return Center(
              child: TextView(
                CoupledStrings.errorMsg,
                size: 12.0,
                fontWeight: FontWeight.normal,
                maxLines: 60,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                color: Colors.white,
                decoration: TextDecoration.none,
                textScaleFactor: .8,
              ),
            );
          } else {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                //controller: getScrollController(),
                //reverse: true,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          top: count > 0 ? 5.0 : 10.0,
                          bottom: 0.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    right:
                                        MediaQuery.of(context).size.width / 4),
                                child: CustomPaint(
                                  painter: ChatBubble(
                                      color: CoupledTheme().myChatColor,
                                      alignment: Alignment.topLeft),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.black26,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '........................................',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    right:
                                        MediaQuery.of(context).size.width / 4),
                                child: CustomPaint(
                                  painter: ChatBubble(
                                      color: CoupledTheme().myChatColor,
                                      alignment: Alignment.topLeft),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.black26,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '........................................',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 4),
                                child: CustomPaint(
                                  painter: ChatBubble(
                                      color: CoupledTheme().myChatColor,
                                      alignment: Alignment.topRight),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.black26,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '........................................',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 4),
                                child: CustomPaint(
                                  painter: ChatBubble(
                                      color: CoupledTheme().myChatColor,
                                      alignment: Alignment.topRight),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.black26,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '........................................',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 4),
                                child: CustomPaint(
                                  painter: ChatBubble(
                                      color: CoupledTheme().myChatColor,
                                      alignment: Alignment.topRight),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.black26,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '........................................',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ));
                });
          }
        });
  }

  String getTime(DateTime? createdAt, bool isEvent) {
    if (isEvent) {
      return formatDate(createdAt!, [MM, ' ', dd, 'th - ', yyyy]).toString() +
          ', ' +
          DateFormat.jm()
              .format(createdAt.add(Duration(hours: 5, minutes: 30)))
              .toString();
    } else if (createdAt is DateTime) {
      int difference = ((DateTime.now()
              .difference(createdAt.add(Duration(hours: 5, minutes: 30)))
              .inDays))
          .round();
      if (difference < 1) {
        return DateFormat.jm()
            .format(createdAt.add(Duration(hours: 5, minutes: 30)))
            .toString();
      } else if (difference >= 1) {
        return DateFormat.jm()
                .format(createdAt.add(Duration(hours: 5, minutes: 30)))
                .toString() +
            '\n' +
            '\n' +
            formatDate(createdAt, [dd, '.', mm, '.', yy]).toString();
      } else {
        return DateFormat.jm()
                .format(createdAt.add(Duration(hours: 5, minutes: 30)))
                .toString() +
            '\n' +
            formatDate(createdAt, [dd, '.', mm, '.', yy]).toString();
      }
    }
    return "Unknown time";
  }

  ScrollController getScrollController() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
    return _scrollController;
  }

  Alignment getAlignment(int index) {
    if (GlobalData.messageModel.response?.messages?[index].userId ==
            GlobalData.myProfile.id &&
        GlobalData.messageModel.response?.messages?[index].type != 'company') {
      return Alignment.topRight;
    }

    if (GlobalData.messageModel.response?.messages?[index].userId !=
            GlobalData.myProfile.id &&
        GlobalData.messageModel.response?.messages?[index].type != 'company') {
      return Alignment.topLeft;
    }

    if (GlobalData.messageModel.response?.messages?[index].type == 'company' ||
        GlobalData.messageModel.response?.messagesUnreadIndex ==
            GlobalData.messageModel.response?.messages?[index].id) {
      return Alignment.topCenter;
    } else
      return Alignment.topCenter;
  }

  String showEventMessages(Message chats) {
    momMessage = chats.message.toString();
    print("jake");
    print(momMessage);

    displayMessage = '';

    /// remove time from date
    final DateTime? now = chats.createdAt;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now!);

    if (momMessage == 'connect' && GlobalData.myProfile.id != chats.partnerId) {
      displayMessage +=
          'You have sent request to ${widget.chatResponse?.partner?.name ?? GlobalData.othersProfile.name}';
    } else if ((momMessage == 'connect' &&
        GlobalData.myProfile.id == chats.partnerId)) {
      displayMessage +=
          'You have received connect request from ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}';
    } else if ((momMessage == 'accept')) {
      displayMessage +=
          'You and ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} are connected';
    } else if (momMessage == 'reject' &&
        GlobalData.myProfile.id != chats.partnerId) {
      displayMessage +=
          'You have declined ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}\'s request';
    } else if (momMessage == 'reject' &&
        GlobalData.myProfile.id == chats.partnerId) {
      displayMessage =
          '${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} has declined your connect request';
    } else if (momMessage == 'snooze' &&
        GlobalData.myProfile.id != chats.partnerId) {
      displayMessage +=
          'You have snoozed ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}\'s request ';
    } else if (momMessage == 'snooze' &&
        GlobalData.myProfile.id == chats.partnerId) {
      displayMessage +=
          '${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} snoozed your profile';
    } else if (momMessage == 'block' &&
        GlobalData.myProfile.id == chats.partnerId) {
      displayMessage +=
          '${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} has blocked your profile';
    } else if (momMessage == 'block' &&
        GlobalData.myProfile.id != chats.partnerId) {
      displayMessage +=
          'You have blocked ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}\'s profile';
    } else if (momMessage == 'unblock' &&
        GlobalData.myProfile.id == chats.partnerId) {
      displayMessage +=
          '${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} have unblocked your profile';
    } else if (momMessage == 'cancel' &&
        GlobalData.myProfile.id == chats.partnerId) {
      displayMessage +=
          '${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} have cancelled the connect request';
    } else if (momMessage == 'cancel' &&
        GlobalData.myProfile.id != chats.partnerId) {
      displayMessage += 'you have cancelled  the connect request';
    } else if (momMessage == 'report' &&
        GlobalData.myProfile.id != chats.partnerId) {
      displayMessage +=
          'you have reported ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}\'s profile';
    } else if (momMessage == 'report' &&
        GlobalData.myProfile.id == chats.partnerId) {
      displayMessage +=
          '${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} have reported your  profile';
    } else if (momMessage == 'shortlist' &&
        GlobalData.myProfile.id != chats.partnerId) {
      displayMessage +=
          'you have shortlisted ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}\'s profile';
    } else if (momMessage == 'shortlist' &&
        GlobalData.myProfile.id == chats.partnerId) {
      displayMessage +=
          '${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} have shortlisted your  profile';
    } else if (momMessage == 'shortlist' &&
        GlobalData.myProfile.id == chats.partnerId) {
      displayMessage +=
          '${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} have shortlisted your  profile';
    } else if (momMessage == 'tokenoflove' &&
        GlobalData.myProfile.id == chats.partnerId) {
      displayMessage +=
          'You have received a Token of Love request.Tap on Accept icon to respond ';
    } else if (momMessage == 'tokenoflove' &&
        GlobalData.myProfile.id != chats.partnerId) {
      displayMessage +=
          'You have sent a token of love request, wait for ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} response ';
    } else if (momMessage == 'tokenoflove_reject' &&
        GlobalData.myProfile.id == chats.partnerId) {
      displayMessage +=
          '${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} has declined your Token of Love request. Keep conversing, impress and unlock the token of love again" ';
    } else if (momMessage == 'tokenoflove_reject' &&
        GlobalData.myProfile.id != chats.partnerId) {
      displayMessage +=
          'You have rejected a token of love request sent by ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}';
    } else if (momMessage == 'tokenoflove_accept' &&
        GlobalData.myProfile.id != chats.partnerId) {
      displayMessage +=
          'You have accepted the token of love request sent by ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}';
    } else if (momMessage == 'tokenoflove_accept' &&
        GlobalData.myProfile.id == chats.partnerId) {
      displayMessage +=
          '${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} has accepted your token of love request .Tap on TOL icon to surprise ${widget?.chatResponse?.partner?.name ?? GlobalData?.othersProfile?.name} with a gift ';
    } else if (momMessage == 'tokenoflove_unlock' &&
        GlobalData.myProfile.id == chats.partnerId) {
      displayMessage += 'Congos! You have given Three Hearts.';
    } else if (momMessage == 'tokenoflove_unlock' &&
        GlobalData.myProfile.id != chats.partnerId) {
      displayMessage +=
          'Congos! You have earned Three Hearts and the Token of Love is Unlocked.Tap on TOL icon to initiate a Request.';
    } else if (momMessage == 'tokenoflove_gift' &&
        GlobalData.myProfile.id == chats.partnerId) {
      displayMessage +=
          'Yay! ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} has sent you a surprise on your address in form of a Token of Love';
    } else if (momMessage == 'unblock' &&
        GlobalData.myProfile.id != chats.partnerId) {
      displayMessage +=
          'You have unblocked ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}\'s profile';
    } else if (momMessage == 'tokenoflove_gift' &&
        GlobalData.myProfile.id != chats.partnerId) {
      displayMessage +=
          'You have sent the Token of Love gift to ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}';
    }
    //return displayMessage + '\n' + getTime(chats.createdAt, true);
    return displayMessage + '\n' + formatted;
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      GlobalData.chatBloc.add(GetChat(
          GlobalData.chatResponse?.partner?.membershipCode ??
              widget.membershipCode));
    }
  }
}
