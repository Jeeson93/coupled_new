import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:coupled/REST/RestAPI.dart';

import 'package:coupled/Utils/Modals/dialogs.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';

import 'package:coupled/registration_new/app_bar.dart';
import 'package:coupled/registration_new/get_bottom_button.dart';
import 'package:coupled/registration_new/helpers/get_section_data.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

import 'AboutPicture.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

const int fadeInImageDuration = 350;

class PhotoA extends StatefulWidget {
  static String route = 'PhotoA';

  @override
  _PhotoAState createState() => _PhotoAState();
}

class _PhotoAState extends State<PhotoA>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  static final FacebookLogin facebookSignIn = FacebookLogin();
  var photoCount = 0;

  File imageFile = File('');

//  List<Asset> images;
  ByteData by = ByteData(0);

  /* final _user = StreamController<PhotoModel>();
  Sink get updateUser => _user.sink;
  Stream<PhotoModel> get user1 => _user.stream;*/

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

  // List<PhotoModel> _profileResponse.photoData = List<PhotoModel>();

  Future getImage(BuildContext context, ImageSource source) async {
    try {
      PickedFile? pickedFile = await ImagePicker().getImage(source: source);
      print("hi getIMage $pickedFile");
      print("hi getIMage ${pickedFile!.path}");

      /// code to crop the image
      CroppedFile croppedImage = (await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        maxWidth: 1080,
        maxHeight: 1080,
      )) as CroppedFile;
      print(croppedImage);

      if (croppedImage != null) {
        imageFile = File(croppedImage.path);
        setState(() {});
      }
      if (pickedFile != null) {
        PhotoModel model = PhotoModel(
            id: 0,
            isProPic: _profileResponse.photoData.length <= 1,
            imgName: Path.basename(pickedFile.path),
            profileImageFile: File(imageFile.path),
            networkImgUrl: '',
            photoType: 99,
            photoTaken: 93);
        _profileResponse.photoData.add(model);
        //TODO title shit
        //setTitle()
        print(model);
        await navigateAndDisplaySelection(
            index: _profileResponse.photoData.length - 1);
      }
    } catch (Exception) {
      //GlobalWidgets().showToast(msg:"something went wrong");
      print(Exception);
    }
  }

  Future navigateAndDisplaySelection({int index = 0}) async {
    List<PhotoModel>? photoData =
        await Navigator.of(context).push<List<PhotoModel>>(
      MaterialPageRoute(
          builder: (context) => AboutPicture(
                context: context,
//                photoModels: _profileResponse.photoData,
//                isUpdate: isUpdate,
                baseSettings: _baseSettings,
                profileResponse: _profileResponse,
                showImage: index,
              )),
    );
    if (mounted)
      setState(() {
        print("PHOTO ::: $photoData");
        if (photoData != null) {
          photos(photoData);

          ///TODO title
          //  setTitle();
        }
      });
  }

  Widget body = GlobalWidgets().showCircleProgress();

  @override
  void didChangeDependencies() {
    Repository().fetchProfile('').then((onValue) async {
      try {
        setState(() {
          GlobalData.myProfile = onValue;
          _profileResponse = GlobalData.myProfile;

          _profileResponse.photoData = [];
          photos([PhotoModel()]);
          _profileResponse.photos.forEach((item) {
            _profileResponse.photoData.add(PhotoModel(
                id: item?.id,
                createdAt: item?.createdAt,
                imgName: item?.photoName,
                networkImgUrl: APis().imageApi(
                  item?.photoName,
                ),
                photoType: item?.imageType?.id,
                photoTypeName: item?.imageType?.value,
                photoTaken: item?.imageTaken?.id,
                photoTakenName: item?.imageTaken?.value,
                isProPic: item?.dpStatus == 1));
            print("Print ::: ${item?.id}");
          });
          photos(_profileResponse.photoData);
          body = getBody();
        });
      } catch (e) {
        print(e);
      }
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    print('didChangeDependencies');
    _baseSettings = GlobalData.baseSettings;

    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  Future<Null> _facebookImagePicker(BuildContext context1) async {
    FacebookLoginResult result;
    FacebookAccessToken accessToken = FacebookAccessToken.fromMap({});
    bool isFBLoggedIn = await facebookSignIn.isLoggedIn;
    if (isFBLoggedIn) {
      accessToken = (await facebookSignIn.accessToken)!;
    } else {
      result = await facebookSignIn.logIn();
      switch (result.status) {
        case FacebookLoginStatus.success:
          accessToken = result.accessToken!;
          break;
        case FacebookLoginStatus.cancel:
          setState(() {
            GlobalWidgets()
                .showSnackBar(_scaffoldKey, "Login cancelled by the user.");
          });

          break;
        case FacebookLoginStatus.error:
          setState(() {
            GlobalWidgets().showSnackBar(
                _scaffoldKey,
                'Something went wrong with the login process.\n'
                'Here\'s the error Facebook gave us: ${result.error}');
          });
          break;
      }
    }
    // if (accessToken.token != null || accessToken.token != "")
    //   Navigator.of(context1).push(
    //     MaterialPageRoute(
    //       builder: (_) => FacebookImagePicker(
    //         accessToken.token,
    //         onDone: (items) {
    //           Navigator.pop(context);
    //           setState(() {
    //             items.forEach((data) {
    //               urlToFile(data.source).then((fbImage) {
    //                 _profileResponse.photoData.add(PhotoModel(
    //                     id: 0,
    //                     photoTypeName: 'facebook',
    //                     imgName: data.name,
    //                     profileImageFile: fbImage,
    //                     networkImgUrl: data.source,
    //                     photoType: 100,
    //                     photoTaken: 93));

    //                 navigateAndDisplaySelection(
    //                     index: _profileResponse.photoData.length - 1);
    //               });
    //             });
    //           });
    //         },
    //         onCancel: () {},
    //       ),
    //     ),
    //   );
  }

  Future<File> urlToFile(String imageUrl) async {
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  void _chooseAction(BuildContext context) {
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
                        Navigator.of(context).pop();
                        getImage(context, ImageSource.gallery);
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
                        Navigator.of(context).pop();
                        _facebookImagePicker(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/facebook.png",
                            height: 50.0,
                            width: 50.0,
                          ),
                          TextView(
                            "Facebook",
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
                        Navigator.of(context).pop();
                        getImage(context, ImageSource.camera);
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

  List<Widget> photoWrap = [];

  void photos(List<PhotoModel> data) {
    _profileResponse.photoData = data;
    photoWrap = [];
    print("PhotoData------------ : ${_profileResponse.photoData}");
    setState(() {
      data.where((test) => !test.isProPic).forEach((photoModel) {
        photoWrap.add(
          InkWell(
            key: ValueKey(photoModel),
            splashColor: Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              GlobalWidgets().printMsg("onTap photoWrap :: $photoModel");
              print(photoModel.id);
              if (photoModel.id == -1) {
                if (_profileResponse.photoData.length - 1 < 10) {
                  _chooseAction(context);
                } else {
                  GlobalWidgets()
                      .showSnackBar(_scaffoldKey, "Maximum photo uploaded");
                  print("Maximum photo uploaded");
                }
              } else {
                int index = _profileResponse.photoData
                    .indexWhere((test) => test.id == photoModel.id);
                print("index ::# $index ${_profileResponse.photoData[index]}");
                navigateAndDisplaySelection(index: index);
              }
            },
            child: Photographs(photoModel),
          ),
        );
      });
    });
    print('PhotoWrap : ${photoWrap.length}');
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex != 0 && oldIndex != 0) {
        print("Old $oldIndex  New $newIndex ");
        Widget row = photoWrap.removeAt(oldIndex);
        photoWrap.insert(newIndex, row);

        photoWrap.asMap().forEach((key, item) {
          _profileResponse.photoData.insert(key, (item.key) as PhotoModel);
        });
        _profileResponse.photoData.toSet();
        print(_profileResponse.photoData.toString());
        List<int> sortIds = [];
        PhotoModel pro = _profileResponse.photoData
            .singleWhere((test) => test.isProPic, orElse: () => PhotoModel());
        if (pro != null) sortIds.add(pro.id);
        photoWrap.forEach((f) {
          PhotoModel data = (f.key as ObjectKey).value as PhotoModel;
          if (data.id != -1 && !data.isProPic) sortIds.add(data.id);
        });
        print("SORT  ids : $sortIds");
        RestAPI().post(APis.photoSection,
            params: {"photos": sortIds, "type": "sort"});
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
  List _tiles = <Widget>[
    Icon(
      Icons.filter_1,
    ),
  ];

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    super.build(context);
//      var size = MediaQuery.of(context).size;
//      final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
//      final double itemWidth = size.width / 2;
    return WillPopScope(
      onWillPop: () {
        return Dialogs().showDialogExitApp(context);
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: CoupledTheme().backgroundColor,
        appBar: getRegAppBar(context,
            progress: 0.72,
            /* title:
                  'Photograph ${(_profileResponse?.photoData?.length ?? 1) - 1}/10',*/
            title: 'Photograph ${(_profileResponse.photos.length ?? 1)}/10',
            step: 10,
            params: getSectionTen()),
        body: body,
      ),
    );
  }

  Widget getBody() {
    return Stack(
      children: [
        Container(
          height: double.infinity,
        ),
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(
              top: 10.0, bottom: 100.0, left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InkWell(
                onTap: () {
                  int index = _profileResponse.photoData
                      .indexWhere((test) => test.isProPic);
                  //navigateAndDisplaySelection(index: index);
                },
                child: Hero(
                  tag: ObjectKey(_profileResponse.photoData.singleWhere(
                      (test) => test.isProPic,
                      orElse: () => PhotoModel())),
                  child: ProfileWidget(
                    photoModel: _profileResponse.photoData.singleWhere(
                        (test) => test.isProPic,
                        orElse: () => PhotoModel()),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              /*ReorderableWrap(
                spacing: 8.0,
                runSpacing: 4.0,
                padding: const EdgeInsets.all(8),
                children: _tiles,
                onReorder: _onReorder,
                onNoReorder: (int index) {
                  //this callback is optional
                  debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
                },
                onReorderStarted: (int index) {
                  //this callback is optional
                  debugPrint('${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
                }
            ),*/

              // ReorderableWrap(
              //     spacing: 8.0,
              //     runSpacing: 8.0,
              //     crossAxisAlignment: WrapCrossAlignment.center,
              //     maxMainAxisCount: 4,
              //     minMainAxisCount: 3,
              //     padding: const EdgeInsets.all(8),
              //     children: photoWrap,
              //     onReorder: _onReorder,
              //     onNoReorder: (int index) {
              //       //this callback is optional
              //       print(
              //           '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
              //     },
              //     onReorderStarted: (int index) {
              //       //this callback is optional

              //       print(
              //           '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
              //     }),
              Container(
                child: ReorderableGridView.extent(
                  shrinkWrap: true,
                  maxCrossAxisExtent: 250,
                  onReorder: _onReorder,
                  childAspectRatio: 1,
                  children: photoWrap,
                ),
              ),
            ],
          ),
        ),
        getBottomNavigationButtons(step: 10, params: getSectionTen())
      ],
    );
  }

  _cropImage(filePath) async {}
}

class Photographs extends StatelessWidget {
  final PhotoModel photoModel;

  Photographs(this.photoModel);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      width: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Card(
              color: CoupledTheme().backgroundColor,
              elevation: 3.0,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              child: photoModel.networkImgUrl == "" &&
                      photoModel.profileImageFile == null
                  ? Container(
                      padding: EdgeInsets.all(20.0),
                      color: Colors.white,
                      child: Image.asset(
                        "assets/add_image.png",
                        color: Colors.grey,
                      ),
                    )
                  : photoModel.profileImageFile != null
                      ? FadeInImage(
                          placeholder: AssetImage("assets/no_image.jpg"),
                          fadeInDuration:
                              Duration(milliseconds: fadeInImageDuration),
                          fadeOutDuration:
                              Duration(milliseconds: fadeInImageDuration),
                          image: FileImage(photoModel.profileImageFile),
                          //  fit: BoxFit.cover,
                        )
                      : FadeInImage(
                          placeholder: AssetImage("assets/no_image.jpg"),
                          image: NetworkImage(photoModel.networkImgUrl),
                          // fit: BoxFit.cover,
                        ),
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
            title: TextView(
              "${photoModel.networkImgUrl == "" && photoModel.profileImageFile == null ? '' : GlobalWidgets().getTime(photoModel.createdAt ?? DateTime.now())}",
              size: 10.0,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
            subtitle: TextView(
              "${photoModel.getPhotoT()}\n${photoModel.getPhotoTn()}",
              size: 12.0,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final PhotoModel photoModel;

  ProfileWidget({required this.photoModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextView(
            "Please upload vertical images for best output",
            size: 16.0,
            color: CoupledTheme().primaryBlue,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Card(
              color: CoupledTheme().backgroundColor,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              clipBehavior: Clip.antiAlias,
              child: photoModel.profileImageFile == null && !photoModel.isProPic
                  ? Container(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      child: Image.asset(
                        "assets/user_shape.png",
                        color: Colors.grey,
                      ),
                    )
                  : photoModel.profileImageFile != null
                      ? FadeInImage(
                          placeholder: AssetImage("assets/no_image.jpg"),
                          fadeInDuration:
                              Duration(milliseconds: fadeInImageDuration),
                          fadeOutDuration:
                              Duration(milliseconds: fadeInImageDuration),
                          image: FileImage(photoModel.profileImageFile),
                          fit: BoxFit.fitWidth,
                        )
                      : FadeInImage(
                          placeholder: AssetImage("assets/no_image.jpg"),
                          fadeInDuration:
                              Duration(milliseconds: fadeInImageDuration),
                          fadeOutDuration:
                              Duration(milliseconds: fadeInImageDuration),
                          image: NetworkImage(photoModel.networkImgUrl),
                          fit: BoxFit.fitWidth,
                        ),
            ),
          ),
          TextView(
            '${GlobalWidgets().getTime(photoModel.createdAt ?? DateTime.now())}',
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.visible,
            size: 12,
            textAlign: TextAlign.center,
            textScaleFactor: .9,
          ),
          TextView(
            "Profile Picture \n${photoModel.getPhotoT() == "Add Picture" ? "" : "${photoModel.getPhotoT()}, ${photoModel.getPhotoTn()}"}",
            size: 12.0,
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            textScaleFactor: .9,
          ),

          /*ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
            title: TextView(
                '${GlobalWidgets().getTime(photoModel?.createdAt ?? DateTime.now())}'),
            subtitle: TextView(
              "Profile Picture \n${photoModel?.getPhotoT() == "Add Picture" ? "" : "${photoModel?.getPhotoT()}, ${photoModel?.getPhotoTn()}"}",
              size: 12.0,
            ),
          )*/
        ],
      ),
    );
  }
}
