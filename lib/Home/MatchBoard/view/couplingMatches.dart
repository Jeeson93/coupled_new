// import 'package:coupled/Actions/shareView.dart';
// import 'package:coupled/Home/MatchBoard/bloc/bloc.dart';
// import 'package:coupled/Home/MatchBoard/bloc/match_board_event.dart';
// import 'package:coupled/Profile/ProfileSwitch.dart';
// import 'package:coupled/Src/REST/RestAPI.dart';
// import 'package:coupled/Src/models/UserShortInfoModel.dart';
// import 'package:coupled/Src/resources/Repository.dart';
// import 'package:coupled/Utils/Modals/Dialogs.dart';
// import 'package:coupled/Utils/globalWidgets.dart';
// import 'package:coupled/Utils/styles.dart';
// import 'package:emoji_picker/emoji_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:coupled/Utils/capitalize_string.dart';
import 'package:coupled/Actions/share_view.dart';
import 'package:coupled/Home/MatchBoard/bloc/match_board_bloc.dart';
import 'package:coupled/Home/Profile/profile_switch.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:coupled/resources/repository.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coupled/Utils/capitalize_string.dart';

String connectHint = "Send interest with message (optional)";
Dialogs dialogs = Dialogs();
bool isVerified = false;
MatchBoardBloc matchBoardBloc = MatchBoardBloc();

buildCouplingCard(UserShortInfoModel userShortInfoModel, BuildContext context) {
  matchBoardBloc = BlocProvider.of<MatchBoardBloc>(context);
  return List<Widget>.generate(userShortInfoModel.response?.data?.length ?? 0,
      (i) {
    if (userShortInfoModel.response?.data![i].officialDocuments != null) {
      isVerified = (userShortInfoModel
                      .response?.data![i].officialDocuments!.govtIdStatus ??
                  0) &
              (userShortInfoModel
                      .response?.data![i].officialDocuments?.officeIdStatus ??
                  0) &
              (userShortInfoModel
                      .response?.data![i].membership?.verificationBadge ??
                  0) ==
          1;
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/profileSwitch',
          arguments: ProfileSwitch(
            userShortInfoModel: userShortInfoModel,
            memberShipCode:
                userShortInfoModel.response?.data![i].membershipCode,
            index: i,
          ),
        );
      },
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          clipBehavior: Clip.antiAlias,
          elevation: 3.0,
          child: Stack(
            children: <Widget>[
              FadeInImage.assetNetwork(
                width: MediaQuery.of(context).size.width,
                height: (72 * MediaQuery.of(context).size.height) / 100,
                fit: BoxFit.cover,
                placeholder: 'assets/no_image.jpg',
                image: userShortInfoModel.response?.data![i].dp?.photoName != ''
                    ? APis().imageApi(
                        userShortInfoModel.response?.data![i].dp?.photoName
                            .toString(),
                        imageConversion: ImageConversion.MEDIA)
                    : '',
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    gradient: LinearGradient(
                        colors: [
                          Colors.black26,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black87,
                        ],
                        stops: [
                          0.08,
                          0.25,
                          0.50,
                          0.75,
                          1.0
                        ],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter)),
              ),
              Positioned(
                  right: 5,
                  top: 5,
                  child: ShareProfileBtn(
                      membershipCode:
                          (userShortInfoModel.response?.data![i].membershipCode)
                              .toString())),
              Positioned(
                top: 5,
                left: 10.0,
                right: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextView(
                              '${userShortInfoModel.response?.data![i].name.toString().capitalize} '
                              '${userShortInfoModel.response?.data![i].lastName?.substring(0, 1).toString().capitalize}',
                              size: 16.0,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                              maxLines: 1,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            /* CommonThings().customToolTip(
                            userShortInfoModel.response.data[i].officialDocuments
                            ),*/
                            isVerified
                                ? GlobalWidgets().iconCreator(
                                    'assets/Profile/Verifid2.png',
                                    size: FixedIconSize.SMALL,
                                  )
                                : Container()
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            TextView(
                              GlobalWidgets().getAge(userShortInfoModel
                                  .response?.data![i].info?.dob),
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: .9,
                              size: 12,
                              maxLines: 1,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            TextView(
                              ", ${userShortInfoModel.response?.data![i].info?.city}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
                              textScaleFactor: .9,
                              size: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 5,
                  left: 10.0,
                  right: 10.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextView(
                        "You and ${userShortInfoModel.response?.data![i].name} matches",
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .9,
                        size: 12,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      HeartPercentage(
                        userShortInfoModel.response?.data![i].score
                                .toString() ??
                            '0',
                        userId:
                            userShortInfoModel.response?.data![i].id.toString(),
                        profileImg: userShortInfoModel
                            .response?.data![i].dp?.photoName
                            .toString(),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                dialogs.connectWithMsgRequest(context,
                                    userShortInfoModel: [userShortInfoModel],
                                    isRemoveItemMatchBoard: true,
                                    isReloadOthersProfile: false,
                                    partnerId: userShortInfoModel
                                        .response?.data![i].id
                                        .toString(), emojiPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return DraggableScrollableSheet(
                                          initialChildSize: 0.35,
                                          maxChildSize: .5,
                                          minChildSize: 0.35,
                                          builder:
                                              (context, scrollController) =>
                                                  SizedBox(
                                            height: 100.0,
                                            child: EmojiPicker(
                                              config: Config(
                                                //  rows: 3,
                                                columns: 7,
                                                // recommendKeywords: [
                                                //   "racing",
                                                //   "horse"
                                                // ],
                                                // numRecommended: 10,
                                              ),
                                              onEmojiSelected:
                                                  (emoji, category) {
                                                print(emoji);
                                              },
                                            ),
                                          ),
                                        );
                                      });
                                });
                              },
                              child: InterestWithMsg(
                                hint: connectHint,
                                backgroundColor: CoupledTheme().backgroundColor,
                                borderVisibility: false,
                                textSize: 12.0,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Repository().doAction({
                                'mom_type': 'connect',
                                'partner_id':
                                    userShortInfoModel.response?.data![i].id
                              }, "MoMConnect").then((value) {
                                GlobalWidgets()
                                    .showToast(msg: value.response?.msg);
                                if (value.code == 200) {
                                  matchBoardBloc.add(
                                    MatchBoardActions(
                                      id: (userShortInfoModel
                                              .response?.data![i].id)!
                                          .toInt(),
                                      userShortInfoModel: [userShortInfoModel],
                                    ),
                                  );
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: BtnWithText(
                                img: "assets/MatchMeter/Connect.png",
                                text: "Connect",
                                onTap: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          )),
    );
  });
}
