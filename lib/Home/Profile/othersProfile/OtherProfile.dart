import 'dart:math' as math;

import 'package:coupled/Actions/share_view.dart';
import 'package:coupled/Home/Profile/CouplingScore/view/CouplingScorePredictions.dart';
import 'package:coupled/Home/Profile/CouplingScore/view/couplingScore.dart';
import 'package:coupled/Home/Profile/MyProfile/PhotoView.dart';
import 'package:coupled/Home/Profile/MyProfile/profile_items.dart';
import 'package:coupled/Home/Profile/othersProfile/bloc/others_profile_bloc.dart';
import 'package:coupled/Home/Profile/othersProfile/helpers/action_buttons.dart';
import 'package:coupled/Home/Profile/othersProfile/helpers/actions_on_profile.dart';
import 'package:coupled/Home/Profile/othersProfile/helpers/bottom_action.dart';
import 'package:coupled/Home/Profile/othersProfile/helpers/photo_widget.dart';
import 'package:coupled/Home/Profile/othersProfile/helpers/profileItem_card.dart';
import 'package:coupled/Home/Profile/profile_switch.dart';

import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/capitalize_string.dart';

import 'package:coupled/Utils/custom_progress_bar.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/resources/settings_and_cms_provider.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'helpers/mom_status.dart';
import 'helpers/similarProfile.dart';

enum actionType {
  DEFAULT,
  requestSent,
  requestReceived,
  blockByMe,
  blockMe,
  rejectedByMe,
  rejectedMe,
  shortlistByMe,
  shortlistMe,
  connected,
  reported,
  sent,
  request,
  remind,
  reject,
  reAccept,
  accept,
  snooze,
  block
}

enum btnType {
  REMINDER,
  RECOMMEND,
  SHORTLIST,
  CONTACT,
  CHAT,
  REPORT,
  BLOCK,
  UNBLOCK,
  SHARE,
  CONNECT,
  CONNECT_WITH_MESSAGE,
  CANCEL,
  REJECT,
  RE_ACCEPT,
  ACCEPT,
  SNOOZE
}

class OthersProfile extends StatefulWidget {
  final String? membershipCode;
  final ProfileResponse profileResponse;
  final double offset;

  OthersProfile({
    this.membershipCode,
    required this.profileResponse,
    this.offset = 0.0,
  });

  @override
  _OthersProfileState createState() => _OthersProfileState();
}

class _OthersProfileState extends State<OthersProfile>
    with SingleTickerProviderStateMixin {
//  List<BaseSettings> baseSettings = List();
  ScrollController nestedScrollController =
      ScrollController(initialScrollOffset: 0);
  Dialogs dialogs = Dialogs();
  OfficialDocuments officialDocuments = OfficialDocuments();
  bool disableEditButton = true, isOnline = false;
  String snoozedDuration = "";
  double screenWidth = 0.0;
  var _pagerPosition = 0;
  List<Widget> profileImages = <Widget>[];
  List<Sibling> brother = [], sister = [];
  UserShortInfoModel similarProfilesResponse =
      UserShortInfoModel(response: UserShortInfoResponse.fromJson({}));
  bool showBottomBar = false, floatingVisible = false;

  PageController pageController = PageController(initialPage: 0);
  late AnimationController _controller;
  late Animation<double> _fadeOut;
  bool isReminderVisible = false;

  bool isMyAcion = false;

  Plan plan = Plan(topups: []);

  void onPageChanged(int value) {
    setState(() {
      _pagerPosition = value;
    });
  }

  OthersProfileBloc othersProfileBloc = OthersProfileBloc();

  @override
  void didChangeDependencies() {
    isMyAcion = GlobalData.myProfile.id == GlobalData.myProfile.id;
    //isMyAcion = GlobalData.othersProfile.mom?.userId != GlobalData.myProfile.id;

    //showBottomBar = CoupledGlobal.othersProfile.mom?.userId != _myProfileResponse.id;

    // if (GlobalData.othersProfile.mom.userId != GlobalData.myProfile.id &&
    //     GlobalData.othersProfile.mom.momStatus == "sent") {
    //   showBottomBar = true;
    // }

    print("MEMBER ::::+ ${widget.membershipCode}");

    super.didChangeDependencies();
  }

  bool loadSimilarProfile = true;

  @override
  void dispose() {
    othersProfileBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    othersProfileBloc
        .add(LoadOthersProfile((widget.membershipCode).toString()));
    // GlobalData.othersProfile = widget.profileResponse;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    _fadeOut = Tween(begin: 0.0, end: 1.0).animate(_controller);

    ///loading similar profile on maxScrollExtent
    nestedScrollController.addListener(() {
      if (nestedScrollController.offset >=
              nestedScrollController.position.maxScrollExtent &&
          !nestedScrollController.position.outOfRange) {
        Repository()
            .similarProfile(GlobalData.othersProfile.membershipCode)
            .then((value) {
          setState(() {
            similarProfilesResponse = value;
            print('Similar...Profile$similarProfilesResponse');
          });
        }, onError: (error) {
          setState(() {
            similarProfilesResponse = UserShortInfoModel(
                status: 'error', response: UserShortInfoResponse.fromJson({}));
          });
        });
      }
      if (nestedScrollController.position.pixels != 0)
        nestedScrollController.position.userScrollDirection ==
                    ScrollDirection.reverse &&
                !nestedScrollController.position.atEdge
            ? _controller.reverse()
            : _controller.forward();
      else
        _controller.reverse();
    });
    print(
        'OtherProfile........................... ${GlobalData.othersProfile}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((widget.offset.abs() - 0.5), 2) / 0.08));
    screenWidth = MediaQuery.of(context).size.width;
    return Transform.translate(
      offset: Offset(-32 * gauss * widget.offset.sign, 0),
      child: Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        body: BlocBuilder(
          bloc: othersProfileBloc,
          builder: (context, OthersProfileState state) {
            print('others profile state----------------$state');
            if (state is OtherProfileErrorState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: GlobalWidgets()
                        .errorState(message: state.errorMessage)),
              );
            }
            initiateData();

            ///This scaffold is to set the snooze disabled and enabled in bottomAction
            return Scaffold(
              backgroundColor: CoupledTheme().backgroundColor,
              bottomNavigationBar: GlobalData.othersProfile != null
                  ? getMomStatus(GlobalData.othersProfile.mom) ==
                          actionType.requestReceived
                      ? bottomAction(
                          context,
                          othersProfileBloc,
                        )
                      : null
                  : SizedBox(),
              floatingActionButton: floatingBtn(),
              body: Stack(
                children: <Widget>[
                  Opacity(
                    opacity: (state is InitialOthersProfileState) ? 0.5 : 1,
                    child: SafeArea(
                      child: NestedScrollView(
                        controller: nestedScrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverAppBar(
                              backgroundColor: CoupledTheme().backgroundColor,
                              expandedHeight:
                                  MediaQuery.of(context).size.height * .62,
                              stretch: true,
                              stretchTriggerOffset: 100.0,
                              titleSpacing: 0.0,
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Visibility(
                                      visible: GlobalData
                                              .othersProfile.mom!.momType !=
                                          "block",
                                      child: ShareProfileBtn(
                                        membershipCode: GlobalData
                                            .othersProfile.membershipCode,
                                        membership: null,
                                      )),
                                )
                              ],
                              flexibleSpace: FlexibleSpaceBar(
                                background: Stack(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => PhotoView(
                                              pageIndex: pageController.page!
                                                  .toDouble(),
                                              photos: GlobalData
                                                  .othersProfile.photos,
                                            ),
                                          ),
                                        );
                                      },
                                      child: PageView.builder(
                                          controller: pageController,
                                          onPageChanged: onPageChanged,
                                          itemCount: profileImages.length,
                                          itemBuilder: (context, position) {
                                            return profileImages[position];
                                          }),
                                    ),
                                    SafeArea(
                                      child: Container(
                                        height: 6,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: profileImages.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              child: Container(
                                                height: 6,
                                                width: screenWidth /
                                                    profileImages.length,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 1),
                                                  child: CustomProgressBar(
                                                    value:
                                                        _pagerPosition == index
                                                            ? 1
                                                            : 0,
                                                    backgroundColor:
                                                        Colors.white,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            CoupledTheme()
                                                                .primaryBlue),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 10.0),
                                        child: getProfileActions(
                                          context,
                                          othersProfileBloc,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ];
                        },
                        body: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          TextView(
                                            '${GlobalData.othersProfile.name.toString().toUpperCase()} '
                                            '${GlobalData.othersProfile.lastName.toString()}',
                                            size: 18,
                                            color: isOnline
                                                ? CoupledTheme().greenOnline
                                                : Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                          ),
                                          TextView(
                                            ", ${GlobalWidgets().getAge((GlobalData.othersProfile.info!.dob ?? DateTime.now()))}",
                                            size: 18,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),

                                          /*Visibility(
                                            visible: (GlobalData?.myProfile
                                                        ?.membership?.share ??
                                                    0) ==
                                                1,
                                            child: CommonThings().customToolTip(
                                              GlobalData.othersProfile
                                                  ?.officialDocuments,
                                            ),
                                          )*/

                                          Visibility(
                                            visible: (GlobalData?.othersProfile
                                                            .membership !=
                                                        ''
                                                    ? GlobalData?.othersProfile
                                                        .membership?.share
                                                    : 0) ==
                                                1,
                                            child: CommonThings().customToolTip(
                                              GlobalData.othersProfile
                                                  .officialDocuments,
                                            ),
                                          )

                                          /*CommonThings().customToolTip(
                                            GlobalData.othersProfile
                                                ?.officialDocuments,
                                          ),*/
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          (GlobalData.othersProfile
                                                          .membership !=
                                                      null
                                                  ? GlobalData.othersProfile
                                                      .membership!.paidMember!
                                                  : false)
                                              ? GlobalWidgets().iconCreator(
                                                  "assets/Profile/Badge.png",
                                                  size: FixedIconSize.SMALL)
                                              : Container(),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          TextView(
                                            GlobalData.othersProfile
                                                    .membershipCode ??
                                                '',
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Visibility(
                                            visible: GlobalData.othersProfile
                                                    .mom?.momType !=
                                                "block",
                                            child: Row(
                                              children: [
                                                NotificationBadge(
                                                  radius: 15,
                                                  bgcolor: isOnline
                                                      ? CoupledTheme()
                                                          .greenOnline
                                                      : Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                TextView(
                                                  isOnline
                                                      ? "online"
                                                      : GlobalWidgets().getTime(
                                                          GlobalData
                                                                  .othersProfile
                                                                  .lastActive ??
                                                              DateTime.now()),
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  size: 12,
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: .8,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      HeartPercentage(
                                        GlobalData.othersProfile.score != null
                                            ? GlobalData.othersProfile.score
                                                .toString()
                                            : '',
                                        userId: GlobalData.othersProfile.id
                                            .toString(),
                                        profileImg: GlobalData
                                                .othersProfile.dp?.photoName ??
                                            '',
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ///Buzz About My Perfect Partner
                                    ProfileItems(
                                      img:
                                          "assets/Profile/Buzz-About-My-Perfect-Partner.png",
                                      title: "Buzz About My Perfect Partner",
                                      editIcon: !disableEditButton,
                                      card: GlobalWidgets().card(
                                          strings: [
                                            GlobalData.othersProfile.info!
                                                .aboutPartner
                                          ],
                                          toWhichCard: 0,
                                          onTap: () {
                                            buzzAboutBtmSheet();
                                          }),
                                      onTap: () {
                                        buzzAboutBtmSheet();
                                      },
                                    ),

                                    ///middle actions
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          ///shortlist
                                          Visibility(
                                            visible: getMomStatus(GlobalData
                                                        .othersProfile.mom) ==
                                                    null ||
                                                getMomStatus(GlobalData
                                                        .othersProfile.mom) ==
                                                    actionType.shortlistMe,
                                            child: getActionBtn(
                                                othersProfileBloc:
                                                    othersProfileBloc,
                                                context: context,
                                                type: btnType.SHORTLIST),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),

                                          ///recommend
                                          getActionBtn(
                                              othersProfileBloc:
                                                  othersProfileBloc,
                                              context: context,
                                              type: btnType.RECOMMEND,
                                              enable: (GlobalData
                                                          .myProfile
                                                          .membership
                                                          ?.paidMember ??
                                                      false) &&
                                                  getMomStatus(GlobalData
                                                          .othersProfile.mom) !=
                                                      actionType.blockByMe &&
                                                  getMomStatus(GlobalData
                                                          .othersProfile.mom) !=
                                                      actionType.blockMe &&
                                                  getMomStatus(GlobalData
                                                          .othersProfile.mom) !=
                                                      actionType.reported),
                                          SizedBox(
                                            width: 10,
                                          ),

                                          ///chat
                                          Visibility(
                                            visible: getMomStatus(GlobalData
                                                    .othersProfile.mom) !=
                                                null,
                                            child: getActionBtn(
                                                othersProfileBloc:
                                                    othersProfileBloc,
                                                context: context,
                                                type: btnType.CHAT),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),

                                          ///contact
                                          getActionBtn(
                                              othersProfileBloc:
                                                  othersProfileBloc,
                                              context: context,
                                              type: btnType.CONTACT),
                                        ],
                                      ),
                                    ),

                                    ///My Personal Fact Sheet
                                    ProfileItems(
                                      img:
                                          "assets/Profile/My-Personal-Fact-Sheet.png",
                                      title: "My Personal Fact Sheet",
                                      editIcon: !disableEditButton,
                                      card: Wrap(
                                        direction: Axis.horizontal,
                                        children: <Widget>[
                                          ProfileItemCard(
                                              title: GlobalData.othersProfile
                                                          .info?.dob !=
                                                      null
                                                  ? "${GlobalWidgets().getAge(GlobalData.othersProfile.info!.dob)} yrs"
                                                  : "${000} yrs",
                                              img: "assets/Profile/Age.png"),
                                          ProfileItemCard(
                                              title: GlobalData.othersProfile
                                                          .info!.height !=
                                                      null
                                                  ? "${CommonThings().convertFeet(
                                                      0,
                                                    )} ft \n ${GlobalData.othersProfile.info!.height.toString()} cm"
                                                  : "${CommonThings().convertFeet(
                                                      0,
                                                    )} ft \n ${00} cm",
                                              img: "assets/Profile/height.png"),
                                          ProfileItemCard(
                                              title: GlobalData.othersProfile
                                                      .info!.weight
                                                      .toString() +
                                                  (" kg"),
                                              img: "assets/Profile/Kg.png"),
                                          ProfileItemCard(
                                              title: toBeginningOfSentenceCase(
                                                      GlobalData
                                                                  .othersProfile
                                                                  .info!
                                                                  .complexion !=
                                                              null
                                                          ? GlobalData
                                                              .othersProfile
                                                              .info!
                                                              .complexion
                                                              ?.value
                                                          : '')
                                                  .toString(),
                                              img:
                                                  "assets/Profile/Wheatish.png",
                                              color: GlobalWidgets()
                                                  .complexionColor(GlobalData
                                                              .othersProfile
                                                              .info!
                                                              .complexion !=
                                                          null
                                                      ? GlobalData
                                                          .othersProfile
                                                          .info!
                                                          .complexion
                                                          ?.value
                                                      : '')),
                                          ProfileItemCard(
                                            title: toBeginningOfSentenceCase(
                                                    GlobalData
                                                                .othersProfile
                                                                .info!
                                                                .bodyType !=
                                                            null
                                                        ? GlobalData
                                                            .othersProfile
                                                            .info!
                                                            .bodyType
                                                            ?.value
                                                        : '')
                                                .toString(),
                                            img: GlobalWidgets().getBodyTypeImg(
                                                GlobalData.othersProfile.info!
                                                            .bodyType !=
                                                        null
                                                    ? GlobalData.othersProfile
                                                        .info!.bodyType?.value
                                                    : ''),
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      onTap: () {},
                                    ),

                                    ///my location
                                    ProfileItems(
                                      img: "assets/Profile/My-Location.png",
                                      title: "My Location",
                                      editIcon: !disableEditButton,
                                      card: GlobalWidgets().card(strings: [
                                        "${toBeginningOfSentenceCase(GlobalData.othersProfile.info?.city)}\n"
                                            "${toBeginningOfSentenceCase(GlobalData.othersProfile.info?.state)}, "
                                            "${toBeginningOfSentenceCase(GlobalData.othersProfile.info?.country)}",
                                      ], onTap: () {}),
                                      onTap: () {},
                                    ),

                                    ///profession
                                    ProfileItems(
                                      img:
                                          "assets/Profile/My-Job-&-Education.png",
                                      title:
                                          "My job & Education ${GlobalData.othersProfile.educationJob?.jobStatus == 1 ? "(Present Job)" : ""}",
                                      editIcon: !disableEditButton,
                                      card: GlobalWidgets().card(strings: [
                                        GlobalData.othersProfile.educationJob
                                                ?.companyName ??
                                            '',
                                        GlobalData.othersProfile.educationJob
                                                    ?.profession !=
                                                null
                                            ? GlobalData.othersProfile
                                                .educationJob?.profession?.value
                                            : '',
                                        GlobalData.othersProfile.educationJob
                                                    ?.industry !=
                                                null
                                            ? GlobalData.othersProfile
                                                .educationJob?.industry?.value
                                            : '',
                                        GlobalData.othersProfile.educationJob
                                                    ?.experience !=
                                                null
                                            ? GlobalData.othersProfile
                                                .educationJob?.experience?.value
                                                .toString()
                                            : '',
                                        GlobalData.othersProfile.educationJob
                                                    ?.incomeRange !=
                                                null
                                            ? GlobalData
                                                .othersProfile
                                                .educationJob
                                                ?.incomeRange
                                                ?.value
                                            : '',
                                      ], onTap: () {}),
                                      onTap: () {},
                                    ),

                                    ///education
                                    ProfileItems(
                                      editIcon: !disableEditButton,
                                      card: GlobalWidgets().card(strings: [
                                        GlobalData.othersProfile.educationJob
                                                    ?.highestEducation !=
                                                null
                                            ? GlobalData
                                                .othersProfile
                                                .educationJob
                                                ?.highestEducation
                                                ?.value
                                            : '',
                                        GlobalData.othersProfile.educationJob
                                                    ?.educationBranch !=
                                                null
                                            ? GlobalData
                                                .othersProfile
                                                .educationJob
                                                ?.educationBranch
                                                ?.value
                                            : '',
                                      ], onTap: () {}),
                                      onTap: () {},
                                    ),

                                    ///Coupling Score Predictions
                                    Visibility(
                                      visible: GlobalData
                                              .othersProfile.freeCoupling !=
                                          null,
                                      child: ProfileItems(
                                        img:
                                            "assets/Profile/Coupling-Score.png",
                                        title: "Coupling Score Predictions",
                                        editIcon: !disableEditButton,
                                        card: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: CustomButton(
                                                onPressed: () {
                                                  /*Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CoupingScorePredictions(
                                                        userId: GlobalData
                                                            .othersProfile?.id
                                                            .toString(),
                                                        profileImg: GlobalData
                                                                .othersProfile
                                                                ?.dp
                                                                ?.photoName ??
                                                            '',
                                                      ),
                                                    ),
                                                  );*/

                                                  if (GlobalData
                                                          .myProfile
                                                          .membership
                                                          ?.paidMember ==
                                                      true) {
                                                    print("hello====");

                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            CoupingScorePredictions(
                                                          userId: GlobalData
                                                              .othersProfile.id
                                                              .toString(),
                                                          profileImg: GlobalData
                                                                  .othersProfile
                                                                  .dp!
                                                                  .photoName ??
                                                              '',
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    becomeamemberPlan(context);
                                                  }
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      CoupledTheme()
                                                          .primaryPinkDark,
                                                      CoupledTheme().primaryPink
                                                    ]),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  child: TextView(
                                                    "View More",
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    size: 12,
                                                    textAlign: TextAlign.center,
                                                    textScaleFactor: .8,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Container(
                                                height: 210,
                                                width: 450,
                                                child: couplingScore(GlobalData
                                                    .othersProfile
                                                    .freeCoupling)),
                                          ],
                                        ),
                                        onTap: () {},
                                      ),
                                    ),

                                    ///cast & religion
                                    ProfileItems(
                                      img:
                                          "assets/Profile/My-Religion-&-Cast.png",
                                      title: "My Religion & Caste",
                                      editIcon: !disableEditButton,
                                      card: GlobalWidgets().card(strings: [
                                        GlobalData.othersProfile.family
                                                    ?.religion !=
                                                null
                                            ? GlobalData.othersProfile.family
                                                ?.religion?.value
                                            : '',
                                        GlobalData.othersProfile.family?.cast !=
                                                null
                                            ? GlobalData.othersProfile.family
                                                ?.cast?.value
                                            : '',
                                        GlobalData.othersProfile.family
                                                    ?.subcast !=
                                                null
                                            ? GlobalData.othersProfile.family
                                                ?.subcast?.value
                                            : '',
                                        GlobalData.othersProfile.family
                                                    ?.gothram !=
                                                null
                                            ? GlobalData.othersProfile.family
                                                ?.gothram?.value
                                            : ''
                                      ], onTap: () {}),
                                      onTap: () {},
                                    ),

                                    ///marital
                                    ProfileItems(
                                      img:
                                          "assets/Profile/My-Marital-Status.png",
                                      title: "My Marital Status",
                                      editIcon: !disableEditButton,
                                      card: GlobalWidgets().card(strings: [
                                        GlobalData.othersProfile.info
                                                    ?.maritalStatus !=
                                                null
                                            ? GlobalData.othersProfile.info
                                                ?.maritalStatus?.value
                                            : '',
                                        GlobalData.othersProfile.info
                                                    ?.numberOfChildren ==
                                                0
                                            ? ""
                                            : "${GlobalData.othersProfile.info?.numberOfChildren} ${GlobalData.othersProfile.info?.numberOfChildren == 1 ? "Child" : "Children"}",
                                        GlobalData.othersProfile.info
                                                    ?.childLivingStatus !=
                                                null
                                            ? GlobalData.othersProfile.info
                                                ?.childLivingStatus?.value
                                            : ''
                                      ], onTap: () {}),
                                      onTap: () {},
                                    ),

                                    ///meetMyFamily
                                    ProfileItems(
                                      img: "assets/Profile/Meet-My-Family.png",
                                      title: "My Family",
                                      editIcon: !disableEditButton,
                                      card: Wrap(
                                        children: <Widget>[
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            color: CoupledTheme().tabColor1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 8),
                                              child: Column(
                                                children: <Widget>[
                                                  TextView(
                                                    "Father",
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    size: 12,
                                                    textAlign: TextAlign.center,
                                                    textScaleFactor: .8,
                                                  ),
                                                  TextView(
                                                    GlobalData
                                                                .othersProfile
                                                                .family!
                                                                .fatherOccupationStatus !=
                                                            null
                                                        ? GlobalData
                                                            .othersProfile
                                                            .family!
                                                            .fatherOccupationStatus!
                                                            .value
                                                        : '',
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    size: 12,
                                                    textAlign: TextAlign.center,
                                                    textScaleFactor: .8,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            color: CoupledTheme().tabColor1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 10),
                                              child: Column(
                                                children: <Widget>[
                                                  TextView(
                                                    "Mother",
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    size: 12,
                                                    textAlign: TextAlign.center,
                                                    textScaleFactor: .8,
                                                  ),
                                                  TextView(
                                                    GlobalData
                                                                .othersProfile
                                                                .family!
                                                                .motherOccupationStatus !=
                                                            null
                                                        ? GlobalData
                                                            .othersProfile
                                                            .family!
                                                            .motherOccupationStatus!
                                                            .value
                                                        : '',
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    size: 12,
                                                    textAlign: TextAlign.center,
                                                    textScaleFactor: .8,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Wrap(
                                            children: <Widget>[
                                              brother.length == 0
                                                  ? Container()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        GlobalWidgets()
                                                            .familyMembersBottomSheet(
                                                                context,
                                                                brother,
                                                                sister);
                                                      },
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        color: CoupledTheme()
                                                            .tabColor1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 12,
                                                                  horizontal:
                                                                      8),
                                                          child: Column(
                                                            children: <Widget>[
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <
                                                                    Widget>[
                                                                  TextView(
                                                                    "Brothers",
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    textScaleFactor:
                                                                        .8,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .visible,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Container(
                                                                    height: 18,
                                                                    width: 18,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      color: CoupledTheme()
                                                                          .primaryBlue,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down,
                                                                        size:
                                                                            15,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              TextView(
                                                                brother.length
                                                                    .toString(),
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                textScaleFactor:
                                                                    .8,
                                                                color: Colors
                                                                    .white,
                                                                size: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              sister.length == 0
                                                  ? Container()
                                                  : GestureDetector(
                                                      onTap: () {
                                                        GlobalWidgets()
                                                            .familyMembersBottomSheet(
                                                                context,
                                                                brother,
                                                                sister);
                                                      },
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        color: CoupledTheme()
                                                            .tabColor1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 12,
                                                                  horizontal:
                                                                      10),
                                                          child: Column(
                                                            children: <Widget>[
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <
                                                                    Widget>[
                                                                  TextView(
                                                                    "Sisters",
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    textScaleFactor:
                                                                        .8,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .visible,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Container(
                                                                    height: 18,
                                                                    width: 18,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      color: CoupledTheme()
                                                                          .primaryBlue,
                                                                    ),
                                                                    child: Center(
                                                                        child: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down,
                                                                      size: 15,
                                                                      color: Colors
                                                                          .white,
                                                                    )),
                                                                  ),
                                                                ],
                                                              ),
                                                              TextView(
                                                                sister.length
                                                                    .toString(),
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                textScaleFactor:
                                                                    .8,
                                                                color: Colors
                                                                    .white,
                                                                size: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          GlobalWidgets().card(strings: [
                                            GlobalData.othersProfile.family!
                                                        .familyType !=
                                                    null
                                                ? GlobalData.othersProfile
                                                    .family!.familyType!.value
                                                : '',
                                            GlobalData.othersProfile.family!
                                                        .familyValues !=
                                                    null
                                                ? GlobalData.othersProfile
                                                    .family!.familyValues!.value
                                                : '',
                                            GlobalData.othersProfile.family!
                                                        .country !=
                                                    null
                                                ? GlobalData.othersProfile
                                                            .family!.country !=
                                                        ''
                                                    ? ("${GlobalData.othersProfile.family!.city.toString()} , ${GlobalData.othersProfile.family!.state.toString()} ,${GlobalData.othersProfile.family!.country.toString()}")
                                                    : ''
                                                : '',
                                          ], onTap: () {}),
                                        ],
                                      ),
                                      onTap: () {},
                                    ),

                                    ///Gossip About Myself
                                    ProfileItems(
                                      img:
                                          "assets/Profile/Gossip-About-Myself.png",
                                      title: "Gossip About Myself",
                                      editIcon: !disableEditButton,
                                      card: GlobalWidgets().card(strings: [
                                        GlobalData.othersProfile.info!
                                                    .aboutSelf !=
                                                null
                                            ? GlobalData
                                                .othersProfile.info!.aboutSelf
                                            : ''
                                      ], onTap: () {}),
                                      onTap: () {},
                                    ),

                                    ///My Kundali
                                    ProfileItems(
                                      img: "assets/Profile/My-Kundali.png",
                                      title: "My Kundali",
                                      editIcon: !disableEditButton,
                                      card: GlobalWidgets().card(
                                        strings: [
                                          GlobalData.othersProfile.info!
                                                  .bornPlace ??
                                              '',
                                          GlobalData.othersProfile.info!.dob !=
                                                  null
                                              ? formatDate(
                                                  (GlobalData
                                                      .othersProfile.info!.dob) as DateTime,
                                                  [dd, '.', mm, '.', yyyy]) 
                                              : '',
                                          GlobalData.othersProfile.info!
                                                  .bornTime ??
                                              ''
                                        ],
                                        onTap: () {},
                                      ),
                                      onTap: () {},
                                    ),

                                    ///Specially Abled
                                    Visibility(
                                      child: ProfileItems(
                                        img:
                                            "assets/Profile/Specially-Abled.png",
                                        title: "Specially Abled",
                                        editIcon: !disableEditButton,
                                        card: Row(
                                          children: [
                                            GlobalWidgets().card(strings: [
                                              GlobalData.othersProfile.info!
                                                          .specialCase ==
                                                      0
                                                  ? "No"
                                                  : "Yes",
                                              GlobalData.othersProfile.info!
                                                          .specialCaseNotify ==
                                                      0
                                                  ? '${GlobalData.othersProfile.info!.specialCaseType != null ? GlobalData.othersProfile.info!.specialCaseType?.value : ''}'
                                                  : '',
                                            ], toWhichCard: 1, onTap: () {}),
                                            Visibility(
                                              visible: GlobalData.othersProfile
                                                          .info!.specialCase ==
                                                      1 &&
                                                  getMomStatus(GlobalData
                                                          .othersProfile.mom) !=
                                                      actionType.blockByMe &&
                                                  getMomStatus(GlobalData
                                                          .othersProfile.mom) !=
                                                      actionType.reported &&
                                                  getMomStatus(GlobalData
                                                          .othersProfile.mom) !=
                                                      actionType.blockMe,
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (GlobalData
                                                          .othersProfile
                                                          .info!
                                                          .specialCaseNotify ==
                                                      1) {
                                                    SettingsAndCmsProvider()
                                                        .doAction(
                                                      {
                                                        "mom_type": "specially",
                                                        "partner_id": GlobalData
                                                            .othersProfile.id
                                                      },
                                                      "MoMSpeciallyRequest",
                                                    ).then((onValue) {
                                                      othersProfileBloc.add(
                                                          LoadOthersProfile(
                                                              (widget.membershipCode)
                                                                  .toString()));
                                                      GlobalWidgets().showToast(
                                                          msg: "Request sent");
                                                    }, onError: (err) {
                                                      print("Error: $err");
                                                      GlobalWidgets().showToast(
                                                          msg:
                                                              "Something went wrong");
                                                    });
                                                  }
                                                },
                                                child: TextView(
                                                  '${(GlobalData.othersProfile.info!.specialCase == 1 && GlobalData.othersProfile?.info?.specialCaseNotify == 1) ? "Request to Know" : GlobalData.othersProfile?.info?.specialCaseNotify == 2 ? "Requested" : GlobalData.othersProfile?.info?.specialCaseNotify == 3 ? "Rejected" : ''}',
                                                  //                                            '${CoupledGlobal.othersProfile.info.specialCaseNotify == 1 ? "Request to Know" : CoupledGlobal.othersProfile.info.specialCaseNotify == 2 ? "Requested" : CoupledGlobal.othersProfile.info.specialCaseNotify == 3 ? "Rejected" : ''}',
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: CoupledTheme()
                                                      .primaryBlue,
                                                  size: 16,
                                                  fontWeight: FontWeight.normal,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: .8,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),

                                    ///bottom bar
                                    Stack(
                                      children: [
                                        Container(
                                          height: 84,
                                          child: ListView(
                                            shrinkWrap: true,
                                            reverse: true,
                                            scrollDirection: Axis.horizontal,
                                            addRepaintBoundaries: true,
                                            children: <Widget>[
                                              ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                //                                              itemExtent: 65,
                                                reverse: true,
                                                children: <Widget>[
                                                  ///Reminder
                                                  Visibility(
                                                      visible: getMomStatus(
                                                              GlobalData
                                                                  .othersProfile
                                                                  .mom) ==
                                                          actionType
                                                              .requestSent,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: getActionBtn(
                                                            othersProfileBloc:
                                                                othersProfileBloc,
                                                            context: context,
                                                            type: btnType
                                                                .REMINDER,
                                                            roundBackGround:
                                                                true),
                                                      )),

                                                  ///cancel
                                                  Visibility(
                                                      visible: getMomStatus(
                                                              GlobalData
                                                                  .othersProfile
                                                                  .mom) ==
                                                          actionType
                                                              .requestSent,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: getActionBtn(
                                                            othersProfileBloc:
                                                                othersProfileBloc,
                                                            context: context,
                                                            type:
                                                                btnType.CANCEL,
                                                            roundBackGround:
                                                                true),
                                                      )),

                                                  ///connect
                                                  Visibility(
                                                      visible: getMomStatus(
                                                                  GlobalData
                                                                      .othersProfile
                                                                      .mom) ==
                                                              null ||
                                                          getMomStatus(GlobalData
                                                                  .othersProfile
                                                                  .mom) ==
                                                              actionType
                                                                  .shortlistByMe ||
                                                          getMomStatus(GlobalData
                                                                  .othersProfile
                                                                  .mom) ==
                                                              actionType
                                                                  .shortlistMe,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: getActionBtn(
                                                            othersProfileBloc:
                                                                othersProfileBloc,
                                                            context: context,
                                                            type: btnType
                                                                .CONNECT_WITH_MESSAGE),
                                                      )),

                                                  ///unblock
                                                  Visibility(
                                                    visible: getMomStatus(
                                                                GlobalData
                                                                    .othersProfile
                                                                    .mom) ==
                                                            actionType
                                                                .blockByMe ||
                                                        getMomStatus(GlobalData
                                                                .othersProfile
                                                                .mom) ==
                                                            actionType.blockMe,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: getActionBtn(
                                                          othersProfileBloc:
                                                              othersProfileBloc,
                                                          context: context,
                                                          type: btnType.UNBLOCK,
                                                          enable: getMomStatus(
                                                                      GlobalData
                                                                          .othersProfile
                                                                          .mom) ==
                                                                  actionType
                                                                      .blockByMe ||
                                                              getMomStatus(GlobalData
                                                                      .othersProfile
                                                                      .mom) ==
                                                                  actionType
                                                                      .blockMe,
                                                          roundBackGround:
                                                              true),
                                                    ),
                                                  ),

                                                  ///re accept
                                                  Visibility(
                                                      visible: getMomStatus(
                                                              GlobalData
                                                                  .othersProfile
                                                                  .mom) ==
                                                          actionType
                                                              .rejectedByMe,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: getActionBtn(
                                                            othersProfileBloc:
                                                                othersProfileBloc,
                                                            context: context,
                                                            type: btnType
                                                                .RE_ACCEPT),
                                                      )),

                                                  ///chat
                                                  Visibility(
                                                    visible: getMomStatus(
                                                            GlobalData
                                                                .othersProfile
                                                                .mom) !=
                                                        null,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: getActionBtn(
                                                        othersProfileBloc:
                                                            othersProfileBloc,
                                                        context: context,
                                                        type: btnType.CHAT,
                                                      ),
                                                    ),
                                                  ),

                                                  ///contact
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: getActionBtn(
                                                        othersProfileBloc:
                                                            othersProfileBloc,
                                                        context: context,
                                                        type: btnType.CONTACT),
                                                  ),

                                                  ///share
                                                  Visibility(
                                                    visible: (GlobalData
                                                                ?.myProfile
                                                                .membership
                                                                ?.share ??
                                                            0) ==
                                                        1,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: getActionBtn(
                                                        othersProfileBloc:
                                                            othersProfileBloc,
                                                        context: context,
                                                        type: btnType.SHARE,
                                                      ),
                                                    ),
                                                  ),

                                                  ///shortlist
                                                  Visibility(
                                                    visible: getMomStatus(
                                                                GlobalData
                                                                    .othersProfile
                                                                    .mom) ==
                                                            null ||
                                                        getMomStatus(GlobalData
                                                                .othersProfile
                                                                .mom) ==
                                                            actionType
                                                                .shortlistMe,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: getActionBtn(
                                                        othersProfileBloc:
                                                            othersProfileBloc,
                                                        context: context,
                                                        type: btnType.SHORTLIST,
                                                      ),
                                                    ),
                                                  ),

                                                  ///recommend
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: getActionBtn(
                                                      othersProfileBloc:
                                                          othersProfileBloc,
                                                      context: context,
                                                      type: btnType.RECOMMEND,
                                                      /*enable: (CoupledGlobal
                                                                  ?.user
                                                                  ?.membership
                                                                  ?.paidMember ??
                                                              false) &&
                                                          getMomStatus( CoupledGlobal.othersProfile.mom)() !=
                                                              actionType
                                                                  .blockByMe &&
                                                          getMomStatus( CoupledGlobal.othersProfile.mom)() !=
                                                              actionType
                                                                  .blockMe &&
                                                          getMomStatus( CoupledGlobal.othersProfile.mom)() !=
                                                              actionType
                                                                  .reported,*/
                                                    ),
                                                  )
                                                ],
                                              ),
                                              ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                reverse: true,

                                                // physics: NeverScrollableScrollPhysics(),
                                                // itemExtent: 65,
                                                children: <Widget>[
                                                  ///block
                                                  Visibility(
                                                    visible: getMomStatus(
                                                                GlobalData
                                                                    .othersProfile
                                                                    .mom) !=
                                                            actionType
                                                                .blockByMe &&
                                                        getMomStatus(GlobalData
                                                                .othersProfile
                                                                .mom) !=
                                                            actionType.blockMe,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25),
                                                      child: getActionBtn(
                                                          othersProfileBloc:
                                                              othersProfileBloc,
                                                          context: context,
                                                          type: btnType.BLOCK),
                                                    ),
                                                  ),

                                                  ///report
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25),
                                                    child: getActionBtn(
                                                        othersProfileBloc:
                                                            othersProfileBloc,
                                                        context: context,
                                                        type: btnType.REPORT,
                                                        enable: getMomStatus(
                                                                    GlobalData
                                                                        .othersProfile
                                                                        .mom) !=
                                                                actionType
                                                                    .request &&
                                                            getMomStatus(GlobalData
                                                                    .othersProfile
                                                                    .mom) !=
                                                                actionType
                                                                    .blockByMe &&
                                                            getMomStatus(GlobalData
                                                                    .othersProfile
                                                                    .mom) !=
                                                                actionType
                                                                    .blockMe &&
                                                            getMomStatus(GlobalData
                                                                    .othersProfile
                                                                    .mom) !=
                                                                actionType
                                                                    .reported),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            top: 15,
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.white,
                                              size: 15,
                                            ))
                                      ],
                                    ),

                                    ///similar profile

                                    similarProfilesResponse == null
                                        ? Container(
                                            height: 80,
                                            child: GlobalWidgets()
                                                .showCircleProgress(),
                                          )
                                        : similarProfilesResponse.status ==
                                                'error'
                                            ? Container(
                                                child: Center(
                                                  child: TextView(
                                                    'No similar profiles found',
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    size: 12,
                                                    textAlign: TextAlign.center,
                                                    textScaleFactor: .8,
                                                  ),
                                                ),
                                              )
                                            : similarProfiles(
                                                similarProfilesResponse),

                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              .15,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  (state is InitialOthersProfileState)
                      ? GlobalWidgets().showCircleProgress()
                      : Container(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  floatingBtn() {
    return FadeTransition(
      opacity: _fadeOut,
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          nestedScrollController.animateTo(0,
              duration: Duration(milliseconds: 350), curve: Curves.decelerate);
        },
        mini: true,
        backgroundColor: CoupledTheme().primaryBlue,
        child: Center(
          child: Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void buzzAboutBtmSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAlias,
        elevation: 4.0,
        context: context,
        builder: (builder) {
          return SafeArea(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextView(
                      "Buzz About My Perfect Partner",
                      color: Colors.grey,
                      size: 24.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextView(
                      (GlobalData.othersProfile.info?.aboutPartner).toString(),
                      color: Colors.black,
                      size: 18.0,
                      lineSpacing: 1.5,
                      textAlign: TextAlign.justify,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textScaleFactor: .8,
                      maxLines: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  initiateData() {
    print("showBottomBar :: $showBottomBar");
    profileImages = [];
    GlobalData.othersProfile.photos.forEach(
      (photo) {
        if (photo?.dpStatus == 1) {
          profileImages.insert(0, photoWidget(photo!));
        } else {
          profileImages.add(
            photoWidget(photo!),
          );
        }
      },
    );

    //isMyAcion = GlobalData.othersProfile.mom.userId != GlobalData.myProfile.id;
    if (GlobalData.othersProfile.siblings != null &&
        brother.length == 0 &&
        sister.length == 0)
      GlobalData.othersProfile.siblings.forEach((item) {
        if (item.role != null) {
          if (item.role!.value.toLowerCase().contains("bro")) {
            brother.add(item);
          } else {
            sister.add(item);
          }
        }
      });
  }

  becomeamemberPlan(BuildContext context) {
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
                        "Hello,Activate Coupling Score to get detailed match predictions and insight between you and your prospective partners",
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
                            "Activate Coupling Score",
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                        onPressed: () {
                          //Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed('/myPlanPayments');
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
      actions: [],
    );
  }

  void _dialogTemplate(
      {title,
      required Color color,
      required BuildContext context,
      required Container content,
      bool barrierDismissible = true,
      required List<Widget> actions}) {
    showDialog(
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
        });
  }
}
