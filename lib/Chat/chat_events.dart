import 'package:coupled/Chat/ChatBloc/chat_bloc.dart';
import 'package:coupled/Chat/Model/ChatModel.dart';
import 'package:coupled/Chat/Model/EventModel.dart';
import 'package:coupled/Utils/chat_bubble.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatEvents extends StatefulWidget {
  final String memcode;
  final ChatResponse chatResponse;

  const ChatEvents(
      {Key? key, required this.memcode, required this.chatResponse})
      : super(key: key);

  @override
  _ChatEventsState createState() => _ChatEventsState();
}

class _ChatEventsState extends State<ChatEvents> {
  // ChatEvent _chatEvent = ChatEvent.init();
  double _defaultPadding = 10.0;
  ChatBloc chatBloc = ChatBloc();

  Widget chatBubbly(
      {required Alignment alignment, required Response chatEventModel}) {
    var a = chatEventModel.userId;
    var b = GlobalData.myProfile.id;
    print("bbb----");
    print(a);
    print(b);
    return Align(
      alignment: alignment,
      child: alignment == Alignment.topCenter
          ? TextView(
              getTime(chatEventModel.createdAt),
              size: 15.0,
              textAlign: TextAlign.center,
              color: CoupledTheme().primaryPink,
              fontWeight: FontWeight.normal,
              maxLines: 60,
              overflow: TextOverflow.ellipsis,
              decoration: TextDecoration.none,
              textScaleFactor: .8,
            )
          : Container(
              margin: alignment == Alignment.topLeft
                  ? EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 4)
                  : EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 4),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: CustomPaint(
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
                                ? 25
                                : _defaultPadding,
                            top: _defaultPadding,
                            bottom: _defaultPadding),
                        child: Stack(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                TextView(
                                  chatEventModel.historyText,
                                  lineSpacing: 1,
                                  size: 15.0,
                                  fontWeight: FontWeight.normal,
                                  maxLines: 60,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  textScaleFactor: .8,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                /* TextView(
                                  getTime(chatEventModel?.createdAt),
                                  size: 15.0,
                                  textAlign: TextAlign.end,
                                ),*/
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    DateFormat.jm().format(
                                        chatEventModel.createdAt.add(Duration(
                                                hours: 5, minutes: 30)) ??
                                            DateTime.now()),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void initState() {
    //_list = _chatEvent.generateChatEvents();

    chatBloc = BlocProvider.of<ChatBloc>(context);

    chatBloc.add(GetEvents(widget.memcode));

    super.initState();
  }

  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder(
          bloc: chatBloc,
          builder: (context, snapshot) {
            if (snapshot is ChatEventLoaded) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  alignment: Alignment(0, -1),
                  children: <Widget>[
                    SingleChildScrollView(
                      reverse: true,
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 10.0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.eventModel.response.length,
                        itemBuilder: (context, index) {
                          if (index + 1 !=
                                  snapshot.eventModel.response.length &&
                              snapshot.eventModel.response[index].id == 1) {
                            count++;
                            if (snapshot.eventModel.response[index + 1].id ==
                                0) {
                              count = 0;
                            }
                          } else if (index + 1 !=
                                  snapshot.eventModel.response.length &&
                              snapshot.eventModel.response[index].id == 0) {
                            count++;
                            if (snapshot.eventModel.response[index + 1].id ==
                                1) {
                              count = 0;
                            }
                          }
                          return Column(
                            children: <Widget>[
                              /*Align(
                                alignment: Alignment.topCenter,
                                child: TextView(
                                  formatDate(
                                      snapshot
                                          .eventModel.response[index].updatedAt,
                                      [dd, '.', mm, '.', yy]).toString(),
                                  textAlign: TextAlign.center,
                                  color: CoupledTheme().primaryPink,
                                ),
                              ),*/
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat(DateFormat.YEAR_MONTH_DAY)
                                        .format(snapshot.eventModel
                                            .response[index].createdAt),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: CoupledTheme().primaryPink,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 0.0,
                                    bottom: 20.0),
                                child: chatBubbly(
                                    alignment: snapshot.eventModel
                                                .response[index].userId ==
                                            GlobalData.myProfile.id
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    chatEventModel:
                                        snapshot.eventModel.response[index]),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot is ChatError) {
              return Container(
                child: Center(
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
                ),
              );
            }

            return GlobalWidgets().showCircleProgress();
          }),
    );
  }

  String getTime(DateTime createdAt) {
    if (createdAt is DateTime) {
      int difference = ((DateTime.now().difference(createdAt).inDays)).round();
//      if (difference < 1) {
//        return formatDate(createdAt, [hh, ':', nn, ' ', am,]).toString();
//      }
      if (difference < 1) {
        return DateFormat.jm()
            .format(createdAt.add(Duration(hours: 5, minutes: 30)))
            .toString();
      }
//      } else if (difference < 2) {
//        return timeago.format(createdAt).toString();
//      }
      else if (difference < 2) {
        return DateFormat.jm().format(createdAt).toString();
      } else {
        return formatDate(createdAt, [dd, '.', mm, '.', yy]).toString();
      }
    } else {
      return "Unknown time";
    }
  }
}
