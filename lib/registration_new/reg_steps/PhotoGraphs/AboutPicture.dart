import 'dart:async';

import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';

import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AboutPicture extends StatefulWidget {
  static String route = 'AboutPicture';

//  final bool isUpdate;
  final BuildContext context;

//  final List<PhotoModel> photoModels;

//  final StreamController photoStream;
  final dynamic profileEdit;
  final ProfileResponse profileResponse;
  final List<BaseSettings> baseSettings;
  final int showImage;

  AboutPicture({
//    this.isUpdate,
    required this.context,
//    this.photoStream,
    this.profileEdit,
//    this.photoModels,
    required this.profileResponse,
    required this.baseSettings,
    this.showImage = 0,
  });

  @override
  _AboutPictureState createState() => _AboutPictureState();
}

class _AboutPictureState extends State<AboutPicture> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<CustomRadioModel> photoTaken = [];
  List<CustomRadioModel> photoTypes = [];
  late PageController _pageController;
  List<PhotoModel> photoModels = [];
  int currentIndex = 0;
  bool _actionMade = false;
  BaseSettings listPhotoAge = BaseSettings(options: []),
      listPhotoType = BaseSettings(options: []);

  bool _isLoading = false;

  Widget setCustomRadio(
      bool isType, PhotoModel photoModel, CustomRadioModel customRadio) {
    if (!isType) {
      if (photoModel.photoTaken == customRadio.id) {
        customRadio.isSelected = true;

        ///Pre value setting
        photoModel.photoTakenName = customRadio.text;
        photoModel.photoTaken = customRadio.id;
      } else {
        customRadio.isSelected = false;
      }
    } else {
      if (photoModel.photoType == customRadio.id) {
        customRadio.isSelected = true;

        ///Pre value setting
        photoModel.photoTypeName = customRadio.text;
        photoModel.photoType = customRadio.id;
      } else {
        customRadio.isSelected = false;
      }
    }

    return CustomRadio(customRadio);
  }

  Future<void> addEditPhoto(
      {required PhotoModel photoModel, bool isEdit = false}) async {
    print("addEditPhoto :: $isEdit}   ${photoModels.toList()}");
    List<PhotoModel> photos = photoModels.where((test) {
      return test.photoTaken == 0 || test.photoType == 0;
    }).toList();
    if (photos.length > 1) {
      GlobalWidgets().showSnackBar(
          _scaffoldKey, "Photo taken and photo type are required");
    } else if (isEdit) {
      try {
        setState(() {
          _isLoading = true;
        });
        await RestAPI()
            .post(APis.photoSection, params: photoModel.toJsonEdit());
        setState(() {
          _isLoading = false;
          _actionMade = true;
        });
        Navigator.pop(widget.context, photoModels);
      } on Exception catch (e) {
        GlobalWidgets().showSomethingWrong(_scaffoldKey);
        print('$e');
        setState(() {
          _isLoading = false;
          _actionMade = false;
        });
      }
    } else {
      try {
        print("addEditPhoto :::  ${photoModels[photoModels.length - 1]}");
        setState(() {
          _isLoading = true;
        });
        Map res = await RestAPI().multiPart<Map>(APis.photoSection,
            params: photoModel.toJsonAdd(isFacebook: false));
        setState(() {
          print("AddEDit:::");
          print("About Pic : $res");
          photoModel
            ..id = res["id"]
            ..profileImageFile = null
            ..networkImgUrl = APis().imageApi(res["photo_names"]);
          print("addEditPhoto :::  ${photoModels[photoModels.length - 1]}");
          _isLoading = false;
          _actionMade = true;
          Navigator.pop(widget.context, photoModels);
        });
      } on RestException catch (e) {
        GlobalWidgets().showSomethingWrong(_scaffoldKey);
        print('$e');
        setState(() {
          _actionMade = false;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _deletePhoto(PhotoModel photoModel) async {
    if (photoModel.isProPic) {
      GlobalWidgets().showSnackBar(
          _scaffoldKey,
          'If you wish to delete this photo, make any other photo '
          'as your profile picture.',
          actions: SnackBarAction(
            label: "Ok",
            onPressed: () => _scaffoldKey.currentState!.hideCurrentSnackBar(),
            textColor: CoupledTheme().primaryPink,
          ));
      return;
    }
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextView(
            'Alert',
            color: Colors.white,
            size: 14,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
          ),
          content: TextView(
            'Do you want to delete this photo?',
            color: Colors.white,
            size: 14,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
          ),
          actions: <Widget>[
            FlatButton(
              child: TextView(
                'Yes',
                color: Colors.black,
                size: 14,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
              ),
              onPressed: () {
                RestAPI().post(
                  APis.photoSection,
                  params: {'type': 'delete', 'id': photoModel.id.toString()},
                ).then((onValue) {
                  print("About Pic : $onValue; $photoModel");
                  setState(() {
                    Navigator.pop(context);
                    _actionMade = true;
                    print(
                        "Delete::: ${currentIndex == photoModels.length - 1}");
                    if (currentIndex == photoModels.length - 1) currentIndex--;

                    print('${photoModels.remove(photoModel)}');
                    print('${photoModels.length}');
//	                        Navigator.pop(widget.context, photoModels);
                  });
                }).catchError((onError) {
                  GlobalWidgets().showSomethingWrong(_scaffoldKey);
                  print(onError);
                  setState(() {
                    _actionMade = false;
                  });
                });
              },
            ),
            FlatButton(
              child: TextView(
                'No',
                color: Colors.white,
                size: 14,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    listPhotoAge = listPhotoAge ??
        getDetailsByType(
            CoupledStrings.baseSettingsPhotoAge, widget.baseSettings);
    listPhotoType = listPhotoType ??
        getDetailsByType(
            CoupledStrings.baseSettingsPhotoType, widget.baseSettings);
    if (listPhotoAge != null && photoTaken.length <= 0) {
      listPhotoAge.options!.sort((a, b) => a.id.compareTo(b.id));
      listPhotoAge.options!.forEach((f) {
        if (listPhotoAge.options![0] == f) {
          photoTaken
              .add(CustomRadioModel(false, f.id, f.value, true, 50.0, 0.0));
        } else if (listPhotoAge.options![listPhotoAge.options!.length - 1] == f)
          photoTaken
              .add(CustomRadioModel(false, f.id, f.value, false, 0.0, 50.0));
        else
          photoTaken
              .add(CustomRadioModel(false, f.id, f.value, true, 0.0, 0.0));
      });
    }
    if (listPhotoType != null && photoTypes.length <= 0) {
      listPhotoType.options!.sort((a, b) => a.id.compareTo(b.id));
      listPhotoType.options!.forEach((f) {
        if (listPhotoType.options![0] == f) {
          photoTypes
              .add(CustomRadioModel(false, f.id, f.value, true, 50.0, 0.0));
        } else if (listPhotoType.options![listPhotoType.options!.length - 1] ==
            f)
          photoTypes
              .add(CustomRadioModel(false, f.id, f.value, false, 0.0, 50.0));
        else
          photoTypes
              .add(CustomRadioModel(false, f.id, f.value, true, 0.0, 0.0));
      });
    }

    photoModels = widget.profileResponse.photoData;
    currentIndex = widget.showImage;
    print(
        "OnPageChanged :intial ${photoModels[currentIndex].id}    ${photoModels[currentIndex].id != 0}");

    ///[currentIndex-1] to not show the add picture widget
    _pageController = PageController(initialPage: currentIndex - 1);
    print("didChangeDependencies :::  ${photoModels.toList()}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CoupledTheme()
          .coupledTheme2()
          .copyWith(unselectedWidgetColor: Colors.white),
      child: WillPopScope(
        onWillPop: () async {
          if (_actionMade) Navigator.pop(context, photoModels);
          photoModels.removeWhere((element) => element.id == 0);
          _actionMade = false;
          return true;
        },
        child: Scaffold(
            backgroundColor: CoupledTheme().backgroundColor,
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 3.0,
              backgroundColor: CoupledTheme().backgroundColor,
              title: TextView(
                photoModels[currentIndex].id != 0 ? "Edit" : 'Upload Photo',
                size: 24.0,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
              ),
            ),
            body: PageView.builder(
              controller: _pageController,
              itemCount: photoModels.length - 1,
              dragStartBehavior: DragStartBehavior.start,
              onPageChanged: (index) {
                setState(() {
                  print(("index ::::::$index   ${photoModels[index]}"));
                  currentIndex = index + 1;
                  print(
                      "OnPageChanged :${photoModels[currentIndex].id}  ${photoModels[currentIndex].id != 0}");
                });
              },
              itemBuilder: (context, index) {
                PhotoModel photoModel = photoModels[index + 1];
                print("PhotoModel in PageView:: $photoModel");
                return Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Card(
                                  color: CoupledTheme().backgroundColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  clipBehavior: Clip.antiAlias,
                                  borderOnForeground: true,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Hero(
                                      tag: ObjectKey(photoModel),
                                      child: photoModel.profileImageFile != null
                                          ? FadeInImage(
                                              placeholder: AssetImage(
                                                  "assets/no_image.jpg"),
                                              image: FileImage(
                                                  photoModel.profileImageFile),
                                              fit: BoxFit.fitWidth,
                                            )
                                          : FadeInImage(
                                              placeholder: AssetImage(
                                                  "assets/no_image.jpg"),
                                              image: NetworkImage(
                                                  photoModel.networkImgUrl),
                                              fit: BoxFit.fitWidth,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            CustomCheckBox(
                              text: "Set as profile pic",
                              value: photoModel.isProPic,
                              onChanged: (value) {
                                setState(() {
                                  print("set as pro pic $value");

                                  //  var s = photoModels.where((test) => test.isProPic);
                                  if (!value!) {
                                    GlobalWidgets().showSnackBar(
                                        _scaffoldKey,
                                        "If you wish to uncheck the profile picture, choose another photo "
                                        "as your profile picture",
                                        actions: SnackBarAction(
                                            label: "Ok",
                                            textColor:
                                                CoupledTheme().primaryPink,
                                            onPressed: () => _scaffoldKey
                                                .currentState!
                                                .hideCurrentSnackBar()));
                                  } else {
                                    photoModels
                                        .singleWhere(
                                          (test) => test.isProPic,
                                        )
                                        .isProPic = false;
                                    photoModel.isProPic = value;
                                  }

                                  //
                                });
                              },
                              secondary: SizedBox(),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                  border: Border.all(color: Colors.white)),
                              margin: EdgeInsets.only(top: 20.0),
                              height: 30.0,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: photoTaken.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (photoTaken[index]
                                              .text
                                              .toLowerCase() ==
                                          'old') {
                                        print("Inside");

                                        GlobalWidgets().showSnackBar(
                                            _scaffoldKey,
                                            CoupledStrings.profileOldMsg,
                                            actions: SnackBarAction(
                                                label: "Ok",
                                                textColor:
                                                    CoupledTheme().primaryPink,
                                                onPressed: () {
                                                  _scaffoldKey.currentState!
                                                      .hideCurrentSnackBar();
                                                }));
                                      }
                                      setState(() {
                                        photoModel.photoTaken =
                                            photoTaken[index].id;
                                        photoModel.photoTakenName =
                                            photoTaken[index].text;
                                        print(
                                            "Photo Taken :: ${photoModel.toString()}\n${photoTaken[index]}");
                                      });
                                    },
                                    child: setCustomRadio(
                                        false, photoModel, photoTaken[index]),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                  border: Border.all(color: Colors.white)),
                              height: 30.0,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: photoTypes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        photoModel.photoType =
                                            photoTypes[index].id;
                                        photoModel.photoTypeName =
                                            photoTypes[index].text;
                                        print(
                                            "Photo Type $index :: ${photoModel.toString()}\n${photoTypes[index]}");
                                      });
                                    },
                                    child: setCustomRadio(
                                        true, photoModel, photoTypes[index]),
                                  );
                                },
                              ),
                            ),
                            photoModel.id != 0
                                ? Container(
                                    margin:
                                        EdgeInsets.only(top: 20.0, left: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        _deletePhoto(photoModel);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.delete,
                                            color:
                                                CoupledTheme().primaryPinkDark,
                                          ),
                                          TextView(
                                            "Delete Photo",
                                            color:
                                                CoupledTheme().primaryPinkDark,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.visible,
                                            size: 12,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: kToolbarHeight,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _isLoading
                          ? Container(
                              color: Colors.white,
                              height: kToolbarHeight,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.black),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                //  widget.bloc.submit(Section(whichSection: 9, params: _profileResponse.getSectionTen()));
                                print("upload----------------");

                                if (photoModel.id != 0) {
                                  addEditPhoto(
                                      photoModel: photoModel, isEdit: true);
                                } else
                                  addEditPhoto(photoModel: photoModel);
                              },
                              child: Container(
                                color: Colors.white,
                                height: kToolbarHeight,
                                child: Center(
                                  child: TextView(
                                    photoModel.id != 0
                                        ? "Update Photo"
                                        : "Upload",
                                    size: 22.0,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}

BaseSettings getDetailsByType(type, List<BaseSettings> baseSettings) {
  return baseSettings.singleWhere(
    (test) => test.value == type,
  );
}
