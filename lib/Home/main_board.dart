import 'package:coupled/Chat/chat_list_0.dart';
import 'package:coupled/Home/MatchBoard/MatchBoard.dart';
import 'package:coupled/MatchMeter/view/mom_page.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:laravel_echo2/laravel_echo2.dart';

class MainBoard extends StatefulWidget {
  @override
  _MainBoardScreenState createState() => _MainBoardScreenState();
}

class _MainBoardScreenState extends State<MainBoard>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Echo echo = Echo({});
  bool isConnected = false;
  final pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: .95);
  var height = 150;
  int _currentIndex = 1;

  // ChatModel chatModel = ChatModel();

  @override
  void initState() {
    //OnlineUsers().getOnlineUsers();
    print('.....................................');
    Repository().getMatchBoardList(path: 'mix', params: {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static List<Widget> _widgetOptions = <Widget>[
    Container(),
    Container(),
    Container()
  ];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: CoupledTheme().backgroundColor,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: _currentIndex == 0
                  ? GlobalWidgets().iconCreator(
                      "assets/MatchBoard/Conversation_fIlled.png",
                      size: FixedIconSize.MEDIUM)
                  : GlobalWidgets().iconCreator(
                      "assets/MatchBoard/Conversations.png",
                      size: FixedIconSize.MEDIUM),
              label: 'Conversations',
              /*  title: TextView(
                'Conversations',
                size: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),*/
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 1
                  ? GlobalWidgets().iconCreator(
                      "assets/MatchBoard/MatchBoardFilled.png",
                      size: FixedIconSize.MEDIUM)
                  : GlobalWidgets().iconCreator(
                      "assets/MatchBoard/MatchBoard.png",
                      size: FixedIconSize.MEDIUM),
              label: 'Matchboard',
              /*  title: TextView(
                'Matchboard',
                size: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),*/
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 2
                  ? GlobalWidgets().iconCreator(
                      "assets/MatchBoard/MOMFilled.png",
                      size: FixedIconSize.MEDIUM)
                  : GlobalWidgets().iconCreator(
                      "assets/MatchBoard/MatchOMeter.png",
                      size: FixedIconSize.MEDIUM),
              label: 'Match O\' Meter',
              /* title: TextView(
                "Match O' Meter",
                size: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),*/
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: IndexedStack(index: _currentIndex, children: <Widget>[
                ChatList(),
                MatchBoard(),
                MoMPage(),
              ]),
            ),
          ],
        ),
      ),
      // _widgetOptions.elementAt(_currentIndex),
      onWillPop: () {
        return Dialogs().showDialogExitApp(context);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
