import 'package:coupled/Home/Profile/profile_switch.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/notification_model.dart';
import 'package:coupled/models/photo_model.dart';
import 'package:coupled/models/plans_and_payment_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatefulWidget {
  final NotificationModelDatum data;

  NotificationItem({required this.data});

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  List routs = [
    '/membershipPlans',
    '/myPlanPayments',
    '/profileSwitch',
    '/specially_request',
    '/chatViewMain',
    '/tolHome',
    '/myprofile'
  ];

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.data.read == 1 ? 0.5 : 1,
      child: GestureDetector(
        onTap: () {
          print('widget.data.doneBy-------');
          print(widget.data.doneBy);
          print(GlobalData.myProfile.membershipCode);
          print(widget.data.type);
          GlobalData.othersProfile = ProfileResponse(
              membershipCode: widget.data.doneBy.membershipCode.toString(),
              name: widget.data.doneBy.name.toString(),
              dp: Dp(
                photoName: widget.data.doneBy.profilePic.toString(),
                imageTaken: BaseSettings(options: []),
                imageType: BaseSettings(options: []),
                userDetail:
                    UserDetail(membership: Membership(paidMember: false)),
              ),
              usersBasicDetails: UsersBasicDetails(),
              mom: Mom(),
              preference: Preference(complexion: BaseSettings(options: [])),
              info: Info(maritalStatus: BaseSettings(options: [])),
              officialDocuments: OfficialDocuments(),
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
              blockMe: Mom(),
              reportMe: Mom(),
              freeCoupling: [],
              recomendCause: [],
              shortlistByMe: Mom(),
              shortlistMe: Mom(),
              photoModel: PhotoModel(),
              currentCsStatistics: CurrentCsStatistics(),
              siblings: []);
          Navigator.pushNamed(
              context,
              widget.data.type == 'plans'
                  ? routs[0]
                  : widget.data.type == 'my_plans'
                      ? routs[1]
                      : widget.data.type == 'specially_request'
                          ? routs[3]
                          : widget.data.type == 'chat' ||
                                  widget.data.type == 'tokenoflove' ||
                                  widget.data.type == 'tokenoflove_request' ||
                                  widget.data.type == 'tokenoflove_reject'
                              ? routs[4]
                              : widget.data.type == 'tokenoflove_accept'
                                  ? routs[5]
                                  : widget.data.type == 'user_registration'
                                      ? routs[6]
                                      /*: widget.data.type == 'share'
                                          ? routs[6]*/
                                      : widget.data.doneBy.membershipCode
                                                  .toString() ==
                                              GlobalData
                                                  .myProfile.membershipCode
                                                  .toString()
                                          ? routs[6]
                                          : routs[2],
              arguments: ProfileSwitch(
                memberShipCode:
                    widget.data.doneBy.membershipCode.toString() ?? "",
                index: 0,
                userShortInfoModel: UserShortInfoModel(
                    response: UserShortInfoResponse(data: [
                  Datum(
                    membershipCode: widget.data.doneBy.membershipCode ?? "",
                    dp: Dp(
                        photoName: '',
                        imageType: BaseSettings(options: []),
                        imageTaken: BaseSettings(options: []),
                        userDetail: UserDetail(
                            membership: Membership(paidMember: false))),
                    info: Info(maritalStatus: BaseSettings(options: [])),
                    membership: Membership(paidMember: false),
                    officialDocuments: OfficialDocuments(),
                  )
                ])),
              ));
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 12, bottom: 12),
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
                      child: Padding(
                        padding: widget.data.mode == 'coupled'
                            ? const EdgeInsets.all(12.0)
                            : const EdgeInsets.all(0.0),
                        child: widget.data.mode == 'coupled'
                            ? Image.asset(
                                "assets/logo/mini_logo_pink.png",
                                width: 2,
                                height: 2,
                              )
                            : widget.data.doneBy.profilePic != null
                                ? FadeInImage.assetNetwork(
                                    height: 300,
                                    fit: BoxFit.cover,
                                    placeholder: 'assets/no_image.jpg',
                                    image: APis().imageApi(
                                      widget.data.doneBy.profilePic.toString(),
                                      imageConversion: ImageConversion.MEDIA,
                                    ),
                                  )
                                : Image.asset('assets/no_image.jpg'),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextView(
                            widget.data.title.toString(),
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
                            widget.data.content.toString(),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            size: 14,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.left,
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
                            formatDate(
                                widget.data.createdAt, [dd, '.', mm, '.', yy]),
                            size: 12,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                          ),
                        ),
                        /*  SizedBox(height: 5,),
                        CustomButton(
                          width: 40,
                          onPressed: () {
                            Dialogs().showDialogSpeciallyAbled(context);
                           */ /* Navigator.pushNamed(context, '/recommendation',
                                arguments: Recommendations(profileResponse: profileResponse));*/ /*
                          },
                          borderRadius: BorderRadius.circular(6.0),
                          gradient:
                          LinearGradient(colors: [CoupledTheme().primaryPinkDark, CoupledTheme().primaryPink]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: TextView(
                              "View",
                              size: 12,
                            ),
                          ),
                        ),*/
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
      ),
    );
  }
}
