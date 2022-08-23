// import 'package:coupled/Actions/shareView.dart';
// import 'package:coupled/Profile/ProfileSwitch.dart';
// import 'package:coupled/Src/REST/RestAPI.dart';
// import 'package:coupled/Src/models/UserShortInfoModel.dart';
// import 'package:coupled/Utils/globalWidgets.dart';
// import 'package:coupled/models/user_short_info_model.dart';
// import 'package:flutter/material.dart';
// import 'package:coupled/Utils/capitalize_string.dart';
import 'package:coupled/Actions/share_view.dart';
import 'package:coupled/Home/Profile/profile_switch.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:flutter/material.dart';
import 'package:coupled/Utils/capitalize_string.dart';

generalCard(UserShortInfoModel userShortInfoModel, BuildContext context) {
  print('userShortInfoModel-------');
  print(userShortInfoModel);
  bool isVerified = false;
  return List<Widget>.generate(userShortInfoModel.response?.data?.length ?? 0,
      (i) {
    if (userShortInfoModel.response?.data![i].officialDocuments != null) {
      isVerified = (userShortInfoModel
                      .response?.data![i].officialDocuments!.govtIdStatus ??
                  0) &
              (userShortInfoModel
                      .response?.data![i].officialDocuments!.officeIdStatus ??
                  0) &
              (userShortInfoModel
                      .response?.data![i].membership!.verificationBadge ??
                  0) ==
          1;
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/profileSwitch',
          arguments: ProfileSwitch(
            memberShipCode:
                userShortInfoModel.response?.data![i].membershipCode,
            userShortInfoModel: userShortInfoModel,
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
                height: 300,
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
                          Colors.black12,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black87,
                        ],
                        stops: [
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
                      membership:
                          userShortInfoModel.response?.data![i].membership,
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
                      flex: 8,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                                  '${userShortInfoModel.response?.data![i].name.toString().capitalize}'
                                  ' ${userShortInfoModel.response?.data![i].lastName?.substring(0, 1).toString().capitalize}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  size: 16.0,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: TextView(
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                  "${GlobalWidgets().getAge(userShortInfoModel.response?.data![i].info!.dob ?? DateTime.now()).trimRight()}",
                                  overflow: TextOverflow.visible,
                                  size: 12,
                                ),
                              ),
                              Flexible(
                                flex: 8,
                                child: TextView(
                                  ", ${userShortInfoModel.response?.data![i].info!.city}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                  size: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      flex: 2,
                      child: HeartPercentage(
                        userShortInfoModel.response?.data![i].score
                                .toString() ??
                            '0',
                        userId:
                            userShortInfoModel.response?.data![i].id.toString(),
                        profileImg:
                            userShortInfoModel.response?.data![i].dp?.photoName,
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  });
}
