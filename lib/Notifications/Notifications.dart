import 'package:coupled/Notifications/notificationItem.dart';

import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/models/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../Utils/styles.dart';
import 'NotificationInfiniteList.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>
    with SingleTickerProviderStateMixin {
  bool state = false;
  late TabController _tabController;
  NotificationInfiniteList notificationInfiniteList =
      NotificationInfiniteList();
  NotificationModel1 _notificationModel = NotificationModel1();
  late ScrollController _scrollControllerMom, _scrollControllerCoupled;
  int momPageNumber = 1;
  int momTotalItems = 0;
  int coupledPageNumber = 1;
  int coupledTotalItems = 0;
  int perPageCount = 10;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  List<String> types = ['mom', 'coupled'];
  List<Widget> coupledTabData = [];
  List<Widget> momTabData = [];

  @override
  void initState() {
    super.initState();

    notificationInfiniteList = NotificationInfiniteList(type: types[0]);
    _tabController = TabController(vsync: this, length: 2);

    _tabController.animation?.addListener(() {
      setState(() {
        state = _tabController.animation!.value > .5;
      });
    });

    ///tab controller
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        tabChanged(_tabController.index);
        print('TABINDEX:${_tabController.index}');
      }
    });

    ///mom pagination Controller
    _scrollControllerMom = ScrollController();
    _scrollControllerMom.addListener(() {
      if (_scrollControllerMom.position.maxScrollExtent ==
          _scrollControllerMom.offset) {
        if (momTotalItems >= (perPageCount * momPageNumber)) {
          momPageNumber++;
          notificationInfiniteList.loadMore(
              page: momPageNumber, type: types[0], clearCachedData: true);
          print("PAGE NUMBER $momPageNumber");
        }
      }
    });

    ///coupled pagination Controller
    _scrollControllerCoupled = ScrollController();
    _scrollControllerCoupled.addListener(() {
      if (_scrollControllerCoupled.position.maxScrollExtent ==
          _scrollControllerCoupled.offset) {
        if (momTotalItems >= (perPageCount * momPageNumber)) {
          momPageNumber++;
          notificationInfiniteList.loadMore(
              page: momPageNumber, type: types[1], clearCachedData: true);
          print("PAGE NUMBER $momPageNumber");
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        tabBarTheme: TabBarTheme(
          indicator: BoxDecoration(color: CoupledTheme().primaryBlue),
        ),
      ),
      child: Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        appBar: AppBar(
          backgroundColor: CoupledTheme().backgroundColor,
          title: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextView(
                  "Notification",
                  size: 22,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                )
              ],
            ),
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: RefreshIndicator(
            key: refreshKey,
            onRefresh: refresh,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: TabBar(
                          controller: _tabController,
                          onTap: (int index) {},
                          tabs: <Widget>[
                            Tab(
                                child: TextView(
                              "Match-O-Meter",
                              color: state ? Colors.black : Colors.white,
                              size: 16,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8,
                            )),
                            Tab(
                              child: TextView(
                                "From Coupled",
                                color: state ? Colors.white : Colors.black,
                                size: 16,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                              ),
                            ),
                          ]),
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: notificationInfiniteList.stream,
                        builder: (context, snapshot) {
                          print('snapshot.hasData------');
                          print(snapshot.hasData);
                          if (snapshot.hasData) {
                            _notificationModel =
                                snapshot.data as NotificationModel1;

                            print('_notificationModel?.response?.data?.length');
                            print(_notificationModel.response?.data?[0]);

                            ///mom
                            if (_notificationModel != null &&
                                _notificationModel.response?.data?[0].mode ==
                                    'match-o-meter') {
                              momTotalItems =
                                  _notificationModel.response?.total;
                              _notificationModel.response?.data?.forEach(
                                (f) {
                                  if (momTabData.length != momTotalItems &&
                                      momPageNumber * 10 > momTabData.length) {
                                    momTabData.add(
                                      NotificationItem(
                                        data: f,
                                      ),
                                    );
                                  }
                                },
                              );
                            } else if ((_notificationModel
                                        .response?.data?.length ??
                                    0) <=
                                1) {
                              momTabData.clear();
                              momTabData.add(Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextView(
                                  CoupledStrings.noRecordFound,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                ),
                              )));
                            }

                            ///coupled
                            if (_notificationModel != null &&
                                _notificationModel.response?.data?[0].mode ==
                                    'from-coupled') {
                              coupledTotalItems =
                                  _notificationModel.response?.total;
                              _notificationModel.response?.data?.forEach(
                                (f) {
                                  if (coupledTabData.length !=
                                          coupledTotalItems &&
                                      coupledPageNumber * 10 >
                                          coupledTabData.length) {
                                    coupledTabData.add(
                                      NotificationItem(
                                        data: f,
                                      ),
                                    );
                                  }
                                },
                              );
                            } else {
                              coupledTabData.clear();

                              ///TODO no data condition
                              // coupledTabData.add(Center(
                              //     child: Padding(
                              //   padding: const EdgeInsets.all(12.0),
                              //   child: TextView(CoupledStrings.noRecordFound),
                              // )));
                            }

                            return _notificationModel.response?.data?[0] != null
                                ? Container(
                                    height: MediaQuery.of(context).size.height,
                                    padding: EdgeInsets.only(bottom: 12),
                                    child: TabBarView(
                                        physics: NeverScrollableScrollPhysics(),
                                        controller: _tabController,
                                        children: [
                                          momTabData.isNotEmpty
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  controller:
                                                      _scrollControllerMom,
                                                  itemCount:
                                                      momTabData.length ?? 0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return momTabData[index];
                                                  },
                                                )
                                              : Center(
                                                  child: GlobalWidgets()
                                                      .showCircleProgress(),
                                                ),
                                          coupledTabData.isNotEmpty
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  controller:
                                                      _scrollControllerCoupled,
                                                  itemCount:
                                                      coupledTabData.length ??
                                                          0,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return coupledTabData[
                                                        index];
                                                  },
                                                )
                                              : Center(
                                                  child: GlobalWidgets()
                                                      .showCircleProgress(),
                                                ),
                                        ]),
                                  )
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
                                          color: Colors.red,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                        ),
                                        TextView(
                                          "Notifications Not found ",
                                          color: Colors.red,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                          overflow: TextOverflow.visible,
                                          size: 12.0,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                        ),
                                      ],
                                    ),
                                  );
                            ;
                          }
                          return GlobalWidgets().showCircleProgress();
//                          else {
//                            return GlobalWidgets().showCircleProgress();
//                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void tabChanged(int index) {
    if (index == 0) {
      notificationInfiniteList.loadMore(
          page: momPageNumber, type: 'mom', clearCachedData: true);
    }
    if (index == 1) {
      notificationInfiniteList.loadMore(
          page: coupledPageNumber, type: 'coupled', clearCachedData: true);
    }
  }

  getTime(DateTime createdAt) {
    int difference = ((DateTime.now().difference(createdAt).inDays)).round();
    if (difference < 1) {
      return timeago.format(createdAt).toString();
    } else {
      var formatter = new DateFormat('dd-MM-yyyy');
      return formatter.format(createdAt).toString();
    }
  }

  ///refresh
  Future<void> refresh() {
    if (_tabController.index == 0) {
      momTabData.clear();
      return notificationInfiniteList.loadMore(
          page: 1, type: types[0], clearCachedData: true);
    } else if (_tabController.index == 1) {
      coupledTabData.clear();
      return notificationInfiniteList.loadMore(
          page: 1, type: types[1], clearCachedData: true);
    }
    return Future.value();
  }
}
