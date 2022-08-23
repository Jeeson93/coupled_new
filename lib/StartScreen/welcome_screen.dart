import 'package:coupled/Utils/capitalize_string.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/registration_new/controller/page_controller.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatefulWidget {
  static String route = 'WelcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: CoupledTheme().backgroundColor,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomPadding: true,
        backgroundColor: CoupledTheme().backgroundColor,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.scaleDown,
              alignment: FractionalOffset.topCenter,
              image: AssetImage('assets/welcome_back_img.jpg'),
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.width * .85,
                    ),
                    TextView(
                      "Hello ${GlobalData.myProfile.name.toString().capitalize},",
                      textAlign: TextAlign.center,
                      size: 34.0,
                      color: CoupledTheme().primaryPink,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textScaleFactor: .8,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextView(
                      "Thanks for believing in Coupled.\n\nYour solo rides are going to turn in long drives with your soul partner sooner.",
                      size: 18.0,
                      lineSpacing: 1.5,
                      textAlign: TextAlign.center,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textScaleFactor: .8,
                      color: Colors.white,
                      maxLines: 10,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                      child: Icon(
                        Icons.chevron_right,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        print("from welcome screen");
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);

                        ///TODO page controller
                        regPageController(
                          context,
                        );

                        /*  Navigator.pushNamed(context, PersonalDetails.route,
                        arguments: PersonalDetails(
                          profileEdit: false,
                        ));*/
                      },
                      height: 40.0,
                      width: 40.0,
                      borderRadius: BorderRadius.circular(100.0),
                      gradient: LinearGradient(colors: [
                        CoupledTheme().primaryBlue,
                        CoupledTheme().primaryBlue
                      ]),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
