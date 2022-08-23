import 'package:coupled/MatchMaker/bloc/match_maker_bloc.dart';
import 'package:coupled/MatchMaker/match_maker_provider.dart';
import 'package:coupled/Utils/Modals/SMC/smc_bloc.dart';
import 'package:coupled/Utils/Modals/SMC/smc_widget.dart';
import 'package:coupled/Utils/dynamic_tree_view.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/match_maker_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Place extends StatefulWidget {
  final bool isCoupled;

  const Place({Key? key, this.isCoupled = false}) : super(key: key);

  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  SmcBloc _smcBloc = SmcBloc();
  bool hideBackButton = true, _isLocations = false;
  late PageController pageController;
  dynamic _matchMakerModel;
  List<Item> _country = [], _state = [], _city = [];
  CounterBloc _counterBloc = CounterBloc();

//  List<BaseData> _baseData = List();

  TreeViewController _dynamicController = TreeViewController();

  @override
  void didChangeDependencies() {
    _country = [];
    _state = [];
    _city = [];
    _dynamicController.removeAllData();
    _matchMakerModel = MatchMakerProvider.of(context)!.matchMakerModel;
    _counterBloc = MatchMakerProvider.of(context)!.counterBloc;
    if (_matchMakerModel.country != null && _matchMakerModel.country.length > 0)
      _isLocations = MatchMakerProvider.of(context)!.chkMaxFilterReached(true);
    print("ISLOcation : $_isLocations");
    _smcBloc = SmcBloc();
    _smcBloc.add(SMCParams());

    super.didChangeDependencies();
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, keepPage: false);
    super.initState();
  }

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: _counterBloc,
          listener: (context, state) {
            if (state is CounterClearAll) {
              setState(() {
                _isLocations = false;
                _dynamicController.removeAllData();
                _state.clear();
                _city.clear();
                _country.forEach((item) {
                  item.isSelected = false;
                });
                _matchMakerModel.country.clear();
                _matchMakerModel.state.clear();
                _matchMakerModel.city.clear();
              });
            }
          },
        ),
        BlocListener(
          bloc: _smcBloc,
          listener: (context, snapshot) {
            if (snapshot is SmcCountry) {
              setState(() {
                _country = snapshot.countries;
                var data = _country.where((item) =>
                    _matchMakerModel.country.contains(item.code) &&
                    !item.isSelected);
                for (var values in data.toList()) {
                  values.isSelected = true;
                  _dynamicController.addBaseData(DataModel(
                      id: ObjectKey(values.code),
                      name: values.name,
                      parentId: "0"));
                  _smcBloc
                      .add(SMCParams(type: 'state', countryCode: values.code));
                }
                print("CountriesListener : $data");
              });
            }
            if (snapshot is SmcStates) {
              setState(() {
                _state.addAll(snapshot.states);
                var data = _state.where((item) =>
                    _matchMakerModel.state.contains(item.name) &&
                    !item.isSelected);
                for (var values in data) {
                  values.isSelected = true;
                  _dynamicController.addBaseData(DataModel(
                      id: ObjectKey(values.name),
                      name: values.name,
                      extras: {"innerParent": true},
                      parentId: ObjectKey(values.code)));
                  _smcBloc.add(SMCParams(type: 'city', stateCode: values.name));
                }
                print("StateListener :: $_state");
              });
            }
            if (snapshot is SmcCity) {
              setState(() {
                _city.addAll(snapshot.cities);
                List<Item> data = _city
                    .where((item) =>
                        _matchMakerModel.city.contains(item.name) &&
                        !item.isSelected)
                    .toList();
                print("CityListener :: $data");
                for (var values in data) {
                  values.isSelected = true;
                  _dynamicController.addBaseData(DataModel(
                      id: ObjectKey(values.name),
                      name: values.name,
                      parentId: ObjectKey(values.code)));
                }
              });
            }
          },
        )
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomCheckBox(
                    enabled: _isLocations,
                    value: _isLocations,
                    text: "Places",
                    textSize: 18.0,
                    onChanged: (value) {
                      setState(() {
                        if (!value!)
                          _isLocations = MatchMakerProvider.of(context)!
                              .chkMaxFilterReached(value);
                        if (!_isLocations) {
                          _state.clear();
                          _city.clear();
                          _country.forEach((item) {
                            item.isSelected = false;
                          });
                          _matchMakerModel.country.clear();
                          _matchMakerModel.state.clear();
                          _matchMakerModel.city.clear();
                          _dynamicController.removeAllData();
                        }
                      });
                    },
                    secondary: SizedBox(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: GestureDetector(
                      onTap: () {
                        if (!_isLocations) {
                          _isLocations = MatchMakerProvider.of(context)!
                              .chkMaxFilterReached(true);
                        }
                        if (_isLocations) {
                          if (!_country[0].isSelected) {
                            _country[0].isSelected = true;
                            _dynamicController.addBaseData(DataModel(
                                id: ObjectKey(_country[0].code),
                                name: _country[0].name,
                                parentId: "0"));
                            _matchMakerModel.country.add(_country[0].code);
                            _smcBloc.add(SMCParams(
                                type: 'state', countryCode: _country[0].code));
                          }
                          _modalBottomSheetMenu(context, page: 0);
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 8.0),
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: TextView(
                            "Add",
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                ],
              ),
              TreeView(
                controller: _dynamicController,
                config: Config(
                    parentTextStyle: TextStyle(
                        color: Colors.blue[700], fontWeight: FontWeight.bold),
                    innerParentTextStyle: TextStyle(
                        color: Colors.blue[300], fontWeight: FontWeight.w600),
                    childrenTextStyle: TextStyle(
                        color: Colors.blue[100], fontWeight: FontWeight.normal),
                    rootId: "0",
                    arrowIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    parentPaddingEdgeInsets:
                        EdgeInsets.only(left: 16, top: 0, bottom: 0)),
                onDelete: deleteData,
                width: MediaQuery.of(context).size.width * .68,
              ),
            ],
          ),
        ),
      ),
    ) /*buildUp(widget.isCoupled)*/;
  }

  void _modalBottomSheetMenu(BuildContext mainContext, {required int page}) {
    hideBackButton = true;
    showBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Theme(
                data: CoupledTheme()
                    .coupledTheme2()
                    .copyWith(unselectedWidgetColor: Colors.black),
                child: Stack(
                  children: <Widget>[
                    PageView(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        /*BlocBuilder<SmcBloc, SmcState>(
                            cubit: _smcBloc,
                            builder: (context, snapshot) {
                              if (snapshot is SmcLoading && snapshot.extras == 'country') {
                                return GlobalWidgets().showCircleProgress();
                              }

                              return SMCWidget(
                                title: "Country",
                                multipleChoice: true,
                                items: _country,
                                selectedItem: (isChecked, values) {
                                  if (values is Item)
                                    setState(() {
                                      print("country : $values");
                                      if (!_isLocations)
                                        _isLocations = MatchMakerProvider.of(mainContext).chkMaxFilterReached(true);
                                      if (_isLocations) {
                                        _country.singleWhere((test) => test == values).isSelected = isChecked;

                                        if (isChecked) {
                                          _dynamicController.addBaseData(
                                              DataModel(id: ObjectKey(values.code), name: values.name, parentId: "0"));
                                          _matchMakerModel.country.add(values.code);
                                          _smcBloc.add(SMCParams(type: 'state', countryCode: values.code));
                                        } else {
                                          deleteData(
                                              DataModel(id: ObjectKey(values.code), name: values.name, parentId: "0"));
                                          if (_matchMakerModel.country.isEmpty) {
                                            _isLocations =
                                                MatchMakerProvider.of(mainContext).chkMaxFilterReached(false);
                                          }
                                        }
                                      }
                                    });
                                },
                              );
                            }),*/
                        BlocBuilder<SmcBloc, SmcState>(
                            bloc: _smcBloc,
                            builder: (context, snapshot) {
                              if (snapshot is SmcLoading &&
                                  snapshot.extras == 'state') {
                                return GlobalWidgets().showCircleProgress();
                              }
                              return SMCWidget(
                                title: "State",
                                parentTitle: true,
                                multipleChoice: true,
                                items: _state,
                                selectedItem: (isChecked, values) {
                                  if (values is Item) {
                                    setState(() {
                                      _state
                                          .singleWhere((test) => test == values)
                                          .isSelected = isChecked;

//                                      _city = List();
                                      if (isChecked) {
                                        _dynamicController.addBaseData(
                                            DataModel(
                                                id: ObjectKey(values.name),
                                                name: values.name,
                                                extras: {"innerParent": true},
                                                parentId:
                                                    ObjectKey(values.code)));

                                        _matchMakerModel.state.add(values.name);
                                        print("jil");
                                        print(values.name);
                                        _smcBloc.add(SMCParams(
                                            type: 'city',
                                            stateCode: values.name));
                                      } else {
                                        deleteData(DataModel(
                                            id: ObjectKey(values.name),
                                            name: values.name,
                                            extras: {"innerParent": true},
                                            parentId: ObjectKey(values.code)));
                                      }
                                      print(
                                          "State ::: ${_matchMakerModel.state.toString().substring(1, _matchMakerModel.state.toString().length - 1)}");
                                    });
                                  }
                                },
                                errorWidget: SizedBox(),
                              );
                            }),
                        BlocBuilder<SmcBloc, SmcState>(
                            bloc: _smcBloc,
                            builder: (context, snapshot) {
                              if (snapshot is SmcLoading &&
                                  snapshot.extras == 'city') {
                                return GlobalWidgets().showCircleProgress();
                              }
                              print("cityValues ${_city.length}");
                              return SMCWidget(
                                title: "City",
                                parentTitle: true,
                                multipleChoice: true,
                                items: _city,
                                selectedItem: (isChecked, values) {
                                  setState(() {
                                    _city
                                        .singleWhere((test) => test == values)
                                        .isSelected = isChecked;

                                    if (isChecked) {
                                      _dynamicController.addBaseData(DataModel(
                                          id: ObjectKey(values.name),
                                          name: values.name,
                                          extras: {"innerParent": false},
                                          parentId: ObjectKey(values.code)));
                                      _matchMakerModel.city.add(values.name);
                                    } else {
                                      deleteData(DataModel(
                                          id: ObjectKey(values.name),
                                          name: values.name,
                                          extras: {"innerParent": false},
                                          parentId: ObjectKey(values.code)));
                                    }
                                  });
                                },
                                errorWidget: SizedBox(),
                              );
                            }),
                      ],
                      onPageChanged: (index) {
                        setState(() {
                          hideBackButton = pageController.page!.round() == 0;
                          print("pageD ${pageController.page} $hideBackButton");
                        });
                      },
                    ),
                    Align(
                      alignment: Alignment(0, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Visibility(
                              visible: !hideBackButton,
                              child: InkWell(
                                onTap: () {
                                  if (pageController.page!.round() > 0) {
                                    pageController.previousPage(
                                        duration: Duration(milliseconds: 350),
                                        curve: Curves.easeInOut);
                                  }
                                  setState(() {
                                    print("country on page change $_country");
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: CoupledTheme().primaryPinkDark),
                                    child: TextView(
                                      "Back",
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.center,
                                      size: 14,
                                      textScaleFactor: .8,
                                    )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (pageController.page!.round() < 1) {
                                  pageController.nextPage(
                                      duration: Duration(milliseconds: 350),
                                      curve: Curves.easeInOut);
                                } else {
                                  Navigator.pop(context);
                                }
                                setState(() {
                                  print("country on page change $_country");
                                });
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: CoupledTheme().primaryPinkDark),
                                  child: TextView(
                                    "Next",
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    size: 14,
                                    textScaleFactor: .8,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  deleteData(BaseData item) {
    setState(() {
      Item country, state, city;

      ///if item deleted is country
      country = _country.singleWhere(
        (test) => test.name == item.getTitle(),
      );
      if (country != null) {
        country.isSelected = false;
        _matchMakerModel.country.removeWhere((test) => test == country.code);
        _state.removeWhere((element) {
          if (element.parentId == country.parentId) {
            _matchMakerModel.state.removeWhere(
                (matchmakerElement) => matchmakerElement == element.name);
            _city.removeWhere((cityElement) {
              if (cityElement.parentId == element.parentId) {
                _matchMakerModel.city.removeWhere((matchmakerElement) =>
                    matchmakerElement == cityElement.name);
                return true;
              } else
                return false;
            });
            return true;
          }
          return false;
        });
      }

      ///if item deleted is state
      state = _state.singleWhere(
        (test) => test.name == item.getTitle(),
      );
      if (state != null) {
        _matchMakerModel.state.removeWhere((test) => test == state.name);
        state.isSelected = false;
        _city.removeWhere((cityElement) {
          if (cityElement.parentId == state.parentId) {
            _matchMakerModel.city.removeWhere(
                (matchmakerElement) => matchmakerElement == cityElement.name);
            return true;
          } else
            return false;
        });
      }

      ///if item deleted is city
      city = _city.singleWhere(
        (test) => test.name == item.getTitle(),
      );
      if (city != null) {
        city.isSelected = false;
        _matchMakerModel.city.removeWhere((test) => test == city.name);
      }
      print("DATA onDelete : $item");
      print("DATA onDelete : $country,$state,$city");

      _dynamicController.removeBaseData(item);
      if (_matchMakerModel.country.isEmpty) {
        _isLocations =
            MatchMakerProvider.of(context)!.chkMaxFilterReached(false);
      }
    });
  }
}
