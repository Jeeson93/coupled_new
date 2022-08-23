import 'package:coupled/Home/Profile/profile_switch.dart';
import 'package:coupled/MatchMeter/bloc/mom_bloc.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

class SpeciallyAbledList extends StatefulWidget {
  @override
  _SpeciallyAbledListState createState() => _SpeciallyAbledListState();
}

class _SpeciallyAbledListState extends State<SpeciallyAbledList> {
  MomBloc momBloc = MomBloc();
  MomDatum speciallyAbled = MomDatum(
    mom: MomM(),
    momReasons: [],
    partner: PartnerDetails(
        dp: Dp(
            photoName: '',
            imageType: BaseSettings(options: []),
            imageTaken: BaseSettings(options: []),
            userDetail: UserDetail(membership: Membership(paidMember: false))),
        info: Info(maritalStatus: BaseSettings(options: [])),
        photos: []),
  );
  List<Datum> listDatum = [];

  @override
  void initState() {
    momBloc = MomBloc();
    momBloc.add(LoadSpecially());
    super.initState();
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
                  "Specially Abled Requests",
                  size: 18,
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
            bloc: momBloc,
            builder: (context, state) {
              if (state is MoMErrorState)
                return GlobalWidgets().errorState(message: state.errorMessage);
              if (state is LoadedSpecially) {
                GlobalData?.speciallyAbled.response?.data!.forEach((element) {
                  listDatum.add(
                    Datum(
                      membershipCode: element.user?.membershipCode,
                      info: element.user?.info,
                      name: element.user?.name,
                      lastName: element.user?.lastName,
                      dp: element.user?.dp,
                      membership: Membership(paidMember: false),
                      officialDocuments: OfficialDocuments(),
                      purchasePlan: Plan(topups: []),
                    ),
                  );
                });

                return ListView.builder(
                    itemCount: GlobalData.speciallyAbled.response?.data!.length,
                    itemBuilder: (context, index) {
                      speciallyAbled =
                          GlobalData.speciallyAbled.response!.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profileSwitch',
                              arguments: ProfileSwitch(
                                index: index,
                                userShortInfoModel: UserShortInfoModel(
                                    response: UserShortInfoResponse(
                                  data: listDatum,
                                )),
                                memberShipCode: GlobalData
                                    .speciallyAbled
                                    .response
                                    ?.data![index]
                                    .user
                                    ?.membershipCode,
                              ));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 12, bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(60.0),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: FadeInImage.assetNetwork(
                                        height: 300,
                                        fit: BoxFit.cover,
                                        placeholder: 'assets/no_image.jpg',
                                        image: APis().imageApi(
                                          speciallyAbled.user?.dp?.photoName ??
                                              "",
                                          imageConversion:
                                              ImageConversion.THUMB,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 7,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          TextView(
                                            speciallyAbled.momStatus ==
                                                    'request'
                                                ? 'Requested'
                                                : speciallyAbled.momStatus ==
                                                        'accept'
                                                    ? 'Accepted'
                                                    : 'Rejected',
                                            size: 16,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextView(
                                            speciallyAbled.momStatus ==
                                                    'request'
                                                ? 'You have received a specially able request from ${speciallyAbled.user?.name}'
                                                : speciallyAbled.momStatus ==
                                                        'accept'
                                                    ? 'Your details will be visible to the ${speciallyAbled.user?.name}'
                                                    : 'Your details will not be disclosed to the ${speciallyAbled.user?.name}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            size: 14,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: TextView(
                                            formatDate(speciallyAbled.createdAt,
                                                [dd, '.', mm, '.', yy]),
                                            size: 12,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        CustomButton(
                                          enabled: speciallyAbled.momStatus ==
                                              'request',
                                          width: 40,
                                          onPressed: () {
                                            Dialogs().showDialogSpeciallyAbled(
                                                context,
                                                index: index,
                                                momBloc: momBloc);
                                            /* Navigator.pushNamed(context, '/recommendation',
                                      arguments: Recommendations(profileResponse: profileResponse));*/
                                          },
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          gradient: LinearGradient(colors: [
                                            CoupledTheme().primaryPinkDark,
                                            CoupledTheme().primaryPink
                                          ]),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: TextView(
                                              "View",
                                              size: 12,
                                              color: Colors.white,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.visible,
                                              textAlign: TextAlign.center,
                                              textScaleFactor: .8,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: CoupledTheme().inactiveColor,
                              height: 1,
                            )
                          ],
                        ),
                      );
                    });
              }
              return GlobalWidgets().showCircleProgress();
            }));
  }
}
