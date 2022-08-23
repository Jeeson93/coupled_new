import 'package:coupled/Home/MatchBoard/view/couplingMatches.dart';
import 'package:coupled/Home/MatchBoard/view/generalMatch.dart';
import 'package:coupled/Home/MatchBoard/view/latestMatches.dart';
import 'package:coupled/Home/MatchBoard/view/mixMatches.dart';

import 'package:coupled/Home/main_board.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchBoardView extends StatefulWidget {
  final Key? key;
  final String setAppBar;
  final String searchQuery;
  final int index;
  final List userShortInfoModelList;

  //final ProfileResponse profileResponse;

  MatchBoardView({
    this.userShortInfoModelList = const [],
    this.key,
    this.setAppBar = '',
    this.searchQuery = '',
    this.index = 0,
    //    this.profileResponse
  }) : super(key: key);

  @override
  _MatchBoardViewState createState() => _MatchBoardViewState();
}

class _MatchBoardViewState extends State<MatchBoardView> {
  PageController _pageController =
      PageController(initialPage: 0, viewportFraction: .95);
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  // SearchBloc searchBloc;
  // OthersProfileBloc othersProfileBloc;
  var search_key;
  @override
  void initState() {
    //searchBloc = SearchBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var refreshKey;
    return WillPopScope(
      onWillPop: onPressed,
      child: Scaffold(
        appBar: widget.setAppBar == ''
            ? null
            : AppBar(
                leading: InkWell(
                    onTap: () async {
                      SharedPreferences prefrences =
                          await SharedPreferences.getInstance();
                      prefrences.remove("uri");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainBoard()),
                      );
                    },
                    child: Icon(Icons.arrow_back)),
                title: TextView(
                  widget.setAppBar,
                  size: 18,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                ),
                backgroundColor: CoupledTheme().backgroundColor,
              ),
        backgroundColor: CoupledTheme().backgroundColor,
        body: Column(
          children: <Widget>[
            widget.index == 0
                ? Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: generalCard(
                          widget.userShortInfoModelList[0], context),
                      childAspectRatio: .8,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                    ),
                  )
                : widget.index == 1
                    ? Container(
                        height: (72 * MediaQuery.of(context).size.height) / 100,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: widget
                              .userShortInfoModelList[0].response.data.length,
                          pageSnapping: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return buildCouplingCard(
                                widget.userShortInfoModelList[0],
                                context)[index];
                          },
                        ),
                      )
                    : widget.index == 2
                        ? LayoutBuilder(
                            builder: (context, boxConstraints) =>
                                CustomScrollView(
                              shrinkWrap: true,
                              slivers: <Widget>[
                                SliverToBoxAdapter(
                                  child: Container(
                                    height: (40 *
                                            MediaQuery.of(context)
                                                .size
                                                .height) /
                                        100,
                                    child: PageView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      itemCount: widget
                                          .userShortInfoModelList[0]
                                          .response
                                          .data
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return premiumMembers(
                                            widget.userShortInfoModelList,
                                            context)[index];
                                      },
                                    ),
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: Container(
                                    height: (30 *
                                            MediaQuery.of(context)
                                                .size
                                                .height) /
                                        100,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      itemCount: widget
                                              .userShortInfoModelList[1]
                                              .response
                                              .data
                                              .length ??
                                          0,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return generalMixMatchCard(
                                            widget.userShortInfoModelList[1],
                                            context)[index];
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.all(10.0),
                                itemCount: widget.userShortInfoModelList[0]
                                        .response.data.length ??
                                    0,
                                itemBuilder: (BuildContext context, int index) {
                                  return latestMatch(
                                    widget.userShortInfoModelList[0],
                                    context,
                                    //      profileResponse: widget.profileResponse,
                                  )[index];
                                },
                              ),
                            ),
                          )
          ],
        ),
      ),
    );
  }

  Future<Null> refreshList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    search_key = prefs.getString('search_key');
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      //searchBloc.add(SearchQuery({"query": search_key, "limit": 10}));
      print("kkk");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainBoard()),
      );

      setState(() {});
    });

    return null;
  }

  Future<bool> onPressed() async {
    print("noel-----");
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    prefrences.remove("uri");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainBoard()),
    );
    return true;
  }
}
