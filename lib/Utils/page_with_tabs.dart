import 'package:coupled/MatchMeter/bloc/mom_bloc.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

class PageWithTabs extends StatefulWidget {
  List<String>? tabName;
  List<List<Widget>>? tabData;
  final bool isHintVisible;
  final bool isCountVisible;
  final bool dividerVisibility;
  final ScrollPhysics scrollPhysics;

//  final MoMInfiniteListData listDatas;
  final bool infoVisibility;
  final Function? loadData;
  final ScrollController? scrollController;
  final TabController? tabController;

  final String hint, tab1Count, tab2Count, tooltipMsg1, tooltipMsg2;

  PageWithTabs({
    Key? key,
    this.tabName,
    this.tabData,
    this.isHintVisible = false,
    this.hint = '',
    this.tab1Count = '',
    this.tab2Count = '',
    this.scrollController,
    this.tooltipMsg1 = "",
    this.tooltipMsg2 = "",
    this.isCountVisible = false,
    this.dividerVisibility = false,
    this.infoVisibility = false,
//    this.listDatas,
    this.loadData,
    this.tabController,
    this.scrollPhysics = const AlwaysScrollableScrollPhysics(),
  }) : super(key: key);

  @override
  _PageWithTabsState createState() => _PageWithTabsState();
}

class _PageWithTabsState extends State<PageWithTabs>
    with SingleTickerProviderStateMixin {
  GlobalKey toolKey = GlobalKey();
  GlobalKey toolKey1 = GlobalKey();
  bool state = false;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  //List<Widget> widgetList = [];
  @override
  void initState() {
    //tabController = TabController(length: 2, vsync: this);

    super.initState();
    widget.tabController!.addListener(() {
      if (mounted) return;
      if (widget.tabController!.animation!.value > .5) {
        state = true;
      } else {
        state = false;
      }
      // if(widget.tabController?.indexIsChanging==true){
      //   widget.tabData?.clear();
      //   widget.tabName?.clear();
      // }
    });
  }

 @override
  void dispose() {
    // TODO: implement dispose
    widget.tabData?.clear();
    widget.tabName?.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print('widget?.ta---------bData');
    print(widget.tabData);
    print((widget.tabData![1]));

    return Scaffold(
      backgroundColor: CoupledTheme().backgroundColor,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: TabBar(
                  controller: widget.tabController,
                  unselectedLabelColor: Colors.black,
                  labelStyle: TextStyle(
                    letterSpacing: 0.5,
                    color: Colors.white,
                    textBaseline: TextBaseline.alphabetic,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bariol',
                    fontSize: 16.0,
                  ),
                  indicator: BoxDecoration(color: CoupledTheme().primaryBlue),
                  tabs: <Widget>[
                    Tab(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Visibility(
                            visible: widget.infoVisibility,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: TooltipTheme(
                                data: TooltipThemeData(
                                    textStyle: TextStyle(color: Colors.black)),
                                child: Tooltip(
                                  key: toolKey,
                                  message: widget.tooltipMsg1,
                                  excludeFromSemantics: true,
                                  preferBelow: false,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      final dynamic tooltip =
                                          toolKey.currentState;
                                      tooltip.ensureTooltipVisible();
                                    },
                                    child: Image.asset(
                                      "assets/Profile/information-variant.png",
                                      width: 22,
                                      color:
                                          state ? Colors.black : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Center(
                              child: Text(widget.tabName![0],
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ),
                          Visibility(
                            visible: widget.isCountVisible,
                            child: Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: state
                                          ? CoupledTheme().primaryBlue
                                          : Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xffc2c2c2),
                                          offset: const Offset(0.0, 0.0),
                                        ),
                                        BoxShadow(
                                          color: Color(0xffffffff),
                                          offset: const Offset(-1.0, 2.0),
                                          spreadRadius: -2.0,
                                          blurRadius: 3.0,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 2),
                                      child: TextView(
                                        '${widget.tab1Count}',
                                        color: state
                                            ? Colors.white
                                            : CoupledTheme().primaryBlue,
                                        size: 12,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: .8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: <Widget>[
                          Visibility(
                            visible: widget.infoVisibility,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: TooltipTheme(
                                data: TooltipThemeData(
                                    textStyle: TextStyle(color: Colors.black)),
                                child: Tooltip(
                                  key: toolKey1,
                                  message: widget.tooltipMsg2,
                                  excludeFromSemantics: true,
                                  preferBelow: false,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      final dynamic tooltip =
                                          toolKey1.currentState;
                                      tooltip.ensureTooltipVisible();
                                    },
                                    child: Image.asset(
                                      "assets/Profile/information-variant.png",
                                      width: 22,
                                      color:
                                          state ? Colors.white : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Center(
                              child: Text(
                                widget.tabName![1],
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: widget.isCountVisible,
                            child: Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: state
                                          ? Colors.white
                                          : CoupledTheme().primaryBlue,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xffc2c2c2),
                                          offset: const Offset(0.0, 0.0),
                                        ),
                                        BoxShadow(
                                          color: Color(0xffffffff),
                                          offset: const Offset(-1.0, 2.0),
                                          spreadRadius: -2.0,
                                          blurRadius: 3.0,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 2),
                                      child: TextView(
                                        '${widget.tab2Count}',
                                        color: state
                                            ? CoupledTheme().primaryBlue
                                            : Colors.white,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: .8,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: widget.tabController,
                children: [
                  SingleChildScrollView(
                    physics: widget.scrollPhysics,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Visibility(
                          visible: widget.isHintVisible,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: TextView(
                              widget.hint,
                              size: 12,
                              color: CoupledTheme().primaryPink,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8,
                            ),
                          ),
                        ),
                        StatefulBuilder(builder: (context, snapshot) {
                          return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            controller: widget.scrollController,
                            key: PageStorageKey('${widget.tabName![0]}'),
                            itemCount: widget.tabData![0].length,
                            itemBuilder: (context, index) {
                              return widget.tabData![0][index];
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Visibility(
                                visible: widget.dividerVisibility,
                                child: const Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                  height: 1.0,
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: widget.scrollPhysics,
                    child: Column(
                      children: <Widget>[
                        Visibility(
                          visible: widget.isHintVisible,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: TextView(
                              widget.hint,
                              size: 12,
                              color: CoupledTheme().primaryPink,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8,
                            ),
                          ),
                        ),
                        StatefulBuilder(builder: (context, snapshot) {
                          return ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            controller: widget.scrollController,
                            key: PageStorageKey('${widget.tabName![1]}'),
                            itemCount: widget.tabData![1].length,
                            itemBuilder: (context, index) {
                              ///TODO sometimes 💩 happen here
                              return widget.tabData![1][index];
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Visibility(
                                visible: widget.dividerVisibility,
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                  height: 1.0,
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      GlobalData.momBloc.add(LoadMomData(widget.tabName![0], 1));
    });

    return null;
  }
}
