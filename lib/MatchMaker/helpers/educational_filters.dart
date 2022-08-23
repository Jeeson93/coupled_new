import 'package:coupled/MatchMaker/bloc/match_maker_bloc.dart';
import 'package:coupled/MatchMaker/match_maker_page.dart';
import 'package:coupled/MatchMaker/match_maker_provider.dart';
import 'package:coupled/Utils/Modals/SMC/smc_widget.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/match_maker_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EducationProfession extends StatefulWidget {
  final MakerTab isGeneral;

  const EducationProfession({Key? key, required this.isGeneral})
      : super(key: key);

  @override
  _EducationProfessionState createState() => _EducationProfessionState();
}

class _EducationProfessionState extends State<EducationProfession> {
  dynamic pageController;
  double minIncomeRange = 1, maxIncomRange = 2;
  bool isGeneral = false, isCouple = false;
  String _selectedYear = "Experience";
  WrapItem incomeRage = WrapItem(), yearRange = WrapItem();
  List<WrapItem> incomeRangeList = [];
  List<Item> professionType = [];
  List<Item> education = [];
  List<Item> experience = [];
  bool _isYearInJob = false;
  bool _isIncomeChecked = false;
  bool _isProfessionType = false;
  bool _isEducation = false;
  List<Widget> professionTypeWidget = [];
  List<Widget> educationWidget = [];
  List<Map<String, String>> experienceList = [];
  dynamic _matchMakerModel;
  CounterBloc _counterBloc = CounterBloc();
  List<BaseSettings> _baseSettings = [];

  @override
  void didChangeDependencies() {
    _baseSettings = MatchMakerProvider.of(context)!.baseSettings;
    _counterBloc = MatchMakerProvider.of(context)!.counterBloc;
    _matchMakerModel = MatchMakerProvider.of(context)!.matchMakerModel;
    incomeRangeList = [];
    professionType = [];
    education = [];
    experience = [];
    professionTypeWidget = [];
    educationWidget = [];
    experienceList = [];
    //income type
    MatchMakerProvider.of(context)!.setPersonalDetails(
      listItems: incomeRangeList,
      type: CoupledStrings.baseSettingsIncome,
      matchmaker: _matchMakerModel,
      isChecked: (value) {
        print("incomeRangeList value :: $value");
        if (value && widget.isGeneral == MakerTab.GENERAL) {
          _isIncomeChecked =
              MatchMakerProvider.of(context)!.chkMaxFilterReached(true);
          // _isIncomeChecked = value;
        }
      },
      baseSettings: _baseSettings,
    );
    //industry
    MatchMakerProvider.of(context)!.setPersonalDetails(
        listItems: professionType,
        type: CoupledStrings.baseSettingsIndustry,
        matchmaker: _matchMakerModel,
        baseSettings: _baseSettings,
        isChecked: (value) {
          print("professionType value :: $value");
          if (value && widget.isGeneral != MakerTab.COUPLE) {
            _isProfessionType =
                MatchMakerProvider.of(context)!.chkMaxFilterReached(true);
          }
        });
    //education
    MatchMakerProvider.of(context)!.setPersonalDetails(
        listItems: education,
        type: CoupledStrings.baseSettingsEdu,
        baseSettings: _baseSettings,
        matchmaker: _matchMakerModel,
        isChecked: (value) {
          print("education value :: $value");
          if (value && widget.isGeneral != MakerTab.COUPLE)
            _isEducation =
                MatchMakerProvider.of(context)!.chkMaxFilterReached(true);
        });
    //experience
    MatchMakerProvider.of(context)!.setPersonalDetails(
        listItems: experience,
        type: CoupledStrings.baseSettingsWorkXp,
        matchmaker: _matchMakerModel,
        baseSettings: _baseSettings,
        isChecked: (value) {
          print("experience value :: $value");
          if (value && widget.isGeneral == MakerTab.GENERAL)
            _isYearInJob =
                MatchMakerProvider.of(context)!.chkMaxFilterReached(true);
        });

    print("EXP : $experience");
    experience.forEach((f) {
      experienceList.add({
        'name': f.name != null ? f.name : '',
        'id': f.id != '' ? f.id.toString() : ''
      });
    });
    print("INCOME RANGE : $incomeRangeList");

    ///Pre Loaded Values
    _matchMakerModel.occupation.forEach((item) {
      Item data = professionType.singleWhere(
        (test) => test.id == item,
      );
      data.isSelected = true;
      print(data);
      updateProfessionType(true, data);
    });

    _matchMakerModel.education.forEach((item) {
      Item data = education.singleWhere(
        (test) => test.id == item,
      );
      data.isSelected = true;
      print("EDU data : $data");
      updateEducationType(true, data);
    });
    _isYearInJob = experienceList.singleWhere(
            (value) => value["id"] == _matchMakerModel.experience.toString(),
            orElse: (() => {})) !=
        null;
    if (_isYearInJob)
      _isYearInJob = MatchMakerProvider.of(context)!.chkMaxFilterReached(true);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    incomeRage = WrapItem.initial();
    yearRange = WrapItem.initial();
    switch (widget.isGeneral) {
      case MakerTab.COUPLE:
        isGeneral = true;
        isCouple = false;
        break;
      case MakerTab.MIX:
        isGeneral = false;
        isCouple = false;
        break;
      default:
        isGeneral = true;
        isCouple = true;
        break;
    }
    pageController = PageController(initialPage: 0, keepPage: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CounterBloc, CounterState>(
      bloc: _counterBloc,
      listener: (context, state) {
        if (state is CounterClearAll) {
          setState(() {
            _isYearInJob =
                _isIncomeChecked = _isProfessionType = _isEducation = false;
            incomeRangeList.forEach((f) => f.isSelected = false);
            _matchMakerModel.income.clear();
            professionType.forEach((f) => f.isSelected = false);
            professionTypeWidget = [];
            _matchMakerModel.occupation.clear();
            education.forEach((f) => f.isSelected = false);
            educationWidget = [];
            _matchMakerModel.education.clear();
            _matchMakerModel.experience = 0;
          });
        }
      },
      child: Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomCheckBox(
                      enabled: _isProfessionType,
                      value: _isProfessionType,
                      text: "Profession Type",
                      textSize: 18.0,
                      onChanged: (value) {
                        setState(() {
                          if (!value!)
                            _isProfessionType = MatchMakerProvider.of(context)!
                                .chkMaxFilterReached(value);
                          if (!_isProfessionType) {
                            professionTypeWidget = [];
                            professionType.forEach((item) {
                              item.isSelected = false;
                            });
                            _matchMakerModel.occupation.clear();
                          }
                        });
                      },
                      secondary: SizedBox(),
                    ),
                    GestureDetector(
                      onTap: () {
                        /*         if (!_isProfessionType)
                          _isProfessionType = MatchMakerProvider.of(context).chkMaxFilterReached(true);
                        if (_isProfessionType)*/
                        _modalBottomSheetMenu(
                          page: 0,
                          items: professionType,
                          title: "Profession Type",
                          selectedItem: (isChecked, values) {
                            setState(() {
                              if (!_isProfessionType)
                                _isProfessionType =
                                    MatchMakerProvider.of(context)!
                                        .chkMaxFilterReached(true);
                              if (_isProfessionType) {
                                if (professionType
                                    .singleWhere(
                                      (test) => test.id == (values as Item).id,
                                    )
                                    .isSelected = isChecked) {
                                  _matchMakerModel.occupation
                                      .add((values as Item).id);
                                  updateProfessionType(true, values);
                                } else {
                                  updateProfessionType(false, values);
                                  _matchMakerModel.occupation
                                      .remove((values as Item).id);
                                }
                                print(
                                    "industry ${_matchMakerModel.occupation.length}");
                                if (_matchMakerModel.occupation.isEmpty) {
                                  _isProfessionType =
                                      MatchMakerProvider.of(context)!
                                          .chkMaxFilterReached(false);
                                }
                              }
                            });
//                            updateProfessionType(values);
                          },
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
                        child: TextView("Add",
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    runSpacing: 10.0,
                    spacing: 10.0,
                    children: professionTypeWidget),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomCheckBox(
                      enabled: _isEducation,
                      value: _isEducation,
                      text: "Education",
                      textSize: 18.0,
                      onChanged: (value) {
                        setState(() {
                          if (!value!)
                            _isEducation = MatchMakerProvider.of(context)!
                                .chkMaxFilterReached(value);
                          if (!_isEducation) {
                            educationWidget = [];
                            education.forEach((item) {
                              item.isSelected = false;
                            });
                            _matchMakerModel.education.clear();
                          }
                        });
                      },
                      secondary: SizedBox(),
                    ),
                    GestureDetector(
                      onTap: () {
                        /*        if (!_isEducation) _isEducation = MatchMakerProvider.of(context).chkMaxFilterReached(true);
                        if (_isEducation)*/
                        _modalBottomSheetMenu(
                          page: 0,
                          items: education,
                          title: "Education",
                          selectedItem: (isChecked, values) {
                            if (!_isEducation)
                              _isEducation = MatchMakerProvider.of(context)!
                                  .chkMaxFilterReached(true);
                            if (_isEducation) {
                              if (education
                                  .singleWhere(
                                    (test) => test.id == (values as Item).id,
                                  )
                                  .isSelected = isChecked) {
                                _matchMakerModel.education
                                    .add((values as Item).id);
                                updateEducationType(true, values);
                              } else {
                                updateEducationType(false, values);
                                _matchMakerModel.education
                                    .remove((values as Item).id);
                              }
                              if (_matchMakerModel.education.isEmpty) {
                                _isEducation = MatchMakerProvider.of(context)!
                                    .chkMaxFilterReached(false);
                              }
                            }
                          },
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
                          child: TextView("Add",
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8)),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    runSpacing: 10.0,
                    spacing: 10.0,
                    children: educationWidget),
                SizedBox(
                  height: 20.0,
                ),
                Visibility(
                  visible: isGeneral,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CustomCheckBox(
                        enabled: _isYearInJob,
                        value: _isYearInJob,
                        text: "Years",
                        textSize: 18.0,
                        onChanged: (value) {
                          setState(() {
                            // if (!value) _isYearInJob = MatchMakerProvider.of(context).chkMaxFilterReached(value);
                            if (!value!) {
                              _isYearInJob = MatchMakerProvider.of(context)!
                                  .chkMaxFilterReached(value);
                              _selectedYear = "Experience";
                              _matchMakerModel.experience = 0;
                              setState(() {});
                            }
                          });
                        },
                        secondary: SizedBox(),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      CustomDropDown(
                        experienceList,
                        hint: _selectedYear,
                        initValue: 
                        experienceList.singleWhere(
                          (value) =>
                              value["id"] ==
                              _matchMakerModel.experience.toString(),
                          orElse: () => experienceList.first,
                        ),
                        margin: EdgeInsets.all(8.0),
                        onChange: (selectedItem) {
                          if (!_isYearInJob)
                            _isYearInJob = MatchMakerProvider.of(context)!
                                .chkMaxFilterReached(true);
                          if (_isYearInJob) {
                            setState(() {
                              print(selectedItem['name']);
                              _matchMakerModel.experience =
                                  int.tryParse(selectedItem['id'])!;
                            });
                          }
                        },
                        radius: 5.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomCheckBox(
                            enabled: _isIncomeChecked,
                            value: _isIncomeChecked,
                            text: "Income",
                            textSize: 16.0,
                            onChanged: (value) {
                              setState(() {
                                if (!value!) {
                                  _isIncomeChecked =
                                      MatchMakerProvider.of(context)!
                                          .chkMaxFilterReached(value);
                                  incomeRangeList.forEach((item) {
                                    item.isSelected = false;
                                  });
                                  _matchMakerModel.income.clear();
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
                      incomeRage.generateItem(
                        incomeRangeList,
                        onTap: (index) {
                          setState(() {
                            if (!_isIncomeChecked)
                              _isIncomeChecked = MatchMakerProvider.of(context)!
                                  .chkMaxFilterReached(true);

                            if (_isIncomeChecked) {
                              incomeRangeList[index].isSelected =
                                  !incomeRangeList[index].isSelected;
                              incomeRangeList[index].isSelected
                                  ? _matchMakerModel.income
                                      .add(incomeRangeList[index].id)
                                  : _matchMakerModel.income
                                      .remove(incomeRangeList[index].id);
                              if (_matchMakerModel.income.isEmpty) {
                                _isIncomeChecked =
                                    MatchMakerProvider.of(context)!
                                        .chkMaxFilterReached(false);
                                _matchMakerModel.income.clear();
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateProfessionType(bool isChecked, Item values) {
    if (values != null)
      setState(() {
        _isProfessionType = _matchMakerModel.occupation.length > 0;
        if (isChecked)
          professionTypeWidget.add(buildSelectedItem(
            values,
            onTap: () {
              setState(() {
                professionTypeWidget
                    .removeWhere((test) => test.key == ObjectKey(values));
                professionType
                    .singleWhere(
                      (test) => test.id == values.id,
                    )
                    .isSelected = false;
                _matchMakerModel.occupation.remove(values.id);
                _matchMakerModel.occupation.toSet().toList();
                _isProfessionType = _matchMakerModel.occupation.length > 0;
                print(
                    "industry after delete ${_matchMakerModel.occupation.length}");
//                                      updateProfessionType(false, values);
              });
            },
          ));
        else
          professionTypeWidget
              .removeWhere((test) => test.key == ObjectKey(values));
        print("industryWidget ${professionTypeWidget.length}");
      });
  }

  void updateEducationType(bool isChecked, Item values) {
    if (values != null)
      setState(() {
        _isEducation = _matchMakerModel.education.length > 0;
        print("education $values");
        if (isChecked) {
          educationWidget.add(buildSelectedItem(
            values,
            onTap: () {
              setState(() {
                educationWidget
                    .removeWhere((test) => test.key == ObjectKey(values));
                education
                    .singleWhere(
                      (test) => test.id == values.id,
                    )
                    .isSelected = false;
                _matchMakerModel.education.remove(values.id);
                _matchMakerModel.education.toSet().toList();
                _isEducation = _matchMakerModel.education.length > 0;
              });
            },
          ));
        } else {
          educationWidget.removeWhere((test) => test.key == ObjectKey(values));
        }

        print("educationWidget ${educationWidget.length}");
      });
  }

  Widget buildSelectedItem(Item item, {required GestureTapCallback onTap}) {
    print("buildSelectedItem $item");
    return StatefulBuilder(
      key: ObjectKey(item),
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(50.0)),
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  flex: 9,
                  child: TextView(item.name,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Flexible(
                  flex: 1,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 15.0,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _modalBottomSheetMenu(
      {int page = 1,
      title,
      required List<Item> items,
      required Function selectedItem}) {
    print("items $items");
    Future.delayed(Duration(milliseconds: 150), () {
      pageController.jumpToPage(page == null ? 0 : page);
    });
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, state) {
              return Stack(
                children: <Widget>[
                  PageView(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      SMCWidget(
                        title: title,
                        multipleChoice: true,
                        items: items,
                        selectedItem:
                            selectedItem as dynamic Function(bool, dynamic),
                        errorWidget: SizedBox(),
                      ),
                    ],
                    onPageChanged: (index) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: CustomButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: TextView("Done",
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            })),
                  )
                ],
              );
            },
          );
        });
  }
}
