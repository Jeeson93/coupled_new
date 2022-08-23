import 'package:coupled/CMS/Settings.dart';
import 'package:coupled/Chat/ChatBloc/chat_bloc.dart';
import 'package:coupled/Chat/Model/ChatModel.dart';
import 'package:coupled/Chat/Model/message_model.dart';
import 'package:coupled/Chat/chat_events.dart';
import 'package:coupled/Chat/chat_view_2.dart';
import 'package:coupled/Home/Profile/profile_switch.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/Modals/SMC/smc_bloc.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/match_o_meter_model.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatViewMain extends StatefulWidget {
  ChatResponse? chatResponse = ChatResponse(
      mom: MomM(),
      partner: PartnerDetails(
          dp: Dp(
              photoName: '',
              imageType: BaseSettings(options: []),
              imageTaken: BaseSettings(options: []),
              userDetail:
                  UserDetail(membership: Membership(paidMember: false))),
          info: Info(maritalStatus: BaseSettings(options: [])),
          photos: []));
  String photoName = '';
  String name = '';
  String memberShipCode = '';
  List<Datum> listDatum = [];
  ScrollController _scrollController = ScrollController();
  ChatViewMain(
      {Key? key,
      this.photoName = '',
      this.name = '',
      this.memberShipCode = '',
      this.chatResponse})
      : super(key: key);

  @override
  State<ChatViewMain> createState() => _ChatViewMainState();
}

class _ChatViewMainState extends State<ChatViewMain> {
  //Variables........
  bool isPaidMember = false;
  ChatModel chatModel = ChatModel();
  TextEditingController _msgController = TextEditingController();
  bool _eventBtnClicked = false;
  FocusNode _msgFocusnode = FocusNode();
  bool hideBackButton = true;
  bool emoticonVisible = false;
  SmcBloc _smcBloc = SmcBloc();
  List dateAndTimeParts = [];
  bool isSelected = false, isWished = false;
  dynamic initialdata;
  dynamic membershipcode;
  ChatBloc chatbloc = ChatBloc();
  //Widgets.............
  Widget eventBtnChanger() {
    return !_eventBtnClicked
        ? BtnWithText(
            img: "assets/Chat/Events.png",
            textSize: 10.0,
            text: "Events",
            fixedIconSize: FixedIconSize.SMALL,
            onTap: () {},
          )
        : BtnWithText(
            img: "assets/Profile/Chat.png",
            textSize: 10.0,
            text: "Chat",
            fixedIconSize: FixedIconSize.SMALL,
            onTap: () {},
          );
  }

  //Finctions...............
  // void _onFocusChange() {
  //   _eventBtnClicked = true;

  //   print("Focus: " + _msgFocusnode.hasFocus.toString());
  // }

  void sendChat(String mode) {
    setState(() {
      GlobalData.messages.add({'msg': _msgController.text.toString()});
      GlobalData.chatBloc.add(SendChat(
          widget.chatResponse?.partner?.membershipCode ??
              GlobalData.othersProfile.membershipCode,
          _msgController.text,
          mode));

      GlobalData.chatBloc.add(GetChat(
          widget.chatResponse?.partner?.membershipCode ??
              GlobalData.othersProfile.membershipCode));
      _msgController.clear();
      _smcBloc = SmcBloc();
      _smcBloc.add(SMCParams());
    });
  }

  @override
  void initState() {
    setState(() {
      // const fiveSeconds = const Duration(seconds: 5);
      //Timer.periodic(fiveSeconds, (Timer t) => _fetchData());

      _smcBloc = SmcBloc();
      _smcBloc.add(SMCParams());
      print("jkkk");
      membershipcode = widget.chatResponse?.partner?.membershipCode;
      print(GlobalData?.othersProfile.membershipCode);
    });

    super.initState();
    isPaidMember = (GlobalData.myProfile.membership?.paidMember ?? false);
    // GlobalData.chatBloc.add(GetChat(
    //     widget.chatResponse?.partner?.membershipCode != null
    //         ? widget.chatResponse?.partner?.membershipCode
    //         : GlobalData?.othersProfile.membershipCode));
    print(
        'init----------------------------${GlobalData.messageModel.response?.mom?.momStatus}');
    print('........................$membershipcode');
    print(GlobalData.messageModel.response?.mom?.momStatus);
    print(GlobalData.messageModel.response?.mom?.momType);
    print(GlobalData.messageModel.response?.userStatus);
    print(GlobalData.messageModel.response?.loveRecieve);
    print(GlobalData.messageModel.response?.requestTolStatus);

    _msgFocusnode = FocusNode();
    //_msgFocusnode.addListener(_onFocusChange);
  }

  // @override
  // void setState(fn) {
  //   super.setState(fn);
  // }

  @override
  void didChangeDependencies() {
    GlobalData.chatBloc.add(GetChat(
        widget.chatResponse?.partner?.membershipCode != null
            ? widget.chatResponse?.partner?.membershipCode
            : GlobalData?.othersProfile.membershipCode));

    super.didChangeDependencies();
  }

  List chatShortInfoModelList = [];
  @override
  void dispose() {
    _msgFocusnode.dispose();

    super.dispose();
  }

  String getTime(dynamic createdAt, bool isEvent) {
    if (isEvent) {
      return formatDate(createdAt, [MM, ' ', dd, 'th - ', yyyy]).toString() +
          ', ' +
          DateFormat.jm().format(createdAt).toString();
    } else if (createdAt is DateTime) {
      int difference = ((DateTime.now().difference(createdAt).inDays)).round();
      if (difference < 1) {
        return DateFormat.jm().format(createdAt).toString();
      } else if (difference >= 1) {
        return DateFormat.jm().format(createdAt).toString() +
            '\n' +
            '\n' +
            formatDate(createdAt, [dd, '.', mm, '.', yy]).toString();
      } else {
        return DateFormat.jm()
                .format(createdAt.add(Duration(hours: 5, minutes: 30)))
                .toString() +
            '\n' +
            formatDate(createdAt, [dd, '.', mm, '.', yy]).toString();
      }
    }
    return "Unknown time";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: GlobalData.chatBloc,
        builder: (context, state) {
          if (state is ChatMessageLoaded) {
            // GlobalData.messageModel = state.messageModel!;

            // setState(() {

            // });
            print(
                'lovereceive......${state.messageModel?.response?.loveRecieve}');
            return Scaffold(
              backgroundColor: CoupledTheme().backgroundColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                iconTheme: IconThemeData(
                  color: CoupledTheme().primaryBlue,
                ),
                backgroundColor: CoupledTheme().backgroundColor,
                actions: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 15.0,
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Opacity(
                                opacity: (GlobalData.messageModel.response
                                            ?.loveRecieve >
                                        index)
                                    ? 1.0
                                    : 0.5,
                                child: GlobalWidgets().iconCreator(
                                  "assets/heart.png",
                                  color: CoupledTheme().primaryBlue,
                                  size: FixedIconSize.EXTRASMALL,
                                ),
                              ),
                            );
                          },
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Opacity(
                                opacity: (GlobalData
                                            .messageModel.response?.loveGiven >
                                        index)
                                    ? 1.0
                                    : 0.5,
                                child: GlobalWidgets().iconCreator(
                                  "assets/heart.png",
                                  color: CoupledTheme().primaryPink,
                                  size: FixedIconSize.EXTRASMALL,
                                ),
                              ),
                            );
                          },
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),

                  Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 5),
                    child: BtnWithText(
                      img: GlobalData.messageModel.response?.loveRecieve < 3 ||
                              GlobalData.messageModel.response
                                      ?.requestTolStatus ==
                                  3
                          ? "assets/MatchMeter/Token-Of-Love.png"
                          : "assets/tol_new.png",
                      text: "TOL",
                      textSize: 8.0,
                      enabled:
                          (GlobalData.messageModel.response?.mom?.momStatus ==
                                  'accept' &&
                              GlobalData.messageModel.response?.mom?.momType ==
                                  'connect' &&
                              GlobalData.messageModel.response?.userStatus ==
                                  'active'),
                      customSize: 20.0,
                      fixedIconSize: FixedIconSize.MEDIUM,
                      onTap: () {
                        if (GlobalData.messageModel.response?.mom?.momStatus ==
                                'accept' &&
                            GlobalData.messageModel.response?.mom?.momType ==
                                'connect') {
                          print('1');
                          if (GlobalData.messageModel.response?.loveRecieve <
                              3) {
                            Dialogs().showDialogYesNo(
                                context: context,
                                title: CoupledStrings.tokenOfLoveTitle,
                                content: CoupledStrings.impressYourPartnerTol,
                                memcode: widget.chatResponse?.partner
                                        ?.membershipCode ??
                                    GlobalData?.othersProfile.membershipCode,
                                leftBbuttonText: "Okay",
                                rightBbuttonText: "Okay",
                                partnerName:
                                    widget.chatResponse?.partner?.name ??
                                        GlobalData?.othersProfile.name,
                                leftButtonVisibility: false,
                                rightButtonVisibility: true);
                          } else if (GlobalData
                                      .messageModel.response?.loveRecieve >=
                                  3 &&
                              GlobalData.messageModel.response
                                      ?.requestTolStatus ==
                                  1) {
                            Dialogs().showDialogYesNo(
                                context: context,
                                title: CoupledStrings.tokenOfLoveTitle,
                                content:
                                    "Yay!  You have earned three hearts from ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}.Send a Token of Love to ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} to take your proposal to next level ",
                                memcode: widget.chatResponse?.partner
                                        ?.membershipCode ??
                                    GlobalData?.othersProfile.membershipCode,
                                leftBbuttonText: "Not now",
                                rightBbuttonText: "Ok",
                                partnerName:
                                    widget.chatResponse?.partner?.name ??
                                        GlobalData?.othersProfile.name,
                                leftButtonVisibility: true,
                                rightButtonVisibility: true);
                          } else if (GlobalData
                                      .messageModel.response?.loveRecieve <
                                  3 &&
                              GlobalData.messageModel.response
                                      ?.requestTolStatus ==
                                  2) {
                            print("jopp");

                            print(GlobalData
                                    .messageModel.response?.requestTolStatus ==
                                2);
                            Dialogs().showDialogYesNo(
                                context: context,
                                title: "Token of Love",
                                content:
                                    "${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} may take some time to respond, in the meanwhile you can keep interacting with ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} ${widget.chatResponse?.partner?.lastName ?? ""} . Wishing best of love!",
                                memcode: widget.chatResponse?.partner
                                        ?.membershipCode ??
                                    GlobalData?.othersProfile.membershipCode,
                                leftBbuttonText: "Ok!",
                                rightBbuttonText: "Yes",
                                partnerName:
                                    widget.chatResponse?.partner?.name ??
                                        GlobalData?.othersProfile.name,
                                leftButtonVisibility: true,
                                rightButtonVisibility: false);
                          } else if (GlobalData
                                      .messageModel.response?.loveRecieve <
                                  3 &&
                              GlobalData.messageModel.response
                                      ?.requestTolStatus ==
                                  3) {
                            Dialogs().showDialogYesNo(
                                context: context,
                                title: "Token of Love",
                                content:
                                    'Hey Guess ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} is not ready for TOL this time. Impress your partner with your conversation, earn three hearts again and unlock the magic of token of love. Double tap on the message to give heart',
                                memcode: widget.chatResponse?.partner
                                        ?.membershipCode ??
                                    GlobalData?.othersProfile.membershipCode,
                                leftBbuttonText: 'Ok!',
                                rightBbuttonText: "Yes",
                                partnerName:
                                    widget.chatResponse?.partner?.name ??
                                        GlobalData?.othersProfile.name,
                                leftButtonVisibility: true,
                                rightButtonVisibility: false);
                          } else if (GlobalData
                                      .messageModel.response?.loveRecieve ==
                                  3 &&
                              GlobalData.messageModel.response
                                      ?.requestTolStatus ==
                                  4) {
                            Dialogs().showDialogYesNo(
                                context: context,
                                title: "Token of Love",
                                content:
                                    " Hey, you lucky in love! ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} has accepted your proposal. Its time to make ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} feel more special, choose a gift and send with a love note. ",
                                memcode: widget.chatResponse?.partner
                                        ?.membershipCode ??
                                    GlobalData.othersProfile.membershipCode,
                                leftBbuttonText: "Ok",
                                rightBbuttonText: "Yes",
                                partnerName:
                                    widget.chatResponse?.partner?.name ??
                                        GlobalData?.othersProfile.name,
                                leftButtonVisibility: true,
                                rightButtonVisibility: false);
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: !_eventBtnClicked
                        ? BtnWithText(
                            img: "assets/Chat/Events.png",
                            textSize: 10.0,
                            text: "Events",
                            fixedIconSize: FixedIconSize.SMALL,
                            onTap: () {
                              setState(() {
                                _eventBtnClicked = !_eventBtnClicked;
                              });
                            },
                          )
                        : BtnWithText(
                            img: "assets/Profile/Chat.png",
                            textSize: 10.0,
                            text: "Chat",
                            fixedIconSize: FixedIconSize.SMALL,
                            onTap: () {
                              setState(() {
                                _eventBtnClicked = !_eventBtnClicked;
                              });
                            },
                          ),
                  ),

                  /// accept button placed here
                  GestureDetector(
                    onTap: () {
                      if (GlobalData.messageModel.response?.recieveTolStatus ==
                          2) {
                        Dialogs().showDialogYesNo(
                            context: context,
                            title: "Token of Love",
                            content:
                                "Hey Congrats! It seems ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}"
                                " wants to surprise you with a Token of love. You both have come a long way, accepting the request can take this proposal to next level. ",
                            memcode:
                                widget.chatResponse?.partner?.membershipCode ??
                                    GlobalData?.othersProfile.membershipCode,
                            leftBbuttonText: "Reject",
                            rightBbuttonText: "Accept",
                            partnerName: widget.chatResponse?.partner?.name ??
                                GlobalData?.othersProfile.name,
                            leftButtonVisibility: true,
                            rightButtonVisibility: true);
                      } else if (GlobalData
                              .messageModel.response?.recieveTolStatus ==
                          3) {
                        Dialogs().showDialogYesNo(
                            context: context,
                            title: "Token of Love",
                            content:
                                " Cheers! Good to hear that you are reaccepting the tol from ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}"
                                "all the best for your love",
                            memcode:
                                widget.chatResponse?.partner?.membershipCode ??
                                    GlobalData.othersProfile.membershipCode,
                            leftBbuttonText: "ReAccept",
                            rightBbuttonText: "Accept",
                            partnerName: widget.chatResponse?.partner?.name ??
                                GlobalData?.othersProfile.name ??
                                "" +
                                    (widget.chatResponse?.partner?.lastName)
                                        .toString() ??
                                "",
                            leftButtonVisibility: true,
                            rightButtonVisibility: false);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        //left: 30.0,
                        //right: 4.0,
                        top: 4,
                        //bottom: 10
                      ),
                      child: Visibility(
                        visible: (GlobalData.messageModel.response
                                        ?.recieveTolStatus ==
                                    2 &&
                                GlobalData.messageModel.response?.userStatus ==
                                    'active' /*||
                                              GlobalData.messageModel?.response
                                                      ?.recieveTolStatus ==
                                                  3*/
                            ) ??
                            true,
                        child: BtnWithText(
                          img: "assets/TOL/Requst.png",
                          text: "Accept",
                          textSize: 8.0,
                          paddingTextIcon: 3,
                          customSize: 20.0,
                          fixedIconSize: FixedIconSize.MEDIUM,
                          onTap: () {
                            if (GlobalData
                                    .messageModel.response?.recieveTolStatus ==
                                2) {
                              Dialogs().showDialogYesNo(
                                  context: context,
                                  title: "Token of Love",
                                  content:
                                      "Hey Congrats! It seems ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}"
                                      " wants to surprise you with a Token of love. You both have come a long way, accepting the request can take this proposal to next level. ",
                                  memcode: widget.chatResponse?.partner
                                          ?.membershipCode ??
                                      GlobalData?.othersProfile.membershipCode,
                                  leftBbuttonText: "Reject",
                                  rightBbuttonText: "Accept",
                                  partnerName:
                                      widget.chatResponse?.partner?.name ??
                                          GlobalData?.othersProfile.name,
                                  leftButtonVisibility: true,
                                  rightButtonVisibility: true);
                            } else if (GlobalData
                                    .messageModel.response?.recieveTolStatus ==
                                3) {
                              Dialogs().showDialogYesNo(
                                  context: context,
                                  title: "Token of Love",
                                  content:
                                      " Cheers! Good to hear that you are reaccepting the tol from ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}"
                                      "all the best for your love",
                                  memcode: widget.chatResponse?.partner
                                          ?.membershipCode ??
                                      GlobalData.othersProfile.membershipCode,
                                  leftBbuttonText: "ReAccept",
                                  rightBbuttonText: "Accept",
                                  partnerName:
                                      widget.chatResponse?.partner?.name ??
                                          GlobalData?.othersProfile.name ??
                                          "" +
                                              (widget.chatResponse?.partner
                                                      ?.lastName)
                                                  .toString() ??
                                          "",
                                  leftButtonVisibility: true,
                                  rightButtonVisibility: false);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
                title: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      child: Row(
                        children: <Widget>[
                          //Icon(Icons.chevron_left,),
                          /* SizedBox(
                              width: 5,
                            ),*/
                          InkWell(
                            onTap: () {
                              print(
                                  'code${UserShortInfoModel(response: UserShortInfoResponse(
                                data: widget.listDatum,
                              ))}');
                              widget.listDatum.add(
                                Datum(
                                  membershipCode: widget.chatResponse?.partner
                                          ?.membershipCode ??
                                      GlobalData
                                          ?.othersProfile.membershipCode ??
                                      "",
                                  info: widget.chatResponse?.partner?.info ??
                                      GlobalData?.othersProfile.info,
                                  name: widget.chatResponse?.partner?.name ??
                                      GlobalData?.othersProfile.name,
                                  lastName:
                                      widget.chatResponse?.partner?.lastName ??
                                          GlobalData?.othersProfile.lastName,
                                  dp: widget.chatResponse?.partner?.dp ??
                                      GlobalData.othersProfile.dp,
                                  membership: Membership(paidMember: false),
                                  officialDocuments: OfficialDocuments(),
                                ),
                              );
                              Navigator.pushNamed(context, '/profileSwitch',
                                  arguments: ProfileSwitch(
                                    userShortInfoModel: UserShortInfoModel(
                                        response: UserShortInfoResponse(
                                      data: widget.listDatum,
                                    )),
                                    memberShipCode: widget
                                        .chatResponse?.partner?.membershipCode,
                                  ));
                            },
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(Icons.arrow_back)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CircleAvatar(
                                        radius: 20.0,
                                        backgroundImage: NetworkImage(
                                          APis().imageApi(
                                            widget.chatResponse?.partner?.dp
                                                    ?.photoName ??
                                                GlobalData?.othersProfile.dp
                                                    ?.photoName,
                                            imageConversion:
                                                ImageConversion.THUMB,
                                          ),
                                        )),
                                  ],
                                ),
                                Visibility(
                                  visible: GlobalData.onlineUsersMemCode
                                      .contains(widget.chatResponse?.partner
                                          ?.membershipCode),
                                  child: Positioned(
                                      bottom: 5.0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(50.0)),
                                      )),
                                ),

                                /// check user online
                                /*Visibility(
                                    visible:widget.chatResponse.messages[0].partner.online==1
                                        ? true
                                        : false,
                                    child: Positioned(
                                        bottom: 5.0,
                                        right: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(50.0)),
                                        )),
                                  ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 8.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    widget.listDatum.add(
                                      Datum(
                                        membershipCode: widget.chatResponse
                                                ?.partner?.membershipCode ??
                                            GlobalData?.othersProfile
                                                .membershipCode ??
                                            "",
                                        info: widget
                                                .chatResponse?.partner?.info ??
                                            GlobalData.othersProfile.info,
                                        name: widget
                                                .chatResponse?.partner?.name ??
                                            GlobalData.othersProfile.name,
                                        lastName: widget.chatResponse?.partner
                                                ?.lastName ??
                                            GlobalData.othersProfile.lastName,
                                        dp: widget.chatResponse?.partner?.dp ??
                                            GlobalData.othersProfile.dp,
                                        membership:
                                            Membership(paidMember: false),
                                        officialDocuments: OfficialDocuments(),
                                      ),
                                    );
                                    Navigator.pushNamed(
                                        context, '/profileSwitch',
                                        arguments: ProfileSwitch(
                                          userShortInfoModel:
                                              UserShortInfoModel(
                                                  response:
                                                      UserShortInfoResponse(
                                            data: widget.listDatum,
                                          )),
                                          memberShipCode: widget.chatResponse
                                              ?.partner?.membershipCode,
                                        ));
                                  },
                                  child: Container(
                                    width: 69.0,
                                    child:
                                        /*TextView(
                                      widget.chatResponse?.partner?.name ??
                                          GlobalData?.othersProfile?.name ??
                                          "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      size: 16.0,
                                    ),*/
                                        Row(
                                      children: [
                                        TextView(
                                          widget.chatResponse?.partner?.name ??
                                              GlobalData?.othersProfile.name ??
                                              "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          size: 14.0,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        TextView(
                                          widget.chatResponse?.partner?.lastName
                                                  ?.toString()
                                                  .substring(0, 1) ??
                                              '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          size: 14.0,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 25),
                                  child: Visibility(
                                    visible: !GlobalData.onlineUsersMemCode
                                        .contains(widget.chatResponse?.partner
                                            ?.membershipCode),
                                    child: TextView(
                                      getTime(
                                          widget.chatResponse?.partner
                                                  ?.lastActive ??
                                              "",
                                          false),
                                      size: 12.0,
                                      maxLines: 2,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.visible,
                                      textScaleFactor: .8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              body: Container(
                child: Column(children: <Widget>[
                  Expanded(
                    child: !_eventBtnClicked
                        ? ChatView(
                            membershipCode: widget.memberShipCode != ''
                                ? widget.memberShipCode
                                : GlobalData.othersProfile.membershipCode,
                            chatResponse: widget.chatResponse,
                          )
                        : ChatEvents(
                            memcode: widget.chatResponse?.partner
                                        ?.membershipCode !=
                                    ''
                                ? (widget.chatResponse?.partner?.membershipCode)
                                    .toString()
                                : widget.memberShipCode,
                            chatResponse: widget.chatResponse!,
                          ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          child: Visibility(
                            visible: !_eventBtnClicked,
                            child: ((GlobalData.messageModel.response?.mom
                                        ?.momStatus) ==
                                    'sent')
                                ? TextView(
                                    "Hello! you would not able to chat with ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} \n till you are connected  ",
                                    size: 15.0,
                                    maxLines: 2,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,
                                  )
                                : !isPaidMember
                                    ? TextView(
                                        CoupledStrings.subscribeToEnjoy,
                                        size: 15.0,
                                        maxLines: 2,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.visible,
                                      )
                                    : GlobalData?.messageModel.response
                                                ?.chatShow ==
                                            'no topup'
                                        ? TextView(
                                            CoupledStrings.chatCreditsMsg,
                                            size: 15.0,
                                            maxLines: 2,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.normal,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.visible,
                                          )
                                        : GlobalData?.messageModel.response
                                                    ?.userStatus !=
                                                'active'
                                            ? TextView(
                                                'Your profile is hidden.You would not be \n able to respond,chat or initiate until \nthe account is reactivated',
                                                size: 15,
                                                maxLines: 2,
                                                color: Colors.white,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.visible,
                                              )
                                            : (GlobalData.messageModel.response
                                                            ?.mom?.momStatus ==
                                                        'accept' &&
                                                    GlobalData
                                                            .messageModel
                                                            .response
                                                            ?.mom
                                                            ?.momType ==
                                                        'connect')
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8.0,
                                                      right: 8.0,
                                                    ),
                                                    child: TextView(
                                                      CoupledStrings.doubleTap,
                                                      size: 13.0,
                                                      color: CoupledTheme()
                                                          .inactiveColor,
                                                      maxLines: 2,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.visible,
                                                    ),
                                                  )
                                                : TextView(
                                                    '',
                                                    maxLines: 2,
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.visible,
                                                  ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !_eventBtnClicked,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8, left: 8.0),
                          child: (!isPaidMember &&
                                  GlobalData.messageModel.response?.mom
                                          ?.momStatus !=
                                      'sent')
                              ? CustomButton(
                                  buttonType: ButtonType.FLAT,
                                  height: 25.0,
                                  child: Text(
                                    '  Upgrade ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/membershipPlans');
                                  },
                                )
                              : isPaidMember &&
                                      GlobalData.messageModel.response?.mom
                                              ?.momStatus !=
                                          'sent' &&
                                      GlobalData?.messageModel.response
                                              ?.chatShow ==
                                          'no topup'
                                  ? CustomButton(
                                      buttonType: ButtonType.FLAT,
                                      height: 25.0,
                                      child: Text(
                                        '  Top Up ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/myPlanPayments');
                                      },
                                    )
                                  : GlobalData?.messageModel.response
                                              ?.userStatus !=
                                          'active'
                                      ? CustomButton(
                                          buttonType: ButtonType.FLAT,
                                          height: 25.0,
                                          child: Text(
                                            ' Reactivate ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Settings()));
                                          })
                                      : null,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                      visible: !_eventBtnClicked,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: TextView(
                          "Scroll up to refresh messages",
                          size: 13.0,
                          color: CoupledTheme().inactiveColor,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          decoration: TextDecoration.none,
                          textScaleFactor: .8,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0),
                    child: IgnorePointer(
                      ignoring:
                          !isPaidMember ||
                              ((GlobalData
                                          .messageModel.response?.mom?.momStatus) ==
                                      'sent' ||
                                  GlobalData
                                          .messageModel.response?.mom?.momStatus ==
                                      'reject' ||
                                  GlobalData.messageModel.response?.mom
                                          ?.momType ==
                                      "shortlist" ||
                                  GlobalData.messageModel.response?.mom
                                          ?.momType ==
                                      'block' ||
                                  GlobalData.messageModel.response?.mom
                                          ?.momType ==
                                      'report' ||
                                  GlobalData
                                          .messageModel.response?.userStatus !=
                                      'active'),
                      child: Opacity(
                        opacity:
                            ((GlobalData.messageModel.response?.mom?.momStatus) ==
                                        'sent' ||
                                    (GlobalData.messageModel.response?.mom
                                            ?.momStatus) ==
                                        'reject' ||
                                    GlobalData.messageModel.response?.mom?.momType ==
                                        "shortlist" ||
                                    GlobalData
                                            .messageModel.response?.mom?.momType ==
                                        'block' ||
                                    GlobalData.messageModel.response?.mom
                                            ?.momType ==
                                        'report' ||
                                    GlobalData.messageModel.response
                                            ?.userStatus !=
                                        'active')
                                ? 0.5
                                : 1,
                        child: Visibility(
                          visible: !_eventBtnClicked,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: ChatTexter(
                                  hint: 'Type a message',
                                  focusNode: _msgFocusnode,
                                  msgController: _msgController,
                                  backgroundColor:
                                      CoupledTheme().backgroundColor,
                                  borderVisibility: false,
                                  textSize: 20.0,
                                  onTap: () {
                                    setState(() {
                                      showModalBottomSheet<Null>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SingleChildScrollView(
                                                child: GridView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: GlobalData.stickerModel
                                                      .response.length ??
                                                  0,
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 4,
                                                      childAspectRatio: 1.2),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    _msgController.text =
                                                        GlobalData
                                                            .stickerModel
                                                            .response[index]
                                                            .image;

                                                    (GlobalData
                                                                    .messageModel
                                                                    .response
                                                                    ?.mom
                                                                    ?.momStatus ==
                                                                'accept' &&
                                                            GlobalData
                                                                    .messageModel
                                                                    .response
                                                                    ?.mom
                                                                    ?.momType ==
                                                                'connect' &&
                                                            _msgController.text
                                                                    .length >
                                                                0 &&
                                                            isPaidMember &&
                                                            GlobalData
                                                                    ?.messageModel
                                                                    .response
                                                                    ?.chatShow !=
                                                                'no topup' &&
                                                            GlobalData
                                                                    ?.messageModel
                                                                    .response
                                                                    ?.userStatus ==
                                                                'active')
                                                        ? sendChat('sticker')
                                                        : Container();
                                                    GlobalData.recievemsg = 2;
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 15,
                                                    width: 15,
                                                    child: Card(
                                                      child: Image.network(
                                                        APis.stickerImagePath +
                                                            GlobalData
                                                                .stickerModel
                                                                .response[index]
                                                                .image,
                                                        height: 12,
                                                        width: 10,
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ));
                                          });

                                      // FocusScope.of(context).unfocus();
                                      //emoticonVisible = !emoticonVisible;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: BtnWithText(
                                    img: "assets/Chat/Message-Sent.png",
                                    text: "Send",
                                    onTap: () {
                                      if (_msgController.text.length < 320) {
                                        (GlobalData.messageModel.response?.mom
                                                        ?.momStatus ==
                                                    'accept' &&
                                                GlobalData.messageModel.response
                                                        ?.mom?.momType ==
                                                    'connect' &&
                                                _msgController.text.length >
                                                    0 &&
                                                isPaidMember &&
                                                GlobalData?.messageModel
                                                        .response?.chatShow !=
                                                    'no topup' &&
                                                GlobalData?.messageModel
                                                        .response?.userStatus ==
                                                    'active')
                                            ? sendChat('text')
                                            : GlobalWidgets().showToast(
                                                msg:
                                                    "Unable to chat:- ${GlobalData.messageModel.response?.mom?.momStatus},${GlobalData.messageModel.response?.mom?.momType}, #Paid Member:${isPaidMember}, #Topup:${GlobalData?.messageModel.response?.chatShow}, #User Status :${GlobalData?.messageModel.response?.userStatus}");

                                        GlobalData.recievemsg = 2;
                                      } else {
                                        GlobalWidgets().showToast(
                                            msg: "You have reached to maximum");
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            );
          }
          if (state is ChatError) {
            /*return Center(
              child: Text(CoupledStrings.errorMsg),
            );*/
            return Center(child: Text("Chat can't able to load"));
          }

          return Scaffold(
            backgroundColor: CoupledTheme().backgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              iconTheme: IconThemeData(
                color: CoupledTheme().primaryBlue,
              ),
              backgroundColor: CoupledTheme().backgroundColor,
              actions: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GlobalWidgets().iconCreator(
                              "assets/heart.png",
                              color: CoupledTheme().primaryBlue,
                              size: FixedIconSize.EXTRASMALL,
                            ),
                          );
                        },
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GlobalWidgets().iconCreator(
                              "assets/heart.png",
                              color: CoupledTheme().primaryPink,
                              size: FixedIconSize.EXTRASMALL,
                            ),
                          );
                        },
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),

                Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 5),
                  child: BtnWithText(
                    img: "assets/MatchMeter/Token-Of-Love.png",
                    text: "TOL",
                    textSize: 8.0,
                    enabled:
                        (GlobalData.messageModel.response?.mom?.momStatus ==
                                'accept' &&
                            GlobalData.messageModel.response?.mom?.momType ==
                                'connect' &&
                            GlobalData.messageModel.response?.userStatus ==
                                'active'),
                    customSize: 20.0,
                    fixedIconSize: FixedIconSize.MEDIUM,
                    onTap: () {
                      if (GlobalData.messageModel.response?.mom?.momStatus ==
                              'accept' &&
                          GlobalData.messageModel.response?.mom?.momType ==
                              'connect') {
                        print('1');
                        if (GlobalData.messageModel.response?.loveRecieve < 3) {
                          Dialogs().showDialogYesNo(
                              context: context,
                              title: CoupledStrings.tokenOfLoveTitle,
                              content: CoupledStrings.impressYourPartnerTol,
                              memcode: widget
                                      .chatResponse?.partner?.membershipCode ??
                                  GlobalData?.othersProfile.membershipCode,
                              leftBbuttonText: "Okay",
                              rightBbuttonText: "Okay",
                              partnerName: widget.chatResponse?.partner?.name ??
                                  GlobalData?.othersProfile.name,
                              leftButtonVisibility: false,
                              rightButtonVisibility: true);
                        } else if (GlobalData
                                    .messageModel.response?.loveRecieve >=
                                3 &&
                            GlobalData
                                    .messageModel.response?.requestTolStatus ==
                                1) {
                          Dialogs().showDialogYesNo(
                              context: context,
                              title: CoupledStrings.tokenOfLoveTitle,
                              content:
                                  "Yay!  You have earned three hearts from ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}.Send a Token of Love to ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} to take your proposal to next level ",
                              memcode: widget
                                      .chatResponse?.partner?.membershipCode ??
                                  GlobalData?.othersProfile.membershipCode,
                              leftBbuttonText: "Not now",
                              rightBbuttonText: "Ok",
                              partnerName: widget.chatResponse?.partner?.name ??
                                  GlobalData?.othersProfile.name,
                              leftButtonVisibility: true,
                              rightButtonVisibility: true);
                        } else if (GlobalData
                                    .messageModel.response?.loveRecieve <
                                3 &&
                            GlobalData
                                    .messageModel.response?.requestTolStatus ==
                                2) {
                          print("jopp");

                          print(GlobalData
                                  .messageModel.response?.requestTolStatus ==
                              2);
                          Dialogs().showDialogYesNo(
                              context: context,
                              title: "Token of Love",
                              content:
                                  "${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} may take some time to respond, in the meanwhile you can keep interacting with ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} ${widget.chatResponse?.partner?.lastName ?? ""} . Wishing best of love!",
                              memcode: widget
                                      .chatResponse?.partner?.membershipCode ??
                                  GlobalData?.othersProfile.membershipCode,
                              leftBbuttonText: "Ok!",
                              rightBbuttonText: "Yes",
                              partnerName: widget.chatResponse?.partner?.name ??
                                  GlobalData?.othersProfile.name,
                              leftButtonVisibility: true,
                              rightButtonVisibility: false);
                        } else if (GlobalData
                                    .messageModel.response?.loveRecieve <
                                3 &&
                            GlobalData
                                    .messageModel.response?.requestTolStatus ==
                                3) {
                          Dialogs().showDialogYesNo(
                              context: context,
                              title: "Token of Love",
                              content:
                                  'Hey Guess ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} is not ready for TOL this time. Impress your partner with your conversation, earn three hearts again and unlock the magic of token of love. Double tap on the message to give heart',
                              memcode: widget
                                      .chatResponse?.partner?.membershipCode ??
                                  GlobalData?.othersProfile.membershipCode,
                              leftBbuttonText: 'Ok!',
                              rightBbuttonText: "Yes",
                              partnerName: widget.chatResponse?.partner?.name ??
                                  GlobalData?.othersProfile.name,
                              leftButtonVisibility: true,
                              rightButtonVisibility: false);
                        } else if (GlobalData
                                    .messageModel.response?.loveRecieve ==
                                3 &&
                            GlobalData
                                    .messageModel.response?.requestTolStatus ==
                                4) {
                          Dialogs().showDialogYesNo(
                              context: context,
                              title: "Token of Love",
                              content:
                                  " Hey, you lucky in love! ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} has accepted your proposal. Its time to make ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name} feel more special, choose a gift and send with a love note. ",
                              memcode: widget
                                      .chatResponse?.partner?.membershipCode ??
                                  GlobalData.othersProfile.membershipCode,
                              leftBbuttonText: "Ok",
                              rightBbuttonText: "Yes",
                              partnerName: widget.chatResponse?.partner?.name ??
                                  GlobalData?.othersProfile.name,
                              leftButtonVisibility: true,
                              rightButtonVisibility: false);
                        }
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: !_eventBtnClicked
                      ? BtnWithText(
                          img: "assets/Chat/Events.png",
                          textSize: 10.0,
                          text: "Events",
                          fixedIconSize: FixedIconSize.SMALL,
                          onTap: () {
                            setState(() {
                              _eventBtnClicked = !_eventBtnClicked;
                            });
                          },
                        )
                      : BtnWithText(
                          img: "assets/Profile/Chat.png",
                          textSize: 10.0,
                          text: "Chat",
                          fixedIconSize: FixedIconSize.SMALL,
                          onTap: () {
                            setState(() {
                              _eventBtnClicked = !_eventBtnClicked;
                            });
                          },
                        ),
                ),
                SizedBox(
                  width: 5,
                ),

                /// accept button placed here
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(
                      //left: 30.0,
                      //right: 4.0,
                      top: 4,
                      //bottom: 10
                    ),
                    child: Visibility(
                      visible: (GlobalData.messageModel.response
                                      ?.recieveTolStatus ==
                                  2 &&
                              GlobalData.messageModel.response?.userStatus ==
                                  'active' /*||
                                              GlobalData.messageModel?.response
                                                      ?.recieveTolStatus ==
                                                  3*/
                          ) ??
                          true,
                      child: BtnWithText(
                        img: "assets/TOL/Requst.png",
                        text: "Accept",
                        textSize: 8.0,
                        paddingTextIcon: 3,
                        customSize: 20.0,
                        fixedIconSize: FixedIconSize.MEDIUM,
                        onTap: () {
                          if (GlobalData
                                  .messageModel.response?.recieveTolStatus ==
                              2) {
                            Dialogs().showDialogYesNo(
                                context: context,
                                title: "Token of Love",
                                content:
                                    "Hey Congrats! It seems ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}"
                                    " wants to surprise you with a Token of love. You both have come a long way, accepting the request can take this proposal to next level. ",
                                memcode: widget.chatResponse?.partner
                                        ?.membershipCode ??
                                    GlobalData?.othersProfile.membershipCode,
                                leftBbuttonText: "Reject",
                                rightBbuttonText: "Accept",
                                partnerName:
                                    widget.chatResponse?.partner?.name ??
                                        GlobalData?.othersProfile.name,
                                leftButtonVisibility: true,
                                rightButtonVisibility: true);
                          } else if (GlobalData
                                  .messageModel.response?.recieveTolStatus ==
                              3) {
                            Dialogs().showDialogYesNo(
                                context: context,
                                title: "Token of Love",
                                content:
                                    " Cheers! Good to hear that you are reaccepting the tol from ${widget.chatResponse?.partner?.name ?? GlobalData?.othersProfile.name}"
                                    "all the best for your love",
                                memcode: widget.chatResponse?.partner
                                        ?.membershipCode ??
                                    GlobalData.othersProfile.membershipCode,
                                leftBbuttonText: "ReAccept",
                                rightBbuttonText: "Accept",
                                partnerName: widget
                                        .chatResponse?.partner?.name ??
                                    GlobalData?.othersProfile.name ??
                                    "" +
                                        (widget.chatResponse?.partner!.lastName)
                                            .toString() ??
                                    "",
                                leftButtonVisibility: true,
                                rightButtonVisibility: false);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                )
              ],
              title: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: Row(
                      children: <Widget>[
                        //Icon(Icons.chevron_left,),
                        /* SizedBox(
                              width: 5,
                            ),*/
                        InkWell(
                          onTap: () {},
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                      radius: 20.0,
                                      backgroundImage: NetworkImage(
                                        APis().imageApi(
                                          widget.chatResponse?.partner?.dp
                                                  ?.photoName ??
                                              GlobalData
                                                  ?.othersProfile.dp?.photoName,
                                          imageConversion:
                                              ImageConversion.THUMB,
                                        ),
                                      )),
                                ],
                              ),
                              Visibility(
                                visible: GlobalData.onlineUsersMemCode.contains(
                                    widget
                                        .chatResponse?.partner?.membershipCode),
                                child: Positioned(
                                    bottom: 5.0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                    )),
                              ),

                              /// check user online
                              /*Visibility(
                                    visible:widget.chatResponse.messages[0].partner.online==1
                                        ? true
                                        : false,
                                    child: Positioned(
                                        bottom: 5.0,
                                        right: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(50.0)),
                                        )),
                                  ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: 8.0,
                              ),
                              InkWell(
                                onTap: () {
                                  widget.listDatum.add(
                                    Datum(
                                      membershipCode: widget.chatResponse
                                              ?.partner?.membershipCode ??
                                          GlobalData
                                              ?.othersProfile.membershipCode ??
                                          "",
                                      info:
                                          widget.chatResponse?.partner?.info ??
                                              GlobalData.othersProfile.info,
                                      name:
                                          widget.chatResponse?.partner?.name ??
                                              GlobalData.othersProfile.name,
                                      lastName: widget.chatResponse?.partner
                                              ?.lastName ??
                                          GlobalData.othersProfile.lastName,
                                      dp: widget.chatResponse?.partner?.dp ??
                                          GlobalData.othersProfile.dp,
                                      membership: Membership(paidMember: false),
                                      officialDocuments: OfficialDocuments(),
                                    ),
                                  );
                                  Navigator.pushNamed(context, '/profileSwitch',
                                      arguments: ProfileSwitch(
                                        userShortInfoModel: UserShortInfoModel(
                                            response: UserShortInfoResponse(
                                          data: widget.listDatum,
                                        )),
                                        memberShipCode: widget.chatResponse
                                            ?.partner?.membershipCode,
                                      ));
                                },
                                child: Container(
                                  width: 69.0,
                                  child:
                                      /*TextView(
                                      widget.chatResponse?.partner?.name ??
                                          GlobalData?.othersProfile?.name ??
                                          "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      size: 16.0,
                                    ),*/
                                      Row(
                                    children: [
                                      TextView(
                                        widget.chatResponse?.partner?.name ??
                                            GlobalData?.othersProfile.name ??
                                            "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        size: 14.0,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: .8,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      TextView(
                                        widget.chatResponse?.partner?.lastName
                                                ?.toString()
                                                .substring(0, 1) ??
                                            '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        size: 14.0,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: .8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Visibility(
                                  visible: !GlobalData.onlineUsersMemCode
                                      .contains(widget.chatResponse?.partner
                                          ?.membershipCode),
                                  child: TextView(
                                    getTime(
                                        widget.chatResponse?.partner
                                                ?.lastActive ??
                                            "",
                                        false),
                                    size: 12.0,
                                    maxLines: 2,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,
                                    textScaleFactor: .8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  )
                ],
              ),
            ),
            body: Container(
              child: Column(children: <Widget>[
                Expanded(
                  child: !_eventBtnClicked
                      ? ChatView(
                          membershipCode: widget.memberShipCode != ''
                              ? widget.memberShipCode
                              : GlobalData.othersProfile.membershipCode,
                          chatResponse: widget.chatResponse,
                        )
                      : ChatEvents(
                          memcode:
                              widget.chatResponse?.partner?.membershipCode != ''
                                  ? (widget.chatResponse?.partner
                                          ?.membershipCode)
                                      .toString()
                                  : widget.memberShipCode,
                          chatResponse: widget.chatResponse!,
                        ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Visibility(
                    visible: !_eventBtnClicked,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: TextView(
                        "Scroll up to refresh messages",
                        size: 13.0,
                        color: CoupledTheme().inactiveColor,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        decoration: TextDecoration.none,
                        textScaleFactor: .8,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: IgnorePointer(
                    ignoring:
                        !isPaidMember ||
                            ((GlobalData
                                        .messageModel.response?.mom?.momStatus) ==
                                    'sent' ||
                                GlobalData.messageModel.response?.mom
                                        ?.momStatus ==
                                    'reject' ||
                                GlobalData
                                        .messageModel.response?.mom?.momType ==
                                    "shortlist" ||
                                GlobalData
                                        .messageModel.response?.mom?.momType ==
                                    'block' ||
                                GlobalData
                                        .messageModel.response?.mom?.momType ==
                                    'report' ||
                                GlobalData.messageModel.response?.userStatus !=
                                    'active'),
                    child: Opacity(
                      opacity:
                          ((GlobalData
                                          .messageModel.response?.mom?.momStatus) ==
                                      'sent' ||
                                  (GlobalData.messageModel.response?.mom
                                          ?.momStatus) ==
                                      'reject' ||
                                  GlobalData.messageModel.response?.mom
                                          ?.momType ==
                                      "shortlist" ||
                                  GlobalData.messageModel.response?.mom
                                          ?.momType ==
                                      'block' ||
                                  GlobalData.messageModel.response?.mom
                                          ?.momType ==
                                      'report' ||
                                  GlobalData
                                          .messageModel.response?.userStatus !=
                                      'active')
                              ? 0.5
                              : 1,
                      child: Visibility(
                        visible: !_eventBtnClicked,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: ChatTexter(
                                hint: 'Type a message',
                                focusNode: _msgFocusnode,
                                msgController: _msgController,
                                backgroundColor: CoupledTheme().backgroundColor,
                                borderVisibility: false,
                                textSize: 20.0,
                                onTap: () {
                                  setState(() {
                                    showModalBottomSheet<Null>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SingleChildScrollView(
                                              child: GridView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: GlobalData.stickerModel
                                                    .response.length ??
                                                0,
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    childAspectRatio: 1.2),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () {
                                                  _msgController.text =
                                                      GlobalData
                                                          .stickerModel
                                                          .response[index]
                                                          .image;

                                                  (GlobalData
                                                                  .messageModel
                                                                  .response
                                                                  ?.mom
                                                                  ?.momStatus ==
                                                              'accept' &&
                                                          GlobalData
                                                                  .messageModel
                                                                  .response
                                                                  ?.mom
                                                                  ?.momType ==
                                                              'connect' &&
                                                          _msgController.text.length >
                                                              0 &&
                                                          isPaidMember &&
                                                          GlobalData
                                                                  ?.messageModel
                                                                  .response
                                                                  ?.chatShow !=
                                                              'no topup' &&
                                                          GlobalData
                                                                  ?.messageModel
                                                                  .response
                                                                  ?.userStatus ==
                                                              'active')
                                                      ? sendChat('sticker')
                                                      : Container();
                                                  GlobalData.recievemsg = 2;
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  child: Card(
                                                    child: Image.network(
                                                      APis.stickerImagePath +
                                                          GlobalData
                                                              .stickerModel
                                                              .response[index]
                                                              .image,
                                                      height: 12,
                                                      width: 10,
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ));
                                        });

                                    // FocusScope.of(context).unfocus();
                                    //emoticonVisible = !emoticonVisible;
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: BtnWithText(
                                  img: "assets/Chat/Message-Sent.png",
                                  text: "Send",
                                  onTap: () {
                                    if (_msgController.text.length < 320) {
                                      (GlobalData.messageModel.response?.mom
                                                      ?.momStatus ==
                                                  'accept' &&
                                              GlobalData.messageModel.response
                                                      ?.mom?.momType ==
                                                  'connect' &&
                                              _msgController.text.length > 0 &&
                                              isPaidMember &&
                                              GlobalData?.messageModel.response
                                                      ?.chatShow !=
                                                  'no topup' &&
                                              GlobalData?.messageModel.response
                                                      ?.userStatus ==
                                                  'active')
                                          ? sendChat('text')
                                          : GlobalWidgets().showToast(
                                              msg:
                                                  "Unable to chat:- ${GlobalData.messageModel.response?.mom?.momStatus},${GlobalData.messageModel.response?.mom?.momType},paid member:${isPaidMember},Topup:${GlobalData?.messageModel.response?.chatShow},User Status :${GlobalData?.messageModel.response?.userStatus}");

                                      GlobalData.recievemsg = 2;
                                    } else {
                                      GlobalWidgets().showToast(
                                          msg: "You have reached to maximum");
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
