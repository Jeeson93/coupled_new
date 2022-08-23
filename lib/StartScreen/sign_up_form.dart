import 'package:coupled/REST/RestAPI.dart';
import 'package:coupled/REST/app_exceptions.dart';
import 'package:coupled/Utils/Modals/dialogs.dart';
import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/error_checkpoint.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/registration_new/controller/registration_redirection.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpForm extends StatefulWidget {
  final String data;

  SignUpForm({this.data = ''});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>
    with SingleTickerProviderStateMixin {
  TextEditingController eomCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();

  TextEditingController otprCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  late AnimationController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Animation<double> _fadeIn, _fadeIn2, _fadeOut;
  bool enabled = true;
  FocusNode nameNode = FocusNode(),
      eomNode = FocusNode(),
      otpNode = FocusNode(),
      passwordNode = FocusNode();
  bool isLoading = false;
  String _eomHint = '';
  RegExp regex = RegExp('');
  bool isPswValid = true;

  setAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    GlobalWidgets().showSnackBar(_scaffoldKey, "Created Successfully");
    print("prefrence ${prefs.getString('accessToken')}");
  }

  List<String> fullName = [];

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
    eomCtrl.text = widget.data != null ? widget.data : "";
    super.initState();
  }

  void sendOTP() {
    if (ErrorCheckPoint().validateEoM(_scaffoldKey, eomCtrl.text)) {
      Map<String, String> params = {
        "type": regex.hasMatch(eomCtrl.text) ? "email" : "phone",
        regex.hasMatch(eomCtrl.text) ? "email" : "phone": eomCtrl.text,
        "name": fullName[0],
        "client_id": RestAPI.clientId,
        "client_secret": RestAPI.clientSecret,
      };
      setState(() {
        isLoading = true;
      });
      RestAPI().post(APis.signUpOtp, params: params).then((onValue) {
        setState(() {
          isLoading = false;
          _controller.forward();
          enabled = false;
          FocusScope.of(context).requestFocus(otpNode);
          GlobalWidgets()
              .showSnackBar(_scaffoldKey, onValue['response']['msg']);
        });
      }).catchError((onError) {
        print("onError----${onError}");
        setState(() {
          isLoading = false;
        });
        GlobalWidgets().showSnackBar(_scaffoldKey, "Something went wrong");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        return false;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Color(0xFFC9E2F6),
        ),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xFFC9E2F6),
          body: SafeArea(
              child: Stack(
            children: <Widget>[
              Opacity(
                opacity: isLoading ? 0.5 : 1,
                child: IgnorePointer(
                  ignoring: isLoading,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        minWidth: 50.0),
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
                            EditTextBordered(
                              controller: nameCtrl,
                              hint: "Full Name",
                              focusNode: nameNode,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) {
                                FocusScope.of(context).requestFocus(eomNode);
                              },
                              color: Colors.black,
                              hintColor: Color(0xff808080),
                              onChange: (_) {
                                fullName = nameCtrl.text.split(" ");
                                /*  setState(() {
                                  _controller.reverse();
                                  enabled = true;
                                });*/
                              },
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
                                      controller: eomCtrl,
                                      hint: _eomHint,
                                      focusNode: eomNode,
                                      textInputAction: TextInputAction.done,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      color: Colors.black,
                                      hintColor: Color(0xff808080),
                                      maxLength: 10,
                                      keyboardType: TextInputType.text,
                                      onChange: (_) {
                                        setState(() {
                                          _controller.reverse();
                                          enabled = true;
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
                                        height: 52.0,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
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
                                          Pattern fullNamePattern =
                                              "[a-zA-Z]*[\\s]{1}[a-zA-Z].*";
                                          RegExp regx = RegExp(
                                              fullNamePattern.toString());

                                          if (regx.hasMatch(nameCtrl.text) &&
                                              nameCtrl.text.length >= 3 &&
                                              ErrorCheckPoint().validateEoM(
                                                  _scaffoldKey, eomCtrl.text)) {
                                            sendOTP();
                                          } else {
                                            GlobalWidgets().showSnackBar(
                                                _scaffoldKey,
                                                'Please provide FIRST space LAST name with minimum one alphabet');
                                          }

                                          /*if (ErrorCheckPoint().validateEoM(
                                              _scaffoldKey, eomCtrl.text)) {
                                            sendOTP();
                                          }*/
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
                                            sendOTP();
                                          },
                                          child: TextView(
                                            "Resend OTP?",
                                            textAlign: TextAlign.end,
                                            color: CoupledTheme().primaryPink,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible,
                                            size: 12,
                                            textScaleFactor: .8,
                                          )),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            FadeTransition(
                              opacity: _fadeIn2,
                              child: TextView(
                                "(Kindly enter the OTP which has been sent to ${eomCtrl.text})",
                                color: Colors.black87,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.visible,
                                size: 12,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            EditTextBordered(
                              enabled: !enabled,
                              controller: otprCtrl,
                              hint: "Verify OTP",
                              maxLength: 6,
                              focusNode: otpNode,
                              // keyboardType: TextInputType.number,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              textCapitalization: TextCapitalization.none,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(passwordNode);
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
                                textCapitalization: TextCapitalization.none,
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                showObscureIcon: true,
                                color: Colors.black,
                                hintColor: Color(0xff808080),
                                errorText: isPswValid
                                    ? null
                                    : "Mix of 8 letters with uppercase,alphanumeric & specialcase",
                                onChange: (value) {
                                  setState(() {
                                    isPswValid =
                                        GlobalWidgets().validatePassword(value);
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            FadeTransition(
                              opacity: _fadeIn,
                              child: CustomButton(
                                enabled: (!enabled & isPswValid),
                                height: 52.0,
                                child: TextView(
                                  "Couple Up",
                                  size: 18.0,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                ),
                                onPressed: () {
//                        _controller.reverse();
                                  Pattern fullNamePattern =
                                      r'^[a-zA-Z]{1,}(?: [a-zA-Z]+){1,}$';
                                  RegExp regx =
                                      RegExp(fullNamePattern.toString());
                                  int validate = 0;
                                  print("${!regx.hasMatch(nameCtrl.text)}");
                                  if (!regx.hasMatch(nameCtrl
                                      .text) /*nameCtrl.text.length <= 4 && nameCtrl.text.contains("") last.trim().length == 0 */) {
                                    /* GlobalWidgets().showSnackBar(_scaffoldKey,
                                        "Please enter a full name");*/
                                    validate += 1;
                                  }
                                  if (!ErrorCheckPoint().validateEoM(
                                      _scaffoldKey, eomCtrl.text)) {
                                    validate += 1;
                                  }
                                  if (otprCtrl.text.length < 6) {
                                    GlobalWidgets().showSnackBar(
                                        _scaffoldKey, "Invalid Otp");
                                    validate += 1;
                                  }
                                  if (!ErrorCheckPoint().validatePassword(
                                      _scaffoldKey, passwordCtrl.text))
                                    validate += 1;

                                  print(validate);
                                  if (validate == 0) {
                                    String first, last;
                                    List<String> fullName =
                                        nameCtrl.text.split(" ");
                                    /* first = fullName[0];
                                    last = nameCtrl.text.substring(
                                        fullName[0].length,
                                        nameCtrl.text.length);*/
                                    Map<String, String> params = {
                                      "type": regex.hasMatch(eomCtrl.text)
                                          ? "email"
                                          : "phone",
                                      regex.hasMatch(eomCtrl.text)
                                          ? "email"
                                          : "phone": eomCtrl.text
                                      /*regex.hasMatch(eomCtrl.text)
                                              ? eomCtrl.text
                                              : ""*/
                                      ,
                                      "otp": otprCtrl.text,
                                      "first_name": nameCtrl.text.substring(
                                          0, nameCtrl.text.indexOf(" ")),
                                      "last_name": nameCtrl.text
                                          .substring(nameCtrl.text.indexOf(" "))
                                          .trim(),
                                      "password": passwordCtrl.text,
                                      "client_id": RestAPI.clientId,
                                      "client_secret": RestAPI.clientSecret,
                                      "firebase_token": GlobalData.fcmToken,
                                    };
                                    print("params $params");
                                    setState(() {
                                      isLoading = true;
                                    });
                                    RestAPI()
                                        .post(APis.signUp, params: params)
                                        .then((response) async {
                                      setState(() {
                                        isLoading = false;
                                      });

                                      if (response
                                          .containsKey("access_token")) {
                                        await setAccessToken(
                                            response["access_token"]);

                                        GlobalData.myProfile =
                                            await Repository().fetchProfile('');
                                        Dialogs().loginCredentialWarning(
                                            context, () {
                                          registrationReDirect(context);
                                        });
                                      } else {
                                        response["response"]
                                            .forEach((key, value) {
                                          print(key);
                                          if (response["response"][key] is List)
                                            GlobalWidgets().showSnackBar(
                                                _scaffoldKey,
                                                response["response"][key][0]);
                                          else
                                            GlobalWidgets().showSnackBar(
                                                _scaffoldKey,
                                                response["response"][key]);
                                        });
                                      }
                                    }).catchError((onError) {
                                      setState(() {
                                        isLoading = false;
                                        // GlobalWidgets()
                                        //     .showToast(msg: "OTP Mismatch");
                                        // print("jangobro");
                                      });
                                      // GlobalWidgets().showSnackBar(_scaffoldKey,
                                      //     onError['response']['phone']);
                                      // GlobalWidgets().showSnackBar(_scaffoldKey,
                                      //     onError.message['response']['msg']);
                                      // print("ONERROR : $onError");
                                      if (onError is BadRequestException) {
                                        print("ONERROR1 : ${onError}");
                                        GlobalWidgets().showSnackBar(
                                            _scaffoldKey,
                                            onError.message['response']);
                                      } else {
                                        GlobalWidgets().showSnackBar(
                                            _scaffoldKey,
                                            CoupledStrings.errorMsg);
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
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
        ),
      ),
    );
  }
}
