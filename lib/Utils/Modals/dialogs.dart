import 'dart:io';

import 'package:coupled/Home/MatchBoard/bloc/match_board_bloc.dart';
import 'package:coupled/Home/Profile/CouplingScore/bloc/coupling_score_bloc.dart';

import 'package:coupled/Home/Profile/othersProfile/bloc/others_profile_bloc.dart';
import 'package:coupled/MatchMeter/bloc/mom_bloc.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/Modals/SMC/smc_bloc.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/user.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SMC/smc_widget.dart';

class Dialogs {
  TextEditingController editTextController = TextEditingController();
  MatchBoardBloc matchBoardBloc = MatchBoardBloc();
  final _streamController = BehaviorSubject<String>();
  TextEditingController _pswdTexControl = TextEditingController();
  TextEditingController _pswdNewTexControl = TextEditingController();
  TextEditingController _mobCurrentPwControl = TextEditingController();
  TextEditingController _mobNoControl = TextEditingController();
  TextEditingController _mobOtpControl = TextEditingController();
  TextEditingController _emailOtpControl = TextEditingController();
  TextEditingController _emailTexControl = TextEditingController();
  TextEditingController _messageTexControl = TextEditingController();

  TextEditingController _countryTextControl = TextEditingController();
  TextEditingController _stateTextControl = TextEditingController();
  TextEditingController _cityTextControl = TextEditingController();
  TextEditingController _addressTextControl = TextEditingController();
  TextEditingController _pincodeTextControl = TextEditingController();
  bool logoutFromOther = false;
  bool _visibility = false;
  MomBloc momBloc = MomBloc();

  bool isPswValid1 = false;

  bool isPnoValid = false;

  bool isEmailValid = false;
  bool tolStatus = false;
  int? locationId;
  SmcBloc _smcBloc = SmcBloc();
  List<Item> _country = [], _state = [], _city = [];
  void _dialogTemplate(
      {required BuildContext context,
      required title,
      Color color = Colors.white,
      bool barrierDismissible = true,
      Widget content = const SizedBox(),
      List<Widget> actions = const []}) async {
    showDialog(
        //useSafeArea: true,
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Theme(
              data: Theme.of(context).copyWith(dialogBackgroundColor: color),
              child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  title: title == null
                      ? null
                      : TextView(
                          title,
                          color: CoupledTheme().primaryBlue,
                          size: 18,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                        ),
                  content: content,
                  actions: actions),
            ),
          );
        }).then((value) {
      editTextController.clear();
    });
  }

  ///ExitFrom App
  showDialogExitApp(context1) {
    return _dialogTemplate(
      context: context1,
      title: "Do you want to exit Coupled?",
      actions: <Widget>[
        CustomButton(
          width: 80.0,
          borderRadius: BorderRadius.circular(2.0),
          gradient: LinearGradient(colors: [Colors.white, Colors.grey]),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: TextView(
              "No",
              size: 16.0,
              color: Colors.black,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
          ),
          onPressed: () {
            Navigator.of(context1).pop();
          },
        ),
        CustomButton(
          width: 80.0,
          borderRadius: BorderRadius.circular(2.0),
          gradient: LinearGradient(colors: [
            CoupledTheme().primaryPinkDark,
            CoupledTheme().primaryPink
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextView(
              "Yes",
              size: 16.0,
              color: Colors.black,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
          ),
          onPressed: () {
            // print('object');
            // SystemNavigator.pop();
            if (Platform.isIOS) {
              Navigator.pop(context1);
              exit(0);
            } else {
              SystemNavigator.pop(animated: true);
            }
          },
        ),
      ],
    );
  }

  ///Clear other Login Sessions
  showDialogClearSessions(context1) {
    return _dialogTemplate(
      context: context1,
      title: "Log out from other devices",
      content: StatefulBuilder(builder: (context, setState) {
        return Container(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextView(
                "You have logged in other devices. Do you want to log out from other devices?",
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.visible,
                size: 12,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
              )
            ],
          ),
        );
      }),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context1).pop();
          },
          child: TextView(
            "No",
            color: CoupledTheme().inactiveColor,
            size: 16,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder(
            stream: _streamController,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == "") {
                return GlobalWidgets().showCircleProgress();
              } else {
                return CustomButton(
                  width: 80,
                  borderRadius: BorderRadius.circular(2.0),
                  gradient: LinearGradient(colors: [
                    CoupledTheme().primaryPinkDark,
                    CoupledTheme().primaryPink
                  ]),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextView("Yes",
                        size: 16,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    ///session clear
                    getData(
                      context: context1,
                      path: "logoutFromOther",
                      verify: true,
                      gotoLogin: true,
                      clearLocalCache: true,
                      action: (String value) {},
                    );
                    logoutFromOther = false;
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  loginCredentialWarning(BuildContext context, Function onPressed) {
    return _dialogTemplate(
        context: context,
        barrierDismissible: false,
        title: "Hello,",
        content: TextView(
          "We have activated your account "
          "at Coupled, please continue creating your Profile and remember your login credentials.",
          color: Colors.black,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.visible,
          size: 12,
          textAlign: TextAlign.center,
          textScaleFactor: .8,
          maxLines: 3,
        ),
        actions: [
          CustomButton(
            width: 80.0,
            borderRadius: BorderRadius.circular(2.0),
            gradient: LinearGradient(colors: [
              CoupledTheme().primaryPinkDark,
              CoupledTheme().primaryPink
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextView(
                "Okay",
                size: 16,
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
              ),
            ),
            onPressed: onPressed,
          )
        ]);
  }

  profileRecommendation({
    String memberShipCode = '',
    dynamic othersProfileBloc,
    dynamic profileResponse,
    context,
    List<RecomendCause> recommendCause = const <RecomendCause>[],
    int? partnerId,
    bool isReloadOthersProfile = false,
    List<BaseSettings>? baseSettings = const <BaseSettings>[],
    List userShortInfoModel = const <dynamic>[],
    bool isRemoveItemMatchBoard = false,
  }) {
    bool isAllChecked = (recommendCause != null)
        ? recommendCause
                .where((element) => element.checked == true)
                .toList()
                .length ==
            recommendCause.length
        : baseSettings!
                .where((element) => element.checked == true)
                .toList()
                .length ==
            baseSettings.length;
    List<ReasonsModel> recommendations = [];

    recommendCause.forEach((element) {
      recommendations.add(ReasonsModel(
          text: element.value,
          isChecked: element.checked,
          count: element.count,
          id: element.id));
    });

    baseSettings!.forEach((element) {
      recommendations.add(ReasonsModel(
          text: element.value,
          isChecked: element.checked,
          count: 0,
          id: element.id));
    });

    return _dialogTemplate(
      context: context,
      title: null,
      content: StatefulBuilder(builder: (context, setState) {
        return Container(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextView(
                "Like this profile?",
                color: CoupledTheme().primaryBlue,
                fontWeight: FontWeight.w700,
                size: 18,
                decoration: TextDecoration.none,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
              ),
              TextView(
                "Recommend & become a matchmaker for others !",
                color: CoupledTheme().primaryPink,
                size: 12,
                decoration: TextDecoration.none,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
                fontWeight: FontWeight.normal,
              ),
              ListView.builder(
                itemCount: recommendations.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            flex: 9,
                            child: IgnorePointer(
                              ignoring: recommendCause != null &&
                                      recommendCause[index].checked ||
                                  !(GlobalData
                                          .myProfile.membership!.paidMember ??
                                      false),
                              child: CustomCheckBox(
                                value: recommendations[index].isChecked,
                                text: recommendations[index].text,
                                textSize: 12,
                                fontWeight: FontWeight.normal,
                                textColor: Colors.black,
                                onChanged: (bool? value) {
                                  setState(
                                    () {
                                      recommendations[index].isChecked = value!;
                                      //  print("${recommendations.toString()}");
                                    },
                                  );
                                },
                                secondary: SizedBox(),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: NotificationBadge(
                              count: recommendations[index].count,
                              bgcolor: CoupledTheme().primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12, right: 12),
          child: CustomButton(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(colors: [
              CoupledTheme().primaryPinkDark,
              CoupledTheme().primaryPink
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: TextView(
                "Submit",
                decoration: TextDecoration.none,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                size: 12,
              ),
            ),
            enabled: !isAllChecked &&
                (GlobalData?.myProfile.membership!.paidMember ?? false),
            onPressed: isAllChecked
                ? null
                : () {
                    print('-----api-------');
                    List shortlist = [];
                    recommendations.asMap().forEach((index, item) {
                      if (item.isChecked) {
                        // shortlist['msg'] = item.text;
                        // ignore: unnecessary_statements
                        shortlist.add(item.id.toString());
                        //  shortlist[index.toString()] = item.id.toString();
                      }
                    });

                    if (shortlist.length <= 0) {
                      GlobalWidgets().showToast(msg: "Please select a reason.");
                    } else {
                      Dialogs().getData(
                        othersProfileBloc: othersProfileBloc,
                        profileResponse: profileResponse,
                        isRecommendation: true,
                        memberShipCode: memberShipCode,
                        userShortInfoModel: userShortInfoModel,
                        isReloadOthersProfile: isReloadOthersProfile,
                        isRemoveItemMatchBoard: isRemoveItemMatchBoard,
                        params: {
                          'mom_type': 'recommend',
                          'partner_id': partnerId,
                          'reasons': shortlist
                        },
                        context: context,
                        path: "MoMRecommend",
                        verify: true,
                        action: (_) {},
                      );
                    }

                    print(recommendations);
                  },
          ),
        ),
      ],
    );
  }

  late Future<CommonResponseModel> res;

  void getData(
      {Map<String, dynamic> params = const <String, dynamic>{},
      dynamic profileResponse,
      bool isReloadOthersProfile = false,
      bool isRemoveItemMatchBoard = false,
      String path = '',
      bool isRecommendation = false,
      String partnerId = '',
      dynamic othersProfileBloc,
      List userShortInfoModel = const [],
      String memberShipCode = '',
      dynamic user,
      setState,
      bool verify = true,
      bool gotoLogin = false,
      bool clearLocalCache = false,
      required BuildContext context,
      String param = '',
      ValueChanged<String>? action}) {
    //    othersProfileBloc = BlocProvider.of<OthersProfileBloc>(context);
    matchBoardBloc = BlocProvider.of<MatchBoardBloc>(context);
    _streamController.add("");

    res = Repository().doAction(params, path);

    res.then(
      (onValue) async {
        print('onValue');
        print(onValue);
        _streamController.add(onValue.code.toString());

        if (onValue.code == 200) {
          if (verify) {
            _pswdTexControl.clear();
            _pswdNewTexControl.clear();
            //  _mobNoControl.clear();
            _mobCurrentPwControl.clear();
            _mobOtpControl.clear();
            //   _emailTexControl.clear();
            _emailOtpControl.clear();
            Navigator.pop(context);

            try {
              GlobalData.othersProfileBloc.add(OtherProfileChangeNotifier());
            } catch (e) {
              print(e);
            }

            if (isRemoveItemMatchBoard ?? false) {
              matchBoardBloc.add(
                MatchBoardActions(
                  id: int.parse(memberShipCode),
                  userShortInfoModel: userShortInfoModel,
                  isRecommended: isRecommendation,
                ),
              );
            }
            if (param != null) {
              GlobalData.momBloc.add(LoadMomData(param, 1));
            }

            try {
              GlobalData.othersProfile.mom = onValue.response?.data!.mom;
              othersProfileBloc.add(OtherProfileChangeNotifier());
              GlobalData.couplingScoreModel.response!.mom =
                  onValue.response!.data!.mom!;
              GlobalData.couplingScoreBloc.add(CSChangeNotify());
            } on NoSuchMethodError {
              GlobalData.couplingScoreModel.response!.mom =
                  onValue.response!.data!.mom!;
              GlobalData.couplingScoreBloc.add(CSChangeNotify());
            } finally {
              try {
                GlobalData.othersProfile.shortlistByMe =
                    onValue.response!.data!.shortlistByMe;
              } catch (e) {
                print('$e');
              }
            }

            logoutFromOther ? showDialogClearSessions(context) : Container();
            if (gotoLogin) {
              SharedPreferences.getInstance().then((pref) {
                pref.setString("accessToken", '');
              });
              Navigator.pushNamed(context, '/startMain');
            }
            gotoLogin = false;
          } else {
            setState(() {
              _visibility = true;
            });
          }
          GlobalWidgets().showToast(
            msg: onValue.response?.msg,
          );
        } else {
          print('onValue.response.msg-----');
          print(onValue.response!.msg);
          GlobalWidgets().showToast(msg: onValue.response!.msg ?? '');
        }
        //  Navigator.pop(context);
      },
      onError: (err) {
        print("Error : $err");
        _streamController.add("1");
        Navigator.pop(context);

        if (params.containsKey('current_password')) {
          GlobalWidgets().showToast(
              msg: params.containsKey('current_password')
                  ? 'Mismatch Password'
                  : CoupledStrings.errorMsg);
        }
      },
    );
  }

  ///Default [multiSelection] is true
  profileDialogs(context, String title, String partnerId,
      {required ValueChanged<String> callBack,
      List<BaseSettings>? reasons = const <BaseSettings>[],
      String memberShipCode = '',
      List userShortInfoModel = const [],
      String momType = '',
      String description = '',
      dynamic profileResponse,
      dynamic othersProfileBloc,
      bool isReloadOthersProfile = false,
      bool isRemoveItemMatchBoard = false,
      bool multiSelection = true}) {
    var selectedReason;
    List<ReasonsModel> shortlists = [];
    reasons!.forEach((option) {
      shortlists.add(
          ReasonsModel(id: option.id, text: option.value, isChecked: false));
    });
    //    memberShipCode != null
    //        ? othersProfileBloc = BlocProvider.of<OthersProfileBloc>(context)
    //        : null;
    bool showMessageBox = false;

    return _dialogTemplate(
      context: context,
      title: "Reason for $title?",
      content: StatefulBuilder(builder: (context, setState) {
        return Container(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextView(
                  description ?? '',
                  color: Colors.black,
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
                ListView.builder(
                  itemCount: shortlists.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex: 9,
                              child: CustomCheckBox(
                                value: shortlists[index].isChecked,
                                text: shortlists[index].text,
                                textSize: 12,
                                fontWeight: FontWeight.normal,
                                textColor: Colors.black,
                                onChanged: (bool? value) {
                                  setState(
                                    () {
                                      if (!multiSelection) {
                                        shortlists.forEach((f) {
                                          f.isChecked = false;
                                        });
                                      }
                                      shortlists[index].isChecked = value!;

                                      selectedReason = shortlists[index].text;

                                      showMessageBox =
                                          reasons[index].others == "1";
                                      print(
                                          '--------${shortlists[index].text}----');
                                      //  print("${recommendations.toString()}");
                                    },
                                  );
                                },
                                secondary: SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Visibility(
                    visible: showMessageBox,
                    child: EditTextBordered(
                      maxLength: 150,
                      maxLines: 2,
                      onChange: (value) {
                        selectedReason = value;
                      },
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      hint: "Reason(optional)",
                      controller: _messageTexControl,
                      hintColor: Colors.black,
                      color: Colors.black,
                      textAlign: TextAlign.start,
                    ))
              ],
            ),
          ),
        );
      }),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12, right: 12),
          child: CustomButton(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(colors: [
              CoupledTheme().primaryPinkDark,
              CoupledTheme().primaryPink
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: TextView(
                "Submit",
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.visible,
                size: 12,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              // callBack("submit");

              ReasonsModel selectedItem = ReasonsModel();
              Map<String, String> shortlist = Map();
              List shortListReason = [];
              shortlists.asMap().forEach((index, item) {
                if (item.isChecked && momType == 'shortlist') {
                  shortlist[index.toString()] = item.id.toString();
                  shortListReason.add(item.id.toString());
                } else {
                  shortlist['msg'] = item.text;
                  shortlist['id'] = item.id.toString();
                }
                if (item.isChecked && momType == 'deleteAccount') {
                  selectedItem = shortlists[index];
                }
              });
              if (shortlist.length <= 0) {
                print("koll");
                GlobalWidgets().showToast(msg: "Please select a reason.");
              } else {
                print(shortlist);
                switch (momType) {
                  case "shortlist":
                    Dialogs().getData(
                        isReloadOthersProfile: isReloadOthersProfile,
                        isRemoveItemMatchBoard: isRemoveItemMatchBoard,
                        memberShipCode: partnerId,
                        userShortInfoModel: userShortInfoModel,
                        profileResponse: profileResponse,
                        othersProfileBloc: othersProfileBloc,
                        params: {
                          "keyword": "partnerProfile",
                          'mom_type': 'shortlist',
                          'partner_id': '$partnerId',
                          'reasons': shortListReason
                        },
                        context: context,
                        path: "MoMShortlist",
                        verify: true,
                        action: (_) {});
                    break;
                  case "block":
                    Dialogs().getData(
                        isReloadOthersProfile: isReloadOthersProfile,
                        profileResponse: profileResponse,
                        othersProfileBloc: othersProfileBloc,
                        //  memberShipCode: memberShipCode,
                        params: {
                          "keyword": "partnerProfile",
                          'mom_type': 'block',
                          'partner_id': partnerId,
                          'message': '$selectedReason'
                        },
                        context: context,
                        path: "MoMBlock",
                        verify: true,
                        action: (_) {});
                    break;
                  case "report":
                    Dialogs().getData(
                        isReloadOthersProfile: isReloadOthersProfile,
                        profileResponse: profileResponse,
                        othersProfileBloc: othersProfileBloc,
                        // memberShipCode: memberShipCode,
                        params: {
                          "keyword": "partnerProfile",
                          'mom_type': 'report',
                          'partner_id': partnerId,
                          'message': '$selectedReason'
                        },
                        context: context,
                        path: "MoMReport",
                        verify: true,
                        action: (_) {});
                    break;

                  case "deleteAccount":
                    Dialogs().getData(
                        params: {
                          'message': _messageTexControl.text,
                          'cause_id': selectedItem.id
                        },
                        context: context,
                        path: "delete",
                        verify: true,
                        gotoLogin: true,
                        clearLocalCache: true,
                        action: (_) {});
                    break;
                }
              }
            },
          ),
        ),
      ],
    );
  }

  ///Specially Abled
  showDialogSpeciallyAbled(context, {int index = 0, required MomBloc momBloc}) {
    var speciallyAbled = GlobalData.speciallyAbled.response?.data![index];
    return _dialogTemplate(
      context: context,
      title:
          "Hello! ${speciallyAbled?.user?.name} want to know about your special case details. would you like to share the details?",
      actions: <Widget>[
        CustomButton(
          width: 80,
          borderRadius: BorderRadius.circular(2.0),
          gradient: LinearGradient(colors: [Colors.white, Colors.white]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextView(
              "Reject",
              size: 12,
              color: Colors.black,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
          ),
          onPressed: () {
            Repository().speciallyAbledAction(params: {
              'mom_status': 'reject',
              'partner_id': '${speciallyAbled?.user?.id}'
            }).then((value) {
              print(value);
              GlobalData.speciallyAbled.response?.data![index].momStatus =
                  'rejected';
              momBloc.add(MoMChangeNotifier());
              Navigator.of(context).pop();
            });
          },
        ),
        CustomButton(
          width: 80,
          borderRadius: BorderRadius.circular(2.0),
          gradient: LinearGradient(colors: [
            CoupledTheme().primaryPinkDark,
            CoupledTheme().primaryPink
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextView(
              "Accept",
              size: 16,
              color: Colors.black,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
          ),
          onPressed: () {
            Repository().speciallyAbledAction(params: {
              'mom_status': 'accept',
              'partner_id': '${speciallyAbled?.user?.id}'
            }).then((value) {
              print(value);

              GlobalData.speciallyAbled.response?.data![index].momStatus =
                  'accepted';

              // momBloc.add(MoMChangeNotifier());
              Navigator.of(context).pop();
              momBloc.add(LoadSpecially());
            });
          },

          // ?mom_type=specially&mom_status=${params['mom_status']}&partner_id:${params['partner_id']}'
        ),
      ],
    );
  }

  showContactNumber(context, CommonResponseModel commonResponseModel) {
    return _dialogTemplate(
      title: null,
      color: Colors.transparent,
      context: context,
      content: Container(
        height: 90,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 35, right: 35, top: 30, bottom: 15),
                  child: TextView(
                    (commonResponseModel.response?.phone).toString(),
                    color: CoupledTheme().primaryPink,
                    size: 16,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: BtnWithText(
                onTap: () {
                  //Dialogs().showContactNumber(context);
                },
                fixedIconSize: FixedIconSize.LARGE_35,
                img: "assets/Profile/CallWhite.png",
                text: "",
                roundBackGround: true,
                bgColor: CoupledTheme().primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  profileTopUpPlan(context) {
    return _dialogTemplate(
      title: null,
      color: Colors.transparent,
      context: context,
      content: Container(
        height: 195,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                height: 170,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 35, bottom: 15),
                  child: Column(
                    children: <Widget>[
                      TextView(
                        "Hello, you have consumed your credits, please recharge with"
                        "chat & contact credits to enjoy unrestricted services",
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                        size: 12,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      CustomButton(
                        borderRadius: BorderRadius.circular(2.0),
                        gradient: LinearGradient(colors: [
                          CoupledTheme().primaryPinkDark,
                          CoupledTheme().primaryPink
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: TextView(
                            "Top-up plan",
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                            color: Colors.black,
                            size: 12,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed('/myPlanPayments');
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: BtnWithText(
                onTap: () {
                  //    Dialogs().showContactNumber(context);
                },
                fixedIconSize: FixedIconSize.LARGE_35,
                img: "assets/Profile/CallWhite.png",
                text: "",
                roundBackGround: true,
                bgColor: CoupledTheme().primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  connectWithMsgRequest(context,
      {dynamic message,
      dynamic partnerId = '',
      dynamic userShortInfoModel = const [],
      dynamic isReloadOthersProfile = false,
      dynamic isRemoveItemMatchBoard = false,
      dynamic othersProfileBloc,
      dynamic profileResponse,
      dynamic param = '',
      dynamic emojiPressed,
      dynamic memberShipCode = ''}) {
    TextEditingController editTextController = TextEditingController();
    List<String> strings = [
      "Hello ${GlobalData.othersProfile.name ?? ''}! Our match looks promising. Let’s connect and know about each other.",
      "Hello ${GlobalData.othersProfile.name ?? ''}! Our Coupling Score is good and have liked your profile. I feel we should connect and explore about each other.",
      //"Hello! We seem to match well, let us connect through chat.",
      "Hello ${GlobalData.othersProfile.name ?? ''}! I feel there’s a connection between us. Let’s give a chance to each other, we might end up as partners for life.",
    ];
    return _dialogTemplate(
      context: context,
      title: "Connect with a message (optional)",
      content: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: strings.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        // contentPadding: EdgeInsets.all(0.0),
                        onTap: () {
                          if (GlobalData.myProfile.membership!.paidMember ??
                              false) {
                            setState(() {
                              editTextController.text = strings[index];
                              // message(editTextController?.text??'');
                              print(strings[index]);
                            });
                          } else {
                            profileUpgradePlan(context);
                          }
                        },
                        subtitle: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: GlobalWidgets().iconCreator(
                                "assets/MatchMeter/Add.png",
                                color: CoupledTheme().primaryPink,
                                size: FixedIconSize.SMALL,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: TextView(
                                strings[index],
                                color: Colors.black,
                                textAlign: TextAlign.left,
                                decoration: TextDecoration.none,
                                overflow: TextOverflow.visible,
                                textScaleFactor: .8,
                                fontWeight: FontWeight.bold,
                                size: 12,
                                maxLines: 10,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.grey,
                        height: 1.0,
                      );
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: EditTextBordered(
                          maxLength: 350,
                          enabled:
                              (GlobalData.myProfile.membership!.paidMember ??
                                  false),
                          controller: editTextController,
                          hint: "",
                          // icon: InkWell(
                          //   onTap: emojiPressed,
                          //   child: GlobalWidgets().iconCreator(
                          //       "assets/MatchBoard/Emoji.png",
                          //       size: FixedIconSize.SMALL),
                          // ),
                          color: Colors.black,
                          maxLines: null,
                          borderColor: CoupledTheme().primaryPinkDark,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: StreamBuilder(
                            stream: _streamController,
                            builder: (context1, snapshot) {
                              if (snapshot.hasData && snapshot.data == "") {
                                return GlobalWidgets().showCircleProgress();
                              } else {
                                return CustomButton(
                                    width: 30.0,
                                    height: 30.0,
                                    shape: ButtonType.BUTTON_ROUND,
                                    buttonType: ButtonType.FLAT,
                                    child: GlobalWidgets().iconCreator(
                                      "assets/MatchMeter/Connect.png",
                                      size: FixedIconSize.MEDIUM,
                                    ),
                                    onPressed: () {
                                      getData(
                                          othersProfileBloc: othersProfileBloc,
                                          profileResponse: profileResponse,
                                          isReloadOthersProfile:
                                              isReloadOthersProfile,
                                          isRemoveItemMatchBoard:
                                              isRemoveItemMatchBoard,
                                          userShortInfoModel:
                                              userShortInfoModel,
                                          memberShipCode: partnerId,
                                          param: param,
                                          params: {
                                            "keyword": "partnerProfile",
                                            'mom_type': 'connect',
                                            'partner_id': partnerId,
                                            'message': editTextController.text
                                          },
                                          context: context,
                                          path: "MoMConnect",
                                          verify: true,
                                          action: message);
                                    });
                              }
                            }),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  rejectWithMsgRequest(context,
      {ValueChanged<String>? message,
      String? partnerId,
      String? param,
      String? name,
      OthersProfileBloc? othersProfileBloc,
      String? memberShipCode}) {
    momBloc = BlocProvider.of<MomBloc>(context);
    /*   if (memberShipCode != null)
   //      othersProfileBloc = BlocProvider.of<OthersProfileBloc>(context);
      //TextEditingController editTextController = TextEditingController();*/
    List<String> strings = [
      "Hi,${name ?? GlobalData.othersProfile.name ?? ''} Glad to know you’re interested but I feel I am not the right match for you. Wishing you the best for your searches.",
      "Hi,${name ?? GlobalData.othersProfile.name ?? ''} Glad that you liked my profile. Went through yours too but I am looking for someone very specific in mind. Wishing you the best for your searches.",
      'Hello ${name ?? GlobalData.othersProfile.name ?? ''}, I will be unable to take this any further, but wishing you all the best for you searches.'
    ];
    return _dialogTemplate(
        context: context,
        title: "Reject with a message (optional)",
        content: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: 500,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: strings.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          // contentPadding: EdgeInsets.all(0.0),
                          onTap: () {
                            if ((GlobalData.myProfile.membership?.paidMember ??
                                false)) {
                              setState(() {
                                editTextController.text = strings[index];
                                print(strings[index]);
                              });
                            } else {
                              profileUpgradePlan(context);
                            }
                          },
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: GlobalWidgets().iconCreator(
                                  "assets/MatchMeter/Add.png",
                                  color: CoupledTheme().primaryPink,
                                  size: FixedIconSize.SMALL,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: TextView(
                                  strings[index],
                                  color: Colors.black,
                                  textAlign: TextAlign.left,
                                  decoration: TextDecoration.none,
                                  overflow: TextOverflow.visible,
                                  textScaleFactor: .8,
                                  fontWeight: FontWeight.bold,
                                  size: 12,
                                  maxLines: 10,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: Colors.grey,
                          height: 1.0,
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: EditTextBordered(
                            enabled:
                                (GlobalData.myProfile.membership!.paidMember ??
                                    false),
                            controller: editTextController,
                            hint: "",
                            color: Colors.black,
                            // icon: GlobalWidgets().iconCreator(
                            //     "assets/MatchBoard/Emoji.png",
                            //     size: FixedIconSize.SMALL),
                            maxLength: 350,
                            maxLines: null,
                            borderColor: CoupledTheme().primaryPinkDark,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: StreamBuilder(
                              stream: _streamController,
                              builder: (context1, snapshot) {
                                if (snapshot.hasData && snapshot.data == "") {
                                  return GlobalWidgets().showCircleProgress();
                                } else {
                                  return BtnWithText(
                                    text: "Reject",
                                    textSize: 12,
                                    img: "assets/MatchMeter/Rejected.png",
                                    roundBackGround: true,
                                    bgColor: CoupledTheme().primaryPink,
                                    textColor: Colors.black,
                                    onTap: () {
                                      getData(
                                          params: {
                                            'mom_type': 'reject',
                                            "keyword": "partnerProfile",
                                            'partner_id': partnerId,
                                            'message': editTextController.text
                                          },
                                          othersProfileBloc: othersProfileBloc,
                                          context: context,
                                          memberShipCode:
                                              memberShipCode.toString(),
                                          path: "MoMReject",
                                          verify: true,
                                          action: message,
                                          param: param.toString());

                                      // Navigator.pop(context);
                                      message!(editTextController.text);
                                    },
                                  );
                                }
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  reAcceptWithMsgRequest(context,
      {ValueChanged<String>? message,
      String? partnerId,
      String? param,
      String? name,
      OthersProfileBloc? othersProfileBloc}) {
    momBloc = BlocProvider.of<MomBloc>(context);
    TextEditingController edittextController = TextEditingController();
    List<String> strings = [
      "Hello ${name ?? GlobalData.othersProfile.name ?? ''}, I just realized that I had declined your connect request by mistake. I would like to Reconnect!",
      "Hello ${name ?? GlobalData.othersProfile.name ?? ''}, I would want to reconnect with you. I wasn’t ready  to take things ahead earlier.",
    ];
    return _dialogTemplate(
        context: context,
        title: "Reaccept with a message (optional)",
        //title: "Reaccept with a message (optional)",
        content: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: 500,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: strings.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          //  contentPadding: EdgeInsets.all(0.0),
                          onTap: () {
                            if (GlobalData.myProfile.membership!.paidMember ??
                                false) {
                              setState(() {
                                edittextController.text = strings[index];
                                print(strings[index]);
                              });
                            } else {
                              profileUpgradePlan(context);
                            }
                          },
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: GlobalWidgets().iconCreator(
                                  "assets/MatchMeter/Add.png",
                                  color: CoupledTheme().primaryPink,
                                  size: FixedIconSize.SMALL,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: TextView(
                                  strings[index],
                                  color: Colors.black,
                                  textAlign: TextAlign.left,
                                  decoration: TextDecoration.none,
                                  overflow: TextOverflow.visible,
                                  textScaleFactor: .8,
                                  fontWeight: FontWeight.bold,
                                  size: 12,
                                  maxLines: 10,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: Colors.grey,
                          height: 1.0,
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: EditTextBordered(
                            enabled:
                                (GlobalData.myProfile.membership!.paidMember ??
                                    false),
                            controller: edittextController,
                            hint: "",
                            color: Colors.black,
                            // icon: GlobalWidgets().iconCreator(
                            //     "assets/MatchBoard/Emoji.png",
                            //     size: FixedIconSize.SMALL),
                            maxLength: 350,
                            maxLines: null,
                            borderColor: CoupledTheme().primaryPinkDark,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: StreamBuilder(
                              stream: _streamController,
                              builder: (context1, snapshot) {
                                if (snapshot.hasData && snapshot.data == "") {
                                  return GlobalWidgets().showCircleProgress();
                                } else {
                                  return CustomButton(
                                      width: 30.0,
                                      height: 30.0,
                                      gradient: LinearGradient(colors: [
                                        CoupledTheme().primaryBlue,
                                        CoupledTheme().primaryBlue,
                                      ]),
                                      shape: ButtonType.BUTTON_ROUND,
                                      buttonType: ButtonType.FLAT,
                                      child: GlobalWidgets().iconCreator(
                                        "assets/MatchMeter/Reaccept.png",
                                        size: FixedIconSize.MEDIUM,
                                      ),
                                      onPressed: () {
                                        getData(
                                            params: {
                                              "keyword": "partnerProfile",
                                              'mom_type': 'accept',
                                              'partner_id': partnerId,
                                              'message': edittextController.text
                                            },
                                            context: context,
                                            othersProfileBloc:
                                                othersProfileBloc,
                                            param: param.toString(),
                                            path: "MoMAccept",
                                            verify: true,
                                            action: message);
                                        //message(edittextController.text);
                                      });
                                }
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  snoozeRequest(context,
      {ValueChanged<String>? snoozed,
      String? partnerId,
      String? param,
      OthersProfileBloc? othersProfileBloc,
      String? memberShipCode}) {
    momBloc = BlocProvider.of<MomBloc>(context);
    /*  memberShipCode != null
        ? othersProfileBloc = BlocProvider.of<OthersProfileBloc>(context)
        : null;*/
    int _btnPressed = 0;

    final List<String> durations = [
      "3",
      "7",
      "10",
    ];
    String selectedDuration = durations[0];

    return _dialogTemplate(
      context: context,
      title: "Snooze",
      content: StatefulBuilder(builder: (context, setState) {
        return Container(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 40.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemExtent: 75,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomButton(
                      height: 40.0,
                      buttonType: ButtonType.FLAT,
                      gradient: _btnPressed == index
                          ? LinearGradient(colors: <Color>[
                              CoupledTheme().primaryPinkDark,
                              CoupledTheme().primaryPinkDark
                            ])
                          : LinearGradient(
                              colors: <Color>[Colors.white, Colors.white]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: TextView(
                          '${durations[index]} Days',
                          size: 14,
                          color: _btnPressed == index
                              ? Colors.white
                              : Colors.black,
                          decoration: TextDecoration.none,
                          overflow: TextOverflow.visible,
                          textScaleFactor: .8,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          //snoozed(durations[index]);
                          _btnPressed = index;
                          selectedDuration = durations[index];
                          //Navigator.pop(context);
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12, right: 12),
          child: StreamBuilder(
              stream: _streamController,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == "") {
                  return GlobalWidgets().showCircleProgress();
                } else {
                  return CustomButton(
                    width: 80.0,
                    borderRadius: BorderRadius.circular(2.0),
                    gradient: LinearGradient(colors: [
                      CoupledTheme().primaryPinkDark,
                      CoupledTheme().primaryPink
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TextView(
                        "Done",
                        size: 16,
                        decoration: TextDecoration.none,
                        overflow: TextOverflow.visible,
                        textScaleFactor: .8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: () {
                      // Navigator.pop(context);

                      getData(
                          memberShipCode: memberShipCode.toString(),
                          param: param.toString(),
                          othersProfileBloc: othersProfileBloc,
                          params: {
                            "keyword": "partnerProfile",
                            'snooze_duration': selectedDuration,
                            'partner_id': partnerId,
                          },
                          context: context,
                          path: "MoMSnooz",
                          verify: true,
                          action: (String value) {});
                    },
                  );
                }
              }),
        ),
      ],
    );
  }

  acceptWithMsgRequest(context,
      {ValueChanged<String>? message,
      String? partnerId,
      String? param,
      String? name,
      OthersProfileBloc? othersProfileBloc,
      String? memberShipCode}) {
    momBloc = BlocProvider.of<MomBloc>(context);
    List<String> strings = [
      "Hi,${name ?? GlobalData.othersProfile.name ?? ''} I have liked your profile too. Let’s keep talking to each other for some time.",
      "Thanks for connecting, am interested in knowing more about you. Let’s Couple Up!",
      "It feels great to receive your interest; we complement each other like a jigsaw puzzle. Let’s connect!",
      'Hi ${name ?? GlobalData.othersProfile.name ?? ''}, I am glad to hear from you and I couldn’t agree more, so let’s get connected.'
    ];
    return _dialogTemplate(
        context: context,
        title: "Accept with a message (optional)",
        content: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: 500,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: strings.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          // contentPadding: EdgeInsets.all(0.0),
                          onTap: () {
                            if (GlobalData.myProfile.membership?.paidMember ??
                                false) {
                              setState(() {
                                editTextController.text = strings[index];
                                print(strings[index]);
                              });
                            } else {
                              profileUpgradePlan(context);
                            }
                          },
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: GlobalWidgets().iconCreator(
                                  "assets/MatchMeter/Add.png",
                                  color: CoupledTheme().primaryPink,
                                  size: FixedIconSize.SMALL,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: TextView(
                                  strings[index],
                                  color: Colors.black,
                                  textAlign: TextAlign.left,
                                  decoration: TextDecoration.none,
                                  overflow: TextOverflow.visible,
                                  textScaleFactor: .8,
                                  fontWeight: FontWeight.bold,
                                  size: 12,
                                  maxLines: 10,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: Colors.grey,
                          height: 1.0,
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: EditTextBordered(
                            enabled:
                                (GlobalData.myProfile.membership?.paidMember ??
                                    false),
                            controller: editTextController,
                            hint: "",
                            color: Colors.black,
                            maxLength: 350,
                            maxLines: null,
                            // icon: GlobalWidgets().iconCreator(
                            //     "assets/MatchBoard/Emoji.png",
                            //     size: FixedIconSize.SMALL),
                            borderColor: CoupledTheme().primaryPinkDark,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: StreamBuilder(
                              stream: _streamController,
                              builder: (context1, snapshot) {
                                if (snapshot.hasData && snapshot.data == "") {
                                  return GlobalWidgets().showCircleProgress();
                                } else {
                                  return BtnWithText(
                                    img: "assets/MatchMeter/Accepted.png",
                                    text: "Accept",
                                    roundBackGround: true,
                                    textColor: Colors.black,
                                    bgColor: CoupledTheme().primaryPink,
                                    onTap: () {
                                      setState(() {
                                        // message("accepted");
                                        // Navigator.pop(context);
                                        getData(
                                            memberShipCode:
                                                memberShipCode.toString(),
                                            param: param.toString(),
                                            othersProfileBloc:
                                                othersProfileBloc,
                                            params: {
                                              "keyword": "partnerProfile",
                                              'mom_type': 'accept',
                                              'partner_id': partnerId,
                                              'message': editTextController.text
                                            },
                                            context: context,
                                            path: "MoMAccept",
                                            verify: true,
                                            action: message);
                                      });
                                    },
                                  );
                                }
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  showUnblock(context,
      {ValueChanged<String>? message,
      String? partnerId,
      OthersProfileBloc? othersProfileBloc,
      ProfileResponse? profileResponse,
      String? name,
      String? img,
      String? memberCode,
      String? reason,
      String? param}) {
    momBloc = BlocProvider.of<MomBloc>(context);
    return _dialogTemplate(
      context: context,
      title: null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Table(
            defaultColumnWidth: FractionColumnWidth(.27),
            columnWidths: {
              0: FractionColumnWidth(.35),
              1: FractionColumnWidth(.70)
            },
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  TableCell(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: NetworkImage(img.toString()),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextView(
                          memberCode.toString(),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          size: 14,
                          decoration: TextDecoration.none,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                        ),
                      ],
                    ),
                  ),
                  TableCell(
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                radius: 16.0,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.close,
                                    color: CoupledTheme().primaryPink),
                              ),
                            ),
                          ),
                          TextView(
                            name.toString(),
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            overflow: TextOverflow.visible,
                            size: 12,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextView(
                            "Would you like to unblock this person?",
                            color: CoupledTheme().primaryBlue,
                            size: 16.0,
                            decoration: TextDecoration.none,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          StreamBuilder(
                              stream: _streamController,
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data == "") {
                                  return GlobalWidgets().showCircleProgress();
                                } else {
                                  return CustomButton(
                                      width: 75.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 10.0),
                                        child: TextView(
                                          "Yes",
                                          decoration: TextDecoration.none,
                                          overflow: TextOverflow.visible,
                                          size: 12,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      buttonType: ButtonType.FLAT,
                                      gradient: LinearGradient(colors: <Color>[
                                        Color(0xffbc1b87),
                                        Color(0xffed2092),
                                      ]),
                                      borderRadius: BorderRadius.circular(5.0),
                                      onPressed: () {
                                        getData(
                                            param: param.toString(),
                                            othersProfileBloc:
                                                othersProfileBloc,
                                            profileResponse: profileResponse,
                                            params: {
                                              'mom_type': 'unblock',
                                              'partner_id': partnerId,
                                              'message': ''
                                            },
                                            context: context,
                                            path: "MoMUnblock",
                                            verify: true,
                                            action: (String value) {});
                                      });
                                }
                              }),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          TextView(
            "Reason for blocking this person",
            fontWeight: FontWeight.w900,
            color: Colors.black,
            decoration: TextDecoration.none,
            overflow: TextOverflow.visible,
            size: 12,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
          ),
          SizedBox(
            height: 5.0,
          ),
          TextView(
            reason ?? '',
            color: Colors.black,
            decoration: TextDecoration.none,
            overflow: TextOverflow.visible,
            size: 12,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    );
  }

  tolDialog(context) {
    return _dialogTemplate(
        context: context,
        title: null,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextView(
              "Impress your partner with your conversations "
              "earn three hearts and unlock the magic of"
              " Token of Love.\n \n  Double tap a message in"
              " chat to give a heart.",
              color: Colors.black,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
              size: 12,
            )
          ],
        ));
  }

  bool isNewPswValid = true;
  bool isPswValid = true;
  showDialogChangePassWord(context1) {
    return _dialogTemplate(
      context: context1,
      title: "Change Password",
      content: StatefulBuilder(builder: (context, setState) {
        return Container(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              EditTextBordered(
                onChange: (value) {
                  setState(() {
                    isNewPswValid = GlobalWidgets().validatePassword(value);
                  });
                },
                controller: _pswdNewTexControl,
                errorText: isNewPswValid
                    ? null
                    : 'Mix of 8 letter wth uppercase,alphanumeric & specialcase',
                hint: "New Password",
                textAlign: TextAlign.left,
                color: Colors.black,
                hintColor: Colors.black,
                size: 16.0,
                obscureText: true,
                height: 16.0,
                showObscureIcon: true,
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: (GlobalData?.myProfile.passwordStatus ?? true),
                child: EditTextBordered(
                  controller: _pswdTexControl,
                  hint: "Current Password",
                  onChange: (value) {
                    setState(() {
                      // isPswValid = GlobalWidgets().validatePassword(value);
                      isPswValid = true;
                    });
                  },
                  errorText: isPswValid
                      ? null
                      : "Password must contain 8 letter with alphanumeric and special case",
                  textAlign: TextAlign.left,
                  color: Colors.black,
                  hintColor: Colors.black,
                  size: 16.0,
                  obscureText: true,
                  height: 16.0,
                  showObscureIcon: true,
                ),
              ),
            ],
          ),
        );
      }),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder(
              stream: _streamController,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == "") {
                  return GlobalWidgets().showCircleProgress();
                } else {
                  return CustomButton(
                    width: 80.0,
                    borderRadius: BorderRadius.circular(2.0),
                    gradient: LinearGradient(colors: [
                      CoupledTheme().primaryPinkDark,
                      CoupledTheme().primaryPink
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TextView(
                        "Save",
                        size: 16.0,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                    ),
                    onPressed: () {
                      logoutFromOther = true;
                      //                      Navigator.of(context1).pop();
                      //                      showDialogClearSessions(context1);
                      if (isNewPswValid &&
                          isPswValid &&
                          _pswdNewTexControl.text.isNotEmpty) {
                        getData(
                            params: {
                              'type':
                                  (GlobalData?.myProfile.passwordStatus ?? true)
                                      ? 'change'
                                      : 'create',
                              'current_password': _pswdTexControl.text ?? '',
                              'new_password': _pswdNewTexControl.text.trim()
                            },
                            context: context1,
                            path: "password",
                            verify: true,
                            action: (String value) {});
                        _pswdTexControl.clear();
                        _pswdNewTexControl.clear();
                      } else {
                        GlobalWidgets()
                            .showToast(msg: "All fields are required");
                      }
                    },
                  );
                }
              }),
        ),
      ],
    );
  }

  profileUpgradePlan(
    context,
  ) {
    return _dialogTemplate(
      title: null,
      color: Colors.transparent,
      context: context,
      content: Container(
        height: 175,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 35, bottom: 15),
                  child: Column(
                    children: <Widget>[
                      TextView(
                        "Hello,we would like to have you on board. "
                        "Please subscribe to Coupled to enjoy unrestricted services.",
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        overflow: TextOverflow.visible,
                        size: 12,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      CustomButton(
                        borderRadius: BorderRadius.circular(2.0),
                        gradient: LinearGradient(colors: [
                          CoupledTheme().primaryPinkDark,
                          CoupledTheme().primaryPink
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: TextView(
                            "Become a member",
                            decoration: TextDecoration.none,
                            overflow: TextOverflow.visible,
                            size: 12,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed('/membershipPlans');
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            /*       Align(
              alignment: Alignment.topCenter,
              child: BtnWithText(
                onTap: () {
                  Dialogs().showContactNumber(context);
                },
                fixedIconSize: FixedIconSize.LARGE_35,
                img: "assets/Profile/CallWhite.png",
                text: "",
                roundBackGround: true,
                bgColor: CoupledTheme().primaryBlue,
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  ///change phone number
  showDialogChangePhoneNo(context1, {user}) {
    _mobNoControl.clear();
    _mobCurrentPwControl.clear();
    _mobOtpControl.clear();
    _visibility = false;
    return _dialogTemplate(
      context: context1,
      title: "Change Mobile Number",
      content: StatefulBuilder(builder: (context, setState) {
        return Container(
          width: 400.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Visibility(
                  visible: !_visibility,
                  child: EditTextBordered(
                    keyboardType: TextInputType.number,
                    hint: "Phone Number",
                    onChange: (value) {
                      setState(() {
                        isPnoValid = GlobalWidgets().validatePhone(value);
                      });
                    },
                    errorText: isPnoValid ? '' : "Invalid Phone Number",
                    controller: _mobNoControl,
                    textAlign: TextAlign.left,
                    color: Colors.black,
                    hintColor: Colors.black,
                    size: 16.0,
                    height: 16.0,
                  ),
                ),
                Visibility(
                  visible: !_visibility,
                  child: SizedBox(
                    height: 5,
                  ),
                ),
                Visibility(
                  visible: !_visibility,
                  child: TextView(
                    'Please note this would become your new User Id as well',
                    color: Colors.black,
                    size: 12.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                ),
                Visibility(
                  visible: !_visibility,
                  child: SizedBox(
                    height: 15,
                  ),
                ),
                Visibility(
                  visible: !_visibility,
                  child: EditTextBordered(
                    hint: "Current Password",
                    controller: _mobCurrentPwControl,
                    onChange: (value) {
                      setState(() {
                        isPswValid1 = GlobalWidgets().validatePassword(value);
                      });
                    },
                    errorText: isPswValid1
                        ? null
                        : "Password must be atleast 8 charecter",
                    textAlign: TextAlign.left,
                    color: Colors.black,
                    hintColor: Colors.black,
                    size: 16.0,
                    height: 16.0,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: _visibility ? false : true,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: StreamBuilder(
                        stream: _streamController,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data == "") {
                            return GlobalWidgets().showCircleProgress();
                          } else {
                            return CustomButton(
                              width: 100.0,
                              borderRadius: BorderRadius.circular(2.0),
                              gradient: LinearGradient(colors: [
                                CoupledTheme().primaryPinkDark,
                                CoupledTheme().primaryPink
                              ]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: TextView(
                                  "Send OTP",
                                  size: 16,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (isPswValid1 &&
                                    isPnoValid &&
                                    _mobNoControl.text.isNotEmpty &&
                                    _mobCurrentPwControl.text.isNotEmpty) {
                                  getData(
                                      params: {
                                        'type': (GlobalData?.myProfile
                                                    .passwordStatus ??
                                                true)
                                            ? 'change'
                                            : 'create',
                                        'current_password':
                                            _mobCurrentPwControl.text,
                                        'mobile': _mobNoControl.text
                                      },
                                      path: "phone",
                                      verify: false,
                                      setState: setState,
                                      context: context,
                                      action: (String value) {});
                                  //  _mobCurrentPwControl.clear();
                                  //    _mobNoControl.clear();
                                } else {
                                  GlobalWidgets().showToast(
                                      msg: "All fields are required");
                                }
                              },
                            );
                          }
                        }),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: _visibility,
                  child: EditTextBordered(
                    controller: _mobOtpControl,
                    hint: "OTP",
                    textAlign: TextAlign.left,
                    color: Colors.black,
                    hintColor: Colors.black,
                    size: 16.0,
                    height: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Visibility(
                    visible: _visibility,
                    child: TextView(
                      _visibility
                          ? "Kindly enter the OTP which has been sent to your phone number"
                          : "",
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    )),
                Visibility(
                  visible: _visibility,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          if (isPswValid1 &&
                              isPnoValid &&
                              _mobNoControl.text.isNotEmpty &&
                              _mobCurrentPwControl.text.isNotEmpty) {
                            getData(
                                params: {
                                  'current_password': _mobCurrentPwControl.text,
                                  'mobile': _mobNoControl.text
                                },
                                path: "phone",
                                context: context,
                                setState: setState,
                                verify: false,
                                action: (String value) {});
                          } else {
                            GlobalWidgets()
                                .showToast(msg: "All fields are required");
                          }
                        },
                        child: TextView(
                          "Resend OTP",
                          color: CoupledTheme().primaryPink,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                        ),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Visibility(
                    visible: _visibility,
                    child: StreamBuilder(
                        stream: _streamController,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data == "") {
                            return GlobalWidgets().showCircleProgress();
                          } else {
                            return CustomButton(
                              borderRadius: BorderRadius.circular(2.0),
                              gradient: LinearGradient(colors: [
                                CoupledTheme().primaryPinkDark,
                                CoupledTheme().primaryPink
                              ]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: TextView(
                                  "Verify",
                                  size: 16,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                ),
                              ),
                              onPressed: () {
                                user.userPhone = _mobNoControl.text;
                                if (_mobOtpControl.text != null &&
                                    _mobOtpControl.text.length > 1) {
                                  getData(
                                      params: {
                                        'otp': _mobOtpControl.text,
                                        'mobile': _mobNoControl.text
                                      },
                                      context: context,
                                      path: "otpphone",
                                      setState: setState,
                                      verify: true,
                                      action: (String value) {});
                                } else {
                                  GlobalWidgets().showToast(msg: "Invalid Otp");
                                }
                              },
                            );
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  ///hide account
  showDialogHideAccount(context, {user}) {
    logoutFromOther = false;
    int _btnPressed = 0;
    final List<String> durations = [
      "7",
      "15",
      "30",
    ];
    _dialogTemplate(
      context: context,
      title: "Hide your account for",
      content: StatefulBuilder(builder: (context, setState) {
        return Container(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 35,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return FlatButton(
                      color: _btnPressed == index
                          ? CoupledTheme().primaryPinkDark
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 5),
                        child: TextView(
                          '${durations[index]} Days',
                          size: 16,
                          color: _btnPressed == index
                              ? Colors.white
                              : Colors.black,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _btnPressed = index;
                        });
                      },
                    );
                  },
                  itemCount: 3,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextView(
                CoupledStrings.hideAccountMsg,
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
              ),
            ],
          ),
        );
      }),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12, right: 12),
          child: StreamBuilder(
              stream: _streamController,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == "") {
                  return GlobalWidgets().showCircleProgress();
                } else {
                  return CustomButton(
                    width: 80,
                    borderRadius: BorderRadius.circular(2.0),
                    gradient: LinearGradient(colors: [
                      CoupledTheme().primaryPinkDark,
                      CoupledTheme().primaryPink
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TextView(
                        "Done",
                        size: 16,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                    ),
                    onPressed: () {
                      var myDate = DateTime.now();
                      myDate.add(
                          Duration(days: int.parse(durations[_btnPressed])));
                      user.hideAt = myDate.toString();
                      getData(
                          user: user,
                          params: {'time_period': durations[_btnPressed]},
                          context: context,
                          path: "hide",
                          verify: true,
                          action: (String value) {});
                    },
                  );
                }
              }),
        ),
      ],
    );
  }

  /// active account
  showDialogActivateAccount(context, {user, hideDate}) {
    logoutFromOther = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            content: Container(
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextView(
                    // CoupledStrings.activateAccountMsg,
                    'Your profile is hidden until ${(DateFormat().add_MMMEd().format(
                          DateTime.parse(hideDate),
                        ))}. \nYou would not be able to respond,chat or initiate interest until the account is reactivated',
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                  /* TextView(
                    // CoupledStrings.activateAccountMsg,
                    'Your profile is hidden until  \nYou would not be able to respond,chat or initiate interest until the account is reactivated',
                    color: Colors.black,
                  ),*/
                  SizedBox(
                    height: 15,
                  ),
                  TextView(
                    "Do you like to activate now?",
                    color: CoupledTheme().primaryBlue,
                    size: 18,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        StreamBuilder(
                            stream: _streamController,
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data == "") {
                                return GlobalWidgets().showCircleProgress();
                              } else {
                                return CustomButton(
                                  width: 80.0,
                                  borderRadius: BorderRadius.circular(2.0),
                                  gradient: LinearGradient(colors: [
                                    CoupledTheme().primaryPinkDark,
                                    CoupledTheme().primaryPink
                                  ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: TextView(
                                      "Yes",
                                      size: 16,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: .8,
                                    ),
                                  ),
                                  onPressed: () {
                                    user.hideAt = null;
                                    getData(
                                        user: user,
                                        params: {},
                                        context: context,
                                        path: "activate",
                                        verify: true,
                                        action: (String value) {});
                                  },
                                );
                              }
                            }),
                        CustomButton(
                          width: 80.0,
                          borderRadius: BorderRadius.circular(2.0),
                          gradient: LinearGradient(colors: [
                            CoupledTheme().primaryPinkDark,
                            CoupledTheme().primaryPink
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: TextView(
                              "No",
                              size: 16,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///change email
  showDialogChangeEmail(context, {user}) {
    _visibility = false;
    return _dialogTemplate(
      context: context,
      title: "Change Email",
      content: StatefulBuilder(builder: (context, setState) {
        return Container(
          width: 400.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Visibility(
                visible: !_visibility,
                child: EditTextBordered(
                  controller: _emailTexControl,
                  keyboardType: TextInputType.emailAddress,
                  hint: "Email",
                  onChange: (value) {
                    setState(() {
                      isEmailValid = GlobalWidgets().validateEmail(value);
                    });
                  },
                  errorText: isEmailValid ? null : "Email not valid",
                  textAlign: TextAlign.left,
                  color: Colors.black,
                  hintColor: Colors.black,
                  size: 16.0,
                  height: 16.0,
                ),
              ),
              Visibility(
                visible: !_visibility,
                child: TextView(
                  'Please note this would become your new User Id as well',
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                ),
              ),
              Visibility(
                visible: !_visibility,
                child: SizedBox(
                  height: 15,
                ),
              ),
              Visibility(
                visible: !_visibility,
                child: EditTextBordered(
                  controller: _pswdTexControl,
                  hint: "Current Password",
                  onChange: (value) {
                    setState(() {
                      isPswValid = GlobalWidgets().validatePassword(value);
                    });
                  },
                  errorText: isPswValid
                      ? null
                      : "Password must be atleast 8 charecter",
                  textAlign: TextAlign.left,
                  color: Colors.black,
                  hintColor: Colors.black,
                  size: 16.0,
                  obscureText: true,
                  height: 16.0,
                  showObscureIcon: true,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: _visibility ? false : true,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: StreamBuilder(
                      stream: _streamController,
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        if (snapshot.hasData && snapshot.data == "") {
                          return GlobalWidgets().showCircleProgress();
                        } else {
                          return CustomButton(
                            width: 100.0,
                            borderRadius: BorderRadius.circular(2.0),
                            gradient: LinearGradient(colors: [
                              CoupledTheme().primaryPinkDark,
                              CoupledTheme().primaryPink
                            ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: TextView(
                                "Send OTP",
                                size: 16,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                              ),
                            ),
                            onPressed: () {
                              if (isPswValid &&
                                  isEmailValid &&
                                  _pswdTexControl.text.isNotEmpty &&
                                  _emailTexControl.text.isNotEmpty) {
                                getData(
                                    params: {
                                      'current_password': _pswdTexControl.text,
                                      'email': _emailTexControl.text
                                    },
                                    path: "email",
                                    verify: false,
                                    setState: setState,
                                    context: context,
                                    action: (String value) {});
                                _pswdTexControl.clear();
                                //_emailTexControl.clear();
                              } else {
                                GlobalWidgets()
                                    .showToast(msg: "All fields are required");
                              }
                            },
                          );
                        }

                        /* return CustomButton(
                        width: 100,
                        borderRadius: BorderRadius.circular(2.0),
                        gradient: LinearGradient(colors: [CoupledTheme().primaryPinkDark, CoupledTheme().primaryPink]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child:  TextView(
                            "Sent OTP",
                            size: 16,
                          ),
                        ),
                        onPressed: () {

                          setState(() {
                            _visibility = true;
                          });

                        },
                      );*/
                      }),
                ),
              ),
              Visibility(
                  visible: _visibility,
                  child: TextView(
                    "( Kindly enter the OTP which has been sent to your email )",
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  )),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: _visibility,
                child: EditTextBordered(
                  controller: _emailOtpControl,
                  hint: "OTP",
                  textAlign: TextAlign.left,
                  color: Colors.black,
                  hintColor: Colors.black,
                  size: 16.0,
                  height: 16.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: _visibility,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (isPswValid &&
                            isEmailValid &&
                            _pswdTexControl.text.isNotEmpty &&
                            _emailTexControl.text.isNotEmpty) {
                          getData(
                              params: {
                                'current_password': _pswdTexControl.text,
                                'email': _emailTexControl.text
                              },
                              path: "email",
                              verify: false,
                              setState: setState,
                              context: context,
                              action: (String value) {});
                        } else {
                          GlobalWidgets()
                              .showToast(msg: "All fields are required");
                        }
                      },
                      child: TextView(
                        "Resend OTP",
                        color: CoupledTheme().primaryPink,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Visibility(
                  visible: _visibility,
                  child: StreamBuilder(
                      stream: _streamController,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data == "") {
                          return GlobalWidgets().showCircleProgress();
                        } else {
                          return CustomButton(
                            borderRadius: BorderRadius.circular(2.0),
                            gradient: LinearGradient(colors: [
                              CoupledTheme().primaryPinkDark,
                              CoupledTheme().primaryPink
                            ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: TextView(
                                "Verify",
                                size: 16.0,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                              ),
                            ),
                            onPressed: () {
                              if (_emailOtpControl.text != null &&
                                  _emailOtpControl.text.length > 1) {
                                user.userEmail = _emailTexControl.text;
                                getData(
                                    params: {
                                      'otp': _emailOtpControl.text,
                                      'email': _emailTexControl.text
                                    },
                                    context: context,
                                    path: "otpemail",
                                    setState: setState,
                                    verify: true,
                                    action: (String value) {});
                              } else {
                                GlobalWidgets().showToast(msg: "Invalid Otp");
                              }
                            },
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  ///dialog with simple message(warning)
  showSimpleMessageDialog(context, {String msg = '', String title = ''}) {
    return _dialogTemplate(
      context: context,
      title: title,
      content: TextView(
        msg,
        color: Colors.black,
        size: 13,
        textScaleFactor: .8,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12, right: 12),
          child: CustomButton(
            borderRadius: BorderRadius.circular(2.0),
            gradient: LinearGradient(colors: [
              CoupledTheme().primaryPinkDark,
              CoupledTheme().primaryPink
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextView(
                "Ok",
                size: 16,
                textScaleFactor: .8,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  showDialogYesNo(
      {required BuildContext context,
      String title = '',
      String content = '',
      String memcode = '',
      String leftBbuttonText = '',
      String rightBbuttonText = '',
      String partnerName = '',
      bool leftButtonVisibility = false,
      bool rightButtonVisibility = false}) {
    return _dialogTemplate(
      context: context,
      title: title,
      content: TextView(
        content,
        color: Colors.black,
        size: 13.0,
        maxLines: 10,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
        overflow: TextOverflow.visible,
        textScaleFactor: .8,
      ),
      actions: <Widget>[
        Visibility(
          visible: leftButtonVisibility,
          child: CustomButton(
            width: 80.0,
            borderRadius: BorderRadius.circular(2.0),
            gradient: LinearGradient(colors: [
              CoupledTheme().primaryPinkDark,
              CoupledTheme().primaryPink
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextView(
                leftBbuttonText,
                size: 13.0,
                color: Colors.white,
                maxLines: 2,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                textScaleFactor: .8,
              ),
            ),
            onPressed: () {
              print(leftBbuttonText);
              if (leftBbuttonText == 'Not now') {
                Navigator.pop(context);
                showSimpleDialog(context, title,
                    "Sorry to hear that, you may come anytime to send gift to your loved one");
              } else if (leftBbuttonText == 'Reject') {
                Navigator.pop(context);
                Map<String, dynamic> params = {
                  'mom_status': 'reject',
                  'membership_code': memcode,
                };

                RestAPI().post(APis.tolAccept, params: params).then((value) {
                  var a = CommonResponseModel.fromJson(value);
                  showSimpleDialog(context, title,
                      "We will Let $partnerName know that your are not ready for Token of Love now and you would want to give this relationship more time to take things ahead");
                  GlobalWidgets().showToast(msg: a.status.toString());
                });
              } else if (leftBbuttonText == 'Ok') {
                Navigator.pop(context);
                print("problem is here");
                Navigator.pushNamed(context, '/tolHome');
              } else if (leftBbuttonText == 'Ok!') {
                Navigator.pop(context);
              } else if (leftBbuttonText == 'ReAccept') {
                Navigator.pop(context);
                Dialogs().chatToTol(context, memcode, partnerName);
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        Visibility(
          visible: rightButtonVisibility,
          child: CustomButton(
            width: 80.0,
            borderRadius: BorderRadius.circular(2.0),
            gradient: LinearGradient(colors: [
              CoupledTheme().primaryPinkDark,
              CoupledTheme().primaryPink
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextView(
                rightBbuttonText,
                size: 13.0,
                color: Colors.white,
                maxLines: 2,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                textScaleFactor: .9,
              ),
            ),
            onPressed: () {
              Map<String, dynamic> params = {
                'membership_code': memcode,
              };

              if (rightBbuttonText == 'Ok') {
                RestAPI().post(APis.tolRequest, params: params).then((value) {
                  print('--res--${value['response']}');
                  // print('--res--${value['response']}')
                  var a = CommonResponseModel.fromJson(value);
                  Navigator.pop(context);
                  showSimpleDialog(context, "Token Of Love",
                      "Hello! we have sent request to  $partnerName , We will Notify you when $partnerName accepts the TOL request. Meanwhile you can keep interacting with your partner. Wishing you best of love!");
                  GlobalWidgets().showToast(msg: a.response?.msg.toString());

                  print('--res--$a');
                });
              } else if (rightBbuttonText == 'Accept') {
                Navigator.pop(context);
                Dialogs().chatToTol(context, memcode, partnerName);
              } else {
                Navigator.pop(context);
              }
              // Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  showSimpleDialog(
    context,
    String title,
    String content,
  ) {
    return _dialogTemplate(
      context: context,
      title: title,
      content: TextView(
        content,
        size: 13,
        color: Colors.black,
        maxLines: 2,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.normal,
        textAlign: TextAlign.center,
        overflow: TextOverflow.visible,
        textScaleFactor: .8,
      ),
      actions: <Widget>[
        Visibility(
          visible: true,
          child: CustomButton(
            width: 80.0,
            borderRadius: BorderRadius.circular(2.0),
            gradient: LinearGradient(colors: [
              CoupledTheme().primaryPinkDark,
              CoupledTheme().primaryPink
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextView(
                "Ok",
                size: 13,
                color: Colors.white,
                maxLines: 2,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                textScaleFactor: .8,
              ),
            ),
            onPressed: () {
              //Navigator.pop(context);

              Navigator.of(context).pushNamed('/chatViewMain');
            },
          ),
        ),
      ],
    );
  }

  chatToTol(context, String memcode, String partnerName) {
    tolStatus = GlobalData.myProfile.address?.tolStatus == 1 ? true : false;
    _countryTextControl.text = GlobalData.myProfile.address!.country != null
        ? GlobalData.myProfile.address!.country
        : '';
    _stateTextControl.text = GlobalData.myProfile.address!.state != null
        ? GlobalData.myProfile.address!.state
        : '';
    _cityTextControl.text = GlobalData.myProfile.address!.city != null
        ? GlobalData.myProfile.address!.city
        : '';
    _addressTextControl.text = GlobalData?.myProfile.address!.address != null
        ? GlobalData?.myProfile.address!.address
        : '';
    _pincodeTextControl.text =
        GlobalData?.myProfile.address!.pincode.toString() ?? '';
    locationId = GlobalData.myProfile.address!.locationId != null
        ? GlobalData.myProfile.address!.locationId
        : 0;
    print('---adddd--${_countryTextControl.text}');
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    var _profileResponse = GlobalData.myProfile;
    _smcBloc = SmcBloc();
    _smcBloc.add(SMCParams());

    return _dialogTemplate(
      context: context,
      title: 'Are You Interested in Activating\nToken Of Love',
      color: Colors.white,
      content: Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: StatefulBuilder(builder: (context, setState) {
            return BlocListener<SmcBloc, SmcState>(
              bloc: _smcBloc,
              listener: (context, snapshot) {
                setState(() {
                  if (snapshot is SmcCountry) {
                    _country = snapshot.countries;
                    Item isCountry = _country.singleWhere(
                      (element) =>
                          element.name.toLowerCase() ==
                          _profileResponse.address?.country.toLowerCase(),
                    );
                    if (isCountry != null) {
                      isCountry.isSelected = true;
                      _smcBloc.add(SMCParams(
                          type: 'state', countryCode: isCountry.code));
                    }
                    print("Countries : $isCountry");
                  }
                  if (snapshot is SmcStates) {
                    _state = snapshot.states;
                    Item isState = _state.singleWhere(
                      (element) =>
                          element.name.toLowerCase() ==
                          _profileResponse.address?.state.toLowerCase(),
                    );
                    if (isState != null) {
                      isState.isSelected = true;
                      _smcBloc.add(
                          SMCParams(type: 'city', stateCode: isState.name));
                    }
                    print(
                        "State : $isState   ${_profileResponse.address?.state}");
                    print(
                        "city : $isState   ${_profileResponse.address?.city}");
                  }
                  if (snapshot is SmcCity) {
                    _city = snapshot.cities;

                    bool? item = _city
                        .singleWhere(
                          (element) =>
                              element.name.toLowerCase() ==
                              _profileResponse.address?.city.toLowerCase(),
                        )
                        .isSelected = true;
                    print("City : $item");
                  }
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
//                  TextView(
//                    'Surprise the special one  with a gift and take the proposal to the next level',
//                    color: Colors.pink,
//                  ),
//                  SizedBox(
//                    height: 10.0,
//                  ),
//                  Row(children: <Widget>[
//                    Checkbox(
//                      activeColor: Colors.pink,
//                      value: tolStatus,
//                      onChanged: (isClicked) {
//                        setState(() {
//                          print(isClicked);
//                          tolStatus = isClicked;
//                        });
//                      },
//                    ),
//                    TextView(
//                      'Yes i wish to send and recieve \nToken Of Love',
//                      color: Colors.black,
//                    ),
//                  ]),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextView(
                    'Thats Great! Share your complete Address, so you may recieve a surprise from someone',
                    color: Colors.black,
                    size: 12.0,
                    maxLines: 2,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    textScaleFactor: .8,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: () {
                      _modalBottomSheetMenu(context: context, page: 0);
                    },
                    child: EditTextBordered(
                      onChange: (value) {
                        print("---country$value");
                      },
                      hint: 'Country',
                      enabled: false,
                      controller: _countryTextControl,
                      color: Colors.black,
                      hintColor: Colors.grey,
                      height: 10.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: () {
                      _modalBottomSheetMenu(context: context, page: 1);
                    },
                    child: EditTextBordered(
                      hint: 'State',
                      enabled: false,
                      controller: _stateTextControl,
                      color: Colors.black,
                      hintColor: Colors.grey,
                      height: 10.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: () {
                      _modalBottomSheetMenu(context: context, page: 2);
                    },
                    child: EditTextBordered(
                        hint: 'City',
                        enabled: false,
                        controller: _cityTextControl,
                        color: Colors.black,
                        hintColor: Colors.grey,
                        height: 10.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  EditTextBordered(
                    hint: 'Address',
                    controller: _addressTextControl,
                    color: Colors.black,
                    hintColor: Colors.grey,
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  EditTextBordered(
                    maxLength: 6,
                    hint: 'Pincode',
                    hintColor: Colors.black,
                    controller: _pincodeTextControl,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.number,
                    color: Colors.black,
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextView(
                    'Your Address information is secure with us and wont be visible to anyone ',
                    color: Colors.black,
                    size: 12.0,
                    maxLines: 2,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    textScaleFactor: .8,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomButton(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15.0),
                          child: TextView(
                            "Update",
                            size: 16.0,
                            maxLines: 2,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            textScaleFactor: .8,
                          ),
                        ),
                        onPressed: () {
                          Map<String, dynamic> params = {
                            'country_code': _countryTextControl.text,
                            'location_id': locationId,
                            'address': _addressTextControl.text,
                            'pincode': _pincodeTextControl.text,
                            'mom_status': 'accept',
                            'membership_code': memcode,
                          };

                          if (_pincodeTextControl.text.length == 6) {
//                            Navigator.pop(context);

                            RestAPI()
                                .post(APis.tolAccept, params: params)
                                .then((value) {
                              var a = CommonResponseModel.fromJson(value);
                              showSimpleDialog(
                                  context,
                                  "Token of Love",
                                  "Congratulations on taking a step further towards a prospective alliance with $partnerName"
                                      ". you  may receive a surprise in a form of a Token of love.");
                              GlobalWidgets()
                                  .showToast(msg: a.status.toString());
                            });
                          } else {
                            GlobalWidgets()
                                .showToast(msg: 'Pincode must be of 6 digits');
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  ///////////////////////
  bool hideBackButton = true;
  String selectedCountry = "", selectedState = "", selectedCity = "";
  void _modalBottomSheetMenu({int page = 1, required BuildContext context}) {
    PageController _pageController;
    _pageController = PageController(initialPage: page, keepPage: true);
    Future.delayed(Duration(milliseconds: 150), () {
      _pageController.jumpToPage(page == null ? 0 : page);
      hideBackButton =
          _pageController.page == null || _pageController.page == 0;
    });
    showBottomSheet(
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
                        BlocBuilder<SmcBloc, SmcState>(
                            bloc: _smcBloc,
                            builder: (context, snapshot) {
                              if (snapshot is SmcLoading &&
                                  snapshot.extras == 'country') {
                                return Container(
                                    color: Colors.white,
                                    child:
                                        GlobalWidgets().showCircleProgress());
                              }
                              return SMCWidget(
                                title: "Country",
                                multipleChoice: false,
                                items: _country,
                                selectedItem: (isChecked, values) {
                                  if (values is Item) {
                                    state(() {
                                      _country
                                          .singleWhere((test) => test == values)
                                          .isSelected = isChecked;

                                      print("country $values");
                                      if (isChecked) {
                                        selectedCountry = values.name;
                                        _stateTextControl.text = '';
                                        _cityTextControl.text = '';
                                        _smcBloc.add(SMCParams(
                                            type: 'state',
                                            countryCode: values.code));
                                      } else {
                                        _countryTextControl.text = "";
                                        _stateTextControl.text = '';
                                        _cityTextControl.text = '';
                                      }
                                    });
                                  }
                                },
                                errorWidget: SizedBox(),
                              );
                            }),
                        BlocBuilder<SmcBloc, SmcState>(
                            bloc: _smcBloc,
                            builder: (context, snapshot) {
                              if (snapshot is SmcLoading &&
                                  snapshot.extras == 'state') {
                                return Container(
                                    color: Colors.white,
                                    child:
                                        GlobalWidgets().showCircleProgress());
                              }
                              return SMCWidget(
                                title: "State",
                                multipleChoice: false,
                                items: _state,
                                selectedItem: (isChecked, values) {
                                  if (values is Item) {
                                    state(() {
                                      _state
                                          .singleWhere((test) => test == values)
                                          .isSelected = isChecked;
                                      if (isChecked) {
                                        _stateTextControl.text = values.name;
                                        _cityTextControl.text = '';

                                        _smcBloc.add(SMCParams(
                                            type: 'city',
                                            stateCode: values.name));
                                        //																				_city.addAll(getCities(values.name));
                                      } else {
                                        _stateTextControl.text = "";
                                        _cityTextControl.text = '';
                                      }
                                    });
                                  }
                                },
                                errorWidget: SizedBox(),
                              );
                            }),
                        BlocBuilder<SmcBloc, SmcState>(
                            bloc: _smcBloc,
                            builder: (context, snapshot) {
                              if (snapshot is SmcLoading &&
                                  snapshot.extras == 'city') {
                                return Container(
                                    color: Colors.white,
                                    child:
                                        GlobalWidgets().showCircleProgress());
                              }
                              return SMCWidget(
                                title: "City",
                                multipleChoice: false,
                                items: _city,
                                selectedItem: (isChecked, values) {
                                  if (values is Item) {
                                    state(() {
                                      _city
                                          .singleWhere((test) => test == values)
                                          .isSelected = isChecked;
                                      print("city $values");
                                      if (isChecked) {
                                        _cityTextControl.text = values.name;
                                        print(GlobalData
                                            .myProfile.info!.locationId);
                                      } else {
                                        _cityTextControl.text = "";
                                      }
                                    });
                                  }
                                },
                                errorWidget: SizedBox(),
                              );
                            }),
                      ],
                      onPageChanged: (index) {
                        state(() {
                          hideBackButton = index == 0;
                          print(
                              "pageD ${_pageController.page} $hideBackButton");
                        });
                      },
                    ),
                    Align(
                      alignment: Alignment(0, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            hideBackButton
                                ? Container()
                                : InkWell(
                                    onTap: () {
                                      if (_pageController.page!.round() > 0) {
                                        _pageController.previousPage(
                                            duration:
                                                Duration(milliseconds: 350),
                                            curve: Curves.easeInOut);
                                      }
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 20.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color:
                                                CoupledTheme().primaryPinkDark),
                                        child: TextView(
                                          "Back",
                                          size: 12.0,
                                          maxLines: 2,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,
                                        )),
                                  ),
                            InkWell(
                              onTap: () {
                                if (_pageController.page!.round() < 2) {
                                  _pageController.nextPage(
                                      duration: Duration(milliseconds: 350),
                                      curve: Curves.easeInOut);
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 20.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: CoupledTheme().primaryPinkDark),
                                  child: TextView(
                                    "Next",
                                    size: 12.0,
                                    maxLines: 2,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }
}
