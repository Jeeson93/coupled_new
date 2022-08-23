import 'package:coupled/MatchMaker/bloc/match_maker_bloc.dart';
import 'package:coupled/MatchMaker/helpers/coupling_questions.dart';
import 'package:coupled/MatchMaker/helpers/coupling_score.dart';
import 'package:coupled/MatchMaker/helpers/educational_filters.dart';
import 'package:coupled/MatchMaker/helpers/family_filter.dart';
import 'package:coupled/MatchMaker/helpers/personal_filter.dart';
import 'package:coupled/MatchMaker/helpers/place_filter.dart';
import 'package:coupled/MatchMaker/helpers/religion_filter.dart';
import 'package:coupled/MatchMaker/match_maker_provider.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/match_maker_model.dart';
import 'package:coupled/models/questions.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MakerTab { GENERAL, COUPLE, MIX }

class MatchMakerPage extends StatefulWidget {
  final int index;

  MatchMakerPage({Key? key, this.index = 0}) : super(key: key);

  @override
  _MatchMakerPageState createState() => _MatchMakerPageState();
}

class _MatchMakerPageState extends State<MatchMakerPage> {
  dynamic tabOneColor = CoupledTheme().primaryBlue, tabTwoColor, tabThreeColor;
  Color textOneColor = Colors.white,
      textTwoColor = Colors.black,
      textThreeColor = Colors.black;
  var _duration = 200;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<BaseSettings> baseSettings = [];
  final Repository matchMakerApiProvider = Repository();
  MatchMakerModel _matchMakerModel = MatchMakerModel.initial();
  bool clearAll = true;
  Questions _couplingQuestionResponse = Questions(response: []);
  List<String> _generalList = [
    "Personal",
    "Family Info",
    "Religion",
    "Education & Profession",
    "Place"
  ];
  List<String> _coupledList = [
    "Score",
    "Coupling Questions (partner)",
    "Personal",
    "Place"
  ];
  List<String> _mixList = [
    "Personal",
    "Religion",
    "Education & Profession",
    "Place",
    "Coupling Questions (partner)"
  ];
  List<String> selectedList = [];
  int _selectedIndex = 0;
  MakerTab _selectedTab = MakerTab.GENERAL;
  MatchMakerBloc _matchMakerBloc = MatchMakerBloc();
  CounterBloc _counterBloc = CounterBloc();
  List<Widget> _makerWidgets = [];
  bool maxFilterReached = false;

  bool _isLoading = false;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void didChangeDependencies() {
    shiftTab(widget.index != null ? widget.index + 1 : 1, initiate: true);
    super.didChangeDependencies();
  }

  coupledquestionsget() async {
    try {
      GlobalData.couplingQuestion =
          await RestAPI().get(APis.getCouplingQuestions);
    } on RestException catch (e) {
      //GlobalWidgets().showToast(msg: 'Coupling Questions not loaded');
    }
  }

  @override
  void initState() {
    coupledquestionsget();
    setState(() {
      baseSettings = GlobalData.baseSettings;

      _couplingQuestionResponse =
          Questions.fromMap(GlobalData.couplingQuestion);
      selectedList = _generalList;
      print(
          '_couplingQuestionResponse==============${GlobalData.couplingQuestion}');
      print(widget.index);
    });
    //  blocBaseSettings.fetchBaseSettings();

//    widget.index != null ? shiftTab(widget.index) : null;

    super.initState();
  }

  saveMatchMaker() {
    setState(() {
      _isLoading = true;
    });
    String type;
    _selectedTab == MakerTab.GENERAL
        ? type = 'general'
        : _selectedTab == MakerTab.COUPLE
            ? type = 'coupling'
            : type = 'mix';
    Map<String, dynamic> matchMakerParams = _matchMakerModel.toJson();
    matchMakerParams["match_type"] = _selectedTab == MakerTab.GENERAL
        ? 'general_match'
        : _selectedTab == MakerTab.COUPLE
            ? 'coupling_match'
            : 'mix_match';
    print("MatchMakerModel : $matchMakerParams");
    _matchMakerBloc.add(SetMatchMaker(type: type, params: matchMakerParams));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: CoupledTheme().backgroundColor,
      appBar: AppBar(
        backgroundColor: CoupledTheme().backgroundColor,
        elevation: 0.0,
        title: TextView(
          "Match Maker",
          size: 18.0,
          textScaleFactor: .8,
          color: Colors.white,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Center(
            child: _isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )),
                  )
                : InkWell(
                    borderRadius: BorderRadius.circular(50.0),
                    onTap: () {
                      _counterBloc.add(CounterEvent(false));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          GlobalWidgets().iconCreator(
                              "assets/MatchMeter/Delete.png",
                              color: Colors.white,
                              size: FixedIconSize.SMALL),
                          SizedBox(width: 5.0),
                          TextView(
                            "Clear",
                            textScaleFactor: .8,
                            size: 12,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
          ),
          Center(
            child: _isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )),
                  )
                : InkWell(
                    borderRadius: BorderRadius.circular(50.0),
                    onTap: () => saveMatchMaker(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16.0,
                          ),
                          SizedBox(width: 5.0),
                          TextView(
                            "Done",
                            textScaleFactor: .8,
                            size: 12,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
          )
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: CoupledTheme().verticalTabBgColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: InkWell(
                        splashColor: CoupledTheme().primaryBlue,
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () {
                          if (_selectedTab != MakerTab.GENERAL) shiftTab(1);
                        },
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: _duration),
                            curve: Curves.easeInOut,
                            color: tabOneColor,
                            child: tabTile(
                                "General Matches",
                                /*  dialogs.showSimpleMessageDialog(context,
            msg: CoupledStrings.matchMakerMaxWarning(_matchMakerModel.generalCount), title: 'Sorry');*/
                                textOneColor,
                                "assets/MatchMaker/ic_generalMatches.png")),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.black38,
                    indent: 2.0,
                  ),
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: InkWell(
                        splashColor: CoupledTheme().primaryBlue,
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () {
                          if (_selectedTab != MakerTab.COUPLE) shiftTab(2);
                        },
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: _duration),
                            curve: Curves.easeInOut,
                            color: tabTwoColor,
                            child: tabTile(
                                "Coupling Matches",
                                /* ${_matchMakerModel.couplingCount == 0 ? "" : _matchMakerModel.couplingCount}*/
                                textTwoColor,
                                "assets/MatchMaker/ic_couplingMatches.png")),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.black38,
                    indent: 2.0,
                  ),
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: InkWell(
                        splashColor: CoupledTheme().primaryBlue,
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () {
                          if (_selectedTab != MakerTab.MIX) shiftTab(3);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: _duration),
                          curve: Curves.easeInOut,
                          color: tabThreeColor,
                          child: tabTile(
                              "Mix Matches",
                              /*${_matchMakerModel.mixCount == 0 ? "" : _matchMakerModel.mixCount}*/
                              textThreeColor,
                              "assets/MatchMaker/ic_mixMatches.png"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Color(0xffe1e1e1),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: selectedList.length,
                itemExtent: 50.0,
                itemBuilder: (context, index) {
                  return Container(
                    color: _selectedIndex != null && _selectedIndex == index
                        ? CoupledTheme().backgroundColor
                        : Color(0xffe1e1e1),
                    child: ListTile(
                      onTap: () => _onSelected(index),
                      contentPadding: EdgeInsets.only(left: 5.0),
                      title: TextView(
                        selectedList[index],
                        color: _selectedIndex != null && _selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                        size: 12,
                        maxLines: 2,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: MultiBlocListener(
              listeners: [
                BlocListener<MatchMakerBloc, MatchMakerState>(
                    bloc: _matchMakerBloc,
                    listener: (context, state) {
                      if (state is MatchMakerError) {
                        setState(() {
                          print("BlocListener _matchMakerBloc");
                          _matchMakerModel = MatchMakerModel.initial();
                        });
                      }
                      if (state is SavedMatchMakerResponse) {
                        setState(() {
                          print("state.userShortInfoModelResponse");
                          print(state.savedMatchMakerResponse);
                          GlobalWidgets()
                              .showSnackBar(_scaffoldKey, "Saved Successfully");
                          // _matchMakerModel = MatchMakerModel.fromJson(state.savedMatchMakerResponse);
                        });
                      }
                      if (state is MatchMakerResponse) {
                        maxFilterReached = false;
                        _counterBloc = CounterBloc();
                        print("_counterBloc RESTARTED");
                        _makerWidgets.clear();
                        _matchMakerModel = state.matchMakerModel;
                        makerWidget(refresh: true);
                      }
                    }),
                BlocListener<CounterBloc, CounterState>(
                    bloc: _counterBloc,
                    listener: (context, state) {
                      print("COUNT ***** :: $state");
                      if (state is CounterIncrement)
                        maxFilterReached =
                            checkCount(state.counterState, _selectedTab);
                      else if (state is CounterDecrement)
                        maxFilterReached =
                            checkCount(state.counterState, _selectedTab);
                      else if (state is CounterClearAll) {
                        checkCount(state.counterState, _selectedTab);
                        _matchMakerModel = MatchMakerModel.clearAll();
                        saveMatchMaker();
                      }
                      print("MaxFilterReached :: $maxFilterReached");
                      setState(() {});
                    }),
              ],
              child: BlocBuilder<MatchMakerBloc, MatchMakerState>(
                bloc: _matchMakerBloc,
                builder: (context, snapshot) {
                  print(_couplingQuestionResponse.response?.length);
                  print("SnapShot : $snapshot");
                  if (snapshot is MatchMakerResponse ||
                      snapshot is SavedMatchMakerResponse) {
                    _isLoading = false;
                    //  &&
                    //       _couplingQuestionResponse != null &&
                    //       _couplingQuestionResponse.response.length >= 0
                    print(
                        "matchMakerModel ::: ${(snapshot is MatchMakerResponse) ? snapshot.matchMakerModel : ""}");

                    return MatchMakerProvider(
                      context: context,
                      baseSettings: baseSettings,
                      matchMakerModel: _matchMakerModel,
                      counterBloc: _counterBloc,
                      maxFilterReached: maxFilterReached,
                      child: IndexedStack(
                        index: switchStack(_selectedIndex),
                        children: _makerWidgets,
                      ),
                    );
                  }
                  if (snapshot is MatchMakerError) {
                    return Center(
                      child: Text("Something went wrong please try again."),
                    );
                  }
                  return GlobalWidgets().showCircleProgress();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _matchMakerBloc.close();
    _counterBloc.close();
    super.dispose();
  }

  Dialogs dialogs = Dialogs();

  bool checkCount(Counter counter, MakerTab makerTab) {
    bool val = false;
    print("makerTab :: $makerTab");
    switch (makerTab) {
      case MakerTab.COUPLE:
        counter == Counter.clearAll
            ? _matchMakerModel.couplingCount = 0
            : /*_matchMakerModel.couplingCount > 2
                ? _matchMakerModel.couplingCount = 2
                : */
            counter == Counter.increment
                ? _matchMakerModel.couplingCount++
                : _matchMakerModel.couplingCount > 0
                    ? _matchMakerModel.couplingCount--
                    : _matchMakerModel.couplingCount = 0;

        val = _matchMakerModel.couplingCount > 1;
        break;
      case MakerTab.MIX:
        counter == Counter.clearAll
            ? _matchMakerModel.mixCount = 0
            : /*_matchMakerModel.mixCount > 4
                ? _matchMakerModel.mixCount = 4
                : */
            counter == Counter.increment
                ? _matchMakerModel.mixCount++
                : _matchMakerModel.mixCount > 0
                    ? _matchMakerModel.mixCount--
                    : _matchMakerModel.mixCount = 0;
        val = _matchMakerModel.mixCount > 3;
        break;
      case MakerTab.GENERAL:
        print(counter == Counter.clearAll);
        print(
            counter == Counter.increment && _matchMakerModel.generalCount <= 7);
        print(
            counter == Counter.decrement && _matchMakerModel.generalCount > 0);
        counter == Counter.clearAll
            ? _matchMakerModel.generalCount = 0
            : /*_matchMakerModel.generalCount > 7
                ? _matchMakerModel.generalCount = 7
                : */
            counter == Counter.increment
                ? _matchMakerModel.generalCount++
                : _matchMakerModel.generalCount > 0
                    ? _matchMakerModel.generalCount--
                    : _matchMakerModel.generalCount = 0;
        val = _matchMakerModel.generalCount > 6;
        break;
    }
    print("counter : $counter "
        "generalCounts : ${_matchMakerModel.generalCount} "
        "coupleCounts : ${_matchMakerModel.couplingCount} "
        "mixCounts : ${_matchMakerModel.mixCount} ");

    if (counter == Counter.increment && _matchMakerModel.generalCount == 6) {
      print("****WARNING*****");

      dialogs.showSimpleMessageDialog(context,
          msg: CoupledStrings.matchMakerWarning(_matchMakerModel.generalCount),
          title: 'Warning');
    }
    if (counter != Counter.decrement) {
      print("****MAX ALERT*****${_matchMakerModel.mixCount}");
      if (_matchMakerModel.generalCount > 7) {
        dialogs.showSimpleMessageDialog(context,
            msg: CoupledStrings.matchMakerMaxWarning(
                _matchMakerModel.generalCount),
            title: 'Sorry');
      } else if (_matchMakerModel.couplingCount > 3) {
        dialogs.showSimpleMessageDialog(context,
            msg: CoupledStrings.matchMakerMaxWarning(
                _matchMakerModel.couplingCount),
            title: 'Sorry');
      } else if (_matchMakerModel.mixCount > 4) {
        dialogs.showSimpleMessageDialog(context,
            msg: CoupledStrings.matchMakerMaxWarning(_matchMakerModel.mixCount),
            title: 'Sorry');
      }
    }
    return val;
  }

  makerWidget({bool refresh = false}) {
    print("refresh : $refresh ${_makerWidgets.isEmpty}");
    if (_makerWidgets.isEmpty || refresh) {
      _makerWidgets = [
        Personal(
          key: GlobalKey(),
          isGeneral: _selectedTab,
        ),
        //    PhotoType(),
        Family(
          key: GlobalKey(),
          isGeneral: _selectedTab,
        ),
        ReligionFilter(
          key: GlobalKey(),
        ),
        EducationProfession(
          key: GlobalKey(),
          isGeneral: _selectedTab,
        ),
        Place(
          key: GlobalKey(),
        ),
        CouplingScore(
          key: GlobalKey(),
        ),
        CouplingQuestion(
          key: GlobalKey(),
          questions: _couplingQuestionResponse,
        ),
      ];
      setState(() {});
    }
  }

  shiftTab(int index, {bool initiate = false}) {
    print("initiate $initiate");
    if (!initiate) {
      saveMatchMaker();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      tabOneColor =
          tabTwoColor = tabThreeColor = CoupledTheme().verticalTabBgColor;
      textOneColor = textTwoColor = textThreeColor = Colors.black;
      selectedList = [];
      switch (index) {
        case 1:
          tabOneColor = CoupledTheme().primaryBlue;
          textOneColor = Colors.white;
          selectedList.addAll(_generalList);
          _selectedTab = MakerTab.GENERAL;
          break;
        case 2:
          tabTwoColor = CoupledTheme().primaryBlue;
          textTwoColor = Colors.white;
          selectedList.addAll(_coupledList);
          _selectedTab = MakerTab.COUPLE;

          break;
        case 3:
          tabThreeColor = CoupledTheme().primaryBlue;
          textThreeColor = Colors.white;
          selectedList.addAll(_mixList);
          _selectedTab = MakerTab.MIX;
          break;
        default:
          tabOneColor =
              tabTwoColor = tabThreeColor = CoupledTheme().verticalTabBgColor;
          break;
      }
      _selectedIndex = 0;
      print("_selectedTab");
      print(_selectedTab);
      //  _registerBloc.add(GetCouplingQ());
      pageStream();
    });
  }

  int switchStack(selectedIndex) {
    int index = 0;
    switch (_selectedTab) {
      case MakerTab.COUPLE:
//          setState(() {
        if (selectedIndex == 0) {
          index = 5;
        } else if (selectedIndex == 1) {
          index = 6;
        } else if (selectedIndex == 2) {
          index = 0;
        } else if (selectedIndex == 3) {
          index = 4;
        }
        break;
      case MakerTab.MIX:
//          setState(() {
        if (selectedIndex == 0) {
          index = 0;
        } else if (selectedIndex == 1) {
          index = 2;
        } else if (selectedIndex == 2) {
          index = 3;
        } else if (selectedIndex == 3) {
          index = 4;
        } else if (selectedIndex == 4) {
          index = 6;
        }
        break;
      default:
        index = selectedIndex;
        break;
    }
    return index;
  }

  tabTile(String title, Color textColor, String imageAsset) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          imageAsset,
          height: 15.0,
          width: 15.0,
        ),
        SizedBox(
          width: 10.0,
        ),
        TextView(title,
            size: 18.0,
            fontWeight: FontWeight.normal,
            color: textColor,
            decoration: TextDecoration.none,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            textScaleFactor: .8),
      ],
    );
  }

  pageStream() {
    String type;
    _selectedTab == MakerTab.GENERAL
        ? type = 'general'
        : _selectedTab == MakerTab.COUPLE
            ? type = 'coupling'
            : type = 'mix';
    _matchMakerBloc.add(GetMatchMaker(
      type: type,
    ));
  }
}

class WrapItem {
  bool isSelected = false;
  String title = '', id = '';
  int index = 0;

  int get _index => index;

  WrapItem(
      {this.isSelected = false, this.title = '', this.id = '', this.index = 0});

  WrapItem.initial();

  @override
  String toString() {
    return 'WrapItem{isSelected: $isSelected, title: $title, id: $id}';
  }

  Widget generateItem(List<WrapItem> status,
      {required ValueGetter<bool> valueGetter, Function(int index)? onTap}) {
    List<Widget> children = List<Widget>.generate(status.length, (i) {
      return GestureDetector(
        onTap: () => onTap!(i),
        child: Container(
            padding: EdgeInsets.all(8.0),
//            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: status[i].isSelected
                    ? CoupledTheme().primaryPinkDark
                    : Colors.transparent,
                border: Border.all(
                    color: status[i].isSelected
                        ? CoupledTheme().primaryPinkDark
                        : Colors.white)),
            child: TextView(
              status[i].title,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
              size: 12,
              color: Colors.white,
            )),
      );
    });

    return Wrap(
        runSpacing: 10.0,
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.end,
        spacing: 10.0,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children);
  }
}

class CheckBoxWidget {
  bool isSelected = false;
  String title = '';
  int _index = 0;

  int get index => _index;

  CheckBoxWidget(this.isSelected, this.title);

  CheckBoxWidget.initial();

  @override
  String toString() {
    return 'CheckBoxWidget{isSelected: $isSelected, title: $title}';
  }

  List<Widget> generateItem(
      List<CheckBoxWidget> status, ValueChanged<bool> onChanged) {
    List<Widget> s = List<Widget>.generate(status.length, (i) {
      return StatefulBuilder(
        builder: (context, setState) {
          return GestureDetector(
            onTapDown: (_) {
              _index = i;
            },
            child: CustomCheckBox(
              value: status[i].isSelected,
              text: status[i].title,
              onChanged: (onChanged) {
                setState(() {
                  status[i].isSelected = onChanged!;
                });
              },
              secondary: SizedBox(),
            ),
          );
        },
      );
    });
    return s;
  }
}
