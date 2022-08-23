import 'dart:async';
import 'dart:io';

import 'package:coupled/REST/RestAPI.dart';

import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/Modals/sub_cat_modal.dart';
import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/photo_view.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';

import 'package:coupled/registration_new/app_bar.dart';
import 'package:coupled/registration_new/get_bottom_button.dart';
import 'package:coupled/registration_new/helpers/get_baseSettings.dart';
import 'package:coupled/registration_new/helpers/get_section_data.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';

class ProEduA extends StatefulWidget {
  static String route = 'ProEduA';

  @override
  _ProEduState createState() => _ProEduState();
}

class _ProEduState extends State<ProEduA>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TextEditingController companyCtrl = TextEditingController(),
      govCtrl = TextEditingController(),
      designationCtrl = TextEditingController();

  bool isPresentJob = false;
  bool isEdited = false;
  bool isDeleted = false;

  bool isTextedited = false;
  List<BaseSettings> buildList = [];
  // PageController pageController;
  dynamic _officeImage;
  String _ofcImage = '';

  List<BaseSettings> _baseSettings = [];
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

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().getImage(source: source);

    setState(() {
      isEdited = true;

      _officeImage = File(image!.path);
      // _profileResponse.officeId = File(image.path);
      _profileResponse.officialDocuments!.officeId = File(image.path);
      Navigator.of(context).pop();
    });
    print("noel");
    print(_officeImage);
    print('_profileResponse.officialDocuments.officeId-----');
    print(_profileResponse.officialDocuments!.officeId);
  }

  List<BaseSettings> _companyList = [];
  List<BaseSettings> buildSubItem = [];
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  void _showCompanyList(TextEditingController textCtrl) {
    //  _profileResponse.educationJob.jobStatus = 1;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(20.0),
            child: SubCatModal(
              listItem: _companyList,
              onValueChange: (item) {
                item.options.forEach((itemSub) {
                  buildList.forEach((f) {
                    if (f.value == item.value) {
                      govCtrl.text = item.value;
                      print("item.title :${item.value}");

                      f.options!.forEach((v) {
                        if (v.value == itemSub.value) {
                          textCtrl.text = itemSub.value;
                        }
                      });
                    }
                  });
                });

                print("onValueChange ${item.toString()}");
              },
              buildWidget: Column(
                children: List.generate(
                  buildList.length,
                  (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextView(
                            buildList[index].value,
                            color: Colors.black,
                            size: 18.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: buildList[index].options!.length,
                          itemBuilder: (context, subIndex) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // buildList[index].others == 'not_working'
                                      //     ? isPresentJob = false
                                      //     : isPresentJob = true;

                                      govCtrl.text = buildList[index].value;
                                      print(
                                          "item.title :${buildList[index].value}");
                                      textCtrl.text = buildList[index]
                                          .options![subIndex]
                                          .value;
                                      _profileResponse.educationJob!.industry =
                                          BaseSettings(
                                              id: buildList[index].id,
                                              value: buildList[index].value,
                                              options: []);

                                      _profileResponse
                                              .educationJob!.profession =
                                          BaseSettings(
                                              id: buildList[index]
                                                  .options![subIndex]
                                                  .id,
                                              value: buildList[index]
                                                  .options![subIndex]
                                                  .value,
                                              options: []);

                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: TextView(
                                      buildList[index].options![subIndex].value,
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
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _chooseAction() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              color: Color(0xffc0c0c0),
              height: 150.0,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      splashColor: Colors.grey,
                      onTap: () {
                        getImage(ImageSource.gallery);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/gallery.png",
                            width: 50.0,
                            height: 50.0,
                          ),
                          TextView(
                            "Gallery",
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.visible,
                            size: 12,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getImage(ImageSource.camera);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/ic_camera.png",
                            height: 50.0,
                            width: 50.0,
                          ),
                          TextView(
                            "Camera",
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.visible,
                            size: 12,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  BaseSettings listIndustry = BaseSettings(options: []);
  BaseSettings listBaseSettings = BaseSettings(options: []);

  @override
  void didChangeDependencies() {
    _baseSettings = GlobalData.baseSettings;
    _profileResponse = GlobalData.myProfile;
    print('_profileResponse.educationJob.companyName----');
    print(_profileResponse.educationJob!.companyName);
    companyCtrl.text = '';
    print("noelxx");
    _profileResponse.educationJob = _profileResponse.educationJob ??
        EducationJob(
            educationBranch: BaseSettings(options: []),
            experience: BaseSettings(options: []),
            highestEducation: BaseSettings(options: []),
            incomeRange: BaseSettings(options: []),
            industry: BaseSettings(options: []),
            profession: BaseSettings(options: []));
    listIndustry = getBaseSettingsByType(
        CoupledStrings.baseSettingsIndustry, _baseSettings);
    buildList.clear();
    listIndustry.options!.forEach((data) {
      buildList.add(BaseSettings(
          id: data.id,
          value: data.value,
          options: data.options,
          others: data.others));
    });

    EducationJob? temp = _profileResponse.educationJob;

    if (temp != null) {
      print('temp---------');
      print(temp.jobStatus);

      companyCtrl.text = _profileResponse.educationJob!.companyName != null
          ? _profileResponse.educationJob!.companyName.toString()
          : '';
      print(_profileResponse.educationJob!.companyName);

      govCtrl.text =
          temp.industry?.value != null ? temp.industry!.value.toString() : '';
      designationCtrl.text = temp.profession?.value != null
          ? temp.profession!.value.toString()
          : '';
      isPresentJob = temp.jobStatus == 1;
    } else {}
    print("companyCtrl===============");
    print(companyCtrl.text);

    print('_profileResponse.officialDocuments--------');
    print(_profileResponse.officialDocuments!.id);
    print(_profileResponse.officialDocuments);

    if (_profileResponse.officialDocuments!.officeId != null) {
      /*  _ofcImage = _profileResponse?.officialDocuments?.officeId;
    } else {*/

      /// image is compresses in coversion to thumb
      /* _ofcImage = APis().imageApi(_profileResponse.officialDocuments.officeId,
          imageFolder: ImageFolder.DOCUMENT,
          imageConversion: ImageConversion.THUMB,
          imageSize: 200);*/

      /// image is coming correctly in media
      _ofcImage = APis().imageApi(_profileResponse.officialDocuments?.officeId,
          imageFolder: ImageFolder.DOCUMENT,
          imageConversion: ImageConversion.MEDIA);

      _findPath(_ofcImage).then((onValue) {
        //_profileResponse.officialDocuments.govtIdFront = onValue;

        print('GlobalData.myProfile.officialDocuments?.officeid======');

        setState(() {
          print("jamu");
          print(GlobalData.myProfile.officeId);

          GlobalData.myProfile.officialDocuments?.officeId = onValue;
        });
        print("jango");
        print(_ofcImage);
        print(_profileResponse.officialDocuments?.officeId);
        print(GlobalData.myProfile.officialDocuments?.officeId);
      });
    }

    super.didChangeDependencies();
  }

  Future<File> _findPath(String imageUrl) async {
//       var cache = await DefaultCacheManager().getFile(imageUrl);
//    final file = await cache.getFile(imageUrl);

    print("offices");
    print(_profileResponse.officialDocuments?.officeId);
    var file = await DefaultCacheManager().getSingleFile(imageUrl);
    print("imageurl");
    print(imageUrl);
    print('file-----');
    print(file);
    print('$file');
    return file;
  }

  @override
  void initState() {
    isEdited = false;
    isDeleted = false;
    isTextedited = false;
    /* new Timer.periodic(
        Duration(seconds: 3),
        (Timer t) => setState(() {

            }));*/
    print("jakes");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('isEdited--------');
    print(isEdited);
    super.build(context);
    return WillPopScope(
      onWillPop: () {
        return Dialogs().showDialogExitApp(context);
      },
      child: Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        appBar: getRegAppBar(context,
            progress: 0.65,
            title: 'Education & Profession',
            step: 14,
            params: getProfEducationA(
                isEdited: isEdited,
                isDeleted: isDeleted,
                isTextedited: isTextedited)),
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
                    TextView(
                      "Occupation Details",
                      size: 18.0,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .9,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    CustomCheckBox(
                      text: "Present Job",
                      value: isPresentJob,
                      onChanged: (isChecked) {
                        setState(() {
                          isPresentJob = isChecked!;
                          _profileResponse.educationJob?.jobStatus =
                              isPresentJob ? 1 : 0;
                        });
                      },
                      secondary: SizedBox(),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    EditTextBordered(
                        onSubmitted: (value) {
                          print("istextedited");
                          print("value");
                          print(value);
                          isTextedited = true;
                          print(isTextedited);
                        },
                        enabled: true,
                        controller: companyCtrl,
                        size: 16.0,
                        hint: "Company Name (optional)",
                        onChange: (value) {
                          setState(() {
                            _profileResponse.educationJob?.companyName =
                                companyCtrl.text;
                          });
                        }),
                    SizedBox(
                      height: 30.0,
                    ),
                    InkWell(
                      splashColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        setState(() {
                          setState(() {
                            _showCompanyList(designationCtrl);
                          });
                        });
                      },
                      child: EditTextBordered(
                        enabled: false,
                        controller: govCtrl,
                        size: 16.0,
                        hint: "Profession Type",
                        icon: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 25.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    InkWell(
                        splashColor: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {
                          setState(() {
                            _showCompanyList(designationCtrl);
                          });
                        },
                        child: EditTextBordered(
                          enabled: false,
                          controller: designationCtrl,
                          size: 16.0,
                          hint: "Profession",
                          icon: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: <Widget>[
                        /*  GestureDetector(
                          onTap: () {
                            _chooseAction();
                          },
                          child: Image.asset(
                            "assets/add_image.png",
                            height: 20.0,
                            width: 20.0,
                          ),
                        ),*/
                        SizedBox(
                          width: 10.0,
                        ),
                        TextView(
                          "Upload Office ID (Optional)",
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          size: 12,
                          textAlign: TextAlign.center,
                          textScaleFactor: .9,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: BtnWithText(
                                    img: _officeImage != null
                                        ? _officeImage
                                        : (_ofcImage.isNotEmpty ?? false)
                                            ? _ofcImage
                                            : "assets/add_image.png",
                                    customSize: 60.0,
                                    onTap: () {
                                      print("_officeimage");
                                      print(_officeImage);

                                      _chooseAction();
                                    },
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    child: Visibility(
                                      visible: _profileResponse
                                              .officialDocuments?.officeId !=
                                          null,
                                      child: CustomButton(
                                        onPressed: () {
                                          setState(() {
                                            isDeleted = true;
                                            _officeImage =
                                                "assets/add_image.png";
                                            _profileResponse.officialDocuments!
                                                .officeId = null;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(
                                              child: TextView(
                                            'x',
                                            size: 16,
                                            color: Colors.black,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                          )),
                                        ),
                                        gradient:
                                            LinearGradient(colors: <Color>[
                                          Colors.red,
                                          Colors.red,
                                        ]),
                                        shape: ButtonType.BUTTON_ROUND,
                                      ),
                                    ))
                              ],
                            ),
                            Visibility(
                              visible: _profileResponse
                                          .officialDocuments?.officeId !=
                                      null
                                  ? true
                                  : false,
                              child: CustomButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewPhoto(
                                        img: _officeImage != null
                                            ? _officeImage
                                            : (_ofcImage.isNotEmpty ?? false)
                                                ? _ofcImage
                                                : "assets/add_image.png",
                                      ),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(12.0),
                                gradient: LinearGradient(colors: [
                                  CoupledTheme().primaryPinkDark,
                                  CoupledTheme().primaryPink
                                ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 5),
                                  child: TextView(
                                    "View",
                                    size: 14,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            _profileResponse.officialDocuments
                                        ?.officeIdRejectStatus ==
                                    1
                                ? Visibility(
                                    visible: _profileResponse.officialDocuments
                                                    ?.officeIdRejectStatus ==
                                                0 ||
                                            _profileResponse.officialDocuments
                                                    ?.officeId ==
                                                null ||
                                            isEdited == true
                                        ? false
                                        : true,
                                    child: TextView(
                                      "(Rejected)",
                                      color: Colors.red,
                                      size: 16,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
            getBottomNavigationButtons(
                step: 14,
                params: getProfEducationA(
                    isEdited: isEdited,
                    isDeleted: isDeleted,
                    isTextedited: isTextedited))
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
