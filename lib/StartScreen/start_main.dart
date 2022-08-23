import 'dart:async';
import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/StartScreen/facebook_sign.dart';
import 'package:coupled/StartScreen/forgot_password.dart';
import 'package:coupled/StartScreen/google_sign.dart';
import 'package:coupled/StartScreen/sign_up_form.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/carosal_pro.dart';
import 'package:coupled/Utils/error_checkpoint.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/registration_new/controller/registration_redirection.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartMain extends StatefulWidget {
  const StartMain({Key? key}) : super(key: key);

  @override
  State<StartMain> createState() => _StartMainState();
}

class _StartMainState extends State<StartMain>
    with SingleTickerProviderStateMixin {
  var i = 0;
  bool _validate = true;
  bool _isVisibility = true;
  Color iconColor = Color(0xff536fb7);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _fadeOut, _fadeIn;
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp('');
  PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;

  bool popUpPassword = false;
  bool isLoggedIn = false;
  var profileData;
  var d;
  StreamController<bool> autoPlay = StreamController();
  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    _fadeOut = Tween(begin: 1.0, end: 0.0).animate(_controller);
    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(_controller);
    regex = RegExp(pattern.toString());
    super.initState();
  }

  //Animation..
  Animation<Offset> slideTransmit(
      Offset _begin, Offset _end, AnimationController _controller) {
    Animation<Offset> anime;
    Animatable<Offset> animeOffset = Tween<Offset>(
      begin: _begin,
      end: _end,
    ).chain(
      CurveTween(
        curve: Curves.fastOutSlowIn,
      ),
    );
    anime = _controller.drive(animeOffset);
    return anime;
  }

  //Animation carosal
  List<Widget> dummy() {
    print("Called");
    List<Map<String, dynamic>> quotes = [
      {
        "quote": "Self-made and managed profiles of matured individuals",
        "icon": "assets/quotesIcon/users.png"
      },
      {
        "quote": "Find similarities & differences through Coupling Score",
        "icon": "assets/quotesIcon/love.png"
      },
      {
        "quote": "Converse, earn roses and surprise with ‘Token of Love’",
        "icon": "assets/quotesIcon/gift.png"
      },
      {
        "quote": "Clear, up-to-date, variety of Photographs",
        "icon": "assets/quotesIcon/camera.png"
      },
      {
        "quote": "Economical & flexible plans with one-time membership",
        "icon": "assets/quotesIcon/plan.png"
      }
    ];
    return List<Widget>.generate(5, (i) {
      return Container(
        padding: const EdgeInsets.only(left: 45.0, right: 45.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ImageIcon(
              AssetImage(quotes[i]["icon"]),
              size: 50.0,
              color: iconColor,
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
            ),
            Flexible(
              child: TextView(
                quotes[i]["quote"],
                color: iconColor,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
                overflow: TextOverflow.visible,
                size: 12,
                textScaleFactor: .8,
              ),
            ),
          ],
        ),
      );
    });
  }

  var text = "Couple In/";
  bool isLoading = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onback() {
    setState(() {
      //text = "Couple In/Up";
      passwordController.clear();
      popUpPassword = false;
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return onback();
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Color(0xFFC9E2F6),
            ),
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: const Color(0xFFC9E2F6),
              body: SafeArea(
                  child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Opacity(
                      opacity: isLoading ? 0.5 : 1,
                      child: IgnorePointer(
                        ignoring: isLoading,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            alignment: FractionalOffset.topCenter,
                            image: AssetImage('assets/reg_back_img.png'),
                          )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: MediaQuery.of(context).size.width * .65,
                              ),
                              TextView(
                                "Love Matures Here...",
                                color: CoupledTheme().primaryPink,
                                size: 28.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width / 6,
                              ),
                              Center(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    // Note: Styles for TextSpans must be explicitly defined.
                                    // Child text spans will inherit styles from parent
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: CoupledTheme().primaryPink,
                                      fontFamily: "Bariol",
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: text,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          )),
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => Navigator.pushNamed(
                                                context, '/coupleUpPage'),
                                          text: "Couple Up",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              FadeTransition(
                                opacity: _fadeOut,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 15.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                context: context,
                                                builder: (builder) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    height: 50,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    color: Colors.black,
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Facebook Login ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          MaterialButton(
                                                            onPressed: () {
                                                              FacebookLogincreate()
                                                                  .handleFacebookSignIn(
                                                                      _scaffoldKey,
                                                                      context)
                                                                  .then((value) =>
                                                                      GlobalWidgets().showSnackBar(
                                                                          _scaffoldKey,
                                                                          'Facebook Login.....'));
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .login_outlined,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Color(0xff3a589b),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset(
                                                    'assets/facebook_icon.png',
                                                    width: 30.0,
                                                    height: 20.0,
                                                    fit: BoxFit.cover),
                                                FittedBox(
                                                  fit: BoxFit.fitHeight,
                                                  child: TextView(
                                                    "Facebook",
                                                    textAlign: TextAlign.center,
                                                    size: 16.0,
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    textScaleFactor: .8,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25.0,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                context: context,
                                                builder: (builder) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    height: 50,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    color: Colors.black,
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Google Login ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          MaterialButton(
                                                            onPressed: () {
                                                              CoupledGoogleSignIn()
                                                                  .handleGoogleSignIn(
                                                                      _scaffoldKey,
                                                                      context)
                                                                  .then((value) =>
                                                                      GlobalWidgets().showSnackBar(
                                                                          _scaffoldKey,
                                                                          'Google Login Progress.....'));
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .login_outlined,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Color(0xff2d78bb),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                //    Icon(Icons.go),
                                                Image.asset('assets/google.png',
                                                    width: 25.0,
                                                    fit: BoxFit.cover),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: TextView(
                                                    "Google",
                                                    textAlign: TextAlign.center,
                                                    size: 16.0,
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    textScaleFactor: .8,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SlideTransition(
                                position: slideTransmit(const Offset(0.0, 0.3),
                                    const Offset(0.0, -1.0), _controller),
                                child: Container(
                                  height: 40.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 15.0),
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.white),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: EditText(
                                          controller: emailController,
                                          hint: "Enter email or phone",
                                          size: 16.0,
                                          textAlign: TextAlign.center,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          hintColor: Color(0xff808080),
                                          textColor: Colors.black,
                                          obscureText: false,
                                          suffixIcon: Image.asset(
                                              'assets/logo/mini_logo_pink.png',
                                              width: 25.0,
                                              height: 25.0,
                                              fit: BoxFit.contain),
                                        ),
                                      ),
                                      FadeTransition(
                                        opacity: _fadeOut,
                                        child: Material(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0)),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            onTap: () {
                                              setState(() {
                                                if (emailController.text ==
                                                    "") {
                                                  GlobalWidgets().showSnackBar(
                                                    _scaffoldKey,
                                                    "Enter an email or phone",
                                                  );
                                                  _validate = false;
                                                } else {
                                                  _validate = ErrorCheckPoint()
                                                      .validateEoM(_scaffoldKey,
                                                          emailController.text);
                                                  if (_validate) {
                                                    var type;
                                                    if (emailController.text !=
                                                            null &&
                                                        regex.hasMatch(
                                                            emailController
                                                                .text)) {
                                                      type = "email";
                                                    } else
                                                      type = "phone";
                                                    Map<String, String> params =
                                                        {
                                                      "type": type,
                                                      emailController.text !=
                                                                      null &&
                                                                  regex.hasMatch(
                                                                      emailController
                                                                          .text)
                                                              ? "email"
                                                              : "phone":
                                                          emailController.text,
                                                      "client_id":
                                                          RestAPI.clientId,
                                                      "device_type":
                                                          'mobile_app',
                                                      "client_secret":
                                                          RestAPI.clientSecret
                                                    };

                                                    setState(() {
                                                      isLoading = true;
                                                    });

                                                    RestAPI()
                                                        .post(APis.existingUser,
                                                            params: params)
                                                        .then((onValue) async {
                                                      print(onValue);

                                                      setState(() {
                                                        isLoading = false;
                                                        //text = "Couple In";
                                                      });
                                                      popUpPassword = true;
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      d = prefs.getString(
                                                          "accountdeactivate");
                                                      print("dark");
                                                      print(d);
                                                      _controller.forward();
                                                    }).catchError((onError) {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      print(
                                                          "Error : ${onError.message['response']}");
                                                      GlobalWidgets().showSnackBar(
                                                          _scaffoldKey,
                                                          onError['response']
                                                              ['msg'],
                                                          actions:
                                                              SnackBarAction(
                                                                  label:
                                                                      "Sign Up",
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  onPressed:
                                                                      () {
                                                                    var route =
                                                                        MaterialPageRoute(
                                                                            builder: (BuildContext context) =>
                                                                                SignUpForm(
                                                                                  data: emailController.text,
                                                                                ));
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                            route);
                                                                  }));
                                                    });
                                                  } else {
                                                    print("validate error");
                                                  }
                                                }
                                              });
                                            },
                                            child: CustomButton(
                                                height: 30.0,
                                                width: 30.0,
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                child: Icon(
                                                  Icons.chevron_right,
                                                  size: 25.0,
                                                  color: Colors.white,
                                                ),
                                                onPressed:
                                                    null) /*Material(
                                            elevation: 2.0,
                                            color: CoupledTheme().activeColor,
                                            borderRadius: BorderRadius.circular(50.0),
                                            child: Container(
                                              width: 30.0,
                                              height: 30.0,
                                              child:  Icon(
                                                Icons.chevron_right,
                                                size: 25.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )*/
                                            ,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SlideTransition(
                                position: slideTransmit(const Offset(0.0, 0.0),
                                    const Offset(0.0, -1.0), _controller),
                                child: FadeTransition(
                                  opacity: d ==
                                          "Account deactivate. Contact coupled care"
                                      ? _fadeOut
                                      : _fadeIn,
                                  child: Visibility(
                                    visible: popUpPassword,
                                    maintainState: true,
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    child: Container(
                                      height: 40.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 15.0),
                                      padding: EdgeInsets.only(
                                          left: 15.0, right: 5.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          color: Colors.white),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: EditText(
                                              controller: passwordController,
                                              hint: "Password",
                                              size: 16.0,
                                              obscureText: _isVisibility,
                                              showObscureIcon: true,
                                              textAlign: TextAlign.center,
                                              hintColor: Color(0xff808080),
                                              textColor: Colors.black,
                                              suffixIcon: const Icon(
                                                Icons.lock,
                                                size: 20.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5.0,
                                          ),
                                          CustomButton(
                                              child: Icon(Icons.chevron_right,
                                                  size: 25.0,
                                                  color: Colors.white),
                                              width: 30.0,
                                              height: 30.0,
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              onPressed: () {
                                                if (ErrorCheckPoint()
                                                    .validatePassword(
                                                        _scaffoldKey,
                                                        passwordController
                                                            .text)) {
                                                  Map<String, String> params = {
                                                    "username":
                                                        emailController.text,
                                                    "password":
                                                        passwordController.text,
                                                    "grant_type": "password",
                                                    "device_type": 'mobile_app',
                                                    "client_id":
                                                        RestAPI.clientId,
                                                    "client_secret":
                                                        RestAPI.clientSecret,
                                                    "firebase_token":
                                                        GlobalData.fcmToken,
                                                  };
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  signIN(APis.signIn, params,
                                                      _scaffoldKey, context);
                                                }
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SlideTransition(
                                position: slideTransmit(Offset(0.0, 0.0),
                                    Offset(0.0, -1.2), _controller),
                                child: FadeTransition(
                                  opacity: _fadeIn,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 15.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            radius: 50.0,
                                            splashColor: Colors.white24,
                                            onTap: () => onback(),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.chevron_left,
                                                  size: 30.0,
                                                  color: CoupledTheme()
                                                      .primaryPink,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: TextView(
                                                    "Back",
                                                    color: CoupledTheme()
                                                        .primaryPink,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    size: 12,
                                                    textAlign: TextAlign.center,
                                                    textScaleFactor: .8,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 15.0),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              var route = MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ForgotPassword(
                                                            data:
                                                                emailController
                                                                    .text,
                                                          ));
                                              Navigator.of(context).push(route);
                                            },
                                            child: TextView(
                                              "Forgot Password?",
                                              color: CoupledTheme().primaryPink,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.visible,
                                              size: 12,
                                              textAlign: TextAlign.center,
                                              textScaleFactor: .8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SlideTransition(
                                position: slideTransmit(Offset(0.0, -0.3),
                                    Offset(0.0, 0.0), _controller),
                                child: Column(
                                  children: <Widget>[
                                    LimitedBox(
                                      maxHeight: 150.0,
                                      maxWidth: 300.0,
                                      child: Carousel(
                                        widget: dummy(),
                                        controller: _pageController,
                                        animationCurve: Curves.ease,
                                        moveIndicatorFromBottom: 5.0,
//		                      autoplayDuration: Duration(milliseconds: 1500),
                                        animationDuration:
                                            Duration(milliseconds: 1500),
                                        dotsDecorator: DotsDecorator(
                                            size: const Size.fromRadius(5.0),
                                            spacing: EdgeInsets.all(5.0),
                                            color: Colors.transparent,
                                            activeColor:
                                                CoupledTheme().primaryBlueDark,
                                            activeSize:
                                                const Size.fromRadius(5.0),
                                            shape: CircleBorder(
                                                side: BorderSide(
                                                    color: CoupledTheme()
                                                        .primaryBlueDark)),
                                            activeShape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0))),
                                        carouselController: autoPlay,
                                        onPageChaged: (int) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  isLoading
                      ? Center(child: GlobalWidgets().showCircleProgress())
                      : Container()
                ],
              )),
            )));
  }

  void signIN(String url, Map<String, String> params,
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) async {
    var response =
        await RestAPI().post(url, params: params).catchError((onError) {
      setState(() {
        isLoading = false;
      });
      /* var a = CommonResponseModel.fromJson(onError.message);
      print("ERROR : ${onError.message}");

      GlobalWidgets().showSnackBar(scaffoldKey, a.response.msg);
      print(
          "Errors : ${onError.message}");*/
      GlobalWidgets().showSnackBar(
        _scaffoldKey,
        "Check your password",
      );
    });

    if (response != null) {
      await setAccessToken(response["access_token"]);
      Repository().fetchProfile('').then((onValue) async {
        GlobalData.myProfile = onValue;
        setState(() {
          isLoading = false;
        });
        print('registration status------------');
        print(onValue.usersBasicDetails?.registrationStatus ?? '');
        print(onValue.usersBasicDetails?.appRegistrationStep ?? '');
        registrationReDirect(context);
      });
    }
  }

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }
}

setAccessToken(String accessToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('accessToken', accessToken);
  print("prefrence ${prefs.getString('accessToken')}");
}
