import 'package:coupled/Chat/ChatBloc/chat_bloc.dart';
import 'package:coupled/Chat/Model/ChatModel.dart';
import 'package:coupled/Chat/Model/online_users.dart';
import 'package:coupled/Chat/chat_main_view_1.dart';
import 'package:coupled/Home/Profile/othersProfile/bloc/others_profile_bloc.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/match_o_meter_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  String _switchImgPath = "assets/MatchBoard/Search.png";
  TextEditingController _filter = TextEditingController();
  String token = '';
  OnlineChatList chatList = OnlineChatList();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

//  Echo _echo;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // List<ChatResponse> _chatList = List();
  ChatModel chatModel = ChatModel();

//	MomBloc _momBloc;
  Future<List<dynamic>> nameList() async {
    List<dynamic> name = await RestAPI()
        .get("https://uinames.com/api/?gender=female&amount=500");
    name.forEach((data) {
      print("name : ${data["name"]}");
    });
    return name;
  }

  Widget _appBarTitle = Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        "assets/logo/mini_logo_pink.png",
        height: 30.0,
        width: 30.0,
      ),
      SizedBox(
        width: 10.0,
      ),
      TextView(
        "Conversation",
        size: 20.0,
        fontWeight: FontWeight.normal,
        maxLines: 60,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        color: Colors.white,
        decoration: TextDecoration.none,
        textScaleFactor: .8,
      )
    ],
  );

  void _searchPressed() {
    setState(() {
      if (this._switchImgPath == "assets/MatchBoard/Search.png") {
        this._switchImgPath = "assets/MatchBoard/Next.png";
        // nameList();

        this._appBarTitle = Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                GlobalData.chatBloc.add(GetChatList());
                _searchPressed();
              },
              child: Icon(
                Icons.keyboard_backspace,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Flexible(
              flex: 1,
              child: EditText(
                controller: _filter,
                textAlign: TextAlign.start,
                hint: 'Search',
                border: false,
                obscureText: false,
              ),
            )
          ],
        );
      } else {
        this._switchImgPath = "assets/MatchBoard/Search.png";
        this._appBarTitle = Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/logo/mini_logo_pink.png",
              height: 30.0,
              width: 30.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            TextView(
              "Matchboard",
              size: 20.0,
              fontWeight: FontWeight.normal,
              maxLines: 60,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              color: Colors.white,
              decoration: TextDecoration.none,
              textScaleFactor: .8,
            )
          ],
        );
//        _filter.clear();
      }
    });
  }

  _buildBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: CoupledTheme().backgroundColor,
      elevation: 3,
      title: _appBarTitle,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
              onTap: () => this._switchImgPath == "assets/MatchBoard/Search.png"
                  ? _searchPressed()
                  : this._switchImgPath == "assets/MatchBoard/Next.png"
                      ? GlobalData.chatBloc.add(GetChatSearchList(_filter.text))
                      : _filter.clear(),
              child: GlobalWidgets()
                  .iconCreator(_switchImgPath, size: FixedIconSize.MEDIUM)),
        ),
      ],
      bottom: TabBar(
          unselectedLabelColor: CoupledTheme().thirdSelectionColor,
          labelColor: CoupledTheme().primaryBlue,
          indicatorColor: CoupledTheme().primaryBlue,
          tabs: [
            Tab(
              text: "Connected",
            ),
            Tab(
              text: "Online",
            )
          ]),
    );
  }

  List<Widget> onlineWidget(OnlineChatList list) {
    return List<Widget>.generate(list.data.length, (index) {
      print('jin');
      print(chatList.data[index].memCode);
      return Column(
        children: <Widget>[
          BlocBuilder(
              bloc: GlobalData.chatBloc,
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    if (state is LoadedOthersProfile) {
                      print('---------paidMember');
                      GlobalData.messageModel.response != null
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatViewMain(
                                        chatResponse: ChatResponse(
                                            mom: MomM(),
                                            partner: PartnerDetails(
                                                dp: Dp(
                                                    photoName: '',
                                                    imageType: BaseSettings(
                                                        options: []),
                                                    imageTaken: BaseSettings(
                                                        options: []),
                                                    userDetail: UserDetail(
                                                        membership: Membership(
                                                            paidMember:
                                                                false))),
                                                info: Info(
                                                    maritalStatus: BaseSettings(
                                                        options: [])),
                                                photos: [])),
                                      )))
                          : GlobalWidgets().showToast(msg: 'Loading..');
                    }
                  },
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(
                            "https://picsum.photos/id/1011/250/250"),
                      ),
                      Positioned(
                          right: 5.0,
                          bottom: 5.0,
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50.0)),
                          )),
                    ],
                  ),
                );
              }),
          SizedBox(
            height: 5.0,
          ),
          TextView(
            chatList.data[index].name.toString() ?? "0",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            size: 16.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            decoration: TextDecoration.none,
            textScaleFactor: .8,
          ),
          SizedBox(
            height: 15.0,
          )
        ],
      );
    });
  }

  Widget listItemWidget(ChatResponse? chatResponse) {
    print(GlobalData.onlineUsersMemCode
        .contains(chatResponse?.partner?.membershipCode));
    print(chatResponse?.partner?.membershipCode);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Table(
        columnWidths: {
          0: FractionColumnWidth(.20),
          1: FractionColumnWidth(.60),
          2: FractionColumnWidth(.20)
        },
        children: [
          TableRow(
            children: [
              TableCell(
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 35.0,
                      backgroundColor: Colors.white,
                      backgroundImage: chatResponse?.partner?.dp?.photoName !=
                              null
                          ? NetworkImage(
                              APis().imageApi(
                                chatResponse?.partner?.dp?.photoName,
                                imageConversion: ImageConversion.MEDIA,
                                //imageSize: 100,
                              ),
                            ) as ImageProvider<Object>
                          : AssetImage("assets/logo/mini_logo_pink_pad.png"),
                    ),
                    Visibility(
                      visible: GlobalData.onlineUsersMemCode
                          .contains(chatResponse?.partner?.membershipCode),
                      child: Positioned(
                        right: 5.0,
                        bottom: 5.0,
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: TableRowInkWell(
                  onTap: () {
                    print("taps");
                    print(chatResponse);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatViewMain(
                                memberShipCode:
                                    (chatResponse?.partner?.membershipCode)
                                        .toString(),
                                chatResponse: chatResponse)));
                  },
                  onHighlightChanged: (va) => true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            TextView(
                              chatResponse?.partner?.name ?? "",
                              size: 16.0,
                              fontWeight: FontWeight.normal,
                              maxLines: 60,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              textScaleFactor: .8,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Visibility(
                              visible:
                                  chatResponse?.mom?.momStatus == 'accept' &&
                                      chatResponse?.mom?.momType == 'connect',
                              child: GlobalWidgets().iconCreator(
                                  "assets/Profile/Connected.png",
                                  size: FixedIconSize.SMALL),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Visibility(
                                visible: chatResponse?.userId !=
                                        chatResponse?.partner?.id ??
                                    GlobalData.othersProfile.id != null,
                                child: chatResponse?.read == 1
                                    ? Icon(
                                        Icons.done_all,
                                        size: 15.0,
                                        color: Colors.blue,
                                      )
                                    : Container()),
                            SizedBox(
                              width: 5.0,
                            ),
                            getconditionstickers(chatResponse!)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: TableRowInkWell(
                  onTap: () {
                    setState(() {
                      chatResponse.readCount = 0;
                    });

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChatViewMain(chatResponse: chatResponse)));
                  },
                  child: Column(
                    children: <Widget>[
                      chatResponse.createdAt == null
                          ? Container()
                          : TextView(
                              getTime(chatResponse.createdAt),
                              size: 12.0,
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
                      chatResponse.readCount == 0
                          ? Container()
                          : Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: CoupledTheme().primaryBlue),
                              child: TextView(
                                chatResponse.readCount.toString() ?? "",
                                size: 12,
                                fontWeight: FontWeight.normal,
                                maxLines: 60,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                textScaleFactor: .8,
                              ),
                            ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String getTime(DateTime createdAt) {
    int difference = ((DateTime.now().difference(createdAt).inDays)).round();
    if (difference < 1) {
      return formatDate(createdAt, [hh, ':', nn, ' ', am]).toString();
    } else if (difference < 2) {
      return timeago.format(createdAt).toString();
    } else {
      return formatDate(createdAt, [dd, '.', mm, '.', yy]).toString();
    }
  }

  ChatBloc chatbloc = ChatBloc();
  @override
  void didChangeDependencies() {
//   _echo = MoMBlocProvider.of(context).echo;
//   _momBloc = MoMBlocProvider.of(context).momBloc;
//   MoMBlocProvider.of(context).momBloc.joinCoupled(_echo);
//    GlobalData.chatBloc  = ChatProvider.of(context).chatBloc;

    GlobalData.chatBloc = ChatBloc();

    GlobalData.chatBloc.add(GetChatList());
//    GlobalData.chatBloc .add(GetOnlineUsers());
    //   chatModel = ChatProvider.of(context).chatModel;

    print('----34---$chatModel');

    super.didChangeDependencies();
  }

  @override
  void setState(fn) {
    chatList = GlobalData.onlineUsersList;
    super.setState(fn);
  }

  @override
  void initState() {
    chatList = GlobalData.onlineUsersList;
    chatbloc = ChatBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        key: _scaffoldKey,
        appBar: _buildBar(context),
        body: SafeArea(
          top: true,
          child: BlocListener<ChatBloc, ChatBlocState>(
            bloc: GlobalData.chatBloc,
            listener: (context, state) {
              print("state---list$state");
              if (state is ChatError) {
                print(state.error);
                GlobalWidgets().showSnackBar(_scaffoldKey, state.error);
              }
              if (state is ChatLoaded) {
                setState(() {
                  chatModel = state.chatModel;
                  print("ChatList :: $chatModel");
                });
              }
            },
            child: TabBarView(
              children: <Widget>[
                BlocBuilder<ChatBloc, ChatBlocState>(
                    buildWhen: (prevState, currState) =>
                        currState.runtimeType != prevState.runtimeType,
                    bloc: GlobalData.chatBloc,
                    builder: (context, state) {
                      if (state is InitialChatBlocState) {
                        return GlobalWidgets().showCircleProgress();
                      }

                      return RefreshIndicator(
                        onRefresh: refresh,
                        key: refreshKey,
                        child: ListView.separated(
                          itemCount: chatModel.response?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return listItemWidget(chatModel.response?[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: Colors.grey,
                              height: 1.0,
                            );
                          },
                        ),
                      );
                    }),
                BlocBuilder(
                    bloc: GlobalData.chatBloc,
                    builder: (context, snapshot) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        padding: EdgeInsets.only(top: 20),
                        itemCount: chatList.data.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return onlineWidget(chatList)[index];
                        },
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refresh() async {
    GlobalData.chatBloc.add(GetChatList());

    return Future.value();
  }

  getconditionstickers(ChatResponse chatResponse) {
    if (chatResponse.message != '' && chatResponse.message.contains(".png")) {
      return TextView(
        "Stickers",
        size: 12,
        fontWeight: FontWeight.normal,
        maxLines: 60,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        color: Colors.white,
        decoration: TextDecoration.none,
        textScaleFactor: .8,
      );
    } else if (chatResponse.message.toString() == "tokenoflove_reject") {
      return TextView(
        "Token of love reject message",
        size: 11.0,
        fontWeight: FontWeight.normal,
        maxLines: 60,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        color: Colors.white,
        decoration: TextDecoration.none,
        textScaleFactor: .8,
      );
    } else if (chatResponse.message.toString() == "tokenoflove") {
      return TextView(
        "Token of love message",
        size: 11.0,
        fontWeight: FontWeight.normal,
        maxLines: 60,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        color: Colors.white,
        decoration: TextDecoration.none,
        textScaleFactor: .8,
      );
    } else if (chatResponse.message.toString() == "tokenoflove_request") {
      return TextView(
        "Token of love request message",
        size: 11.0,
        fontWeight: FontWeight.normal,
        maxLines: 60,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        color: Colors.white,
        decoration: TextDecoration.none,
        textScaleFactor: .8,
      );
    } else if (chatResponse.message.toString() == "tokenoflove_accept") {
      return TextView(
        "Token of love accept message",
        size: 11.0,
        fontWeight: FontWeight.normal,
        maxLines: 60,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        color: Colors.white,
        decoration: TextDecoration.none,
        textScaleFactor: .8,
      );
    } else if (chatResponse.message.toString() == "tokenoflove_unlock") {
      return TextView(
        "Token of love unlock message",
        size: 11.0,
        fontWeight: FontWeight.normal,
        maxLines: 60,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        color: Colors.white,
        decoration: TextDecoration.none,
        textScaleFactor: .8,
      );
    } else if (chatResponse.message != ".png") {
      return TextView(
        chatResponse.message.length > 35
            ? chatResponse.message.substring(0, 28)
            : chatResponse.message,
        size: 12,
        fontWeight: FontWeight.normal,
        maxLines: 60,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        color: Colors.white,
        decoration: TextDecoration.none,
        textScaleFactor: .8,
      );
    } else {
      TextView(
        'Hello! XXXXXXXXXXX To view the message and respond with a personal note, please become a member with coupled',
        size: 12,
        fontWeight: FontWeight.normal,
        maxLines: 60,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        color: Colors.white,
        decoration: TextDecoration.none,
        textScaleFactor: .8,
      );
    }
  }
}
