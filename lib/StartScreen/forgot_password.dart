import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/error_checkpoint.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/common_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPassword extends StatefulWidget {
  final String data;

  ForgotPassword({this.data = ''});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>
    with SingleTickerProviderStateMixin {
  TextEditingController numberCtrl = TextEditingController();

  TextEditingController otprCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  late AnimationController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Animation<double> _fadeIn, _fadeIn2, _fadeOut;
  bool enabled = true;
  FocusNode numNode = FocusNode(),
      otpNode = FocusNode(),
      passwordNode = FocusNode();
  String _eomHint = '';
  RegExp regex = RegExp('');
  bool isPswValid = true;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    _fadeIn = Tween(begin: 0.5, end: 1.0).animate(_controller);
    _fadeIn2 = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _fadeOut = Tween(begin: 1.0, end: 0.5).animate(_controller);
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    regex = RegExp(pattern.toString());

    if (widget.data != null && regex.hasMatch(widget.data)) {
      _eomHint = "Email id";
    } else {
      _eomHint = "Mobile";
    }

    numberCtrl.text = widget.data ?? "";
    super.initState();
  }

  void sendOtp() {
    Map<String, String> params = {
      "type": regex.hasMatch(numberCtrl.text) ? "email" : "phone",
      regex.hasMatch(numberCtrl.text) ? "email" : "phone": numberCtrl.text,
      "client_id": RestAPI.clientId,
      "client_secret": RestAPI.clientSecret
    };
    RestAPI()
        .post(
      APis.forgotOtp,
      params: params,
    )
        .then((onValue) {
      GlobalWidgets().showSnackBar(_scaffoldKey, onValue["response"]["msg"]);
      setState(() {
        _controller.forward();
        enabled = false;
      });
    }).catchError((onError) {
      GlobalWidgets().showSnackBar(_scaffoldKey, onError.message);
      setState(() {
        _controller.reverse();
        enabled = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFFC9E2F6),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xFFC9E2F6),
        body: SafeArea(
            child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width, minWidth: 50.0),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.scaleDown,
                alignment: FractionalOffset.topCenter,
                image: AssetImage('assets/reg_back_img.png'),
              )),
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.width * .65,
                  ),
                  TextView(
                    "Forgot Password",
                    color: CoupledTheme().primaryBlue,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                    size: 22.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                          flex: 2,
                          fit: FlexFit.loose,
                          child: EditTextBordered(
                            controller: numberCtrl,
                            hint: _eomHint,
                            focusNode: numNode,
                            textInputAction: TextInputAction.done,
                            color: Colors.black,
                            hintColor: Color(0xff808080),
                            onChange: (_) {
                              setState(() {
                                enabled = true;
                                _controller.reverse();
                              });
                            },
                          )),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FadeTransition(
                            opacity: _fadeOut,
                            child: CustomButton(
                              enabled: enabled,
                              height: 55.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TextView(
                                  "Send OTP",
                                  size: 18.0,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  sendOtp();
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          FadeTransition(
                            opacity: _fadeIn,
                            child: GestureDetector(
                                onTap: () {
                                  sendOtp();
                                },
                                child: TextView(
                                  "Resend OTP?",
                                  textAlign: TextAlign.end,
                                  color: CoupledTheme().primaryPink,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                  textScaleFactor: .8,
                                  size: 12,
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FadeTransition(
                    opacity: _fadeIn2,
                    child: TextView(
                      "(Kindly enter the OTP which has been sent to ${numberCtrl.text})",
                      color: Colors.black87,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                      size: 12,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  EditTextBordered(
                    enabled: !enabled,
                    controller: otprCtrl,
                    hint: "Verify OTP",
                    focusNode: otpNode,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passwordNode);
                    },
                    color: Colors.black,
                    hintColor: Color(0xff808080),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: EditTextBordered(
                      enabled: !enabled,
                      controller: passwordCtrl,
                      hint: "Password",
                      focusNode: passwordNode,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      showObscureIcon: true,
                      color: Colors.black,
                      hintColor: Color(0xff808080),
                      errorText: isPswValid
                          ? null
                          : "Password must contain 8 letter with uppercase, alphanumeric and special case",
                      onChange: (value) {
                        setState(() {
                          isPswValid = GlobalWidgets().validatePassword(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FadeTransition(
                    opacity: _fadeIn,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        CustomButton(
                          enabled: (!enabled && isPswValid),
                          height: 40.0,
                          child: TextView(
                            "Submit",
                            size: 18.0,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                          ),
                          onPressed: () {
                            bool validate = true;
                            if (otprCtrl.text.length <= 0) {
                              GlobalWidgets()
                                  .showSnackBar(_scaffoldKey, "Invalid Otp");
                              validate = false;
                            }
                            validate = ErrorCheckPoint().validatePassword(
                                _scaffoldKey, passwordCtrl.text);
                            if (validate) {
                              Map<String, String> params = {
                                "type": regex.hasMatch(numberCtrl.text)
                                    ? "email"
                                    : "phone",
                                regex.hasMatch(numberCtrl.text)
                                    ? "email"
                                    : "phone": numberCtrl.text,
                                "otp": otprCtrl.text,
                                "password": passwordCtrl.text,
                                "client_id": RestAPI.clientId,
                                "client_secret": RestAPI.clientSecret
                              };
                              RestAPI()
                                  .post(APis.forgotPassword, params: params)
                                  .then((onValue) {
                                Navigator.of(context).pushNamed('/startMain');
                              }, onError: (e) {
                                try {
                                  print('e-------');
                                  print(e.message);
                                  var res =
                                      CommonResponseModel.fromJson(e.message);
                                  print('res-- ${res.response?.msg}');
                                  GlobalWidgets().showSnackBar(
                                      _scaffoldKey, res.response?.msg ?? '');
                                } catch (e) {
                                  GlobalWidgets().showSnackBar(
                                      _scaffoldKey, CoupledStrings.errorMsg);
                                  print(e);
                                }
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SlideTransition(
                          position: slideTransmit(
                              Offset(0.0, 0.0), Offset(0.0, -1.2), _controller),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FadeTransition(
                                opacity: _fadeOut,
                                child: Container(
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(50.0),
                                      radius: 50.0,
                                      splashColor: Colors.white24,
                                      onTap: () => Navigator.pop(context),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.chevron_left,
                                            size: 30.0,
                                            color: CoupledTheme().primaryPink,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5.0),
                                            child: TextView(
                                              "Back",
                                              color: CoupledTheme().primaryPink,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.visible,
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

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
}
