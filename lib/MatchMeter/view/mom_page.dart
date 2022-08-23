import 'package:coupled/MatchMeter/bloc/mom_bloc.dart';
import 'package:coupled/MatchMeter/view/mom_card.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/page_with_tabs.dart';
import 'package:coupled/Utils/shifting_tab.dart';

import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/match_o_meter_model.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mom_card.dart';

class MoMPage extends StatefulWidget {
  @override
  MoMPageState createState() => MoMPageState();
}

class MoMPageState extends State<MoMPage> with TickerProviderStateMixin {
  TabController? _mainTabController,
      _shortlistTabController,
      _acceptedTabController,
      _rejectTabController,
      _viewMoreTabController,
      _blockedTabController;
  List type = [0, 0];
  final _scrollController = ScrollController();
  final _scrollThreshold = 100.0;
  List<Widget> widgetList = [];
  MatchOMeterModel matchMeterModel = MatchOMeterModel();

  ///type array
  static List<List> typeList = [
    [
      "sent",
      "receive",
      "accept_me",
      "shortlist_me",
      "reject_me",
      "view_me",
      "block"
    ],
    ["accept_me", "accept_partner"], //accept
    ["shortlist_me", "shortlist_partner"], //shortlist
    ["reject_me", "reject_partner"], //rejected
    ["view_me", "view_partner"], //views
    ["block", "report"], //more
  ];

  ///card array
  List<List<Pager>> pagerList = [
    [
      Pager.SENT,
      Pager.RECEIVED,
      Pager.ACCEPTED,
      Pager.SHORTLISTED,
      Pager.REJECTED,
      Pager.VIEWS,
      Pager.BLOCKED
    ],
    [Pager.ACCEPTED, Pager.ACCEPTED],
    [Pager.SHORTLISTED, Pager.SHORTLISTED_BY_HER],
    [Pager.REJECTED, Pager.REJECTED_BY_HER],
    [Pager.VIEWS, Pager.VIEWS],
    [Pager.BLOCKED, Pager.REPORT],
  ];

  Widget tabBar() => ShiftingTabBar(
        scrollable: true,
        forceUpperCase: false,
        controller: _mainTabController,
        labelFlex: 6,
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        color: CoupledTheme().backgroundColor,
//        labelFlex: .2,
        tabs: [
          ShiftingTab(
            iconpath: "assets/MatchMeter/Sent.png",
            text: "Sent",
          ),
          ShiftingTab(
            iconpath: "assets/MatchMeter/Received.png",
            text: "Received",
          ),
          ShiftingTab(
              iconpath: "assets/MatchMeter/Accepted.png", text: "Accepted"),
          ShiftingTab(
              iconpath: "assets/MatchMeter/Shortlisted.png",
              text: "Shorlisted"),
          ShiftingTab(
              iconpath: "assets/MatchMeter/Rejected.png", text: "Rejected"),
          ShiftingTab(iconpath: "assets/MatchMeter/Views.png", text: "Views"),
          ShiftingTab(iconpath: "assets/MatchMeter/More.png", text: "More"),
        ],
      );

  @override
  void didChangeDependencies() async {
    //...(MainController)
    _mainTabController = TabController(
      length: 7,
      vsync: this,
    );
    _acceptedTabController = TabController(length: 2, vsync: this);
    _shortlistTabController = TabController(
      length: 2,
      vsync: this,
    );
    _rejectTabController = TabController(length: 2, vsync: this);
    _viewMoreTabController = TabController(length: 2, vsync: this);
    _blockedTabController = TabController(length: 2, vsync: this);

     loadMomData(index0, index1) {
      pageNumber = 1;
      // test.clear();
      print('loadtest....');
      print('$index0,$index1');
      print(typeList[index0][index1]);
      type[0] = index0;
      type[1] = index1;
      GlobalData.momBloc.add(LoadMomData(typeList[index0][index1], 1));
    }

    ///main tab controller
    _mainTabController!.addListener(() {
      //....
     
      _acceptedTabController!.animateTo(0);
      //....
      _shortlistTabController!.animateTo(0);
      //....
      _rejectTabController!.animateTo(0);
      //....
      _viewMoreTabController!.animateTo(0);
      //...
      _blockedTabController!.animateTo(0);
    });
    _mainTabController!.addListener(() {
      if (_mainTabController!.indexIsChanging==true) {
        loadMomData(0, _mainTabController?.index);
      }
      _acceptedTabController!.addListener(() {
        if (_acceptedTabController!.index == 0) {
          loadMomData(1, 0);
        } else if (_acceptedTabController!.index == 1) {
          loadMomData(1, 1);
        }
      });
      _shortlistTabController!.addListener(() {
        if (_shortlistTabController!.index == 0) {
          loadMomData(2, 0);
        } else if (_shortlistTabController!.index == 1) {
          loadMomData(2, 1);
        }
      });
      _rejectTabController!.addListener(() {
        if (_rejectTabController!.index == 0) {
          loadMomData(3, 0);
        } else if (_rejectTabController!.index == 1) {
          loadMomData(3, 1);
        }
      });
      _viewMoreTabController!.addListener(() {
        if (_viewMoreTabController!.index == 0) {
          //_viewMoreTabController!.animateTo(0);
          loadMomData(4, 0);
        } else if (_viewMoreTabController!.index == 1) {
          //_viewMoreTabController!.animateTo(1);
          loadMomData(4, 1);
        }
      });
      _blockedTabController!.addListener(() {
        if (_blockedTabController!.index == 0) {
          loadMomData(5, 0);
        } else if (_blockedTabController!.index == 1) {
          loadMomData(5, 1);
        }
      });
    });

    super.didChangeDependencies();
  }

  @override
  void initState() {
    GlobalData.momBloc = MomBloc();
    GlobalData.momBloc.add(LoadMomData('sent', 1));

    super.initState();
  }

  _buildBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: CoupledTheme().backgroundColor,
      elevation: 3,
      title: Row(
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
            "Match O' Meter",
            size: 20.0,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            color: Colors.white,
            decoration: TextDecoration.none,
            textScaleFactor: .8,
            fontWeight: FontWeight.normal,
          )
        ],
      ),
      actions: <Widget>[],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int pageNumber = 1;

  // void _onScroll() {
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.position.pixels;

  //   if (maxScroll - currentScroll <= _scrollThreshold) {
  //     void loadMomData(index0, index1) {
  //       pageNumber = 1;
  //       // test.clear();
  //       print('loadtest....');
  //       print('$index0,$index1');
  //       print(typeList[index0][index1]);
  //       type[0] = index0;
  //       type[1] = index1;

  //       GlobalData.momBloc.add(LoadMomData(typeList[index0][index1], 1));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      backgroundColor: CoupledTheme().backgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Flexible(flex: 2, child: Container(child: tabBar())),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: kToolbarHeight,
            child: tabBar(),
          ),
          Flexible(
            flex: 2,
            child: BlocConsumer<MomBloc, MomState>(
                bloc: GlobalData.momBloc,
                listener: (context, state) {
                  print('mom state------$state');
                  print(widgetList);

                  if (state is LoadedMomData) {
                    widgetList.clear();
                    widgetList.add(Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        GlobalWidgets().showCircleProgress()
                      ],
                    ));

                    addData(
                        matchMeterModel: state.matchOMeterModel,
                        state: 'model');
                    pageNumber++;
                  }
                  if (state is MoMErrorState) {
                    widgetList.clear();
                    widgetList.add(Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        GlobalWidgets().showCircleProgress()
                      ],
                    ));
                    addData(
                        matchMeterModel: MatchOMeterModel(),
                        state: state.errorMessage);
                    print('Error State......${state.errorMessage}');
                  }
                  if (state is InitialMomState) {
                    widgetList.clear();
                    widgetList.add(Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        GlobalWidgets().showCircleProgress()
                      ],
                    ));
                  }
                },
                buildWhen: (context, MomState state) {
                  return state is LoadMomData || state is MoMErrorState;
                },
                builder: (context, MomState state) {
                  return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _mainTabController,
                    children: <Widget>[
                      StatefulBuilder(builder: (context, snapshot) {
                        return ListView.separated(
                          shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: widgetList.length,
                          itemBuilder: (context, index) {
                            // return widgetList[index];

                            return widgetList[index];
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            print(index);
                            return Divider(
                              color: Colors.grey[300],
                              thickness: 1.0,
                              height: 3,
                            );
                          },
                        );
                      }),
                      StatefulBuilder(builder: (context, snapshot) {
                        return ListView.separated(
                          shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: widgetList.length,
                          itemBuilder: (context, index) {
                            return widgetList[index];
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: Colors.grey[300],
                              height: 1.0,
                            );
                          },
                        );
                      }),
                      PageWithTabs(
                        tabController: _acceptedTabController,
                        tabName: ["Accepted By Me", "Accepted Me"],
                        dividerVisibility: true,
                        tabData: [widgetList, widgetList],
                      ),
                      PageWithTabs(
                        tabController: _shortlistTabController,
                        tabName: ["Shortlisted By Me", "Shortlisted Me"],
                        dividerVisibility: true,
                        tabData: [widgetList, widgetList],
                      ),
                      PageWithTabs(
                        tabController: _rejectTabController,
                        tabName: ["Rejected By Me", "Rejected Me"],
                        dividerVisibility: true,
                        tabData: [widgetList, widgetList],
                      ),
                      PageWithTabs(
                        //   scrollController: _scrollController,
                        tabController: _viewMoreTabController,
                        tabName: ["Viewed By Me", "Viewed Me"],
                        dividerVisibility: true,
                        tabData: [widgetList, widgetList],
                      ),
                      PageWithTabs(
                        tabController: _blockedTabController,
                        tabName: ["Blocked", "Report"],
                        dividerVisibility: true,
                        tabData: [widgetList, widgetList],
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  addData({MatchOMeterModel? matchMeterModel, state}) {
    print('matchMeterModel------');
    print('////////////${matchMeterModel?.path}${matchMeterModel?.status}');

    if (state == '{status: error, response: {msg: No data found}, code: 404}' ||
        state ==
            'Error occured while Communication with Server with StatusCode : 500') {
      print(state);
      setState(() {
        widgetList.clear();
      });
      widgetList.add(Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
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
            state !=
                    'Error occured while Communication with Server with StatusCode : 500'
                ? TextView(
                    "no profiles found..",
                    size: 18,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.left,
                    textScaleFactor: .8,
                  )
                : state != 'No Internet connection'
                    ? TextView(
                        "Error occured while Communication with Server..",
                        size: 18,
                        color: Colors.red,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        textScaleFactor: .8,
                      )
                    : TextView(
                        "No Internet connection..",
                        size: 18,
                        color: Colors.red,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        textScaleFactor: .8,
                      ),
          ],
        ),
      ));
    }
    if (state == []) {
      setState(() {
        widgetList.clear();
      });
      widgetList.add(Center(child: GlobalWidgets().showCircleProgress()));
    }
    if (state == 'model') {
      print(
          'Type.............................................${typeList[type[0]][type[1]]}');
      print(matchMeterModel?.code);
      setState(() {
        widgetList.clear();
      });

      matchMeterModel?.response?.data
          ?.asMap()
          .forEach((int? index, MomDatum? f) {
        if (typeList[type[0]][type[1]] == 'sent' ||
            typeList[type[0]][type[1]] == 'accept_me' ||
            typeList[type[0]][type[1]] == 'shortlist_me' ||
            typeList[type[0]][type[1]] == 'reject_me' ||
            typeList[type[0]][type[1]] == 'report' ||
            typeList[type[0]][type[1]] == 'view_me') {
          widgetList.add(
            MomCard(
              index: index,
              matchMeterModel: matchMeterModel,
              param: typeList[type[0]][type[1]],

              ///true for partner data
              partner: true,

              data: f,
              page: pagerList[type[0]][type[1]],
            ),
          );
        } else if (typeList[type[0]][type[1]] == 'receive' ||
            typeList[type[0]][type[1]] == 'accept_partner' ||
            typeList[type[0]][type[1]] == 'shortlist_partner' ||
            typeList[type[0]][type[1]] == 'reject_partner' ||
            typeList[type[0]][type[1]] == 'block' ||
            typeList[type[0]][type[1]] == 'view_partner') {
          widgetList.add(
            MomCard(
              index: index,
              matchMeterModel: matchMeterModel,
              param: typeList[type[0]][type[1]],

              ///true for partner data
              partner: false,

              data: f,
              page: pagerList[type[0]][type[1]],
            ),
          );
        }
      });
    }
  }
}
