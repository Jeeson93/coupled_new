import 'package:coupled/MatchMaker/bloc/match_maker_bloc.dart';
import 'package:coupled/MatchMaker/helpers/place_filter.dart';
import 'package:coupled/MatchMaker/match_maker_page.dart';
import 'package:coupled/MatchMaker/match_maker_provider.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/match_maker_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Personal extends StatefulWidget {
  final MakerTab isGeneral;

  const Personal({Key? key, required this.isGeneral}) : super(key: key);

  //Personal({this.user, this.isGeneral = MakerTab.GENERAL, this.clearAll = false, this.baseSettings,Key key});

  @override
  PersonalState createState() => PersonalState();
}

class PersonalState extends State<Personal> {
  var isSelected = false;
  var mycolor = Colors.white;
  List<BaseSettings> _baseSettingsList = [];
  dynamic _matchMakerModel;

  //MatchMakerModel _matchMakerModel;
  bool _isAgeChecked = false;
  bool _newAgechecked = false;
  bool isGeneral = false, isCouple = false, isPlace = false;
  bool _isHeightChecked = false;
  bool _isWeightChecked = false;
  bool _isBodyChecked = false;
  BaseSettings baseSettings = BaseSettings(options: []);
  bool _isComplexionChecked = false;
  bool _isMaritalChecked = false;
  WrapItem _marital = WrapItem();
  WrapItem _bodyTypeWidget = WrapItem();
  WrapItem _complexionWidget = WrapItem();
  List<WrapItem> maritalStatus = [];
  List<WrapItem> bodyTypeItems = [];
  List<WrapItem> complexionItems = [];
  CounterBloc _counterController = CounterBloc();
  int count = 0;

  void toggleSelection() {
    setState(() {
      if (isSelected) {
        mycolor = Colors.white;
        isSelected = false;
      } else {
        mycolor = Colors.grey;
        isSelected = true;
      }
    });
  }

  late BaseSettings bodyTypeList, complexTypeList, maritalStatusList;

  @override
  void didChangeDependencies() {
    _counterController = MatchMakerProvider.of(context)!.counterBloc;
    _baseSettingsList = MatchMakerProvider.of(context)!.baseSettings;
    _matchMakerModel = MatchMakerProvider.of(context)!.matchMakerModel;
    if (_matchMakerModel.userId == null) {
      print("Matchmaker : $_matchMakerModel");
    }
    maritalStatus = [];
    bodyTypeItems = [];
    complexionItems = [];
    print("PersonalFilter didChangeDependencies()");
    if (widget.isGeneral != MakerTab.COUPLE &&
        _matchMakerModel.heightMax > 0 &&
        _matchMakerModel.heightMin > 0)
      _isHeightChecked =
          MatchMakerProvider.of(context)!.chkMaxFilterReached(true);

    if (widget.isGeneral == MakerTab.GENERAL &&
        _matchMakerModel.weightMax > 0 &&
        _matchMakerModel.weightMin > 0)
      _isWeightChecked =
          MatchMakerProvider.of(context)!.chkMaxFilterReached(true);

    //body type
    MatchMakerProvider.of(context)!.setPersonalDetails(
      listItems: bodyTypeItems,
      type: CoupledStrings.baseSettingsBodyType,
      isChecked: (isChecked) {
        if (isChecked && widget.isGeneral == MakerTab.GENERAL)
          // _counterController.add(CounterEvent(_isBodyChecked = true));
          _isBodyChecked =
              MatchMakerProvider.of(context)!.chkMaxFilterReached(true);
      },
      matchmaker: _matchMakerModel,
      baseSettings: _baseSettingsList,
    );
    //complexion
    MatchMakerProvider.of(context)!.setPersonalDetails(
      listItems: complexionItems,
      type: CoupledStrings.baseSettingsComplexion,
      isChecked: (bool isChecked) {
        if (isChecked && widget.isGeneral == MakerTab.GENERAL)
          _isComplexionChecked =
              MatchMakerProvider.of(context)!.chkMaxFilterReached(true);
      },
      matchmaker: _matchMakerModel,
      baseSettings: _baseSettingsList,
    );
    //marital status
    MatchMakerProvider.of(context)!.setPersonalDetails(
      listItems: maritalStatus,
      type: CoupledStrings.baseSettingsMaritalStatus,
      isChecked: (isChecked) {
        if (isChecked && widget.isGeneral != MakerTab.COUPLE)
          _isMaritalChecked =
              MatchMakerProvider.of(context)!.chkMaxFilterReached(true);
      },
      matchmaker: _matchMakerModel,
      baseSettings: _baseSettingsList,
    );
    maritalStatus
        .removeWhere((element) => element.title.toLowerCase() == "married");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _counterController.close();
    super.dispose();
  }

  @override
  void initState() {
    _marital = WrapItem.initial();
    _bodyTypeWidget = WrapItem.initial();
    _complexionWidget = WrapItem.initial();
    //_matchMakerModel = _matchMakerModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      //_globalKey.currentState.getPersonalDetails();

      switch (widget.isGeneral) {
        case MakerTab.COUPLE:
          isGeneral = false;
          isCouple = false;
          isPlace = true;
          break;
        case MakerTab.MIX:
          isGeneral = false;
          isCouple = true;
          isPlace = false;
          break;
        default:
          isGeneral = true;
          isCouple = true;
          isPlace = false;
          break;
      }
    });
    return BlocListener<CounterBloc, CounterState>(
      bloc: _counterController,
      listener: (context, state) {
        print("StateClear : $state");
        if (state is CounterClearAll) {
          _isHeightChecked = _isWeightChecked =
              _isBodyChecked = _isComplexionChecked = _isMaritalChecked = false;
          _matchMakerModel.ageMin = 20;
          _matchMakerModel.ageMax = 27;
          _matchMakerModel.weightMin = 0;
          _matchMakerModel.weightMax = 0;
          _matchMakerModel.heightMin = 0;
          _matchMakerModel.heightMax = 0;
          _matchMakerModel.bodyType.clear();
          bodyTypeItems.forEach((data) {
            if (data.isSelected) {
              data.isSelected = false;
            }
          });
          _matchMakerModel.complexion.clear();
          complexionItems.forEach((data) {
            if (data.isSelected) {
              data.isSelected = false;
            }
          });
          _matchMakerModel.maritalStatus.clear();
          maritalStatus.forEach((data) {
            if (data.isSelected) {
              data.isSelected = false;
            }
          });
          print("MATCHMAKERMODEL : $_matchMakerModel");
          setState(() {});
        }
      },
      child: Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomCheckBox(
                          value: true,
                          text: "Age",
                          textSize: 16.0,
                          onChanged: (value) {
                            setState(() {});
                          },
                          secondary: SizedBox(),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          child: TextView(
                              '${_matchMakerModel.ageMin.round() > 0 ? _matchMakerModel.ageMin.round() : 20} - ${_matchMakerModel.ageMax.round() > 0 ? _matchMakerModel.ageMax.round() : 25} yrs',
                              size: 18.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RangeSlider(
                      values: RangeValues(
                          _matchMakerModel.ageMin.roundToDouble() > 0
                              ? _matchMakerModel.ageMin.roundToDouble()
                              : 20,
                          _matchMakerModel.ageMax.roundToDouble() > 0
                              ? _matchMakerModel.ageMax.roundToDouble()
                              : 27),
                      min: 18,
                      max: 60,
                      activeColor: Colors.white,
                      inactiveColor: CoupledTheme().primaryPinkDark,
                      labels: RangeLabels(
                          "${_matchMakerModel.ageMin > 0 ? _matchMakerModel.ageMin : 20}",
                          "${_matchMakerModel.ageMax > 0 ? _matchMakerModel.ageMax : 27}"),
                      onChanged: (_value) {
                        setState(
                          () {
                            _matchMakerModel.ageMin = _value.start.round();
                            _matchMakerModel.ageMax = _value.end.round();
                          },
                        );
                      },
                    ),
                    Visibility(
                        visible: false,
                        child: Place(
                          isCoupled: true,
                        )),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Visibility(
                  visible: isCouple,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomCheckBox(
                            enabled: _isHeightChecked,
                            value: _isHeightChecked,
                            text: "Height",
                            textSize: 16.0,
                            onChanged: (value) {
                              setState(() {
                                if (!value!) {
                                  _isHeightChecked =
                                      MatchMakerProvider.of(context)!
                                          .chkMaxFilterReached(false);
                                  print("mach");
                                  print(_isHeightChecked);
                                  _matchMakerModel.heightMax =
                                      _matchMakerModel.heightMax = 0;
                                }
//                                  _counterController.add(CounterEvent(_isHeightChecked));
                              });
                            },
                            secondary: SizedBox(),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            child: TextView(
                                '${_matchMakerModel.heightMin > 0 ? _matchMakerModel.heightMin : 145} - '
                                '${_matchMakerModel.heightMax > 0 ? _matchMakerModel.heightMax : 172} cm',
                                size: 18.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RangeSlider(
                          values: RangeValues(
                              _matchMakerModel.heightMin.roundToDouble() > 0
                                  ? _matchMakerModel.heightMin.roundToDouble()
                                  : 145,
                              _matchMakerModel.heightMax.roundToDouble() > 0
                                  ? _matchMakerModel.heightMax.roundToDouble()
                                  : 172),
                          min: 90.0,
                          max: 231.0,
                          activeColor: Colors.white,
                          inactiveColor: CoupledTheme().primaryPinkDark,
                          labels: RangeLabels(
                              "${_matchMakerModel.heightMin > 0 ? _matchMakerModel.heightMin : 145}",
                              "${_matchMakerModel.heightMax > 0 ? _matchMakerModel.heightMax : 172}"),
                          onChanged: (_value) {
                            setState(() {
                              if (!_isHeightChecked) {
                                _isHeightChecked =
                                    MatchMakerProvider.of(context)!
                                        .chkMaxFilterReached(true);
                              }
                              if (_isHeightChecked) {
                                _matchMakerModel.heightMin =
                                    _value.start.round();
                                _matchMakerModel.heightMax = _value.end.round();
                              }
                            });
                          })
                    ],
                  ),
                ),
                Visibility(
                  visible: isGeneral,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomCheckBox(
                            enabled: _isWeightChecked,
                            value: _isWeightChecked,
                            text: "Weight",
                            textSize: 16.0,
                            onChanged: (value) {
                              setState(() {
                                if (!value!) {
                                  _isWeightChecked =
                                      MatchMakerProvider.of(context)!
                                          .chkMaxFilterReached(false);
                                  _matchMakerModel.weightMin =
                                      _matchMakerModel.weightMax = 0;
                                }
//                                  _counterController.add(CounterEvent(_isWeightChecked));
                              });
                            },
                            secondary: SizedBox(),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            child: TextView(
                                '${_matchMakerModel.weightMin > 0 ? _matchMakerModel.weightMin : 45} '
                                '- ${_matchMakerModel.weightMax > 0 ? _matchMakerModel.weightMax : 75} kg',
                                size: 18.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RangeSlider(
                          values: RangeValues(
                              _matchMakerModel.weightMin.roundToDouble() > 0
                                  ? _matchMakerModel.weightMin.roundToDouble()
                                  : 45,
                              _matchMakerModel.weightMax.roundToDouble() > 0
                                  ? _matchMakerModel.weightMax.roundToDouble()
                                  : 75),
                          min: 20.0,
                          max: 200.0,
                          activeColor: Colors.white,
                          inactiveColor: CoupledTheme().primaryPinkDark,
                          labels: RangeLabels(
                              "${_matchMakerModel.weightMin > 0 ? _matchMakerModel.weightMin : 45}",
                              "${_matchMakerModel.weightMax > 0 ? _matchMakerModel.weightMax : 75}"),
                          onChanged: (_value) {
                            setState(() {
                              if (!_isWeightChecked) {
                                _isWeightChecked =
                                    MatchMakerProvider.of(context)!
                                        .chkMaxFilterReached(true);
//                                  _counterController.add(CounterEvent(_isWeightChecked));
                              }
                              if (_isWeightChecked) {
                                _matchMakerModel.weightMin =
                                    _value.start.round();
                                _matchMakerModel.weightMax = _value.end.round();
                              }
                            });
                          }),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomCheckBox(
                            enabled: _isBodyChecked,
                            value: _isBodyChecked,
                            text: "Body Type",
                            textSize: 16.0,
                            onChanged: (value) {
                              setState(() {
                                if (!value!)
                                  _isBodyChecked =
                                      MatchMakerProvider.of(context)!
                                          .chkMaxFilterReached(value);
                                if (!_isBodyChecked) {
                                  bodyTypeItems.forEach((item) {
                                    item.isSelected = false;
                                  });
                                  _matchMakerModel.bodyType.clear();
                                }
                              });
                            },
                            secondary: SizedBox(),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.0, left: 5.0),
                        child: _bodyTypeWidget.generateItem(
                          bodyTypeItems,
                          onTap: (i) {
                            setState(() {
                              if (!_isBodyChecked) {
                                bodyTypeItems[i].isSelected = _isBodyChecked =
                                    MatchMakerProvider.of(context)!
                                        .chkMaxFilterReached(
                                            !bodyTypeItems[i].isSelected);
                              } else {
                                bodyTypeItems[i].isSelected =
                                    !bodyTypeItems[i].isSelected;
                              }
                              if (_isBodyChecked) {
                                bodyTypeItems[i].isSelected
                                    ? _matchMakerModel.bodyType
                                        .add(bodyTypeItems[i].id)
                                    : _matchMakerModel.bodyType
                                        .remove(bodyTypeItems[i].id);
                                if (_matchMakerModel.bodyType.isEmpty) {
                                  _isBodyChecked =
                                      MatchMakerProvider.of(context)!
                                          .chkMaxFilterReached(false);
                                  _matchMakerModel.bodyType.clear();
                                }
                              }
                              print(_matchMakerModel.bodyType.length);
                            });
                          },
                          valueGetter: () {
                            return false;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      CustomCheckBox(
                        enabled: _isComplexionChecked,
                        value: _isComplexionChecked,
                        text: "Complexion",
                        textSize: 16.0,
                        onChanged: (value) {
                          setState(() {
                            if (!value!) {
                              _isComplexionChecked =
                                  MatchMakerProvider.of(context)!
                                      .chkMaxFilterReached(value);
                              if (!_isComplexionChecked) {
                                complexionItems.forEach((item) {
                                  item.isSelected = false;
                                });
                                _matchMakerModel.complexion.clear();
                              }
                            }
                          });
                        },
                        secondary: const SizedBox(),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15.0, left: 5.0),
                        child: _complexionWidget.generateItem(
                          complexionItems,
                          onTap: (i) {
                            setState(() {
                              if (!_isComplexionChecked) {
                                complexionItems[i].isSelected =
                                    _isComplexionChecked =
                                        MatchMakerProvider.of(context)!
                                            .chkMaxFilterReached(
                                                !complexionItems[i].isSelected);
                              } else {
                                complexionItems[i].isSelected =
                                    !complexionItems[i].isSelected;
                              }
                              if (_isComplexionChecked) {
                                complexionItems[i].isSelected
                                    ? _matchMakerModel.complexion
                                        .add(complexionItems[i].id)
                                    : _matchMakerModel.complexion
                                        .remove(complexionItems[i].id);
                                if (_matchMakerModel.complexion.isEmpty) {
                                  _isComplexionChecked =
                                      MatchMakerProvider.of(context)!
                                          .chkMaxFilterReached(false);
                                  _matchMakerModel.complexion.clear();
                                }
                              }
                            });
                          },
                          valueGetter: () {
                            return false;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Visibility(
                  visible: isCouple,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomCheckBox(
                            enabled: _isMaritalChecked,
                            value: _isMaritalChecked,
                            text: "Marital status",
                            textSize: 16.0,
                            onChanged: (value) {
                              setState(() {
                                if (!value!)
                                  _isMaritalChecked =
                                      MatchMakerProvider.of(context)!
                                          .chkMaxFilterReached(value);
                                if (!_isMaritalChecked) {
                                  maritalStatus.forEach((item) {
                                    item.isSelected = false;
                                  });
                                  _matchMakerModel.maritalStatus.clear();
                                }
                              });
                            },
                            secondary: SizedBox(),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.0, left: 5.0),
                        child: _marital.generateItem(
                          maritalStatus,
                          onTap: (i) {
                            setState(() {
                              if (!_isMaritalChecked)
                                maritalStatus[i].isSelected =
                                    _isMaritalChecked =
                                        MatchMakerProvider.of(context)!
                                            .chkMaxFilterReached(
                                                !maritalStatus[i].isSelected);
                              else {
                                maritalStatus[i].isSelected =
                                    !maritalStatus[i].isSelected;
                              }
                              if (_isMaritalChecked) {
                                /*    if (maritalStatus[i].isSelected &&
                                    maritalStatus[i].title.toLowerCase() != "bachelor") {
                                  maritalStatus.forEach((element) {
                                    if (element.title.toLowerCase() != "bachelor") {
                                      element.isSelected = true;
                                      if (!_matchMakerModel.maritalStatus.contains(element.id))
                                        _matchMakerModel.maritalStatus.add(element.id);
                                    }
                                  });
                                  print("martal :: ${_matchMakerModel.maritalStatus}");
                                }*/

                                maritalStatus[i].isSelected
                                    ? _matchMakerModel.maritalStatus
                                        .add(maritalStatus[i].id)
                                    : _matchMakerModel.maritalStatus
                                        .remove(maritalStatus[i].id);
                                if (_matchMakerModel.maritalStatus.isEmpty) {
                                  _isMaritalChecked =
                                      MatchMakerProvider.of(context)!
                                          .chkMaxFilterReached(false);
                                  _matchMakerModel.maritalStatus.clear();
                                }
                              }
                            });
                          },
                          valueGetter: () {
                            return false;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
