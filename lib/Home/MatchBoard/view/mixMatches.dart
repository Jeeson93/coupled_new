// import 'package:coupled/Actions/shareView.dart';
// import 'package:coupled/Profile/ProfileSwitch.dart';
// import 'package:coupled/Src/REST/RestAPI.dart';
// import 'package:coupled/Src/coupled_global.dart';
// import 'package:coupled/Src/models/UserShortInfoModel.dart';
// import 'package:coupled/Utils/Modals/Dialogs.dart';
// import 'package:coupled/Utils/globalWidgets.dart';
// import 'package:flutter/material.dart';
// import 'package:coupled/Utils/capitalize_string.dart';
import 'package:coupled/Actions/share_view.dart';
import 'package:coupled/Home/Profile/profile_switch.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/capitalize_string.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';

premiumMembers(List userShortInfoModel, BuildContext context) {
  bool isVerified = false;

  void callAction(title, baseType, momType, id, membershipCode,
      {isMultiSelection = true}) {
    var s = GlobalData().getBaseSettingsType(baseType: baseType);
    Dialogs().profileDialogs(context, title, id.toString(),
        multiSelection: isMultiSelection,
        momType: momType,
        memberShipCode: membershipCode,
        userShortInfoModel: userShortInfoModel,
        isRemoveItemMatchBoard: true,
        reasons: s.options,
        callBack: (String value) {});
  }

  Datum userInfo = Datum(
    membership: Membership(paidMember: false),
    officialDocuments: OfficialDocuments(),
    dp: Dp(
        photoName: '',
        imageType: BaseSettings(options: []),
        imageTaken: BaseSettings(options: []),
        userDetail: UserDetail(membership: Membership(paidMember: false))),
    info: Info(maritalStatus: BaseSettings(options: [])),
  );
  return List<Widget>.generate(userShortInfoModel[0].response.data.length, (i) {
    userInfo = userShortInfoModel[0].response.data[i];
    if (userShortInfoModel[0].response.data[i].officialDocuments != null) {
      isVerified = (userShortInfoModel[0]
                      .response
                      .data[i]
                      .officialDocuments
                      ?.govtIdStatus ??
                  0) &
              (userShortInfoModel[0]
                      .response
                      .data[i]
                      .officialDocuments
                      ?.officeIdStatus ??
                  0) &
              (userShortInfoModel[0]
                      .response
                      .data[i]
                      .membership
                      ?.verificationBadge ??
                  0) ==
          1;
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/profileSwitch',
            arguments: ProfileSwitch(
              memberShipCode:
                  userShortInfoModel[0].response.data[i].membershipCode,
              userShortInfoModel: userShortInfoModel[0],
              index: i,
            ));
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
                height: (42 * MediaQuery.of(context).size.height) / 100,
                fit: BoxFit.cover,
                placeholder: 'assets/no_image.jpg',
                image: userShortInfoModel[0].response.data[i]?.dp?.photoName !=
                        ''
                    ? APis().imageApi(
                        userShortInfoModel[0].response.data[i]?.dp?.photoName,
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
                  left: 5,
                  top: 5,
                  child: InkWell(
                      radius: 50.0,
                      splashColor: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(50.0),
                      onTap: () {
                        print("Premium!");
                      },
                      child: GlobalWidgets().iconCreator(
                          "assets/Profile/Badge.png",
                          size: FixedIconSize.SMALL))),
              Positioned(
                  right: 10,
                  top: 5,
                  child: ShareProfileBtn(
                      membershipCode: userShortInfoModel[0]
                          .response
                          .data[i]
                          .membershipCode)),
              Positioned(
                right: 10,
                top: 35,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    radius: 50.0,
                    splashColor: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(50.0),
                    onTap: () {
                      callAction(
                          "Shortlisting",
                          "shortlist_cause",
                          "shortlist",
                          userShortInfoModel[0].response.data[i].id,
                          userShortInfoModel[0]
                              .response
                              .data[i]
                              .membershipCode);
                    },
                    child: GlobalWidgets().iconCreator(
                        "assets/Profile/Shortlist.png",
                        size: FixedIconSize.SMALL),
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
                              '${userInfo.name.toString().capitalize} '
                              '${userInfo.lastName?.substring(0, 1).toString().capitalize}',
                              size: 16.0,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8,
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
                              GlobalWidgets().getAge(
                                userShortInfoModel[0].response.data[i].info.dob,
                              ),
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                              textScaleFactor: .8,
                              size: 12,
                            ),
                            TextView(
                              ", ${userShortInfoModel[0].response.data[i].info.city}",
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
                      userShortInfoModel[0].response.data[i].score.toString() ==
                              ''
                          ? '0'
                          : userShortInfoModel[0]
                              .response
                              .data[i]
                              .score
                              .toString(),
                      userId:
                          userShortInfoModel[0].response.data[i].id.toString(),
                      profileImg:
                          userShortInfoModel[0].response.data[i]?.dp?.photoName,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }, growable: true);
}

generalMixMatchCard(
    UserShortInfoModel userShortInfoModel, BuildContext context) {
  bool isVerified = false;
  return List<Widget>.generate(userShortInfoModel.response?.data?.length ?? 0,
      (i) {
    if (userShortInfoModel.response?.data![i].officialDocuments != null) {
      isVerified = (userShortInfoModel
                      .response?.data![i].officialDocuments?.govtIdStatus ??
                  0) &
              (userShortInfoModel
                      .response?.data![i].officialDocuments?.officeIdStatus ??
                  0) &
              (userShortInfoModel
                      .response?.data![i].membership?.verificationBadge ??
                  0) ==
          1;
    }
    return SizedBox(
      width: 200.0,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/profileSwitch',
              arguments: ProfileSwitch(
                memberShipCode:
                    userShortInfoModel.response?.data![i].membershipCode,
                userShortInfoModel: userShortInfoModel,
                index: i,
              ));
        },
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            clipBehavior: Clip.antiAlias,
            elevation: 3.0,
            child: Stack(
              children: <Widget>[
                FadeInImage.assetNetwork(
                  width: 400,
                  height: (30 * MediaQuery.of(context).size.height) / 100,
                  fit: BoxFit.cover,
                  placeholder: 'assets/no_image.jpg',
                  image: userShortInfoModel.response?.data![i].dp?.photoName !=
                          ''
                      ? APis().imageApi(
                          userShortInfoModel.response?.data![i].dp?.photoName,
                          imageConversion: ImageConversion.MEDIA)
                      : '',
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black87,
                          ],
                          stops: [
                            0.25,
                            0.50,
                            0.68,
                            1.0
                          ],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter)),
                ),
                Positioned(
                    right: 5,
                    top: 5,
                    child: ShareProfileBtn(
                        membershipCode: userShortInfoModel
                            .response?.data![i].membershipCode)),
                Positioned(
                  bottom: 5,
                  left: 10.0,
                  right: 10.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Flexible(
                                  flex: 9,
                                  child: TextView(
                                    '${userShortInfoModel.response?.data![i].name.toString().capitalize} '
                                    '${userShortInfoModel.response?.data![i].lastName?.substring(0, 1).toString().capitalize}',
                                    size: 16.0,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: .8,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Flexible(
                                    flex: 1,
                                    child: isVerified
                                        ? GlobalWidgets().iconCreator(
                                            "assets/Profile/Verifid2.png",
                                            size: FixedIconSize.SMALL)
                                        : Container())
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                      ),
                      Flexible(
                        flex: 2,
                        child: HeartPercentage(
                          userShortInfoModel.response?.data![i].score
                                      .toString() ==
                                  ''
                              ? '0'
                              : userShortInfoModel.response?.data![i].score
                                  .toString(),
                          userId: userShortInfoModel.response?.data![i].id
                              .toString(),
                          profileImg: userShortInfoModel
                              .response?.data![i].dp?.photoName,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }, growable: true);
}
