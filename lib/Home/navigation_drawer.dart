import 'package:coupled/CMS/AboutCoupled.dart';
import 'package:coupled/CMS/ContactUs.dart';
import 'package:coupled/CMS/Settings.dart';
import 'package:coupled/Home/Profile/profile_switch.dart';
import 'package:coupled/PlansAndPayment/MembershipPlans/view/MembershipPlans.dart';
import 'package:coupled/PlansAndPayment/MyPlansandPayments/view/MyPlansAndPayment.dart';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/user_short_info_model.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndDrawer extends StatefulWidget {
  final ValueGetter<Future<bool>> onTap;

  EndDrawer({required this.onTap});

  @override
  State<StatefulWidget> createState() {
    return EndDrawerScreen();
  }
}

class EndDrawerScreen extends State<EndDrawer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //  print("object :**** ${widget.profileResponse}");

    List<Map> drawerMenuList = [
      {'isSelected': true, 'name': 'My Profile', 'navigate': ''},
      {
        'isSelected': false,
        'name': GlobalData.myProfile.membership?.paidMember ?? false
            ? 'My Plans And Payments'
            : 'Become A Member',
        'navigate': ''
      },
      {'isSelected': false, 'name': 'Match Maker', 'navigate': '/matchMaker'},
      {'isSelected': false, 'name': 'Settings', 'navigate': ''},
      {'isSelected': false, 'name': 'About Coupled', 'navigate': ''},
      {'isSelected': false, 'name': 'Contact Us', 'navigate': ''},
      {'isSelected': false, 'name': 'Logout', 'navigate': ''},
    ];

    return Builder(
      builder: (context) {
        return Container(
          alignment: Alignment.topRight,
          color: CoupledTheme().backgroundColor,
          padding: EdgeInsets.all(5.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: ListView.builder(
              //physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: drawerMenuList.length,
              padding: EdgeInsets.only(right: 10.0),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
//                      setState(() async {
                    drawerMenuList.forEach((value) {
                      value['isSelected'] = false;
                    });
                    drawerMenuList[index]['isSelected'] = true;
                    await widget.onTap();
                    switch (index) {
                      case 0:
                        Navigator.pushNamed(context, '/profileSwitch',
                            arguments: ProfileSwitch(
                              memberShipCode: 'null',
                              userShortInfoModel: UserShortInfoModel(
                                  response: UserShortInfoResponse.fromJson({})),
                            ));

                        break;

                      case 1:
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                GlobalData.myProfile.membership!.paidMember ??
                                        false
                                    ? MyPlansAndPayment()
                                    : MembershipPlans(),
                          ),
                        );
                        break;

                      case 2:
                        Navigator.of(context)
                            .pushNamed(drawerMenuList[index]['navigate']);
                        break;

                      case 3:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Settings()));
                        break;
                      case 4:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AboutCoupled()));
                        break;
                      case 5:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ContactUs()));
                        break;
                      case 6:
                        /*SharedPreferences.getInstance().then((pref) {
                          //pref.setString("accessToken", null);
                          pref.clear();
                        });*/
                        /*SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.clear();*/

                        Map<String, String> params = {
                          "device_type": 'mobile_app',
                        };

                        signOut(APis.signOut, params, _scaffoldKey, context);

                        break;
                    }
                    //print("object");
//                      });
                  },
                  child: drawerMenuList[index]['name'] == 'My Profile'
                      ? buildProfileTile()
                      : ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: TextView(
                            drawerMenuList[index]['name'],
                            size: drawerMenuList[index]['isSelected']
                                ? 22.0
                                : 18.0,
                            textAlign: TextAlign.end,
                            color:
                                /* drawerMenuList[index]['isSelected']
                                ? CoupledTheme().primaryBlue
                                : */
                                Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.visible,
                            textScaleFactor: .8,
                          ),
                        ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  buildProfileTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: GlobalData.myProfile.dp!.photoName != null
                ? Image.network(
                    APis().imageApi(
                      GlobalData.myProfile.dp!.photoName ?? '',
                      imageConversion: ImageConversion.MEDIA,
                      //imageSize: 200,
                    ),
                    height: 100,
                    width: 100,
                  )
                : Image.asset('assets/no_image.jpg'),
          ),
          ListTile(
            dense: true,
            //contentPadding: EdgeInsets.zero,
            title: FittedBox(
                fit: BoxFit.fitWidth,
                child: TextView(
                  "${toBeginningOfSentenceCase(GlobalData.myProfile.name ?? '')} ${GlobalData.myProfile.lastName ?? ''}",
                  textAlign: TextAlign.center,
                  color: GlobalData.myProfile.gender.toLowerCase() == 'male'
                      ? CoupledTheme().primaryBlue
                      : CoupledTheme().primaryPink,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible,
                  textScaleFactor: .8,
                  size: 12,
                )),
            subtitle: TextView(
              GlobalData.myProfile.membershipCode ?? '',
              textAlign: TextAlign.center,
              color: Colors.grey,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              textScaleFactor: 1,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }

  void signOut(String url, Map<String, String> params,
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) async {
    var response =
        await RestAPI().post(url, params: params).catchError((onError) {});

    if (response != null) {
      Navigator.of(context).pushNamed('/startMain');
      print("logout");
    }
  }

  ///assets/drawerMenu/checklist.svg
  ///assets/drawerMenu/disc.svg
  ///assets/drawerMenu/document_.svg
  ///assets/drawerMenu/gear.svg
  ///assets/drawerMenu/meter.svg
  ///assets/drawerMenu/return.svg

}
