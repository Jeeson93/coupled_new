import 'package:coupled/Home/MatchBoard/MatchBoardView.dart';
import 'package:coupled/MatchMaker/bloc/match_maker_bloc.dart';
import 'package:coupled/MatchMaker/helpers/activeness_on_site.dart';
import 'package:coupled/MatchMaker/helpers/educational_filters.dart';
import 'package:coupled/MatchMaker/helpers/family_filter.dart';
import 'package:coupled/MatchMaker/helpers/personal_filter.dart';
import 'package:coupled/MatchMaker/helpers/place_filter.dart';
import 'package:coupled/MatchMaker/helpers/religion_filter.dart';
import 'package:coupled/MatchMaker/match_maker_page.dart';
import 'package:coupled/MatchMaker/match_maker_provider.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/match_maker_model.dart';
import 'package:coupled/models/user.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdvancedSearch extends StatefulWidget {
  @override
  _AdvancedSearchState createState() => _AdvancedSearchState();
}

class _AdvancedSearchState extends State<AdvancedSearch> {
  List<BaseSettings> baseSettings = [];
  dynamic _matchMakerModel;
  CounterBloc _counterBloc = CounterBloc();
  bool maxFilterReached = false;
  User user = User();
  List<String> _generalList = [
    "Personal",
    "Family Info",
    "Religion",
    "Education & Profession",
    "Place",
    "Activeness on site"
  ];
  int _selectedIndex = 0;
  bool clearAll = true;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    baseSettings = GlobalData.baseSettings;
    _matchMakerModel = MatchMakerModel.initial();

    super.initState();
  }

  @override
  Future<void> dispose() async {
    SharedPreferences prefren = await SharedPreferences.getInstance();
    prefren.remove("uri");
    _counterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoupledTheme().backgroundColor,
      appBar: AppBar(
        backgroundColor: CoupledTheme().backgroundColor,
        elevation: 0.0,
        title: TextView(
          "Advanced Search",
          size: 18.0,
          color: Colors.white,
          decoration: TextDecoration.none,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          textScaleFactor: .8,
          fontWeight: FontWeight.normal,
        ),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              SharedPreferences prefrences =
                  await SharedPreferences.getInstance();
              prefrences.remove("uri");

              print("jakes");

              _counterBloc.add(CounterEvent(false));
            },
            child: Row(
              children: <Widget>[
                GlobalWidgets().iconCreator("assets/MatchMeter/Delete.png",
                    size: FixedIconSize.SMALL),
                SizedBox(width: 5.0),
                TextView(
                  "Clear all",
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                  size: 12,
                  fontWeight: FontWeight.normal,
                )
              ],
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
                onTap: () async {
                  var res = Repository()
                      .getAdvanceSearch(_matchMakerModel.matchMakerParams());
                  res.then((onValue) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MatchBoardView(
                            setAppBar: "Advanced Search Results",
                            searchQuery: 'advanced',
                            index: 0,
                            userShortInfoModelList: [onValue])));
                  });
                },
                child: TextView(
                  "Done",
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                  size: 12,
                )),
          ))
        ],
      ),
      body: BlocListener(
        bloc: _counterBloc,
        listener: (context, state) {
          setState(() {
            print("COUNT ***** :: $state");
            if (state is CounterIncrement)
              checkCount(state.counterState);
            else if (state is CounterDecrement)
              checkCount(state.counterState);
            else if (state is CounterClearAll) {
              checkCount(state.counterState);
              _matchMakerModel = MatchMakerModel.clearAll();
              setState(() {});
            }

            print("MaxFilterReached :: $maxFilterReached");
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                color: Color(0xffe1e1e1),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _generalList.length,
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
                          _generalList[index],
                          color:
                              _selectedIndex != null && _selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                          fontWeight: FontWeight.bold,
                          size: 12,
                          decoration: TextDecoration.none,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .9,
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
              child: MatchMakerProvider(
                context: context,
                matchMakerModel: _matchMakerModel,
                counterBloc: _counterBloc,
                baseSettings: baseSettings,
                maxFilterReached: maxFilterReached,
                child: IndexedStack(
                  index: _selectedIndex,
                  children: <Widget>[
                    Personal(
                      isGeneral: MakerTab.GENERAL,
                    ),
                    Family(
                      isGeneral: MakerTab.GENERAL,
                    ),
                    ReligionFilter(),
                    EducationProfession(
                      isGeneral: MakerTab.GENERAL,
                    ),
                    Place(),
                    ActivenessOnSite(
                      matchMakerModel: _matchMakerModel,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Dialogs dialogs = Dialogs();

  void checkCount(Counter counter) {
    print(counter == Counter.clearAll);
    print(counter == Counter.increment && _matchMakerModel.generalCount <= 7);
    print(counter == Counter.decrement && _matchMakerModel.generalCount > 0);
    counter == Counter.clearAll
        ? _matchMakerModel.generalCount = 0
        : _matchMakerModel.generalCount > 7
            ? _matchMakerModel.generalCount = 7
            : counter == Counter.increment
                ? _matchMakerModel.generalCount++
                : _matchMakerModel.generalCount > 0
                    ? _matchMakerModel.generalCount--
                    : _matchMakerModel.generalCount = 0;

    if (counter == Counter.increment && _matchMakerModel.generalCount == 6) {
      print("****WARNING*****");

      dialogs.showSimpleMessageDialog(context,
          msg: CoupledStrings.matchMakerWarning(_matchMakerModel.generalCount),
          title: 'Warning');
    }
  }
}
