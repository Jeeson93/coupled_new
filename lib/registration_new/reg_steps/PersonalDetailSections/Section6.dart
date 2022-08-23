import 'dart:io';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
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

class SectionSix extends StatefulWidget {
  static String route = 'SectionSix';

  _SectionSixState createState() => _SectionSixState();
}

class _SectionSixState extends State<SectionSix>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  String errorText = "";
  dynamic _fImage, _bImage;
  String fImageUrl = '', bImageUrl = '';
  List<Map> listGovId = [];
  Map initialValue = {};

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
  List<BaseSettings> _baseSettings = [];

  bool isEdited = false;
  bool isDeleted = false;
  bool isDeletedback = false;

  Future getImage(String whichSide, ImageSource source) async {
    //var image = await ImagePicker.pickImage(source: source);
    var image = await ImagePicker().getImage(source: source);
    print("IMAGE : ${image.toString()}");
    setState(() {
      isEdited = true;
      if (whichSide == 'front') {
        _fImage = File(image!.path);
        _profileResponse.officialDocuments!.govtIdFront = File(image.path);
      } else {
        _bImage = File(image!.path);
        _profileResponse.officialDocuments!.govtIdBack = File(image.path);
      }

      Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    isEdited = false;
    isDeleted = false;
    isDeletedback = false;

    _baseSettings = GlobalData.baseSettings;
    _profileResponse = GlobalData.myProfile;
    _profileResponse.officialDocuments =
        _profileResponse.officialDocuments ?? OfficialDocuments();

    BaseSettings _listGovId =
        getBaseSettingsByType(CoupledStrings.baseSettingsGovt, _baseSettings);
    print("GOVT : $_listGovId");

    print('_profileResponse.officialDocuments.govtIdBack------');
    print(_profileResponse.officialDocuments);

    if (_listGovId != null && listGovId.length == 0) {
      // listGovId.add({'id': 0, 'name': "Select Card"});

      _listGovId.options!.forEach((i) {
        listGovId.add({'id': i.id, 'name': i.value});
      });
      //initialValue = listGovId[0];

      if (_profileResponse.officialDocuments != null) {
        listGovId.forEach((data) {
          print("data $data");
          if (_profileResponse.officialDocuments!.govtIdType == data["id"]) {
            initialValue = data;
            _profileResponse.officialDocuments!.govtIdType = data["id"];
          }
        });

        if (_profileResponse.officialDocuments!.govtIdFront != null) {
          fImageUrl = APis().imageApi(
              _profileResponse.officialDocuments!.govtIdFront,
              imageConversion: ImageConversion.MEDIA,
              imageFolder: ImageFolder.DOCUMENT);
          _findPath(fImageUrl).then((onValue) {
            _profileResponse.officialDocuments!.govtIdFront = onValue;

            print('GlobalData.myProfile.officialDocuments?.govtIdFront======');
            setState(() {
              GlobalData.myProfile.officialDocuments!.govtIdFront = onValue;
            });
            print(GlobalData.myProfile.officialDocuments!.govtIdFront);
          });
        }
        if (_profileResponse.officialDocuments!.govtIdBack != null) {
          bImageUrl = APis().imageApi(
              _profileResponse.officialDocuments!.govtIdBack,
              imageConversion: ImageConversion.MEDIA,
              imageFolder: ImageFolder.DOCUMENT);
          _findPath(bImageUrl).then((onValue) {
            setState(() {
              _profileResponse.officialDocuments!.govtIdBack = onValue;
            });
          });
        }
      }
    }
    print('GlobalData.myProfile.officialDocuments?.govtIdFront======2');
    print(GlobalData.myProfile.officialDocuments!.govtIdFront);
    super.initState();
  }

  void _chooseAction(String whichSide) {
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
                        getImage(whichSide, ImageSource.gallery);
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
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getImage(whichSide, ImageSource.camera);
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
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                            size: 12,
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

  Future<File> _findPath(String imageUrl) async {
//       var cache = await DefaultCacheManager().getFile(imageUrl);
//    final file = await cache.getFile(imageUrl);
    var file = await DefaultCacheManager().getSingleFile(imageUrl);
    print('file-----');
    print('$file');
    return file;
  }

  @override
  Widget build(BuildContext context) {
    print('initialValue------------');
    print('$initialValue');
    print(isDeleted);
    super.build(context);

    return WillPopScope(
      onWillPop: () {
        return Dialogs().showDialogExitApp(context);
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Scaffold(
          backgroundColor: CoupledTheme().backgroundColor,
          appBar: getRegAppBar(context,
              progress: 0.432,
              title: 'Personal Details (Optional)',
              step: 6,
              params: getSectionSix(
                  isEdited: isEdited,
                  isDeleted: isDeleted,
                  isDeletedback: isDeletedback)),
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
                      "Help to create world's largest love platform of genuine matrimonial profiles.",
                      color: CoupledTheme().primaryPink,
                      size: 18.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextView(
                      "Upload a Government Id",
                      size: 18.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomDropDown(
                          listGovId,
                          radius: 5.0,
                          hint: 'Select ID',
                          initValue: initialValue,
                          onChange: (value) {
                            setState(() {
                              initialValue = value;
                              _profileResponse.officialDocuments!.govtIdType =
                                  initialValue["id"] == 0 ? 0 : value['id'];
                              errorText = "";
                            });
                          },
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: BtnWithText(
                                    img: _fImage != null
                                        ? _fImage
                                        : fImageUrl.isNotEmpty
                                            ? fImageUrl
                                            : "assets/add_image.png",
                                    text: "Front side",
                                    customSize: 60.0,
                                    onTap: () {
                                      setState(() {
                                        print(
                                            initialValue['name'].toLowerCase());
                                        if (initialValue['id'] == 0) {
                                          errorText = "Select a card";
                                        } else {
                                          _chooseAction("front");
                                          errorText = "";
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    child: Visibility(
                                      visible: _profileResponse
                                              .officialDocuments!.govtIdFront !=
                                          null,
                                      child: CustomButton(
                                        onPressed: () {
                                          setState(() {
                                            isDeleted = true;
                                            _fImage = "assets/add_image.png";
                                            _profileResponse.officialDocuments!
                                                .govtIdFront = null;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(
                                              child: TextView(
                                            'x',
                                            size: 16,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            color: Colors.black,
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
                            SizedBox(
                              height: 4,
                            ),
                            Visibility(
                              visible: _profileResponse
                                          .officialDocuments!.govtIdFront !=
                                      null
                                  ? true
                                  : false,
                              child: CustomButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewPhoto(
                                        img: _fImage != null
                                            ? _fImage
                                            : fImageUrl.isNotEmpty
                                                ? fImageUrl
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
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        /*GestureDetector(
                          onTap: (){
                            setState(() {
                              print(initialValue['name'].toLowerCase());
                              if (initialValue['id'] == 0) {
                                errorText = "Select a card";
                              } else {
                                _chooseAction("front");
                                errorText = "";
                              }
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              CachedNetworkImage(
                                width: 50,
                                height: 50,
                                imageUrl: fImageUrl,placeholder:(context,url)=>Image.asset("assets/add_image.png",height: 50,width: 50,),
                              ),
                              SizedBox(height: 5,),
                              TextView(
                                'Back side',
                                size: 10,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              print(initialValue['name'].toLowerCase());
                              if (initialValue['id'] == 0) {
                                errorText = "Select a card";
                              } else {
                                _chooseAction("back");
                                errorText = "";
                              }
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              CachedNetworkImage(
                                width: 50,
                                height: 50,
                                imageUrl: bImageUrl,placeholder:(context,url)=>Image.asset("assets/add_image.png",height: 50,width: 50,),
                              ),
                              SizedBox(height: 5,),
                              TextView(
                                'Back side',
                                size: 10,
                              )
                            ],
                          ),
                        ),*/

                        Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: BtnWithText(
                                    img: _bImage != null
                                        ? _bImage
                                        : bImageUrl.isNotEmpty
                                            ? bImageUrl
                                            : "assets/add_image.png",
                                    text: "Back side",
                                    customSize: 60.0,
                                    onTap: () {
                                      setState(() {
                                        print(
                                            initialValue['name'].toLowerCase());
                                        if (initialValue['id'] == 0) {
                                          errorText = "Select a card";
                                        } else {
                                          _chooseAction("back");
                                          errorText = "";
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    child: Visibility(
                                      visible: _profileResponse
                                              .officialDocuments!.govtIdBack !=
                                          null,
                                      child: CustomButton(
                                        onPressed: () {
                                          setState(() {
                                            isDeletedback = true;
                                            _bImage = "assets/add_image.png";
                                            _profileResponse.officialDocuments!
                                                .govtIdBack = null;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(
                                              child: TextView(
                                            'x',
                                            size: 16,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            color: Colors.black,
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
                            SizedBox(
                              height: 4,
                            ),
                            Visibility(
                              visible: _profileResponse
                                          .officialDocuments!.govtIdBack !=
                                      null
                                  ? true
                                  : false,
                              child: CustomButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewPhoto(
                                        img: _bImage != null
                                            ? _bImage
                                            : bImageUrl.isNotEmpty
                                                ? bImageUrl
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
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    _profileResponse.officialDocuments!.govIdRejectStatus == 1
                        ? Visibility(
                            visible: _profileResponse.officialDocuments!
                                            .govIdRejectStatus ==
                                        0 ||
                                    _profileResponse
                                            .officialDocuments!.govtIdFront ==
                                        null ||
                                    _profileResponse
                                            .officialDocuments!.govtIdBack ==
                                        null ||
                                    isEdited == true
                                ? false
                                : true,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: Align(
                                alignment: Alignment.centerRight,
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
                              ),
                            ),
                          )
                        : Container(),
                    TextView(
                      errorText,
                      size: 10.0,
                      color: Colors.redAccent,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                    SizedBox(height: 20.0),
                    TextView(
                      "Your information is secured with us. Providing this would allow us to flag others that you are a genuine member.",
                      size: 12.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .9,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              getBottomNavigationButtons(
                  step: 6,
                  params: getSectionSix(
                      isEdited: isEdited,
                      isDeleted: isDeleted,
                      isDeletedback: isDeletedback))
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
