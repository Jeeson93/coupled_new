import 'dart:convert';
import 'dart:io';
import 'package:coupled/Home/DashBoard/dashboard.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../helpers/getAppStep.dart';
import 'coupling_questions/coupling_question.dart';

class MOEVerification extends StatefulWidget {
  static String route = 'MOEVerification';

  MOEVerification();

  @override
  _MOEVerificationState createState() => _MOEVerificationState();
}

class _MOEVerificationState extends State<MOEVerification>
    with SingleTickerProviderStateMixin {
  TextEditingController moeController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  late AnimationController _controller;
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
  late Animation<double> _fadeIn;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String email = '';
  bool moeValid = false;
  int _whichSection = 0;

  //RegisterBloc _bloc;
  Map<String, String> getSectionSeventeen = {};
  Map<String, String> getSectionEighteen = {};
  //var route = MaterialPageRoute(builder: (BuildContext context) =>   Dashboard();
  bool isVisibleVerifyOtp = false;
  bool isOtpVisible = false;

  Animation<Offset> slideTransmit(
      Offset _begin, Offset _end, AnimationController _controller) {
    Animation<Offset> anime;
    Animatable<Offset> animeOffset = Tween<Offset>(
      begin: _begin,
      end: _end,
    ).chain(
      CurveTween(
        curve: Curves.fastOutSlowIn,
      ),
    );
    anime = _controller.drive(animeOffset);
    return anime;
  }

  @override
  void didChangeDependencies() {
    // _bloc = RegisterBloc();
    // PersonalDetailsProvider.of(context).registerBloc.add(SetTitle("MOE"));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _profileResponse = GlobalData.myProfile;
    Repository().fetchProfile('').then((value) => GlobalData.myProfile = value);
    _controller = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);

    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Dialogs().showDialogExitApp(context);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: CoupledTheme().backgroundColor,
            leading: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, CouplingScoreQuestions.route);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
          backgroundColor: CoupledTheme().backgroundColor,
          key: _scaffoldKey,
          body: Padding(
            padding: EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextView(
                  "We would like to have your ${_profileResponse.userEmail == null ? "email id" : "mobile number"} for updates and communication.",
                  size: 18.0,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                ),
                SizedBox(
                  height: 30.0,
                ),
                EditTextBordered(
                  maxLength: _profileResponse.userEmail == null ? 100 : 10,
                  hint: _profileResponse.userEmail == null
                      ? "Email"
                      : "Mobile No.",
                  controller: moeController,
                  keyboardType: _profileResponse.userEmail == null
                      ? TextInputType.emailAddress
                      : TextInputType.phone,
                  onChange: (value) {
                    setState(() {
                      print('_profileResponse.userEmail');
                      print(_profileResponse.userEmail);
                      _controller.reverse();
                      otpController.clear();
                      if (_profileResponse.userEmail == null) {
                        moeValid =
                            RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(moeController.text);
                        // _profileResponse.userEmail=moeController.text;
                      } else {
                        moeValid = moeController.text.trim().length == 10 &&
                            RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                .hasMatch(moeController.text);
                        // _profileResponse.userPhone=moeController.text;
                      }
                    });
                  },
                ),
                SizedBox(height: 5.0),
                FadeTransition(
                  opacity: _fadeIn,
                  child: SlideTransition(
                    position: slideTransmit(const Offset(0.0, -1.0),
                        const Offset(0.0, 0.0), _controller),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextView(
                          "(Kindly enter the OTP which has been sent to ${moeController.text})",
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.visible,
                          size: 12,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            EditTextBordered(
                              hint: "OTP",
                              // keyboardType: TextInputType.number,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              controller: otpController,
                              onEditingComplete: () {
                                setState(() {
                                  otpController.text;
                                  print(otpController.text);
                                });
                              },
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            InkWell(
                              onTap: () {
                                sendData(step: 32, params: {
                                  'type': _profileResponse.userEmail == null
                                      ? "email"
                                      : "phone",
                                  _profileResponse.userEmail == null
                                      ? "email"
                                      : "phone": moeController.text
                                });
                              },
                              child: TextView(
                                "Resend OTP",
                                color: CoupledTheme().primaryPink,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.visible,
                                size: 12,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ///Send OTP
                Visibility(
                  visible: !isVisibleVerifyOtp,
                  child: SlideTransition(
                    position: slideTransmit(const Offset(0.0, -1.0),
                        const Offset(0.0, 1.0), _controller),
                    child: FractionallySizedBox(
                      widthFactor: .4,
                      child: Opacity(
                        opacity: moeValid ? 1.0 : .50,
                        child: CustomButton(
                          enabled: moeValid,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15.0),
                            child: TextView(
                              'Send OTP',
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              overflow: TextOverflow.visible,
                              size: 12,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8,
                            ),
                          ),
                          onPressed: () {
                            sendData(step: 32, params: {
                              'type': _profileResponse.userEmail == null
                                  ? "email"
                                  : "phone",
                              _profileResponse.userEmail == null
                                  ? "email"
                                  : "phone": moeController.text
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                ///verify otp
                Visibility(
                  visible: isVisibleVerifyOtp,
                  child: FractionallySizedBox(
                    widthFactor: .4,
                    child: CustomButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        child: TextView(
                          'Verify OTP',
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.visible,
                          size: 12,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                        ),
                      ),
                      onPressed: () {
                        sendData(step: 33, params: {
                          'type': _profileResponse.userEmail == null
                              ? "email"
                              : "phone",
                          'otp': otpController.text
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void sendData({int? step, Map<String, String>? params}) {
    RestAPI()
        .post('${APis.register}${getSteps(step!)}', params: params)
        .then((value) {
      try {
        GlobalWidgets().showToast(msg: value);
      } catch (e) {
        print(e);
      }
      setState(() {
        isVisibleVerifyOtp = (step == 32);
      });
      _controller.forward();

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        (step == 33)
            ? Navigator.pushReplacementNamed(
                context,
                Dashboard
                    .route) // Navigator.pushReplacementNamed(context, Dashboard.route)
            : Container();
      });
    }).catchError((onError) {
      GlobalWidgets().showToast(msg: onError.toString());
    });
    // onError: (e) {
    //   print('res' +value['response']['msg']);
    //   try {
    //     GlobalWidgets().showToast(msg: e.toString());
    //   } catch (e) {
    //     print('res' + e);
    //   }
    // });
  }
}
