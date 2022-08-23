import 'package:coupled/Home/Profile/profile_switch.dart';
import 'package:coupled/REST/RestAPI.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

similarProfiles(UserShortInfoModel userShortInfoModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextView(
          "Similar Profiles",
          size: 16,
          color: Colors.white,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          textScaleFactor: .9,
        ),
      ),
      Container(
        height: 200,
        child: ListView.builder(
          itemExtent: 170,
          itemCount: userShortInfoModel.response != null
              ? userShortInfoModel.response?.data?.length
              : 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  print(
                      "MEMBER :::: ${userShortInfoModel.response?.data![index].membershipCode}");
                  Navigator.pushNamed(context, '/profileSwitch',
                      arguments: ProfileSwitch(
                        memberShipCode: userShortInfoModel
                            .response?.data![index].membershipCode,
                        index: index,
                        userShortInfoModel: userShortInfoModel,
                      ));
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.transparent,
                  height: 200,
                  width: 160,
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(12),
                        child: FadeInImage.assetNetwork(
                          height: 200,
                          width: 160,
                          fit: BoxFit.cover,
                          placeholder: 'assets/no_image.jpg',
                          image: APis().imageApi(
                              userShortInfoModel
                                  .response?.data?[index].dp?.photoName,
                              imageConversion: ImageConversion.MEDIA),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            gradient: const LinearGradient(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 9,
                                        child: TextView(
                                          '${toBeginningOfSentenceCase(userShortInfoModel.response?.data![index].name)} ${userShortInfoModel.response?.data![index].lastName != null ? toBeginningOfSentenceCase(userShortInfoModel.response?.data![index].lastName![0]) : ''}',
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
                                      userShortInfoModel.response?.data![index]
                                                      .govtIdStatus &
                                                  userShortInfoModel
                                                      .response
                                                      ?.data![index]
                                                      .linkedinIdStatus &
                                                  userShortInfoModel
                                                      .response
                                                      ?.data![index]
                                                      .govtIdStatus ==
                                              1
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
                                      Flexible(
                                        flex: 2,
                                        child: TextView(
                                          userShortInfoModel
                                                      .response
                                                      ?.data![index]
                                                      .info
                                                      ?.dob !=
                                                  null
                                              ? "${GlobalWidgets().getAge(userShortInfoModel.response?.data![index].info?.dob)},"
                                              : '',
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          textScaleFactor: .8,
                                          size: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Flexible(
                                          flex: 8,
                                          child: TextView(
                                            userShortInfoModel.response
                                                    ?.data![index].city ??
                                                '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            size: 12,
                                          )),
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
                                "0",
                                userId: userShortInfoModel
                                    .response?.data![index].id
                                    .toString(),
                                profileImg: userShortInfoModel
                                    .response?.data![index].dp?.photoName,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}
