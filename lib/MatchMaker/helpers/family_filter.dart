import 'package:coupled/MatchMaker/bloc/match_maker_bloc.dart';
import 'package:coupled/MatchMaker/match_maker_page.dart';
import 'package:coupled/MatchMaker/match_maker_provider.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/match_maker_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Family extends StatefulWidget {
  final MakerTab isGeneral;

  const Family({Key? key, required this.isGeneral}) : super(key: key);

  @override
  _FamilyState createState() => _FamilyState();
}

class _FamilyState extends State<Family> {
  WrapItem _familyType = WrapItem();
  WrapItem _familyValue = WrapItem();
  List<WrapItem> familyTypes = [];
  List<WrapItem> familyValues = [];
  bool _isFamilyType = false;
  bool _isFamilyValue = false;
  List<BaseSettings> _baseSettingsList = [];
  dynamic _matchMakerModel;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  CounterBloc _counterBloc = CounterBloc();
  bool maxFilterReached = false;

  @override
  void didChangeDependencies() {
    maxFilterReached = MatchMakerProvider.of(context)!.maxFilterReached;
    _counterBloc = MatchMakerProvider.of(context)!.counterBloc;
    _baseSettingsList = MatchMakerProvider.of(context)!.baseSettings;
    _matchMakerModel = MatchMakerProvider.of(context)!.matchMakerModel;
    if (_matchMakerModel == null) {
      _matchMakerModel = MatchMakerModel.initial();
      print("Matchmaker : $_matchMakerModel");
    }
    familyTypes = [];
    familyValues = [];
    //family type
    MatchMakerProvider.of(context)!.setPersonalDetails(
      listItems: familyTypes,
      type: CoupledStrings.baseSettingsFamilyType,
      matchmaker: _matchMakerModel,
      isChecked: (value) {
        // if (value) _counterBloc.add(CounterEvent(_isFamilyType = true));
        if (value && widget.isGeneral == MakerTab.GENERAL)
          _isFamilyType =
              MatchMakerProvider.of(context)!.chkMaxFilterReached(value);
      },
      baseSettings: _baseSettingsList,
    );
    //family value
    MatchMakerProvider.of(context)!.setPersonalDetails(
      listItems: familyValues,
      type: CoupledStrings.baseSettingsFamilyValue,
      matchmaker: _matchMakerModel,
      isChecked: (value) {
        if (value && widget.isGeneral == MakerTab.GENERAL)
          _isFamilyValue =
              MatchMakerProvider.of(context)!.chkMaxFilterReached(value);
        // _counterBloc.add(CounterEvent(_isFamilyValue = true));
      },
      baseSettings: _baseSettingsList,
    );
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _familyType = WrapItem.initial();
    _familyValue = WrapItem.initial();
//    _matchMakerModel= _matchMakerModel;

    super.initState();
  }

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _counterBloc,
      listener: (context, state) {
        if (state is CounterClearAll) {
          setState(() {
            _isFamilyType = _isFamilyValue = false;
            familyTypes.forEach((f) => f.isSelected = false);
            familyValues.forEach((f) => f.isSelected = false);
            _matchMakerModel.familyValues.clear();
            _matchMakerModel.familyType.clear();
          });
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: CoupledTheme().backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomCheckBox(
                enabled: _isFamilyType,
                value: _isFamilyType,
                text: "Family Type",
                textSize: 18.0,
                onChanged: (value) {
                  setState(() {
                    if (!value!)
                      _isFamilyType = MatchMakerProvider.of(context)!
                          .chkMaxFilterReached(value);

                    /* if (value && !maxFilterReached) {
	                      _counterBloc.add(CounterEvent(true));
                    } else {
                      _counterBloc.add(CounterEvent(false));
                    }*/
                    if (!_isFamilyType) {
                      familyTypes.forEach((item) {
                        item.isSelected = false;
                      });
                      _matchMakerModel.familyType.clear();
                    }
                  });
                },
                secondary: SizedBox(),
              ),
              SizedBox(
                height: 15.0,
              ),
              _familyType.generateItem(familyTypes, onTap: (index) {
                setState(() {
                  if (!_isFamilyType) {
                    familyTypes[index].isSelected = _isFamilyType =
                        MatchMakerProvider.of(context)!.chkMaxFilterReached(
                            !familyTypes[index].isSelected);
                  } else
                    familyTypes[index].isSelected =
                        !familyTypes[index].isSelected;

                  if (_isFamilyType) {
                    familyTypes[index].isSelected
                        ? _matchMakerModel.familyType.add(familyTypes[index].id)
                        : _matchMakerModel.familyType
                            .remove(familyTypes[index].id);
                    if (_matchMakerModel.familyType.isEmpty) {
                      _isFamilyType = MatchMakerProvider.of(context)!
                          .chkMaxFilterReached(false);
                      _matchMakerModel.familyType.clear();
                    }
                  }
                });
              }, valueGetter: () {
                return false;
              }),
              SizedBox(
                height: 15.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomCheckBox(
                    enabled: _isFamilyValue,
                    value: _isFamilyValue,
                    text: "Family Value",
                    textSize: 18.0,
                    onChanged: (value) {
                      setState(() {
                        if (!value!)
                          _isFamilyValue = MatchMakerProvider.of(context)!
                              .chkMaxFilterReached(value);
                        /* if (!maxFilterReached && value) {
                          _isFamilyValue = value;
                          _counterBloc.add(CounterEvent(_isFamilyValue));
                        } else {
                          _counterBloc.add(CounterEvent(true));
                        }*/
                        if (!_isFamilyValue) {
                          familyValues.forEach((item) {
                            item.isSelected = false;
                          });
                          _matchMakerModel.familyValues.clear();
                        }
                      });
                    },
                    secondary: SizedBox(),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              _familyValue.generateItem(
                familyValues,
                onTap: (i) {
                  setState(() {
                    if (!_isFamilyValue) {
                      familyValues[i].isSelected = _isFamilyValue =
                          MatchMakerProvider.of(context)!
                              .chkMaxFilterReached(!familyValues[i].isSelected);
                    } else
                      familyValues[i].isSelected = !familyValues[i].isSelected;

                    if (_isFamilyValue) {
                      familyValues[i].isSelected
                          ? _matchMakerModel.familyValues
                              .add(familyValues[i].id)
                          : _matchMakerModel.familyValues
                              .remove(familyValues[i].id);
                      if (_matchMakerModel.familyValues.isEmpty) {
                        _isFamilyValue = MatchMakerProvider.of(context)!
                            .chkMaxFilterReached(false);
                        _matchMakerModel.familyValues.clear();
                      }
                    }
                  });
                },
                valueGetter: () {
                  return false;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
