import 'package:coupled/MatchMaker/bloc/match_maker_bloc.dart';
import 'package:coupled/MatchMaker/match_maker_provider.dart';
import 'package:coupled/Utils/Modals/SMC/smc_widget.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/dynamic_tree_view.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/match_maker_model.dart';
import 'package:coupled/registration_new/helpers/get_baseSettings.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReligionFilter extends StatefulWidget {
  const ReligionFilter({Key? key}) : super(key: key);

  @override
  _ReligionFilterState createState() => _ReligionFilterState();
}

class _ReligionFilterState extends State<ReligionFilter> {
  List<Item> _religion = [], _caste = [];
  List<BaseSettings> _baseSettingsList = [], casteBaseSettings = [];
  MatchMakerModel? _matchMakerModel;
  BaseSettings religionBaseSettings = BaseSettings(options: []);
  List<Item> selectedReligionList = [];
  bool _isReligion = false;
  CounterBloc _counterBloc = CounterBloc();

//  bool _isCaste = false;
  TreeViewController _dynamicController = TreeViewController();
  PageController pageController =
      PageController(initialPage: 1, keepPage: true);
  List<BaseData> initialBaseData = [];

  bool hideBackButton = true;

  @override
  void didChangeDependencies() {
    _religion = [];
    _caste = [];
    _dynamicController.removeAllData();
    _counterBloc = MatchMakerProvider.of(context)!.counterBloc;
    _baseSettingsList = GlobalData.baseSettings;
    _matchMakerModel = MatchMakerProvider.of(context)!.matchMakerModel;
    //religion
    MatchMakerProvider.of(context)!.setPersonalDetails(
      listItems: _religion,
      type: CoupledStrings.baseSettingsReligions,
      baseSettings: _baseSettingsList,
      isChecked: () {},
    );
    religionBaseSettings = getBaseSettingsByType(
        CoupledStrings.baseSettingsReligions, _baseSettingsList);
    _religion.removeAt(_religion
        .indexWhere((element) => element.name.toLowerCase() == "others"));

    ///Load previous data
    if (_matchMakerModel == null) {
      _matchMakerModel = MatchMakerModel.initial();
      print("Matchmaker initial : $_matchMakerModel");
    } else {
      if (_matchMakerModel!.matchType.toLowerCase() != "coupling_match" &&
          _matchMakerModel!.religion.length > 0) {
        _isReligion = MatchMakerProvider.of(context)!.chkMaxFilterReached(true);
        // _counterBloc.add(CounterEvent(_isReligion = true));
        List<Item> religion = _religion
            .where((test) => _matchMakerModel!.religion.contains(test.id))
            .toList();

        for (var values in religion) {
          values.isSelected = true;
          _dynamicController.addBaseData(
              DataModel(id: values.id, name: values.name, parentId: 0));
          print("CASTE::: ${getCaste(values)}");
          List<Item> caste = getCaste(values);

          for (var value in caste
              .where((test) => _matchMakerModel!.cast.contains(test.id))
              .toList()) {
            print("VALUE ::: $value");
            value.isSelected = true;
            _dynamicController.addBaseData(DataModel(
                id: value.id, name: value.name, parentId: value.parentId));
          }
          _caste.addAll(caste);
        }
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _counterBloc,
      listener: (context, state) {
        if (state is CounterClearAll) {
          setState(() {
            _isReligion = false;
            _dynamicController.removeAllData();
            _caste.clear();
            _religion.forEach((item) {
              item.isSelected = false;
            });
            _matchMakerModel!.religion.clear();
            _matchMakerModel!.cast.clear();
          });
        }
      },
      child: Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomCheckBox(
                      enabled: _isReligion,
                      value: _isReligion,
                      text: "Religion & Caste",
                      textSize: 18.0,
                      onChanged: (value) {
                        setState(() {
                          if (value!)
                            _isReligion = MatchMakerProvider.of(context)!
                                .chkMaxFilterReached(false);
                          if (!_isReligion) {
                            _dynamicController.removeAllData();
                            _religion.forEach((item) {
                              item.isSelected = false;
                            });
                            _caste.clear();
                            _matchMakerModel!.religion.clear();
                            _matchMakerModel!.cast.clear();
                          }
                        });
                      },
                      secondary: SizedBox(),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('religion:::$_religion');
                        _modalBottomSheetMenu(
                          context,
                          religionItem: _religion,
                          casteItem: _caste,
                          title: "Religion",
                        );
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
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          size: 12,
                          textScaleFactor: .8,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                TreeView(
                  width: MediaQuery.of(context).size.width * .68,
                  controller: _dynamicController,
                  initialValue: initialBaseData,
                  config: Config(
                      parentTextStyle: TextStyle(
                          color: Colors.blue[700], fontWeight: FontWeight.bold),
                      innerParentTextStyle: TextStyle(
                          color: Colors.blue[300], fontWeight: FontWeight.w600),
                      childrenTextStyle: TextStyle(
                          color: Colors.blue[100],
                          fontWeight: FontWeight.normal),
                      rootId: "0",
                      arrowIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      parentPaddingEdgeInsets:
                          EdgeInsets.only(left: 8, top: 0, bottom: 0)),
                  onDelete: deleteData,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu(
    BuildContext mainContext, {
    title,
    required List<Item> religionItem,
    required List<Item> casteItem,
  }) {
    hideBackButton = true;
    print("pageController :: ${pageController.hasClients}");
    print('Controller:::$pageController');
    showBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, _setState) {
              return Stack(
                children: <Widget>[
                  PageView(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      SMCWidget(
                        title: "Religion",
                        multipleChoice: true,
                        items: religionItem,
                        selectedItem: (isChecked, values) {
                          if (values is Item)
                            print("Religion : $isChecked $_isReligion $values");
                          if (!_isReligion) {
                            _isReligion = MatchMakerProvider.of(mainContext)!
                                .chkMaxFilterReached(true);
                          }
                          if (_isReligion) {
                            _religion
                                .singleWhere(
                                  (test) => test == values,
                                )
                                .isSelected = isChecked;
                            if (isChecked) {
                              _matchMakerModel!.religion.add(values.id);
                              _caste.addAll(getCaste(values));
                              _dynamicController.addBaseData(DataModel(
                                  id: values.id,
                                  name: values.name,
                                  parentId: "0"));
                            } else {
                              var _data = DataModel(
                                  id: values.id,
                                  name: values.name,
                                  parentId: "0");
                              print("_Data : $_data");
                              deleteData(_data);
                            }
                          }
                          print("caste : $_caste");
                          print(
                              "ObjectKey Religion : $_isReligion ${values.id}");
                          setState(() {});
                        },
                        errorWidget: SizedBox(),
                      ),
                      SMCWidget(
                        title: "Caste",
                        parentTitle: true,
                        multipleChoice: true,
                        items: _caste,
                        selectedItem: (isChecked, value) {
                          if (value is Item) {
                            setState(() {
                              print("Caste :: $isChecked :: $value");
                              print("ObjectKey Caste : ${value.parentId}");
                              _caste
                                  .singleWhere(
                                    (test) => test == value,
                                  )
                                  .isSelected = isChecked;
                              if (isChecked) {
                                _dynamicController.addBaseData(DataModel(
                                    id: value.id,
                                    name: value.name,
                                    parentId: value.parentId));
                                _matchMakerModel!.cast.add(value.id);
                              } else {
                                deleteData(DataModel(
                                    id: value.id,
                                    name: value.name,
                                    parentId: value.parentId.toString()));
                              }
                            });
                          }
                        },
                        errorWidget: SizedBox(),
                      ),
                    ],
                    onPageChanged: (index) {
                      setState(() {
                        hideBackButton = pageController.page!.round() == 0;
                        print("pageController :: ${pageController.hasClients}");
                        print(
                            "pageD ${pageController.page!.round() == 0} $hideBackButton");
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
                                /*   setState(() {
                                  print("Religion on page change $_religion");
                                });*/
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: CoupledTheme().primaryPinkDark),
                                  child: TextView(
                                    "Back",
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    size: 12,
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
                              /*       setState(() {
                                print("Religion on page change $_caste");
                              });*/
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
                                  size: 12,
                                  textScaleFactor: .8,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        });
  }

  List<Item> getCaste(Item parent) {
    List<BaseSettings>? options =
        getBaseSettingsOptionsByType(parent.name, religionBaseSettings.options);
    if (options!.length > 0)
      return Item().convertToItem(baseSettings: options, parentName: parent);
    return [];
  }

  deleteData(BaseData item) {
    setState(() {
      Item religion, caste;
      religion = _religion.singleWhere(
        (element) => element.name == item.getTitle(),
      );
      print("RELIGION : $religion");
      if (religion != null) {
        religion.isSelected = false;
        _matchMakerModel!.religion.removeWhere((value) => value == religion.id);
        _caste.removeWhere((element) {
          if (element.parentId == religion.id) {
            _matchMakerModel!.cast.removeWhere(
                (matchMakerElement) => matchMakerElement == element.id);
            return true;
          } else
            return false;
        });
      }

      caste = _caste.singleWhere(
        (element) => element.name == item.getTitle(),
      );
      if (caste != null) {
        caste.isSelected = false;
        _matchMakerModel!.cast.removeWhere((element) => element == caste.id);
      }
      print("DATA onDelete : $item");
      print("DATA onDelete : $religion, $caste");
      print("DATA onDelete : ${_matchMakerModel!.religion}");
      print("DATA onDelete : ${_matchMakerModel!.cast}");
      print("DATA onDelete : ${_matchMakerModel!.religion.isEmpty}");
      _dynamicController.removeBaseData(item);
      if (_matchMakerModel!.religion.isEmpty) {
        _isReligion =
            MatchMakerProvider.of(context)!.chkMaxFilterReached(false);
      }
    });
  }
}
