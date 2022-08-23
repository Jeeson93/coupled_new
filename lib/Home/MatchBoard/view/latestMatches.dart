// import 'package:coupled/Actions/shareView.dart';
// import 'package:coupled/Profile/ProfileSwitch.dart';
// import 'package:coupled/Src/REST/RestAPI.dart';
// import 'package:coupled/Src/models/BaseSettingsModel.dart';
// import 'package:coupled/Src/coupled_global.dart';
// import 'package:coupled/Src/models/UserShortInfoModel.dart';
// import 'package:coupled/Utils/Modals/Dialogs.dart';
// import 'package:coupled/Utils/globalWidgets.dart';
// import 'package:coupled/Utils/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:coupled/Utils/capitalize_string.dart';
// bool isVerified = false;

import 'package:coupled/Actions/share_view.dart';
import 'package:coupled/Home/Profile/profile_switch.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/capitalize_string.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

bool isVerified = false;

latestMatch(UserShortInfoModel userShortInfoModel, BuildContext context) {
  BaseSettings recommendationCause;
  recommendationCause =
      GlobalData().getBaseSettingsType(baseType: 'recommend_cause');

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
              height: (50 * MediaQuery.of(context).size.height) / 100,
              fit: BoxFit.cover,
              placeholder: 'assets/no_image.jpg',
              image: APis().imageApi(
                  userShortInfoModel.response?.data![i].dp?.photoName,
                  imageConversion: ImageConversion.MEDIA),
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
                        0.02,
                        0.12,
                        0.50,
                        0.75,
                        1.0
                      ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter)),
            ),
            Positioned(
                right: 20,
                top: 5,
                child: ShareProfileBtn(
                    membershipCode:
                        userShortInfoModel.response?.data![i].membershipCode)),
            Positioned(
              right: 10,
              top: 30,
              child: InkWell(
                radius: 50.0,
                splashColor: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(50.0),

                ///Recommendation
                child: Stack(
                  children: [
                    BtnWithText(
                      ///Recommendation only show when user has a valid plan And no recommend action done before
                      enabled: ((GlobalData.myProfile.membership!.paidMember ??
                              false) &&
                          !userShortInfoModel.response?.data![i].recommend),
                      roundBackGround: true,
                      img: "assets/MatchBoard/Recommendation.png",
                      onTap: () {
                        Dialogs().profileRecommendation(
                          memberShipCode:
                              (userShortInfoModel.response?.data![i].id)
                                  .toString(),
                          userShortInfoModel: [userShortInfoModel],
                          context: context,
                          partnerId: userShortInfoModel.response?.data![i].id,
                          isRemoveItemMatchBoard: true,
                          baseSettings: recommendationCause.options,
                        );
                      },
                    ),
                    Visibility(
                      visible: userShortInfoModel
                              .response?.data![i].recomendCauseCount !=
                          0,
                      child: Positioned(
                        top: 0,
                        right: 0,
                        child: NotificationBadge(
                          count: userShortInfoModel
                                  .response?.data![i].recomendCauseCount ??
                              0,
                          radius: 20,
                          bgcolor: CoupledTheme().primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
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
                            '${userShortInfoModel.response?.data![i].name.toString().capitalize} ${userShortInfoModel.response?.data![i].lastName?.substring(0, 1).toString().capitalize}',
                            size: 16.0,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .9,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          isVerified
                              ? GlobalWidgets().iconCreator(
                                  "assets/Profile/Verifid2.png",
                                  size: FixedIconSize.SMALL)
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
                            textScaleFactor: .8,
                            size: 12,
                          ),
                          TextView(
                            ", ${userShortInfoModel.response?.data![i].info?.city}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                            size: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                  HeartPercentage(
                    userShortInfoModel.response?.data![i].score.toString() ??
                        '0',
                    userId: userShortInfoModel.response?.data![i].id.toString(),
                    profileImg:
                        userShortInfoModel.response?.data![i].dp?.photoName,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }, growable: true);
}
