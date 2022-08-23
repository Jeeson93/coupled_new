import 'package:coupled/Home/MatchBoard/MatchBoardView.dart';
import 'package:coupled/Home/MatchBoard/bloc/match_board_bloc.dart';
import 'package:coupled/Home/Search/bloc/search_bloc.dart';
import 'package:coupled/Home/Search/searchProfile.dart';
import 'package:coupled/Home/navigation_drawer.dart';

import 'package:coupled/REST/RestAPI.dart';

import 'package:coupled/Utils/badge.dart';
import 'package:coupled/Utils/custom_tool_tip.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/shifting_tab.dart';
//import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'bloc/bloc.dart';

class MatchBoard extends StatefulWidget {
  final int index;

  const MatchBoard({Key? key, this.index = 0}) : super(key: key);

  @override
  _MatchBoardState createState() => _MatchBoardState();
}

class _MatchBoardState extends State<MatchBoard> with TickerProviderStateMixin {
  //Animation.................................../////////////////////////
  late TabController _shiftingTabController;
  Curve scaleDownCurve = Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
  final GlobalKey toolKey2 = GlobalKey();
  int momNotifications = 0, coupledNotifications = 0;
  final notifications = FlutterLocalNotificationsPlugin();
  //(1)//SearchBloc.............................../////////////////////
  SearchBloc searchBloc = SearchBloc();
  //.......................................
  List params = ['general', 'coupling', 'mix', 'latest'];
  MatchBoardBloc matchBoardBloc = MatchBoardBloc();
  // ProfileResponse profileResponse =
  //     ProfileResponse(usersBasicDetails: UsersBasicDetails());
  // double height = 0.0;
  var _milliseconds = 350;
  double xAxis = 0;
  late AnimationController _animationController;
  final Widget _appBarTitle = Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      GestureDetector(
        child: Image.asset(
          "assets/logo/mini_logo_pink.png",
          height: 30.0,
          width: 30.0,
        ),
      ),
      const SizedBox(
        width: 10.0,
      ),
      TextView(
        "Matchboard",
        size: 20.0,
        color: Colors.white,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
        textScaleFactor: .8,
      )
    ],
  );

  var filteredList = [];

  List userShortInfoModelList = [];

  // Future onSelectNotification(String payload) async => await Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => Notifications()),
  //     );

  @override
  void didChangeDependencies() {
    searchBloc = SearchBloc();
    MatchBoardBloc matchBoardBloc = BlocProvider.of<MatchBoardBloc>(context);
    super.didChangeDependencies();
  }

//Init...............................................///////////////////////
  @override
  void initState() {
    /////load initial home......................////////////////////
    matchBoardBloc = BlocProvider.of<MatchBoardBloc>(context);
    print('usershotlist..........$userShortInfoModelList');
    userShortInfoModelList.isEmpty
        ? matchBoardBloc.add(LoadMatchData(params[0]))
        : userShortInfoModelList;
    ///////AnimationLoad.....................///////////////////////
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: _milliseconds),
        reverseDuration: Duration(milliseconds: _milliseconds));
    _shiftingTabController = TabController(length: 4, vsync: this);
    ////Local Notification........................../////////////////
    final initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    // final initializationSettingsIOS = IOSInitializationSettings(
    //     onDidReceiveLocalNotification: (id, title, body, payload) =>
    //         onSelectNotification(payload));

    // notifications.initialize(
    //     InitializationSettings(
    //       android: initializationSettingsAndroid,
    //       iOS: initializationSettingsIOS,
    //     ),
    //     onSelectNotification: onSelectNotification);

    // Repository().getNotifications(path: 'count').then((onValue) {
    //   //  print('onValue-------------------------');
    //   //  print(onValue);
    //   setState(() {
    //     momNotifications = onValue.response.momCount;
    //     coupledNotifications = onValue.response.couplingCount;
    //   });
    // });
//TbbarAnimation..........................................
    _shiftingTabController.animateTo(widget.index);
    _shiftingTabController.addListener(() {
      if (_shiftingTabController.indexIsChanging) {
        matchBoardBloc.add(LoadMatchData(params[_shiftingTabController.index]));
      }
    });

    super.initState();
  }

//Dispose/////////////////////////////////
  @override
  void dispose() {
    //searchBloc?.close();
    super.dispose();
  }

  ////AppBar Widget........///////////////.............................................////////////
  Widget _buildBar(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CoupledTheme().backgroundColor,
        actions: <Widget>[
          Builder(
            builder: (builder) => GestureDetector(
                onTap: () async {
                  dynamic result = await showSearch(
                      context: context,
                      delegate: SearchAction(
                          searchFieldLabel: "Search by id or name",
                          searchBloc: searchBloc));
                  //   //                    TheSearch(),
                  // );
                  if (result != null) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: TextView(
                      result.toString(),
                      color: Colors.red,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      size: 12,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    )));
                  }
                },
                /*this._switchImgPath == "assets/MatchBoard/Search.png" ? _searchPressed() : _filter.clear(),*/
                child: GlobalWidgets().iconCreator(
                    "assets/MatchBoard/Search.png",
                    size: FixedIconSize.SMALL)),
          ),
          SizedBox(
            width: 15,
          ),
          Row(
            children: [
              CustomTooltip(
                key: toolKey2,
                height: 45,
                showDuration: Duration(milliseconds: 5000),
                preferBelow: true,
                margin: EdgeInsets.only(bottom: 0.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white.withOpacity(1)),
                tooltipWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GlobalWidgets().iconCreator(
                        "assets/logo/mini_logo_pink.png",
                        size: FixedIconSize.MEDIUM),
                    TextView(
                      coupledNotifications.toString(),
                      color: Colors.red,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      size: 12,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GlobalWidgets().iconCreator(
                        "assets/MatchBoard/MatchOMeter.png",
                        size: FixedIconSize.MEDIUM),
                    TextView(
                      momNotifications.toString(),
                      color: Colors.red,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      size: 12,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    //                   Navigator.push(context, MaterialPageRoute(builder: (context) => TOLHome()));

                    Navigator.pushNamed(context, '/notification');
                  },
                  child: Badge(
                    badgeContent: TextView(
                      '',
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      size: 12,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                      color: Colors.white,
                    ),
                    child: GlobalWidgets().iconCreator(
                        "assets/MatchBoard/Notification.png",
                        color: Colors.white,
                        size: FixedIconSize.MEDIUM),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          /*  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_animationController.isDismissed) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
                    print(
                        "Height : ${MediaQuery.of(context).size.height}  Width : $xAxis ");
                  });
                },
                // child: Icon(Icons.person)
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(APis()
                      .imageApi(GlobalData.myProfile?.dp?.photoName ?? '')),
                )),
          ),*/
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_animationController.isDismissed) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
                    print(
                        "Height : ${MediaQuery.of(context).size.height}  Width : $xAxis ");
                  });
                },
                // child: Icon(Icons.person)
                child: _animationController.isDismissed
                    ? CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(APis().imageApi(
                            GlobalData.myProfile.dp!.photoName ?? '')))
                    : Container(
                        child: Transform.scale(
                          scale: 1.2,
                          child: BlinkWidget(
                            children: <Widget>[
                              Icon(
                                Icons.arrow_forward,
                                color: CoupledTheme().primaryBlue,
                              ),
                              Icon(
                                Icons.arrow_back,
                                color: CoupledTheme().primaryBlue,
                              ),
                            ],
                            interval: 1000,
                          ),
                        ),
                      )),
          ),
        ],
        elevation: 3,
        title: _appBarTitle);
  }

//TbbarWidget........................................./////////////////////
  Widget tabBar() => ShiftingTabBar(
        forceUpperCase: false,
        scrollable: false,
        labelFlex: 8,
        controller: _shiftingTabController,
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        color: CoupledTheme().backgroundColor,
        tabs: <ShiftingTab>[
          ShiftingTab(
              iconpath: "assets/MatchMeter/Views.png", text: "General Matches"),
          ShiftingTab(
              iconpath: "assets/MatchBoard/Coupling-Matches.png",
              text: "Coupling Matches"),
          ShiftingTab(
              iconpath: "assets/MatchBoard/Mix-Matches.png",
              text: "Mix Matches"),
          ShiftingTab(
              iconpath: "assets/MatchBoard/Latest-Profile.png",
              text: "Latest Profiles"),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: CoupledTheme().backgroundColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            EndDrawer(
              onTap: () async {
                if (_animationController.isDismissed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                print(
                    "Height : ${MediaQuery.of(context).size.height}  Width : $xAxis ");
                return _animationController.isDismissed;
              },
            ),
            AnimatedBuilder(
                animation: _animationController,
                builder: (context, _) {
                  xAxis = -(MediaQuery.of(context).size.width - 180);
                  double slide = xAxis * _animationController.value;
                  double scale = 1 - (_animationController.value * .1);
                  return Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: Material(
                      color: CoupledTheme().backgroundColor,
                      elevation: _animationController.value * 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              _animationController.value * 15)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                              height: kToolbarHeight,
                              child: _buildBar(context)),
                          //Column(1)//Tabbar and goto matchmaker....................................../////////
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      height: kToolbarHeight,
                                      child: tabBar())),
                              GestureDetector(
                                onTap: () {
                                  print("matchMaker");
                                  Navigator.of(context)
                                      .pushNamed("/matchMaker");
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black45,
                                            blurRadius: 2.0,
                                            spreadRadius: .5,
                                            offset: Offset(-1.0, 3.0))
                                      ],
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20.0))),
                                  child: GlobalWidgets().iconCreator(
                                      "assets/MatchBoard/Match-Maker.png",
                                      size: FixedIconSize.LARGE_30),
                                ),
                              )
                            ],
                          ),
                          //Column(2)//MatchBordBody....................................../////////
                          Flexible(
                            child: BlocBuilder(
                              bloc: matchBoardBloc,
                              builder: (context, MatchBoardState state) {
                                print('state-------------$state');
                                if (state is LoadedMatchData) {
                                  print(
                                      'state1-------------${state.userShortInfoModel[0]}');

                                  userShortInfoModelList =
                                      state.userShortInfoModel;

                                  return TabBarView(
                                    physics: NeverScrollableScrollPhysics(),
                                    controller: _shiftingTabController,
                                    children: List.generate(
                                      4,
                                      (index) => MatchBoardView(
                                          //   profileResponse: profileResponse,
                                          userShortInfoModelList:
                                              userShortInfoModelList,
                                          index: _shiftingTabController.index),
                                    ),
                                  );
                                }
                                if (state is MatchBoardError) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/logo/mini_logo_blue.png",
                                          width: 200,
                                          colorBlendMode: BlendMode.modulate,
                                          color: Colors.white10,
                                        ),
                                        TextView(
                                          "Sorry!",
                                          size: 18,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 5),
                                          child: TextView(
                                            "We know you are very particular about your Life-partner and we are looking for profiles matching your preferences. You may also review your Partner Preferences (Inside Match Maker) to help us widen our search base. See you around after some time!",
                                            color: Colors.red,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.visible,
                                            size: 12.0,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            maxLines: 6,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return state is LoadedMatchData
                                    ? GlobalWidgets().showCircleProgress()
                                    : Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/logo/mini_logo_blue.png",
                                          width: 200,
                                          colorBlendMode: BlendMode.modulate,
                                          color: Colors.white10,
                                        ),
                                        TextView(
                                          "Sorry!",
                                          size: 18,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 5),
                                          child: TextView(
                                            "We know you are very particular about your Life-partner and we are looking for profiles matching your preferences. You may also review your Partner Preferences (Inside Match Maker) to help us widen our search base. See you around after some time!",
                                            color: Colors.red,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.visible,
                                            size: 12.0,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            maxLines: 6,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class BlinkWidget extends StatefulWidget {
  final List<Widget> children;
  final int interval;

  BlinkWidget({required this.children, this.interval = 500, Key? key})
      : super(key: key);

  @override
  _BlinkWidgetState createState() => _BlinkWidgetState();
}

class _BlinkWidgetState extends State<BlinkWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentWidget = 0;

  initState() {
    super.initState();

    _controller = new AnimationController(
        duration: Duration(milliseconds: widget.interval), vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (++_currentWidget == widget.children.length) {
            _currentWidget = 0;
          }
        });

        _controller.forward(from: 0.0);
      }
    });

    _controller.forward();
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.children[_currentWidget],
    );
  }
}
