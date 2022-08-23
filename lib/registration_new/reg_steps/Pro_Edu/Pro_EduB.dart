import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/Modals/sub_cat_modal.dart';
import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';

import 'package:coupled/registration_new/app_bar.dart';
import 'package:coupled/registration_new/get_bottom_button.dart';
import 'package:coupled/registration_new/helpers/get_baseSettings.dart';
import 'package:coupled/registration_new/helpers/get_section_data.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

class ProEduB extends StatefulWidget {
  static String route = 'ProEduB';

  @override
  _ProEduBState createState() => _ProEduBState();
}

class _ProEduBState extends State<ProEduB> with AutomaticKeepAliveClientMixin {
  List<Map> _expList = [];
  List<Map<dynamic, dynamic>> _incomeList = [];
  List<SelectionCaseModel> _eduList = [];
  List<BaseSettings> coursesBotomSheetList = [];
  List<BaseSettings> graduateList = [];
  BaseSettings baseSettings = BaseSettings(options: []);

  Map _experience = Map();
  List<Widget> _selectionCaseItems = [];
  bool isUgPG = false;
  String _educationName = "", _incomeRange = "";
  TextEditingController _graduateCtrl = TextEditingController();

  BaseSettings listExperiences = BaseSettings(options: []),
      listIncome = BaseSettings(options: []),
      listEducation = BaseSettings(options: []),
      listPgCourses = BaseSettings(options: []);
  List<BaseSettings> _baseSettings = [];

  //EducationJobResponse _educationResponse;
  ProfileResponse _profileResponse = ProfileResponse(
      usersBasicDetails: UsersBasicDetails(),
      mom: Mom(),
      info: Info(maritalStatus: BaseSettings(options: [])),
      preference: Preference(complexion: BaseSettings(options: [])),
      officialDocuments: OfficialDocuments(),
      address: Address(),
      photoData: [],
      photos: [],
      family: Family(
          fatherOccupationStatus: BaseSettings(options: []),
          cast: BaseSettings(options: []),
          familyType: BaseSettings(options: []),
          familyValues: BaseSettings(options: []),
          gothram: BaseSettings(options: []),
          motherOccupationStatus: BaseSettings(options: []),
          religion: BaseSettings(options: []),
          subcast: BaseSettings(options: [])),
      educationJob: EducationJob(
          educationBranch: BaseSettings(options: []),
          experience: BaseSettings(options: []),
          highestEducation: BaseSettings(options: []),
          incomeRange: BaseSettings(options: []),
          industry: BaseSettings(options: []),
          profession: BaseSettings(options: [])),
      membership: Membership.fromMap({}),
      userCoupling: [],
      dp: Dp(
          photoName: '',
          imageType: BaseSettings(options: []),
          imageTaken: BaseSettings(options: []),
          userDetail: UserDetail(membership: Membership(paidMember: false))),
      blockMe: Mom(),
      reportMe: Mom(),
      freeCoupling: [],
      recomendCause: [],
      shortlistByMe: Mom(),
      shortlistMe: Mom(),
      photoModel: PhotoModel(),
      currentCsStatistics: CurrentCsStatistics(),
      siblings: []);

  @override
  void didChangeDependencies() {
    _profileResponse = GlobalData.myProfile;
    _profileResponse.educationJob = _profileResponse.educationJob ??
        EducationJob(
            educationBranch: BaseSettings(options: []),
            experience: BaseSettings(options: []),
            highestEducation: BaseSettings(options: []),
            incomeRange: BaseSettings(options: []),
            industry: BaseSettings(options: []),
            profession: BaseSettings(options: []));

    _baseSettings = GlobalData.baseSettings;

    //  _educationResponse = PersonalDetailsProvider.of(context).profileResponse.educationJob;

    listExperiences =
        getBaseSettingsByType(CoupledStrings.baseSettingsWorkXp, _baseSettings);
    listIncome =
        getBaseSettingsByType(CoupledStrings.baseSettingsIncome, _baseSettings);
    listEducation =
        getBaseSettingsByType(CoupledStrings.baseSettingsEdu, _baseSettings);

    addExperienceList(listExperiences);
    addIncomeList(listIncome);
    addEducationList(listEducation);

    ///Load Previous data
    if (_profileResponse.educationJob != null) {
      _experience = _expList.singleWhere(
          (test) => test["id"] == _profileResponse.educationJob?.experience?.id,
          orElse: () => {});

      _incomeRange = _incomeList.singleWhere(
          (test) =>
              test['id'] == _profileResponse.educationJob?.incomeRange?.id,
          orElse: () => {"value": "Select Income"})['value'];

      _eduList
          .singleWhere(
              (test) =>
                  test.item["id"] ==
                  _profileResponse.educationJob?.highestEducation?.id,
              orElse: () => SelectionCaseModel(false, {}))
          .isSelected = true;
      Map _edu = _eduList
          .singleWhere(
              (test) =>
                  test.item["id"] ==
                  _profileResponse.educationJob?.highestEducation?.id,
              orElse: () => SelectionCaseModel(false, {}))
          .item;
      _educationName = _edu["name"] != null ? _edu["name"] : "";

      if (_educationName != "") {
        coursesBotomSheetList = getBaseSettingsOptionsByType(
            _educationName, listEducation.options)!;
        print(
            "coursesBotomSheetList $_edu ${coursesBotomSheetList.toString()}");
        addGraduationList(coursesBotomSheetList);
      }

      ///Graduate List
      _graduateCtrl.text = graduateList
          .singleWhere(
              (test) =>
                  test.id == _profileResponse.educationJob?.educationBranch?.id,
              orElse: () => BaseSettings(options: []))
          .value;
      isUgPG = _graduateCtrl.text.isNotEmpty;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
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
            progress: 0.7,
            title: 'Education & Profession',
            step: 15,
            params: getProfEducationB()),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 100.0, left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextView(
                    "Years in Professional Life",
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                    size: 12,
                    textAlign: TextAlign.center,
                    textScaleFactor: .9,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomDropDown(
                    _expList,
                    hint: "Select years",
                    initValue: _experience,
                    radius: 50.0,
                    onChange: (value) {
                      setState(() {
                        print("VALUE : $value");
                        _experience = value;
                        _profileResponse.educationJob?.experience =
                            BaseSettings(
                                id: value['id'],
                                value: value['name'],
                                options: []);
                      });
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextView(
                    "Income Range(Monthly)",
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                    size: 12,
                    textAlign: TextAlign.center,
                    textScaleFactor: .9,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SelectionBox(
                    radius: 5.0,
                    height: 40.0,
                    onTap: () {
                      setState(() {
                        _incomeBottomSheetMenu();
                      });
                    },
                    borderColor: Colors.white,
                    child: TextView(
                      _incomeRange,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      size: 12,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextView(
                    'Education',
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                    size: 12,
                    textAlign: TextAlign.center,
                    textScaleFactor: .9,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  educationRange(_eduList),
                ],
              ),
            ),
            getBottomNavigationButtons(step: 15, params: getProfEducationB())
          ],
        ),
      ),
    );
  }

  //experience
  void addExperienceList(BaseSettings listExperiences) {
    _expList.clear();

    if (listExperiences != null) {
      //   _expList.add({'id': "0", 'name': "Select Experience"});
      listExperiences.options!.forEach((i) {
        _expList.add({'id': i.id, 'name': i.value});
      });
      _experience = _expList[0];
    }
  }

  //income
  void addIncomeList(BaseSettings listIncome) {
    _incomeList.clear();
    if (listIncome != null) {
      listIncome.options!.forEach((data) {
        _incomeList.add({"id": data.id, "value": data.value});
      });
    }
  }

  //eduction
  void addEducationList(BaseSettings listEducation) {
    _eduList.clear();
    if (listEducation != null) {
      listEducation.options!.forEach((data) {
        _eduList.add(SelectionCaseModel(
            false, {"id": data.id, "name": data.value, "others": data.others}));
      });
    }
  }

  //graduation
  void addGraduationList(List<BaseSettings> listCourses) {
    graduateList.clear();
    if (listCourses != null) {
      listCourses.forEach((data) {
        graduateList.add(BaseSettings(
            isSelected: false, value: data.value, id: data.id, options: []));
      });
    }
  }

  Widget educationRange(List<SelectionCaseModel> selectionCaseModel) {
    _selectionCaseItems = [];
    for (int i = 0; i < /*specialCaseItems*/ selectionCaseModel.length; i++) {
      _selectionCaseItems.add(
        SelectionBox(
          onTap: () {
            setState(() {
              print('clicked $i : ${selectionCaseModel[i].item['others']}');
              selectionCaseModel.forEach((selectionItems) {
                selectionItems.isSelected = false;
              });
              selectionCaseModel[i].isSelected = true;
              _profileResponse.educationJob?.educationBranch =
                  BaseSettings(options: []);
              _profileResponse.educationJob?.highestEducation = BaseSettings(
                  id: selectionCaseModel[i].item['id'],
                  value: selectionCaseModel[i].item['name'],
                  options: []);
              print(isUgPG);
              _educationName = selectionCaseModel[i].item['name'];
              // _profileResponse.education = selectionCaseModel[i].item['id'];

              coursesBotomSheetList = getBaseSettingsOptionsByType(
                  _educationName, listEducation.options)!;
              addGraduationList(coursesBotomSheetList);
              if (coursesBotomSheetList.length != 0) {
                _showGraduateModel(_graduateCtrl);
                isUgPG = true;
              } else {
                isUgPG = false;
              }
            });
          },
          borderColor: selectionCaseModel[i].isSelected
              ? CoupledTheme().primaryPinkDark
              : Colors.white,
          innerColor: selectionCaseModel[i].isSelected
              ? CoupledTheme().primaryPinkDark
              : null,
          child: TextView(
            selectionCaseModel[i].item['name'],
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.visible,
            size: 12,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
          ),
        ),
      );
    }
    setState(() {
      print(isUgPG);
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(children: _selectionCaseItems),
        SizedBox(
          height: 20.0,
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          child: InkWell(
            onTap: () => _showGraduateModel(_graduateCtrl),
            child: isUgPG
                ? EditTextBordered(
                    hint: '${" in"}',
                    controller: _graduateCtrl,
                    size: 16.0,
                    enabled: false,
                  )
                : Container(),
          ),
        ),
      ],
    );
  }

  void _showGraduateModel(TextEditingController textCtrl) {
    showModalBottomSheet(
      enableDrag: false,
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: SubCatModal(
            buildWidget: WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: graduateList.length,
                        itemBuilder: (context, subIndex) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    textCtrl.text =
                                        graduateList[subIndex].value;
                                    _profileResponse
                                            .educationJob!.educationBranch =
                                        BaseSettings(
                                            id: graduateList[subIndex].id,
                                            value: graduateList[subIndex].value,
                                            options: []);

                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: TextView(
                                    graduateList[subIndex].value,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    size: 18.0,
                                    decoration: TextDecoration.none,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,
                                  ),
                                ),
                              ),
                              Divider(
                                color: Color(0xffe2e2e2),
                                height: 1.0,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  void _incomeBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextView(
                      "Income Range (Monthly)",
                      color: Colors.black,
                      size: 18.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: _incomeList.length,
                            itemBuilder: (context, i) {
                              return SelectionBox(
                                  height: 50.0,
                                  radius: 5.0,
                                  onTap: () {
                                    setState(() {
                                      _incomeRange = _incomeList[i]["value"];
                                      _profileResponse
                                              .educationJob!.incomeRange =
                                          BaseSettings(
                                              id: _incomeList[i]['id'],
                                              value: _incomeList[i]['value'],
                                              options: []);

                                      Navigator.pop(context);
                                    });
                                  },
                                  borderColor: Colors.black,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      TextView(
                                        _incomeList[i]["value"],
                                        color: Colors.black,
                                        size: 16.0,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none,
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: .8,
                                      ),
                                    ],
                                  ));
                            }),
                      ),
                    )
                  ],
                )),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}

class SelectionCaseModel {
  bool isSelected = false;

  final Map item;

  SelectionCaseModel(this.isSelected, this.item);

  @override
  String toString() {
    return 'SelectionCaseModel{isSelected: $isSelected, item: $item}';
  }
}
