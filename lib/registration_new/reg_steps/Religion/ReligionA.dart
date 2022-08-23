import 'package:coupled/Utils/Modals/SMC/smc_widget.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';

import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/profile.dart';

import 'package:coupled/registration_new/app_bar.dart';
import 'package:coupled/registration_new/get_bottom_button.dart';
import 'package:coupled/registration_new/helpers/get_baseSettings.dart';
import 'package:coupled/registration_new/helpers/get_section_data.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

class ReligionA extends StatefulWidget {
  static String route = 'ReligionA';

  @override
  _ReligionAState createState() => _ReligionAState();
}

class _ReligionAState extends State<ReligionA>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  TextEditingController _religionCtrl = TextEditingController(),
      _casteCtrl = TextEditingController(),
      _subCasteCtrl = TextEditingController(),
      _gothramCtrl = TextEditingController();
  bool showOtherReligion = false,
      showCaste = false,
      showSubCaste = false,
      showGothram = false;
  List<Item> _casteLists = [],
      _subCasteLists = [],
      _gothramLists = [],
      _otherReligionLists = [],
      religionData = [];
  BaseSettings listReligions = BaseSettings(options: []);
  List<BaseSettings> listCasts = [], listSubCaste = [];

  Family userFamily = Family(
      fatherOccupationStatus: BaseSettings(options: []),
      cast: BaseSettings(options: []),
      familyType: BaseSettings(options: []),
      familyValues: BaseSettings(options: []),
      gothram: BaseSettings(options: []),
      motherOccupationStatus: BaseSettings(options: []),
      religion: BaseSettings(options: []),
      subcast: BaseSettings(options: []));
  List<BaseSettings> _baseSettings = [];
  List<String> religionList = [
    'hinduism',
    'christianity',
    'islam',
    'buddhism',
    'jainism',
    'judaism',
    'sikhism',
    'others'
  ];
  List<String> religionIconsList = [
    'assets/Religion/Hinduism.png',
    'assets/Religion/Christianity.png',
    'assets/Religion/Islam.png',
    'assets/Religion/Buddhism.png',
    'assets/Religion/Jainism.png',
    'assets/Religion/Judaism.png',
    'assets/Religion/Sikhism.png',
    'assets/Religion/Others.png',
  ];

  @override
  void didChangeDependencies() {
    _baseSettings = GlobalData.baseSettings;
    userFamily = GlobalData.myProfile.family!;
    listReligions = getBaseSettingsByType(
        CoupledStrings.baseSettingsReligions, _baseSettings);
    print("Religion ::: ${listReligions.toString()}");
    _gothramLists.addAll(
        filterOptions(CoupledStrings.baseSettingsGothram, _baseSettings).item1);
    religionData.clear();

    ///religion list
    if (listReligions != null) {
      _otherReligionLists.clear();
      listReligions.options!.forEach((f) {
        int index = religionList
            .indexWhere((test) => test.toLowerCase() == f.others.toLowerCase());
        print('Option :  $index :: $f');
        if (index > -1) {
          if (religionList[index] != "others") {
            religionData.add(Item(
              code: religionList[index],
              id: f.id.toString(),
              extras: {"imagePath": religionIconsList[index]},
              name: f.value,
            ));
          } else {
            _otherReligionLists.add(Item(
              code: religionList[index],
              id: f.id.toString(),
              name: f.value,
            ));
          }
        }
      });
      religionData.add(Item(
          id: "0",
          extras: {"imagePath": 'assets/Religion/Others.png'},
          name: "Others",
          code: "others"));
    }

    ///Load previous data
    if (userFamily != null) {
      _gothramCtrl.text =
          userFamily.gothram != null ? userFamily.gothram!.value : '';
      print(religionData);
      Item religionItem = religionData.singleWhere(
          (test) =>
              test.code.toLowerCase() ==
              userFamily.religion?.others.toLowerCase(),
          orElse: (() => Item()));
      print(
          "religionItem :: ${userFamily.religion?.others.toString().toLowerCase()}   $religionItem");
      if (religionItem != null) {
        religionItem.isSelected = true;
        showCaste = showGothram =
            userFamily.religion?.others.toLowerCase() == 'hinduism';
        if (religionItem.code.toLowerCase() == "others") {
          print("USERFAMILY : ${userFamily.religion?.value}");
          showOtherReligion = true;

          _religionCtrl.text =
              userFamily.religion != null ? userFamily.religion!.value : '';
          _otherReligionLists.firstWhere(
            (test) {
              print("test.name : ${test.name}");
              return test.name == userFamily.religion?.value;
            },
          ).isSelected = true;
        }
        /*listCasts = PersonalDetailsProvider.of(context)
            .getBaseSettingsOptionsByType(religionItem.name, listReligions.options);*/
        final foo = filterOptions(religionItem.name, listReligions.options);
        listCasts = foo.item2!;
        _casteLists = foo.item1;
        print("listCasts :: $listCasts");

        Item casteItem = _casteLists.firstWhere(
            (test) => test.name == userFamily.cast?.value,
            orElse: () => Item());
        if (casteItem != null) {
          showCaste = true;
          casteItem.isSelected = true;
          _casteCtrl.text =
              userFamily.cast != null ? userFamily.cast!.value : '';
          /*   _subCasteLists.addAll(Item().convertToItem(
              baseSettings: PersonalDetailsProvider.of(context)
                  .getBaseSettingsOptionsByType(casteItem.name, listCasts)));*/
          _subCasteLists = filterOptions(casteItem.name, listCasts).item1;
          Item data = _subCasteLists.firstWhere(
              (test) => test.name == userFamily.subcast?.value,
              orElse: (() => Item()));
          if (data != null) {
            showSubCaste = true;
            data.isSelected = true;
            _subCasteCtrl.text =
                userFamily.subcast != null ? userFamily.subcast!.value : '';
          }
        }
      }
      _gothramLists
          .firstWhere((test) => test.name == userFamily.gothram?.value,
              orElse: () => Item())
          .isSelected = true;
    }

    super.didChangeDependencies();
  }

  void _modalBottomSheetMenu(
      {int page = 0, required Function(bool, dynamic) selectedItem}) {
    PageController _pageController;
    _pageController = PageController(initialPage: page, keepPage: true);

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Theme(
            data: CoupledTheme()
                .coupledTheme2()
                .copyWith(unselectedWidgetColor: Colors.black),
            child: StatefulBuilder(
              builder: (context, state) {
                return Stack(
                  children: <Widget>[
                    PageView(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        SMCWidget(
                          title: "Caste",
                          multipleChoice: false,
                          items: _casteLists,
                          selectedItem: selectedItem,
                          errorWidget: SizedBox(),
                        ),
                        SMCWidget(
                          title: "SubCaste",
                          multipleChoice: false,
                          items: _subCasteLists,
                          selectedItem: selectedItem,
                          errorWidget: SizedBox(),
                        ),
                        SMCWidget(
                          title: "Gothram",
                          multipleChoice: false,
                          items: _gothramLists,
                          selectedItem: selectedItem,
                          errorWidget: SizedBox(),
                        ),
                        SMCWidget(
                          title: "Other Religion",
                          multipleChoice: false,
                          items: _otherReligionLists,
                          selectedItem: selectedItem,
                          errorWidget: SizedBox(),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () {
        return Dialogs().showDialogExitApp(context);
      },
      child: Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        appBar: getRegAppBar(context,
            progress: 0.89,
            title: 'Religion',
            step: 13,
            params: getSectionThirteen()),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 100.0, left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  GridView.count(
                    crossAxisCount: 4,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: .8,
                    shrinkWrap: true,
                    children: List.generate(religionData.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          showGothram = religionData[index].code == "hinduism";
                          if (!showGothram) {
                            _gothramLists
                                .firstWhere((test) => test.isSelected == true,
                                    orElse: () => Item())
                                .isSelected = false;
                          }
                          setState(() {
                            religionData
                                .singleWhere((test) => test.isSelected,
                                    orElse: () => Item())
                                .isSelected = false;

                            religionData[index].isSelected = true;
                            userFamily.religion = BaseSettings(
                                id: int.parse(religionData[index].id),
                                value: religionData[index].name,
                                others: religionData[index].code,
                                options: []);
                            userFamily.cast = BaseSettings(options: []);
                            userFamily.subcast = BaseSettings(options: []);
                            userFamily.gothram = BaseSettings(options: []);
                            /*   _casteLists.clear();

                            listCasts = PersonalDetailsProvider.of(context)
                                .getBaseSettingsOptionsByType(religionData[index].name, listReligions.options);
                            _casteLists.addAll(Item().convertToItem(baseSettings: listCasts));*/

                            /// to generate caste field
                            final foo = filterOptions(religionData[index].name,
                                listReligions.options);
                            listCasts = foo.item2!;
                            _casteLists = foo.item1;
                            print("listCasts :: $listCasts");
                            showCaste = _casteLists.length > 0;
                            showSubCaste = false;

                            _casteCtrl.clear();
                            _subCasteCtrl.clear();
                            _gothramCtrl.clear();
                            showOtherReligion =
                                religionData[index].name.toLowerCase() ==
                                    "others";
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Opacity(
                            opacity: religionData[index].isSelected ? 1.0 : .5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Image.asset(
                                    religionData[index].extras["imagePath"],
                                    fit: BoxFit.fill,
                                    color: religionData[index].isSelected
                                        ? CoupledTheme().primaryPinkDark
                                        : null,
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                TextView(
                                  religionData[index].name,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                  size: 12,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  showOtherReligion
                      ? InkWell(
                          splashColor: Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () {
                            setState(() {
                              _modalBottomSheetMenu(
                                  page: 3,
                                  selectedItem: (isChecked, otherReligion) {
                                    if (otherReligion != null &&
                                        otherReligion is Item) {
                                      setState(() {
                                        _otherReligionLists
                                            .singleWhere(
                                              (test) => test == otherReligion,
                                            )
                                            .isSelected = isChecked;

                                        _religionCtrl.text = otherReligion.name;
                                        userFamily.religion = BaseSettings(
                                            id: int.parse(otherReligion.id),
                                            value: otherReligion.name,
                                            others: otherReligion.code,
                                            options: []);
                                        userFamily.cast =
                                            BaseSettings(options: []);
                                        userFamily.subcast =
                                            BaseSettings(options: []);
                                        userFamily.gothram =
                                            BaseSettings(options: []);
                                        /*  _casteLists.clear();
                                        listCasts = PersonalDetailsProvider.of(context)
                                            .getBaseSettingsOptionsByType(otherReligion.name, listReligions.options);
                                        _casteLists.addAll(Item().convertToItem(baseSettings: listCasts));*/
                                        final foo = filterOptions(
                                            otherReligion.name,
                                            listReligions.options);
                                        listCasts = foo.item2!;
                                        _casteLists = foo.item1;
                                        showCaste = _casteLists.length > 0;
                                        showSubCaste = false;
                                        _casteCtrl.clear();
                                        _subCasteCtrl.clear();
                                        _gothramCtrl.clear();
                                      });
                                      Navigator.pop(context);
                                    }
                                  });
                            });
                          },
                          child: EditTextBordered(
                            enabled: false,
                            hint: "Other Religion",
                            size: 16.0,
                            controller: _religionCtrl,
                          ))
                      : Container(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible: showCaste,
                    child: InkWell(
                      splashColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        setState(() {
                          _modalBottomSheetMenu(
                              page: 0,
                              selectedItem: (isChecked, caste) {
                                if (caste is Item) {
                                  setState(() {
                                    print("caste------- $caste");

                                    _casteLists
                                        .singleWhere(
                                          (test) => test == caste,
                                        )
                                        .isSelected = isChecked;

                                    if (isChecked) {
                                      _casteCtrl.text = caste.name;
                                      userFamily.cast = BaseSettings(
                                          id: int.parse(caste.id),
                                          value: caste.name,
                                          options: []);
                                      /*    _subCasteLists.clear();
                                  listSubCaste = PersonalDetailsProvider.of(context)
                                          .getBaseSettingsOptionsByType(caste.name, listCasts);
                                      _subCasteLists.addAll(Item().convertToItem(baseSettings: listSubCaste));*/
                                      final foo =
                                          filterOptions(caste.name, listCasts);
                                      listSubCaste = foo.item2!;
                                      _subCasteLists = foo.item1;
                                      userFamily.subcast =
                                          BaseSettings(options: []);
                                      print("SUBCASTE :: $_subCasteLists");
                                      showSubCaste = _subCasteLists.length > 0;
                                      print("jj");
                                    } else {
                                      showSubCaste = true;
                                      _casteCtrl.clear();
                                      _subCasteCtrl.clear();

                                      userFamily.cast =
                                          BaseSettings(options: []);
                                    }
                                  });
                                  Navigator.pop(context);
                                }
                              });
                        });
                      },
                      child: EditTextBordered(
                        enabled: false,
                        hint: "Caste (Optional)",
                        size: 16.0,
                        controller: _casteCtrl,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible: _subCasteLists.length > 0 ? true : false,
                    child: InkWell(
                      splashColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        setState(() {
                          _modalBottomSheetMenu(
                              page: 1,
                              selectedItem: (isChecked, subCaste) {
                                if (subCaste is Item) {
                                  setState(() {
                                    _subCasteLists
                                        .singleWhere(
                                          (test) => test == subCaste,
                                        )
                                        .isSelected = isChecked;
                                    if (isChecked) {
                                      _subCasteCtrl.text = subCaste.name;
                                      userFamily.subcast = BaseSettings(
                                          id: int.parse(subCaste.id),
                                          value: subCaste.name,
                                          options: []);
                                    } else {
                                      _subCasteCtrl.clear();
                                      userFamily.subcast =
                                          BaseSettings(options: []);
                                    }
                                  });
                                }
                                Navigator.pop(context);
                              });
                        });
                      },
                      child: EditTextBordered(
                        enabled: false,
                        hint: "Sub Caste (Optional)",
                        size: 16.0,
                        controller: _subCasteCtrl,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible: showGothram,
                    child: InkWell(
                      splashColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        setState(() {
                          _modalBottomSheetMenu(
                              page: 2,
                              selectedItem: (isChecked, gothram) {
                                if (gothram is Item) {
                                  setState(() {
                                    _gothramLists
                                        .singleWhere(
                                          (test) => test == gothram,
                                        )
                                        .isSelected = isChecked;
                                    if (isChecked) {
                                      _gothramCtrl.text = gothram.name;
                                      userFamily.gothram = BaseSettings(
                                          id: int.parse(gothram.id),
                                          value: gothram.name,
                                          options: []);
                                    } else {
                                      _gothramCtrl.clear();
                                      userFamily.gothram =
                                          BaseSettings(options: []);
                                    }
                                  });
                                }
                                Navigator.pop(context);
                              });
                        });
                      },
                      child: EditTextBordered(
                        enabled: false,
                        hint: "Gothram (Optional)",
                        size: 16.0,
                        controller: _gothramCtrl,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            getBottomNavigationButtons(step: 13, params: getSectionThirteen())
          ],
        ),
      ),
    );
  }

  clearData() {}

  /// this part is for data coming in bottom sheet of caste(optional) and subcaste(optional) and gothram(optional)
  Tuple<List<Item>, List<BaseSettings>?> filterOptions(
    dynamic type,
    List<BaseSettings>? baseSettings,
  ) {
    List<Item> items = [];

    ///BaseSetting is structure parent and child. for eg: there are so many child under hinduism like Nair, Ezhava etc.
    ///So First we filter the List of child list according to parent name
    final listBaseSettings = getBaseSettingsOptionsByType(type, baseSettings);

    ///After that we have to add static item like 'Don't wish to specify' at the top and 'Don't know', 'Other'
    /// at the bottom of the list of Items.
    ///So we take that list from base settings
    if (listBaseSettings != null &&
        listBaseSettings.length > 0 &&
        listBaseSettings[0].value.toLowerCase() != "no caste") {
      final staticTypeList = getBaseSettingsByType(
          CoupledStrings.baseSettingsStaticOptions, _baseSettings);
      print(staticTypeList);

      ///Then we convert baseSettings to Item for our purpose and adding to the list;
      final staticTypeItems = Item().convertToItem(
        baseSettings: staticTypeList.options,
      );
      items.add(staticTypeItems[0]);

      /// this part is to add the items coming from base setting and it will be in the middle of dont wish and dont know
      items.addAll(Item().convertToItem(baseSettings: listBaseSettings));
      items.add(staticTypeItems[1]);
      items.add(staticTypeItems[2]);
    }
    return Tuple(item1: items, item2: listBaseSettings);
  }

  @override
  bool get wantKeepAlive => true;

  Future<Null> refreshlist() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _baseSettings = GlobalData.baseSettings;
      userFamily = GlobalData.myProfile.family!;
      listReligions = getBaseSettingsByType(
          CoupledStrings.baseSettingsReligions, _baseSettings);
      print("Religion ::: ${listReligions.toString()}");
      _gothramLists.addAll(
          filterOptions(CoupledStrings.baseSettingsGothram, _baseSettings)
              .item1);
      religionData.clear();

      ///religion list
      if (listReligions != null) {
        _otherReligionLists.clear();
        listReligions.options!.forEach((f) {
          int index = religionList.indexWhere(
              (test) => test.toLowerCase() == f.others.toLowerCase());
          print('Option :  $index :: $f');
          if (index > -1) {
            if (religionList[index] != "others") {
              religionData.add(Item(
                code: religionList[index],
                id: f.id.toString(),
                extras: {"imagePath": religionIconsList[index]},
                name: f.value,
              ));
            } else {
              _otherReligionLists.add(Item(
                code: religionList[index],
                id: f.id.toString(),
                name: f.value,
              ));
            }
          }
        });
        religionData.add(Item(
            id: "0",
            extras: {"imagePath": 'assets/Religion/Others.png'},
            name: "Others",
            code: "others"));
      }

      ///Load previous data
      if (userFamily != null) {
        _gothramCtrl.text = userFamily.gothram!.value;
        Item religionItem = religionData.singleWhere(
          (test) =>
              test.code.toLowerCase() ==
              userFamily.religion!.others.toLowerCase(),
        );
        print(
            "religionItem :: ${userFamily.religion!.others.toLowerCase()}   $religionItem");
        if (religionItem != null) {
          religionItem.isSelected = true;
          showCaste = showGothram =
              userFamily.religion!.others.toLowerCase() == 'hinduism';
          if (religionItem.code.toLowerCase() == "others") {
            print("USERFAMILY : ${userFamily.religion!.value}");
            showOtherReligion = true;

            _religionCtrl.text = userFamily.religion!.value;
            _otherReligionLists.firstWhere(
              (test) {
                print("test.name : ${test.name}");
                return test.name == userFamily.religion!.value;
              },
            ).isSelected = true;
          }
          /*listCasts = PersonalDetailsProvider.of(context)
            .getBaseSettingsOptionsByType(religionItem.name, listReligions.options);*/
          final foo = filterOptions(religionItem.name, listReligions.options);
          listCasts = foo.item2!;
          _casteLists = foo.item1;
          print("listCasts :: $listCasts");

          Item casteItem = _casteLists.firstWhere(
            (test) => test.name == userFamily.cast!.value,
          );
          if (casteItem != null) {
            showCaste = true;
            casteItem.isSelected = true;
            _casteCtrl.text = userFamily.cast!.value;
            /*   _subCasteLists.addAll(Item().convertToItem(
              baseSettings: PersonalDetailsProvider.of(context)
                  .getBaseSettingsOptionsByType(casteItem.name, listCasts)));*/
            _subCasteLists = filterOptions(casteItem.name, listCasts).item1;
            Item data = _subCasteLists.firstWhere(
              (test) => test.name == userFamily.subcast!.value,
            );
            if (data != null) {
              showSubCaste = true;
              data.isSelected = true;
              _subCasteCtrl.text = userFamily.subcast!.value;
            }
          }
        }
        _gothramLists
            .firstWhere(
              (test) => test.name == userFamily.gothram!.value,
            )
            .isSelected = true;
      }
    });

    return null;
  }
}

class Tuple<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple({
    required this.item1,
    required this.item2,
  });
}
