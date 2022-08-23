import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/profile.dart';

import 'package:coupled/registration_new/helpers/get_baseSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SiblingFamily extends StatefulWidget {
  final Function(
    Sibling,
    int,
  ) siblings;
  final int index;
  final dynamic baseSettings;
  final dynamic siblingResponse;

  SiblingFamily({
    title,
    userValue,
    required this.siblings,
    required this.index,
    required this.baseSettings,
    this.siblingResponse,
  });

  @override
  _SiblingFamilyState createState() => _SiblingFamilyState();
}

class _SiblingFamilyState extends State<SiblingFamily> {
  bool hasSiblings = true;
  List<BaseSettings> siblingModel = [];
  TextEditingController occupationCtrl = TextEditingController(),
      maritalCtr = TextEditingController();
  Sibling _siblings = Sibling(
      maritalStatus: BaseSettings(options: []),
      profession: BaseSettings(options: []),
      role: BaseSettings(options: []));
  BaseSettings listBroMStatus = BaseSettings(options: []),
      listSisMStatus = BaseSettings(options: []),
      listMaritalStatus = BaseSettings(options: []),
      listRelationType = BaseSettings(options: []);
  BaseSettings occuStatus = BaseSettings(options: []);

  @override
  void initState() {
    listMaritalStatus = getBaseSettingsByType(
        CoupledStrings.baseSettingsMaritalStatus, widget.baseSettings);
    listRelationType = getBaseSettingsByType(
        CoupledStrings.baseSettingsRelationShip, widget.baseSettings);

    ///list Brother marital status listBroMStatus =
    occuStatus = getBaseSettingsByType(
        CoupledStrings.baseSettingsBrotherOccuStatus, widget.baseSettings);
    print("occuStatus");
    print(occuStatus);

    ///list Sister marital status listSisMStatus =
    getBaseSettingsByType(
        CoupledStrings.baseSettingsSisterOccuStatus, widget.baseSettings);
    if (listRelationType != null) {
      siblingModel.clear();
      listRelationType.options!.forEach((f) {
        siblingModel.add(BaseSettings(id: f.id, value: f.value, options: []));
      });

      ///Only the first list have to be none option if (widget.index < 1) {
      siblingModel.add(BaseSettings(value: 'None', id: 0, options: []));
    } else {
      siblingModel.add(BaseSettings(value: 'Remove', id: -1, options: []));
    }
    if (widget.siblingResponse != null) {
      print("didChangeDependencies Sibling :: ${widget.siblingResponse}");
      hasSiblings = widget.siblingResponse.role != null &&
          widget.siblingResponse.role.value.toString().toLowerCase() !=
              'None'.toLowerCase();
      print("jjj");
      print(hasSiblings);
      occupationCtrl.text = widget.siblingResponse.profession != null
          ? widget.siblingResponse.profession.value
          : "";
      maritalCtr.text = widget.siblingResponse.maritalStatus != null
          ? widget.siblingResponse.maritalStatus.value
          : "";
    }

    super.initState();
  }

  showStatusList({dynamic textCtrl, isMarital = false, dynamic settingsList}) {
    List<Map<String, String>> baseSettings = [];
    if (settingsList != null) {
      settingsList.options.forEach((f) {
        baseSettings.add({'id': f.id.toString(), 'value': f.value});
      });
    }
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: baseSettings.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          // setState(() {
                          textCtrl.text =
                              baseSettings[index]['value'].toString();
                          if (!isMarital) {
                            _siblings.profession = BaseSettings(
                                id: int.parse(
                                    baseSettings[index]['id'].toString()),
                                value: baseSettings[index]['value'].toString(),
                                options: []);
                          } else {
                            _siblings.maritalStatus = BaseSettings(
                                id: int.parse(
                                    baseSettings[index]['id'].toString()),
                                value: baseSettings[index]['value'].toString(),
                                options: []);
                          }
                          widget.siblings(_siblings, widget.index);
                          //   });
                          Navigator.pop(context);
                        },
                        child: TextView(
                          baseSettings[index]['value'].toString(),
                          color: Colors.black,
                          size: 18.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xffe2e2e2),
                      height: 1.0,
                    )
                  ],
                );
              },
            ),
          );
        });
  }

  /// siblings making area
  List<Widget> siblingModels(Sibling siblingResponse) {
    List<Widget> siblingList = [];
    bool isSelectedSibling = false;
    siblingModel.forEach((item) {
      print('isSelectedSibling--------');
      print('$isSelectedSibling');
      print(item.value);
      print(siblingResponse.role!.value);
      if (siblingResponse != null) {
        isSelectedSibling =
            item.id == siblingResponse.role!.id; // _siblings.role = item;
      } else {
        isSelectedSibling =
            item.value.toLowerCase() == _siblings.role!.value.toLowerCase();
      }
      // isSelectedSibling = item.value == siblingResponse?.role?.value; occuStatus =
      /*  _siblings.role?.value?.toLowerCase() == 'brother'.toLowerCase()
          ? listBroMStatus
          : listSisMStatus;*/
      print("isSelectedSibling ::: $occuStatus :::: ${_siblings.role}");
      siblingList.add(item.value.toLowerCase() == "remove"
          ? InkWell(
              borderRadius: BorderRadius.circular(20.0),
              onTap: () {
                setState(() {
                  _siblings.maritalStatus = BaseSettings(options: []);
                  _siblings.profession = BaseSettings(options: []);
                  siblingResponse.role = item;
                  _siblings.role = item;
                  maritalCtr.clear();
                  occupationCtrl.clear();
                  print(_siblings.toString());
                  widget.siblings(_siblings, widget.index);
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextView(
                  item.value,
                  size: 14.0,
                  color: CoupledTheme().primaryBlueDark,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                ),
              ),
            )

          /// the place where the box is clicked
          : SelectionBox(
              onTap: () {
                setState(() {
                  hasSiblings = item.value.toString().isNotEmpty &&
                      item.value.toString().toLowerCase() !=
                          'None'.toLowerCase();
                  siblingResponse.role = item;
                  _siblings.maritalStatus = BaseSettings(options: []);
                  _siblings.profession = BaseSettings(options: []);
                  _siblings.role = item;
                  maritalCtr.clear();
                  occupationCtrl.clear();
                  print("jk");
                  print(_siblings.toString());
                  widget.siblings(_siblings, widget.index);
                });
              },
              borderColor: isSelectedSibling != null && isSelectedSibling ||
                      hasSiblings == item.value.toString().isEmpty &&
                          item.value.toString().toLowerCase() ==
                              'None'.toLowerCase()
                  ? CoupledTheme().primaryPinkDark
                  : null,
              innerColor: isSelectedSibling != null && isSelectedSibling ||
                      hasSiblings == item.value.toString().isEmpty &&
                          item.value.toString().toLowerCase() ==
                              'None'.toLowerCase()
                  ? CoupledTheme().primaryPinkDark
                  : null,
              child: TextView(
                item.value,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible,
                size: 12,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
              ),
            ));
    });
    return siblingList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: siblingModels(widget.siblingResponse)),
        SizedBox(
          height: 30.0,
        ),
        hasSiblings
            ? Column(
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      showStatusList(
                          textCtrl: occupationCtrl, settingsList: occuStatus);
                    },
                    child: EditTextBordered(
                      enabled: false,
                      controller: occupationCtrl,
                      hint: "Occupation Status",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    splashColor: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      showStatusList(
                          textCtrl: maritalCtr,
                          isMarital: true,
                          settingsList: listMaritalStatus);
                    },
                    child: EditTextBordered(
                      enabled: false,
                      controller: maritalCtr,
                      hint: "Marital Status",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
