import 'package:coupled/Home/Profile/CouplingScore/bloc/coupling_score_bloc.dart';
import 'package:coupled/Home/Profile/CouplingScore/view/couplingScore.dart';
import 'package:coupled/Home/Profile/othersProfile/bloc/others_profile_bloc.dart';
import 'package:coupled/Home/Profile/othersProfile/helpers/action_buttons.dart';
import 'package:coupled/Home/Profile/othersProfile/helpers/mom_status.dart';

import 'package:coupled/REST/RestAPI.dart';

import 'package:coupled/Utils/Modals/dialogs.dart';

import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/page_with_tabs.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/models/coupling_score.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coupled/Home/Profile/othersProfile/OtherProfile.dart';

class CoupingScorePredictions extends StatefulWidget {
  final String userId;
  final String profileImg;

  const CoupingScorePredictions(
      {Key? key, this.userId = '', this.profileImg = ''})
      : super(key: key);

  @override
  _CoupingScorePredictions createState() => _CoupingScorePredictions();
}

class _CoupingScorePredictions extends State<CoupingScorePredictions>
    with SingleTickerProviderStateMixin {
  bool state = false;

  late TabController _tabController;

  // CouplingScoreBloc couplingScoreBloc;
  CouplingScoreModel couplingScoreModel = CouplingScoreModel(
      response: CouplingScoreModelResponse(
          mom: Mom(), physical: [], psychological: []));
  List<BaseSettings> baseSettings = [];
  ProfileResponse myProfileResponse = ProfileResponse(
      officialDocuments: OfficialDocuments(),
      usersBasicDetails: UsersBasicDetails(),
      mom: Mom(),
      info: Info(maritalStatus: BaseSettings(options: <BaseSettings>[])),
      preference:
          Preference(complexion: BaseSettings(options: <BaseSettings>[])),
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
  CommonResponseModel commonResponseModel = CommonResponseModel(
      response: CommonResponse(
          data: Data(
              recomendCause: [],
              recomendCauseCount: 0,
              mom: Mom(),
              shortlistByMe: Mom())));

  void callAction(title, baseType, momType, {isMultiSelection = true}) {
    var s = baseSettings.singleWhere((f) {
      return f.value == baseType;
    });
    Dialogs().profileDialogs(
      context,
      title,
      widget.userId,
      multiSelection: isMultiSelection,
      momType: momType,
      reasons: s.options,
      callBack: (msg) {
        print(msg);
      },
    );
  }

  @override
  void initState() {
    //  couplingScoreBloc = CouplingScoreBloc();
    GlobalData.couplingScoreBloc = CouplingScoreBloc();
    GlobalData.couplingScoreBloc.add(LoadCouplingScore(widget.userId));
    // GlobalData.othersProfile = ProfileResponse(id: int.parse(widget.userId));

    myProfileResponse = GlobalData.myProfile;
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.animation!.addListener(() {
      if (_tabController.animation!.value > .5) {
        state = true;
      } else {
        state = false;
      }
    });
    print(myProfileResponse.dp!.photoName);
  }

  List<Widget> generateCard(List<Ical>? physical) {
    return List<Widget>.generate(physical!.isEmpty ? 0 : physical.length,
        (index) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: getCouplingScoreCard(physical, index),
      );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    GlobalData.couplingScoreBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        appBar: AppBar(
          backgroundColor: CoupledTheme().backgroundColor,
          title: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextView(
                  "Couping Score Predictions",
                  size: 22,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder(
          bloc: GlobalData.couplingScoreBloc,
          builder: (context, CouplingScoreState state) {
            print('state---------------------$state');
            if (state is LoadedCouplingScore ||
                state is CouplingScoreNotifier) {
              print('CoupledGlobal.couplingScoreModel.response.mom---');
              print(getMomStatus(GlobalData.couplingScoreModel.response!.mom));
              // print(GlobalData.couplingScoreModel.response.mom.momStatus);
              couplingScoreModel = GlobalData.couplingScoreModel;

              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: CoupledTheme().backgroundColor,
                      expandedHeight: 210,
                      floating: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(22.0),
                                  child: Card(
                                    child: FadeInImage.assetNetwork(
                                      height: 120,
                                      width: 110,
                                      fit: BoxFit.cover,
                                      placeholder: 'assets/no_image.jpg',
                                      image: APis().imageApi(
                                          myProfileResponse.dp!.photoName,
                                          imageConversion:
                                              ImageConversion.MEDIA),
                                    ),
                                  ),
                                ),
                                HeartPercentage(
                                  couplingScoreModel.response!.score.toString(),
                                  fontSize: 11,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(22.0),
                                  child: Card(
                                    child: FadeInImage.assetNetwork(
                                      height: 120,
                                      width: 110,
                                      fit: BoxFit.cover,
                                      placeholder: 'assets/no_image.jpg',
                                      image: widget.profileImg,
                                      // APis().imageApi(widget.profileImg,
                                      //     imageConversion:
                                      //         ImageConversion.MEDIA),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            /*Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: TextView(
                                CoupledStrings.couplingScore,
                                size: 12,
                              ),
                            ),*/
                            Visibility(
                              visible: generateCard(
                                          couplingScoreModel.response!.physical)
                                      .isEmpty
                                  ? false
                                  : true,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: getquoteonScore(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: Stack(
                  children: <Widget>[
                    Padding(
                      padding: getMomStatus(GlobalData
                                      .couplingScoreModel.response!.mom) ==
                                  null ||
                              (GlobalData.couplingScoreModel.response?.mom
                                              ?.momType ??
                                          '') !=
                                      'connect' &&
                                  getMomStatus(GlobalData
                                          .couplingScoreModel.response!.mom) !=
                                      actionType.blockByMe &&
                                  getMomStatus(GlobalData
                                          .couplingScoreModel.response!.mom) !=
                                      actionType.blockMe &&
                                  getMomStatus(GlobalData
                                          .couplingScoreModel.response!.mom) !=
                                      actionType.reported
                          ? const EdgeInsets.only(bottom: 60)
                          : const EdgeInsets.only(),
                      child: Visibility(
                        visible:
                            generateCard(couplingScoreModel.response!.physical)
                                    .isEmpty
                                ? false
                                : true,
                        child: PageWithTabs(
                          //  scrollPhysics: NeverScrollableScrollPhysics(),
                          tabController: _tabController,
                          tabName: ["Physical", "Phychological"],
                          tabData: [
                            generateCard(couplingScoreModel.response?.physical),
                            generateCard(
                                couplingScoreModel.response?.psychological)
                          ],
                          isHintVisible: false,
                          isCountVisible: true,
                          dividerVisibility: false,
                          infoVisibility: true,
                          tab1Count: couplingScoreModel.response?.physicalScore
                                  ?.toString() ??
                              '0',
                          tab2Count: couplingScoreModel
                                  .response?.psychologicalScore
                                  ?.toString() ??
                              '0',
                          tooltipMsg1:
                              "Decode your thinking and wavelength compatibility with the partner",
                          tooltipMsg2:
                              "Explore your latent, subconscious expectations from a partner",
                        ),
                      ),
                    ),
                    Visibility(
                      visible: getMomStatus(GlobalData
                                  .couplingScoreModel.response!.mom) !=
                              actionType.blockByMe &&
                          getMomStatus(GlobalData
                                  .couplingScoreModel.response!.mom) !=
                              actionType.blockMe &&
                          getMomStatus(GlobalData
                                  .couplingScoreModel.response!.mom) !=
                              actionType.reported,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              ///shortlist
                              Visibility(
                                visible: getMomStatus(GlobalData
                                            .couplingScoreModel
                                            .response
                                            ?.mom) ==
                                        null ||
                                    getMomStatus(GlobalData.couplingScoreModel
                                            .response!.mom) ==
                                        actionType.shortlistMe,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 30),
                                  child: getActionBtn(
                                    context: context,
                                    type: btnType.SHORTLIST,
                                    othersProfileBloc: OthersProfileBloc(),
                                  ),
                                ),
                              ),

                              ///connect
                              Visibility(
                                  visible: getMomStatus(GlobalData
                                              .couplingScoreModel
                                              .response!
                                              .mom) ==
                                          null ||
                                      (GlobalData.couplingScoreModel.response!
                                                  .mom!.momType ??
                                              '') !=
                                          'connect',
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 30),
                                    child: getActionBtn(
                                      context: context,
                                      type: btnType.CONNECT_WITH_MESSAGE,
                                      othersProfileBloc: OthersProfileBloc(),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                          generateCard(couplingScoreModel.response?.physical)
                                  .isEmpty
                              ? true
                              : false,
                      child: AlertDialog(
                        backgroundColor: Colors.transparent,
                        title: null,
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
                                        left: 15,
                                        right: 15,
                                        top: 35,
                                        bottom: 15),
                                    child: Column(
                                      children: <Widget>[
                                        TextView(
                                          "Hello,Activate Coupling Score to get detailed match predictions and insight between you and your prospective partners",
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                          overflow: TextOverflow.visible,
                                          size: 12,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                          maxLines: 10,
                                        ),
                                        SizedBox(
                                          height: 18,
                                        ),
                                        CustomButton(
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                          gradient: LinearGradient(colors: [
                                            CoupledTheme().primaryPinkDark,
                                            CoupledTheme().primaryPink
                                          ]),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 8),
                                            child: TextView(
                                              "Activate Coupling Score",
                                              decoration: TextDecoration.none,
                                              overflow: TextOverflow.visible,
                                              size: 12,
                                              textAlign: TextAlign.center,
                                              textScaleFactor: .8,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    '/myPlanPayments');
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            /*else if (state is ErrorState) {
              print("ERROR::::::");
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                if (state.errorMessage == 'no plan')
                  await Dialogs().profileUpgradePlan(context);
                if (state.errorMessage == 'no topup')
                  await Dialogs().profileTopUpPlan(context);
              });
              // return GlobalWidgets().errorState(message: state.errorMessage);
              return GlobalWidgets()
                  .errorState(message: CoupledStrings.errorMsg);
            }*/

            else {
              return GlobalWidgets().showCircleProgress();
            }
          },
        ));
  }

  ///coupling score summary message based on score
  getquoteonScore() {
    if (couplingScoreModel.response!.score <= 50) {
      return TextView(
        CoupledStrings.couplingScore,
        decoration: TextDecoration.none,
        overflow: TextOverflow.visible,
        size: 12,
        textAlign: TextAlign.center,
        textScaleFactor: .8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    } else if (couplingScoreModel.response!.score >= 51 &&
        couplingScoreModel.response!.score <= 55) {
      return TextView(
        CoupledStrings.couplingScore1,
        decoration: TextDecoration.none,
        overflow: TextOverflow.visible,
        size: 12,
        textAlign: TextAlign.center,
        textScaleFactor: .8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    } else if (couplingScoreModel.response!.score >= 56 &&
        couplingScoreModel.response!.score <= 60) {
      return TextView(
        CoupledStrings.couplingScore1,
        decoration: TextDecoration.none,
        overflow: TextOverflow.visible,
        size: 12,
        textAlign: TextAlign.center,
        textScaleFactor: .8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    } else if (couplingScoreModel.response!.score >= 61 &&
        couplingScoreModel.response!.score <= 65) {
      return TextView(
        CoupledStrings.couplingScore2,
        decoration: TextDecoration.none,
        overflow: TextOverflow.visible,
        size: 12,
        textAlign: TextAlign.center,
        textScaleFactor: .8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    } else if (couplingScoreModel.response!.score >= 66 &&
        couplingScoreModel.response!.score <= 70) {
      return TextView(
        CoupledStrings.couplingScore2,
        decoration: TextDecoration.none,
        overflow: TextOverflow.visible,
        size: 12,
        textAlign: TextAlign.center,
        textScaleFactor: .8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    } else if (couplingScoreModel.response!.score >= 71 &&
        couplingScoreModel.response!.score <= 75) {
      return TextView(
        CoupledStrings.couplingScore3,
        decoration: TextDecoration.none,
        overflow: TextOverflow.visible,
        size: 12,
        textAlign: TextAlign.center,
        textScaleFactor: .8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    } else if (couplingScoreModel.response!.score >= 76 &&
        couplingScoreModel.response!.score <= 80) {
      return TextView(
        CoupledStrings.couplingScore3,
        decoration: TextDecoration.none,
        overflow: TextOverflow.visible,
        size: 12,
        textAlign: TextAlign.center,
        textScaleFactor: .8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    } else if (couplingScoreModel.response!.score >= 81 &&
        couplingScoreModel.response!.score <= 85) {
      return TextView(
        CoupledStrings.couplingScore4,
        decoration: TextDecoration.none,
        overflow: TextOverflow.visible,
        size: 12,
        textAlign: TextAlign.center,
        textScaleFactor: .8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    } else if (couplingScoreModel.response!.score >= 86 &&
        couplingScoreModel.response!.score <= 90) {
      return TextView(
        CoupledStrings.couplingScore4,
        decoration: TextDecoration.none,
        overflow: TextOverflow.visible,
        size: 12,
        textAlign: TextAlign.center,
        textScaleFactor: .8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    } else if (couplingScoreModel.response!.score >= 91 &&
        couplingScoreModel.response!.score <= 95) {
      return TextView(
        CoupledStrings.couplingScore5,
        decoration: TextDecoration.none,
        overflow: TextOverflow.visible,
        size: 12,
        textAlign: TextAlign.center,
        textScaleFactor: .8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    } else if (couplingScoreModel.response!.score >= 96 &&
        couplingScoreModel.response!.score <= 100) {
      return TextView(
        CoupledStrings.couplingScore5,
        decoration: TextDecoration.none,
        overflow: TextOverflow.visible,
        size: 12,
        textAlign: TextAlign.center,
        textScaleFactor: .8,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    } else {
      return null;
    }
  }
}
