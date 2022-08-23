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

import 'siblings.dart';

class FamilyInfoA extends StatefulWidget {
  static String route = 'FamilyInfoA';

  @override
  _FamilyInfoAState createState() => _FamilyInfoAState();
}

class _FamilyInfoAState extends State<FamilyInfoA>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<Map<String, String>> occupationList = [];
  TextEditingController fatherCtrl = TextEditingController(),
      motherCtrl = TextEditingController();
  List<BaseSettings> _baseSettings = [];

  // ProfileResponse _profileResponse;
  List<SiblingFamily> siblingDatas = [];
  bool isAddAnotherSibling = false, removeSibling = false;
  BaseSettings listFatherOccupation = BaseSettings(options: []),
      listMotherOccupation = BaseSettings(options: []);
  int selectedSiblingIndex = -1;
  bool hasSiblings = true;
  bool isFather = false;

  List<Widget> siblingBuilderList = [];

//  Widget siblingBuilder(List<SiblingStatus> siblingStatusItems) {}

  @override
  void initState() {
    _baseSettings = GlobalData.baseSettings;
    // _profileResponse = GlobalData.myProfile;
    listFatherOccupation = getBaseSettingsByType(
        CoupledStrings.baseSettingsFatherStatus, _baseSettings);
    listMotherOccupation = getBaseSettingsByType(
        CoupledStrings.baseSettingsMothStatus, _baseSettings);

    ///load previous data
    fatherCtrl.text = GlobalData.myProfile.family!.fatherOccupationStatus !=
            null
        ? GlobalData.myProfile.family!.fatherOccupationStatus!.value.toString()
        : '';
    motherCtrl.text = GlobalData.myProfile.family!.motherOccupationStatus !=
            null
        ? GlobalData.myProfile.family!.motherOccupationStatus!.value.toString()
        : '';
    isAddAnotherSibling = GlobalData.myProfile.siblings != null &&
        GlobalData.myProfile.siblings.length > 0;
    GlobalData.myProfile.siblings = GlobalData.myProfile.siblings ?? [];
    siblingDatas = [];
    print(siblingDatas);
    print('GlobalData.myProfile.siblings.length-------------');
    print('${GlobalData.myProfile.siblings}');
    if (GlobalData.myProfile.siblings.length > 0) {
      GlobalData.myProfile.siblings.forEach((f) => siblingsAdding(f));
    } else {
      siblingsAdding();
    }

    super.initState();
  }

  siblingsAdding([Sibling? siblingResponse]) {
    setState(() {});
    siblingDatas.add(SiblingFamily(
      baseSettings: _baseSettings,
      siblingResponse: siblingResponse == null
          ? Sibling(
              profession: BaseSettings(options: []),
              maritalStatus: BaseSettings(options: []),
              role: BaseSettings(options: []))
          : siblingResponse,
      index: siblingDatas.length,
      siblings: siblingActions,
    ));
    setState(() {});
  }

  siblingActions(Sibling sibling, index) {
    ///remove all sibling list when value is none

    setState(() {
      print('siblingDatas1----22222');
      print('$sibling');
      isAddAnotherSibling =
          sibling.role!.value.toLowerCase() != "none" ?? false;
      removeSibling = sibling.role!.value.toLowerCase() == "remove" ?? false;

      ///old method
      /*if (!isAddAnotherSibling && !removeSibling) {
        print("kiran");
        siblingDatas.removeWhere((element) => element.index != 0);
        // GlobalData.myProfile.siblings.removeWhere((element) => element.id!=1);
        GlobalData.myProfile.siblings = List<Sibling>();
      } else if(removeSibling){
        print("raj");
        siblingDatas.removeAt(index-1);
        // GlobalData.myProfile.siblings.removeWhere((element) => element.id!=1);
        GlobalData.myProfile.siblings.removeAt(index-1);
      }*/

      ///the new method
      /*if (removeSibling) {
       print("raj");
        siblingDatas.removeAt(index-1);
        GlobalData.myProfile.siblings.removeAt(index);

      }
      else if(isAddAnotherSibling && removeSibling){
        print("kumar");
        siblingDatas.removeWhere((element) => element.index != 0);
        // GlobalData.myProfile.siblings.removeWhere((element) => element.id!=1);
        GlobalData.myProfile.siblings = List<Sibling>();
      }*/

      ///if the [index] is less than siblings length it will update else insert
      ///TODO sibling loop
      if (index < GlobalData.myProfile.siblings.length) {
        GlobalData.myProfile.siblings[index].profession = sibling.profession;
        GlobalData.myProfile.siblings[index].role =
            GlobalData.myProfile.siblings[index].role;
        GlobalData.myProfile.siblings[index].maritalStatus =
            sibling.maritalStatus;
      } else {
        GlobalData.myProfile.siblings.add(Sibling(
            profession: sibling.profession,
            role: sibling.role,
            maritalStatus: sibling.maritalStatus));
      }

      print('siblingDatas----');
      print('${siblingDatas[0]}');
    });
  }

  showOccupationList(BaseSettings listStatus, {required bool isFather}) {
    addOcuupationStatus(listStatus);
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
              itemCount: occupationList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        //   setState(() {

                        print('occupation----------------');
                        print(
                            int.parse(occupationList[index]['id'].toString()));
                        if (isFather) {
                          setState(() {
                            GlobalData.myProfile.family!
                                .fatherOccupationStatus = BaseSettings(
                              id: int.parse(
                                  occupationList[index]['id'].toString()),
                              value: occupationList[index]['name'].toString(),
                              options: [],
                            );

                            fatherCtrl.text =
                                occupationList[index]['name'].toString();
                          });
                        } else {
                          setState(() {
                            GlobalData.myProfile.family!
                                .motherOccupationStatus = BaseSettings(
                              id: int.parse(
                                  occupationList[index]['id'].toString()),
                              value: occupationList[index]['name'].toString(),
                              options: [],
                            );

                            motherCtrl.text =
                                occupationList[index]['name'].toString();
                          });
                        }
                        print(GlobalData
                            .myProfile.family!.fatherOccupationStatus!.id);
                        Navigator.pop(context);
                        //     });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: TextView(
                          occupationList[index]['name'].toString(),
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
            progress: 0.79,
            title: 'Family (Optional)',
            step: 11,
            params: getSectionEleven()),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: 10, left: 15.0, right: 15.0, bottom: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  InkWell(
                    splashColor: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      setState(() {
                        showOccupationList(listFatherOccupation,
                            isFather: true);
                      });
                    },
                    child: EditTextBordered(
                      enabled: false,
                      controller: fatherCtrl,
                      hint: "Father Status",
                      size: 16.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    splashColor: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      showOccupationList(listMotherOccupation, isFather: false);
                    },
                    child: EditTextBordered(
                      enabled: false,
                      controller: motherCtrl,
                      hint: "Mother Status",
                      size: 16.0,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextView(
                    "Sibling",
                    size: 18.0,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.left,
                    textScaleFactor: .8,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  ///TODO siblings
                  ListView.builder(
                    itemCount: siblingDatas.length ?? 0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      //  return Text('test');
                      return siblingDatas[index];
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  isAddAnotherSibling
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              siblingsAdding();

                              /// the problem related to siblings is in this line of code
                              //GlobalData.myProfile.siblings.add(Sibling());
                              isAddAnotherSibling = false;
                            });

                            print('GlobalData.myProfile.siblings------');
                            print(GlobalData.myProfile.siblings);
                          },
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/add_image.png",
                                width: 20.0,
                                height: 20.0,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              TextView(
                                "Add another sibling",
                                color: Colors.white,
                                size: 18.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                              )
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            getBottomNavigationButtons(step: 11, params: getSectionEleven())
          ],
        ),
      ),
    );
  }

  void addOcuupationStatus(BaseSettings listStatus) {
    occupationList.clear();
    if (listStatus != null) {
      listStatus.options!.forEach((f) {
        occupationList.add({'id': f.id.toString(), 'name': f.value});
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class SiblingStatus {
//  final MaritalModel maritalModel;
//  bool isSelected;
  final Map status;

  SiblingStatus(/*this.isSelected,*/ this.status);
}
