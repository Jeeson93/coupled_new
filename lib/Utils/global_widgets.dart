import 'dart:io';

import 'package:coupled/Home/Profile/CouplingScore/bloc/coupling_score_bloc.dart';
import 'package:coupled/Home/Profile/CouplingScore/view/CouplingScorePredictions.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:coupled/models/profile.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

enum FixedIconSize {
  EXTRASMALL,
  SMALL,
  MEDIUM,
  SEMILARGE,
  LARGE_30,
  LARGE_35,
  LARGE_45
}

class GlobalWidgets {
  void showToast({msg}) {
    Fluttertoast.showToast(
        timeInSecForIosWeb: 5,
        msg: msg ?? '',
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER);
  }

  launchURL({url}) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  bool validatePassword(String value) {
    String pattern =
        r"^(?=.*?[A-Z])(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";
    RegExp regExp = new RegExp(pattern);
    // if (value.length >= 8) return true;
    return regExp.hasMatch(value);
  }

  showSnackBar(GlobalKey<ScaffoldState> _scaffoldKey, String msg,
      {dynamic actions, bool floating = false}) {
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
          content: Text(msg),
          behavior:
              floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
          duration:
              actions == null ? Duration(seconds: 2) : Duration(seconds: 10),
          action: actions),
    );
  }

  Widget showCircleProgress({double size = 30}) => Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            backgroundColor: CoupledTheme().primaryBlue,
            valueColor:
                new AlwaysStoppedAnimation<Color>(CoupledTheme().primaryPink),
          ),
        ),
      );
  Widget iconCreator(img,
      {required FixedIconSize size, dynamic color, dynamic customSize}) {
    double _size = 0.0;
    if (customSize == null) {
      switch (size) {
        case FixedIconSize.LARGE_45:
          _size = 45.0;
          break;
        case FixedIconSize.LARGE_35:
          _size = 35.0;
          break;
        case FixedIconSize.LARGE_30:
          _size = 30.0;
          break;
        case FixedIconSize.SEMILARGE:
          _size = 25.0;
          break;
        case FixedIconSize.MEDIUM:
          _size = 20.0;
          break;
        case FixedIconSize.EXTRASMALL:
          _size = 10.0;
          break;
        default:
          _size = 16.0;
      }
    } else {
      _size = customSize;
    }

    if (img is File) {
      return Image.file(
        img,
        width: _size,
        height: _size,
        color: color,
      );
    } else if (img.contains("http")) {
      return Image.network(
        img,
        width: _size,
        height: _size,
        color: color,
      );
    } else if (img.contains("com.appeonix.datematrimony")) {
      return Image.file(
        File(img),
        width: _size,
        height: _size,
        color: color,
      );
    } else {
      return Image.asset(
        img,
        height: _size,
        width: _size,
        color: color,
      );
    }
  }

  Widget errorState({String? message}) => Container(
        color: CoupledTheme().backgroundColor,
        child: Center(
            child: TextView(
          message.toString(),
          textAlign: TextAlign.center,
          color: Colors.white,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible,
          size: 12,
          textScaleFactor: .8,
        )),
      );
  String getAge(DateTime? birthDate) {
    int age = 0;
    if (birthDate != null) {
      DateTime currentDate = DateTime.now();
      age = currentDate.year - birthDate.year;
      int month1 = currentDate.month;
      int month2 = birthDate.month;
      if (month2 > month1) {
        age--;
      } else if (month1 == month2) {
        int day1 = currentDate.day;
        int day2 = birthDate.day;
        if (day2 > day1) {
          age--;
        }
      }
    }

    return age.toString();
  }

  getTime(DateTime createdAt) {
    int difference = ((DateTime.now().difference(createdAt).inDays)).round();
    if (difference < 7) {
      return timeago.format(createdAt).toString();
    } else {
      return formatDate(createdAt, [dd, '.', mm, '.', yyyy]).toString();
    }
  }

  ///give strings length to [toWhichCard] to set GestureCallBack to the appropriate card
  Widget card(
      {Color card2Color = const Color(0xff4b5076),
      required List<String?> strings,
      required GestureTapCallback onTap,
      int toWhichCard = 0}) {
    List<Widget> children = [];
    for (var i = 0; i < strings.length; i++) {
      var text = strings[i];
      if (text != null && text.isNotEmpty) {
        children.add(GestureDetector(
          onTap: toWhichCard == null
              ? onTap
              : toWhichCard == i
                  ? onTap
                  : null,
          child: Visibility(
            visible: text != null && text.isNotEmpty,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 50,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: i == 0
                    ? CoupledTheme().tabColor1
                    : i == 1
                        ? card2Color
                        : CoupledTheme().tabColor3,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: 1,
                    //
                    child: TextView(
                      "$text",
                      textAlign: TextAlign.start,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      size: 12,
                      textScaleFactor: .8,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
      }
    }

    return Container(
      child: Wrap(
        children: children,
      ),
    );
  }

  Color complexionColor(String? complexionValue) {
    return complexionValue?.toLowerCase() == 'fair'
        ? CoupledTheme().fairColor
        : complexionValue?.toLowerCase() == 'wheatish'
            ? CoupledTheme().wheatColor
            : CoupledTheme().darkColor;
  }

  String getBodyTypeImg(String? bodyType) {
    return bodyType?.toLowerCase() == 'slim fit'
        ? "assets/slim.png"
        : bodyType?.toLowerCase() == 'regular'
            ? "assets/regular.png"
            : "assets/athletic.png";
  }

  void familyMembersBottomSheet(
    context,
    List<Sibling> brother,
    List<Sibling> sister,
  ) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      context: context,
      builder: (builder) {
        return Container(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Scrollbar(
                child: ListView(
                  children: <Widget>[
                    brother.length == 0
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextView(
                                "Brothers",
                                color: Colors.black,
                                size: 18,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: brother.length,
                                itemBuilder: (BuildContext context, int index) {
                                  int numb = index + 1;
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                          width: 20,
                                          child: TextView(
                                            '$numb',
                                            color: Colors.black,
                                            size: 22,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                          )),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        color: CoupledTheme().tabColor3,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 12),
                                          child: Column(
                                            children: <Widget>[
                                              TextView(
                                                brother[index]
                                                            .profession
                                                            ?.value ==
                                                        null
                                                    ? "Not specified"
                                                    : brother[index]
                                                        .profession!
                                                        .value,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.bold,
                                                textAlign: TextAlign.center,
                                                textScaleFactor: .8,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextView(
                                                "Occupation",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.normal,
                                                decoration: TextDecoration.none,
                                                textAlign: TextAlign.center,
                                                textScaleFactor: .8,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        color: CoupledTheme().tabColor3,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 12),
                                          child: Column(
                                            children: <Widget>[
                                              TextView(
                                                brother[index]
                                                            .maritalStatus
                                                            ?.value ==
                                                        null
                                                    ? "Not specified"
                                                    : brother[index]
                                                        .maritalStatus!
                                                        .value,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                decoration: TextDecoration.none,
                                                textAlign: TextAlign.center,
                                                textScaleFactor: .8,
                                                color: Colors.white,
                                                size: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextView(
                                                "Status",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.normal,
                                                decoration: TextDecoration.none,
                                                textAlign: TextAlign.center,
                                                textScaleFactor: .8,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    sister.length == 0
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextView(
                                "Sisters",
                                color: Colors.black,
                                size: 18,
                                decoration: TextDecoration.none,
                                textAlign: TextAlign.center,
                                textScaleFactor: .8,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.visible,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: sister.length,
                                itemBuilder: (BuildContext context, int index) {
                                  int numb = index + 1;
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                          width: 20,
                                          child: TextView(
                                            '$numb',
                                            color: Colors.black,
                                            size: 22,
                                            decoration: TextDecoration.none,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.visible,
                                          )),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        color: CoupledTheme().tabColor3,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 12),
                                          child: Column(
                                            children: <Widget>[
                                              TextView(
                                                sister[index]
                                                            .profession
                                                            ?.value ==
                                                        null
                                                    ? "Not specified"
                                                    : sister[index]
                                                        .profession!
                                                        .value,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                decoration: TextDecoration.none,
                                                textAlign: TextAlign.center,
                                                textScaleFactor: .8,
                                                color: Colors.white,
                                                size: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextView(
                                                "Occupation",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.normal,
                                                decoration: TextDecoration.none,
                                                textAlign: TextAlign.center,
                                                textScaleFactor: .8,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        color: CoupledTheme().tabColor3,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 12),
                                          child: Column(
                                            children: <Widget>[
                                              TextView(
                                                sister[index]
                                                            .maritalStatus
                                                            ?.value ==
                                                        null
                                                    ? "Not specified"
                                                    : sister[index]
                                                        .maritalStatus!
                                                        .value,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                decoration: TextDecoration.none,
                                                textAlign: TextAlign.center,
                                                textScaleFactor: .8,
                                                color: Colors.white,
                                                size: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextView(
                                                "Status",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.normal,
                                                decoration: TextDecoration.none,
                                                textAlign: TextAlign.center,
                                                textScaleFactor: .8,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String timeFormatter(BuildContext context, String? birthTime) {
    if (birthTime != null) {
      List<String> _splittedTime = birthTime.split(":");
      print("_splittedTime :: ${_splittedTime}");
      var time = _splittedTime == []
          ? TimeOfDay(
              hour: int.parse(_splittedTime[0].trim()),
              minute: int.parse(_splittedTime[1].trim()))
          : TimeOfDay(hour: int.parse('0'), minute: int.parse('00'));
      print("time : ${time != '' ? time.format(context) : ''}");
      return time.format(context);
    } else
      return "";
  }

  String dateFormatter(DateTime date) {
    var formatter = new DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  showSomethingWrong(GlobalKey<ScaffoldState> _scaffoldKey) {
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
          content: TextView(
        "Something went wrong. Please try again",
        color: Colors.black,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.visible,
        size: 12,
        textAlign: TextAlign.center,
        textScaleFactor: .8,
      )),
    );
  }

  bool _print = true;
  printMsg(var message) {
    if (_print) {
      print(message);
    }
  }

  bool validatePhone(String value) {
    String pswd = value.trim();
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(pswd);
  }

  bool validateEmail(String value) {
    String pswd = value.trim();
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(pswd);
  }
}

Widget buildPlanDetails(String detail, int status) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 9,
            child: TextView(
              "$detail",
              size: 14,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
          ),
          Flexible(
            flex: 1,
            child: Icon(
              status == 0 ? Icons.close : Icons.check,
              color: Colors.white,
              size: 18.0,
            ),
          )
        ],
      ),
    ),
  );
}

class RadioModel {
  bool isSelected;
  int id;
  final text, activeImageUrl, inActiveImageUrl;

  RadioModel(this.isSelected, this.id, this.activeImageUrl,
      this.inActiveImageUrl, this.text);
}

class TextView extends StatelessWidget {
  final String text;
  final double size, _size, textScaleFactor;
  final Color color;
  final int maxLines;
  final double lineSpacing;
  final TextOverflow overflow;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextDecoration decoration;

  TextView(
    this.text, {
    Key? key,
    this.size = 0.0,
    required this.textAlign,
    required this.color,
    this.textScaleFactor = 0.0,
    required this.fontWeight,
    required this.overflow,
    this.maxLines = 1,
    this.lineSpacing = 0,
    required this.decoration,
  })  : _size = size == null ? 12.0 : size,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign != null ? textAlign : TextAlign.start,
      textScaleFactor: textScaleFactor,
      style: TextStyle(
        letterSpacing: 1.2,
        decoration: decoration,
        height: lineSpacing,
        color: color != null ? color : Colors.white,
        textBaseline: TextBaseline.alphabetic,
        fontWeight: fontWeight != null ? fontWeight : FontWeight.bold,
        fontFamily: 'Bariol',
        fontSize: _size,
      ),
    );
  }
}

class EditText extends StatefulWidget {
  final dynamic _text;
  final dynamic _size;
  final dynamic textColor, hintColor;
  final dynamic maxLength;
  final dynamic obscureText;
  final dynamic border;
  final dynamic maxLines;
  final dynamic showObscureIcon;
  final dynamic focusNode;
  final dynamic onClick;
  final dynamic textInputAction;
  final dynamic textAlign;
  final dynamic keyboardType;
  final dynamic onChange, onSubmitted;
  final dynamic onEditingComplete;
  dynamic controller = TextEditingController();
  final dynamic icon, suffixIcon;
  final dynamic customBorder;
  final dynamic showCursor;

  final dynamic readOnly;

  void test(String i, String j) {}

  EditText({
    Key? key,
    required var hint,
    dynamic size,
    this.keyboardType,
    this.maxLength,
    this.textAlign,
    this.onChange,
    this.hintColor,
    this.textColor,
    this.obscureText,
    this.onSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.textInputAction,
    this.onClick,
    this.border = false,
    this.customBorder,
    this.controller,
    this.suffixIcon,
    this.icon,
    bool showObscureIcon = false,
    decoration,
    this.maxLines = 1,
    this.showCursor,
    this.readOnly = false,
  })  : _text = hint,
        this.showObscureIcon = showObscureIcon == null ? false : true,
        _size = size == null ? 14.0 : size,
        super(key: key);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.obscureText != null ? widget.obscureText : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(1, 0),
      children: <Widget>[
        TextField(
          controller: widget.controller,
          onChanged: widget.onChange,
          obscureText: obscureText == null ? false : obscureText,
          onSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          minLines: 1,
          showCursor: widget.showCursor,
          readOnly: widget.readOnly,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          textAlign:
              widget.textAlign == null ? TextAlign.center : widget.textAlign,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            icon: widget.suffixIcon,
            labelStyle: TextStyle(fontSize: widget._size),
            contentPadding: EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 12.0,
            ),
            enabledBorder: widget.border == null || !widget.border
                ? InputBorder.none
                : widget.customBorder != null
                    ? widget.customBorder
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(width: 1.0, color: Color(0xff717483))),
            border: widget.border == null || !widget.border
                ? InputBorder.none
                : widget.customBorder != null
                    ? widget.customBorder
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(width: 1.0, color: Color(0xff717483))),
            counterText: "",
            hintText: widget._text,
            hintStyle: TextStyle(
              color: widget.hintColor != null ? widget.hintColor : Colors.white,
            ),
          ),
          style: TextStyle(
            color: widget.textColor != null ? widget.textColor : Colors.white,
            fontFamily: 'Bariol',
            fontWeight: FontWeight.bold,
            fontSize: widget._size,
          ),
        ),
        widget.icon == null
            ? Container()
            : Positioned(right: 10.0, bottom: 10.0, child: widget.icon),
        Positioned(
          right: 10,
          child: obscureText == false
              ? Container()
              : Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50.0),
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                        print("$obscureText");
                      });
                    },
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      child: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        size: 25.0,
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class EditTextBordered extends StatefulWidget {
  final dynamic hint, errorText;
  final dynamic size, height;
  final dynamic color, hintColor, borderColor;
  final int? maxLength;
  final dynamic maxLines;
  final dynamic textCapitalization;
  final dynamic obscureText;
  final dynamic enabled;
  final dynamic setBorder, setDecoration;
  final dynamic showObscureIcon;
  final dynamic focusNode;
  final dynamic textInputAction;
  final dynamic textAlign;
  final dynamic keyboardType;
  final dynamic onChange, onSubmitted;
  final dynamic onEditingComplete;
  final dynamic controller;
  final dynamic icon;

  EditTextBordered({
    Key? key,
    required this.hint,
    this.size,
    this.keyboardType,
    this.maxLength,
    this.maxLines = 1,
    //this.maxLines,
    this.textAlign,
    this.onChange,
    this.hintColor,
    this.color,
    this.obscureText,
    this.onSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.textInputAction,
    this.borderColor,
    this.controller,
    this.icon,
    this.height,
    this.showObscureIcon = false,
    this.enabled,
    this.setBorder = true,
    this.setDecoration = true,
    this.errorText,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  EditTextBorderedState createState() => EditTextBorderedState();
}

class EditTextBorderedState extends State<EditTextBordered> {
  bool _isVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(1, 0),
      children: <Widget>[
        TextField(
          enabled: widget.enabled == null ? true : widget.enabled,
          controller: widget.controller,
          onChanged: widget.onChange,
          obscureText: widget.obscureText == null ? false : _isVisibility,
          onSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          focusNode: widget.focusNode,
          textAlign:
              widget.textAlign == null ? TextAlign.start : widget.textAlign,
          textAlignVertical: TextAlignVertical.top,
          keyboardType: widget.keyboardType,
          decoration: !widget.setDecoration
              ? InputDecoration(
                  counterText: '',
                  hintStyle: TextStyle(
                      inherit: true,
                      fontSize: widget.size,
                      color: widget.hintColor != null
                          ? widget.hintColor
                          : Colors.white),
                  hintText: widget.hint,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                )
              : InputDecoration(
                  counterText: '',
                  labelStyle: TextStyle(
                      inherit: true,
                      fontFamily: 'Bariol',
                      fontWeight: FontWeight.bold,
                      fontSize: widget.size,
                      color: widget.hintColor != null
                          ? widget.hintColor
                          : Colors.white),
                  contentPadding: EdgeInsets.only(
                    left: 12.0,
                    top: 12.0,
                    right: 12.0,
                    bottom: widget.height != null ? widget.height : 16,
                  ),
                  focusedBorder: widget.setBorder
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 1.0,
                              color: widget.borderColor != null
                                  ? widget.borderColor
                                  : Color(0xffcacaca)))
                      : InputBorder.none,
                  enabledBorder: widget.setBorder
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 1.0,
                              color: widget.borderColor != null
                                  ? widget.borderColor
                                  : Color(0xffcacaca)))
                      : InputBorder.none,
                  border: widget.setBorder
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 1.0,
                              color: widget.borderColor != null
                                  ? widget.borderColor
                                  : Color(0xffcacaca)))
                      : InputBorder.none,
                  disabledBorder: widget.setBorder
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1.0, color: Color(0xffcacaca)))
                      : InputBorder.none,
                  labelText: widget.hint,
                  errorText: widget.errorText,
                  errorMaxLines: 3,
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Bariol',
                    fontWeight: FontWeight.bold,
                    fontSize: widget.size,
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(width: 1.0, color: Color(0xffff0000)))),
          style: TextStyle(
            color: widget.color != null ? widget.color : Colors.white,
            fontFamily: 'Bariol',
            fontWeight: FontWeight.bold,
            fontSize: widget.size,
          ),
        ),
        widget.icon == null
            ? Container()
            : Positioned(right: 10.0, bottom: 10.0, child: widget.icon),
        Positioned(
          top: 10,
          right: 10,
          child: !widget.showObscureIcon
              ? Container()
              : Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50.0),
                    onTap: () {
                      setState(() {
                        _isVisibility = !_isVisibility;
                        print("$_isVisibility");
                      });
                    },
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      child: Icon(
                        _isVisibility ? Icons.visibility_off : Icons.visibility,
                        size: 25.0,
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

enum ButtonType { FLAT, RAISED, BUTTON_ROUND, BUTTON_RRECT }

class CustomButton extends StatefulWidget {
  final Widget child;
  final dynamic gradient;
  final dynamic width;
  final dynamic height;
  final bool isLoading;
  final dynamic disabledReasonMsg;
  final ButtonType buttonType, shape;
  final bool enabled;
  final dynamic borderRadius;
  final dynamic onPressed;
  final dynamic _raisedGradient = LinearGradient(colors: <Color>[
    Color(0xffbc1b87),
    Color(0xffed2092),
  ]);

  final Gradient _flatGradient = LinearGradient(
      colors: <Color>[CoupledTheme().primaryPink, CoupledTheme().primaryPink]);

  CustomButton({
    required this.child,
    required this.onPressed,
    this.gradient,
    this.width,
    this.height,
    this.borderRadius,
    bool? enabled,
    this.buttonType = ButtonType.RAISED,
    this.shape = ButtonType.BUTTON_RRECT,
    this.isLoading = false,
    this.disabledReasonMsg,
  }) : enabled = enabled == null ? true : enabled;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.enabled ? 1 : 0.5,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            shape: widget.shape == ButtonType.BUTTON_ROUND
                ? BoxShape.circle
                : BoxShape.rectangle,
            gradient: widget.gradient == null
                ? widget.buttonType == ButtonType.FLAT
                    ? widget._flatGradient
                    : widget._raisedGradient
                : widget.gradient,
            boxShadow: widget.buttonType == ButtonType.FLAT
                ? null
                : [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 1.5),
                      blurRadius: 1.5,
                    ),
                  ],
            borderRadius: widget.shape == ButtonType.BUTTON_ROUND
                ? null
                : widget.borderRadius == null
                    ? BorderRadius.circular(10.0)
                    : widget.borderRadius),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              borderRadius: widget.borderRadius == null
                  ? BorderRadius.circular(10.0)
                  : widget.borderRadius,
              onTap: widget.enabled
                  ? widget.onPressed
                  : () {
                      if (widget.disabledReasonMsg != null)
                        GlobalWidgets()
                            .showToast(msg: widget.disabledReasonMsg);
                    },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  widget.isLoading
                      ? GlobalWidgets().showCircleProgress()
                      : widget.child,
                ],
              )),
        ),
      ),
    );
  }
}

class NotificationBadge extends StatelessWidget {
  final int count;
  final double radius;
  final Color bgcolor;
  final Color txtColor;

  NotificationBadge(
      {this.count = 0,
      this.radius = 16.0,
      this.bgcolor = Colors.white,
      this.txtColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(color: bgcolor, shape: BoxShape.circle),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: TextView(
            count.toString() ?? '0',
            size: 8,
            color: txtColor,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            textScaleFactor: .8,
          ),
        ),
      ),
    );
  }
}

class HeartPercentage extends StatelessWidget {
  final String? partnerPercentage, userId, profileImg;
  final double fontSize;

  final FixedIconSize heartSize;

  const HeartPercentage(
    this.partnerPercentage, {
    this.fontSize = 10.0,
    Key? key,
    this.heartSize = FixedIconSize.LARGE_35,
    this.userId,
    this.profileImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("premiumuserid====$profileImg");
        if (GlobalData.myProfile.membership?.paidMember == true &&
            userId != null) {
          print("premiumuserid====$profileImg");
          print(userId);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => CouplingScoreBloc(),
                child: (CoupingScorePredictions(
                    userId: userId.toString(),
                    profileImg: profileImg.toString())),
              ),
            ),
          );
        } else if (GlobalData.myProfile.membership?.paidMember == false &&
            GlobalData.myProfile.currentCsStatistics?.status == "active") {
          print("freeuserid====$profileImg");
          print(userId);
          print(GlobalData.myProfile.currentCsStatistics?.status.toString());
          //becomeamemberPlan(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => CouplingScoreBloc(),
                child: (CoupingScorePredictions(
                    userId: userId.toString(),
                    profileImg: profileImg.toString())),
              ),
            ),
          );
        } else {
          becomeamemberPlan(context);
        }

        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => CouplingScoreBloc(),
              child: (CoupingScorePredictions(
                  userId: userId, profileImg: profileImg)),
            ),
          ),
        );*/
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GlobalWidgets().iconCreator(
            "assets/heart.png",
            color: CoupledTheme().primaryPinkDark,
            size: heartSize,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: TextView(
                "$partnerPercentage%",
                size: fontSize,
                decoration: TextDecoration.none,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  becomeamemberPlan(BuildContext context) {
    return _dialogTemplate(
      title: null,
      color: Colors.transparent,
      context: context,
      content: Container(
        height: 175,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 35, bottom: 15),
                  child: Column(
                    children: <Widget>[
                      TextView(
                        "Hello,Activate Coupling Score to get detailed match predictions and insight between you and your prospective partners",
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        overflow: TextOverflow.visible,
                        size: 12,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      CustomButton(
                        borderRadius: BorderRadius.circular(2.0),
                        gradient: LinearGradient(colors: [
                          CoupledTheme().primaryPinkDark,
                          CoupledTheme().primaryPink
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: TextView(
                            "Activate Coupling Score",
                            decoration: TextDecoration.none,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            size: 12,
                          ),
                        ),
                        onPressed: () {
                          //Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed('/myPlanPayments');
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [],
    );
  }

  void _dialogTemplate(
      {title,
      Color color = Colors.white,
      required BuildContext context,
      required Container content,
      bool barrierDismissible = true,
      required List<Widget> actions}) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Theme(
              data: Theme.of(context).copyWith(dialogBackgroundColor: color),
              child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  title: title == null
                      ? null
                      : TextView(
                          title,
                          color: CoupledTheme().primaryBlue,
                          size: 18,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .8,
                        ),
                  content: content,
                  actions: actions),
            ),
          );
        });
  }
}

class BtnWithText extends StatelessWidget {
  final String text;
  final img;
  final GestureTapCallback onTap;
  final bool roundBackGround;
  final textColor;
  final bool enabled;
  final dynamic bgColor;
  final dynamic imgColor;
  final FixedIconSize fixedIconSize;
  final dynamic customSize;
  final double textSize;
  final double paddingTextIcon;

  BtnWithText({
    this.bgColor,
    this.imgColor,
    this.enabled = true,
    this.img,
    this.text = "",
    this.fixedIconSize = FixedIconSize.SEMILARGE,
    required this.onTap,
    this.roundBackGround = false,
    this.textColor = Colors.white,
    this.textSize = 10,
    this.customSize,
    this.paddingTextIcon = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
                onTap: enabled ? onTap : null,
                //child: GlobalWidgets().iconCreator(img, size: iconSize.LARGE),
                child: Container(
                  decoration: roundBackGround
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: bgColor,
                        )
                      : null,
                  child: Padding(
                    padding: roundBackGround
                        ? const EdgeInsets.all(8)
                        : const EdgeInsets.all(4),
                    child: GlobalWidgets().iconCreator(img,
                        size: fixedIconSize,
                        color: imgColor,
                        customSize: customSize),
                  ),
                )),
            SizedBox(
              height: paddingTextIcon,
            ),
            TextView(
              text,
              color: textColor,
              size: textSize,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            )
          ],
        ),
      ),
    );
  }
}

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final bool enabled;
  final bool disableTheme;
  final Color textColor;
  final double checkBoxSize;
  final double contentPaddingLeft;
  final double textSize;
  final EdgeInsetsGeometry padding;
  final FontWeight fontWeight;
  final String? text;
  final ValueChanged<bool?> onChanged;
  final Widget secondary;

  CustomCheckBox(
      {this.value = false,
      required this.onChanged,
      this.text = '',
      this.textColor = Colors.white,
      this.textSize = 14.0,
      this.fontWeight = FontWeight.normal,
      this.checkBoxSize = 25,
      this.padding = const EdgeInsets.all(0),
      this.contentPaddingLeft = 5.0,
      required this.secondary,
      this.enabled = true,
      this.disableTheme = false});

  @override
  Widget build(BuildContext context) {
    /*return SizedBox.fromSize(
	    size: Size(250,40.0),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        dense: true,
        activeColor: CoupledTheme().primaryPinkDark,
        title: TextView(
          text != null ? text : "",
          color: textColor,
          size: textSize,
          fontWeight: fontWeight != null ? fontWeight : FontWeight.bold,
        ),
	        secondary: secondary,
      ),
    );*/
    return Theme(
      data: CoupledTheme().coupledTheme2().copyWith(
          unselectedWidgetColor: disableTheme ? Colors.black : Colors.black,
          disabledColor: Colors.grey),
      child: InkWell(
        onTap: enabled
            ? () {
                onChanged(!value);
              }
            : null,
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: checkBoxSize,
                height: checkBoxSize,
                child: Checkbox(
                    activeColor: CoupledTheme().primaryPinkDark,
                    value: value,
                    onChanged: enabled ? onChanged : null,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    focusColor: Colors.white),
              ),
              SizedBox(
                width: contentPaddingLeft,
              ),
              Flexible(
                flex: 9,
                child: TextView(
                  text!,
                  color: enabled ? textColor : Colors.grey,
                  size: textSize,
                  fontWeight: fontWeight != null ? fontWeight : FontWeight.bold,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .9,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InterestWithMsg extends StatefulWidget {
  final double textSize;
  final String hint;
  final bool borderVisibility;
  final dynamic backgroundColor;

  const InterestWithMsg(
      {Key? key,
      this.textSize = 14.0,
      required this.hint,
      this.backgroundColor,
      this.borderVisibility = true})
      : super(key: key);

  @override
  _InterestWithMsgState createState() => _InterestWithMsgState();
}

class _InterestWithMsgState extends State<InterestWithMsg> {
//  Controller _intrestTextController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: widget.borderVisibility
            ? Border.all(color: CoupledTheme().primaryPinkDark, width: 2.0)
            : Border.all(
                color: Colors.transparent,
              ),
        color: widget.backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("IconClicked");
            },
            child: GlobalWidgets().iconCreator(
              "assets/MatchMeter/Add.png",
              size: FixedIconSize.SMALL,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextView(
                widget.hint,
                size: 12.0,
                textAlign: TextAlign.start,
                maxLines: 1,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible,
                textScaleFactor: .8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectionBox extends StatelessWidget {
  final Widget child;
  final dynamic radius, height, width;
  final dynamic borderColor, innerColor;
  final dynamic onTap;
  final dynamic itemBuilder;

  SelectionBox({
    Key? key,
    required this.child,
    this.radius,
    this.borderColor,
    this.innerColor,
    this.height,
    this.width,
    this.onTap,
    this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: Container(
        height: height != null ? height : null,
        width: width != null ? width : null,
        // margin: EdgeInsets.only(right: 10.0, top: 10.0),
//      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: borderColor != null ? borderColor : Colors.white,
            ),
            color: innerColor != null ? innerColor : Colors.transparent,
            borderRadius: BorderRadius.all(
                Radius.circular(radius != null ? radius : 50.0))),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius != null ? radius : 50.0),
          onTap: onTap != null ? onTap : null,
          splashColor: Color(0xff6d77b4),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: child,
          ),
        ),
      ),
    );
  }
}

class CustomSlider extends StatelessWidget {
  final dynamic value, min, max;
  final dynamic rangeValues;
  final bool rangeSlider;
  final dynamic onChanged;
  final dynamic onRangeChanged;
  final SliderComponentShape thumbShape;

  CustomSlider(
      {Key? key,
      this.rangeSlider = false,
      this.onChanged,
      this.value,
      this.thumbShape = const RoundSliderThumbShape(),
      required this.min,
      required this.max,
      this.rangeValues,
      this.onRangeChanged})
      : assert(min != null),
        assert(max != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //max = max >0.0?max:0.0;
    //value = max>value?value:max;
    return SliderTheme(
      data: SliderThemeData(
          showValueIndicator: ShowValueIndicator.onlyForContinuous,
          valueIndicatorColor: Colors.white,
          activeTrackColor: CoupledTheme().primaryPink,
          thumbColor: Colors.white,
          inactiveTrackColor: CoupledTheme().primaryPinkDark,
          valueIndicatorTextStyle: TextStyle(color: Colors.black),
          thumbShape: thumbShape),
      child: !rangeSlider
          ? Slider(
              label: "${value.round()}",
              value: value,
              max: max,
              min: min,
              onChanged: onChanged)
          : RangeSlider(
              values: RangeValues(rangeValues.start, rangeValues.end),
              //values: RangeValues(0.0, 252.0),
              min: min,
              max: max,
              activeColor: Colors.white,
              inactiveColor: CoupledTheme().primaryPinkDark,
              labels: RangeLabels(
                  "${rangeValues.start.round()}", "${rangeValues.end.round()}"),
              onChanged: onRangeChanged),
    );
  }
}

class DashRectPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;

  DashRectPainter(
      {this.strokeWidth = 1.0, this.color = Colors.grey, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double x = size.width;
    double y = size.height;

    Path _topPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(x, 0),
      gap: gap,
    );

    Path _rightPath = getDashedPath(
      a: math.Point(x, 0),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _bottomPath = getDashedPath(
      a: math.Point(0, y),
      b: math.Point(x, y),
      gap: gap,
    );

    Path _leftPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(0.001, y),
      gap: gap,
    );

    canvas.drawPath(_topPath, dashedPaint);
    canvas.drawPath(_rightPath, dashedPaint);
    canvas.drawPath(_bottomPath, dashedPaint);
    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    required math.Point<double> a,
    required math.Point<double> b,
    required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    num radians = math.atan(size.height / size.width);

    num dx = math.cos(radians) * gap < 0
        ? math.cos(radians) * gap * -1
        : math.cos(radians) * gap;

    num dy = math.sin(radians) * gap < 0
        ? math.sin(radians) * gap * -1
        : math.sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x.toDouble(), currentPoint.y.toDouble())
          : path.moveTo(currentPoint.x.toDouble(), currentPoint.y.toDouble());
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BodyTypeItem extends StatelessWidget {
  final RadioModel _item;

  BodyTypeItem(this._item);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              _item.activeImageUrl,
              height: 60.0,
              width: 60.0,
              color: _item.isSelected
                  ? CoupledTheme().primaryPinkDark
                  : Colors.white,
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10.0,
              ),
              child: TextView(
                _item.text,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                textScaleFactor: .8,
                size: 12,
              ),
            )
          ],
        );
      },
    );
  }
}

class CustomDropDown extends StatelessWidget {
  final String hint;
  final List items;
  final dynamic radius;
  final bool isExpanded;

  /// The initValue of the currently selected [DropdownMenuItem].
  ///
  /// If [initValue] is null and [hint] is non-null, the [hint] widget is
  /// displayed as a placeholder for the dropdown button's value.
  final initValue;
  final dynamic onChange;
  final dynamic margin;

  CustomDropDown(this.items,
      {Key? key,
      this.hint = '',
      this.onChange,
      this.margin,
      this.radius,
      this.initValue,
      this.isExpanded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin != null ? margin : null,
      child: SelectionBox(
        height: 40.0,
        radius: radius != null ? radius : 5.0,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xff34374a),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Map>(
              isDense: true,
              isExpanded: isExpanded,
              elevation: 1,
              value: initValue != '' ? initValue : '',
              hint: initValue == null
                  ? hint == ''
                      ? null
                      : TextView(
                          hint,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          textScaleFactor: .9,
                          color: Colors.white,
                          size: 12,
                        )
                  : TextView(
                      'select',
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .9,
                      color: Colors.white,
                      size: 12,
                    ),
              items: items.isNotEmpty
                  ? items.map((value) {
                      return DropdownMenuItem<Map>(
                          value: value,
                          child: Container(
                              height: 20.0,
                              child: TextView(
                                value['name'],
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                textScaleFactor: .9,
                                color: Colors.white,
                                size: 12,
                              )));
                    }).toList()
                  : [],
              onChanged: onChange != null ? onChange : null,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRadioModel {
  bool isSelected, hasDivider = false;
  dynamic activeColor, inActiveColor;
  final int id;
  final String text;
  final double left, right;

  CustomRadioModel(this.isSelected, this.id, this.text, this.hasDivider,
      this.left, this.right);

  @override
  String toString() {
    return 'CustomRadioModel{isSelected: $isSelected, hasDivider: $hasDivider,'
        ' activeColor: $activeColor, inActiveColor: $inActiveColor, id: $id,'
        ' text: $text, left: $left, right: $right}';
  }
}

class CustomRadio extends StatelessWidget {
//  final MaritalModel maritalModel;
  final CustomRadioModel customRadioModel;

  CustomRadio(
    this.customRadioModel,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 60.0,
          decoration: BoxDecoration(
            /*   border:  Border.all(
              color: Color(0xff717483),
            ),*/
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(customRadioModel.left),
                right: Radius.circular(customRadioModel.right)),
            color:
                customRadioModel.isSelected ? Colors.white : Colors.transparent,
            /* SelectionBox(
            innerColor: isSelected ? Color(0xff717483) : Colors.transparent,
            children:  TextView(status),
          )*/
          ),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
            child: TextView(
              customRadioModel.text,
              color: customRadioModel.isSelected ? Colors.black : Colors.white,
              size: 12.0,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
          )),
        ),
        customRadioModel.hasDivider
            ? Container(
                color: Color(0xff717483),
                height: 30.0,
                width: 0.5,
              )
            : Container(),
      ],
    );
  }
}

buildOfferCard(String text, String description) => Expanded(
      child: Card(
        color: Colors.transparent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextView(
                  text,
                  size: 24.0,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
                TextView(
                  description,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  textScaleFactor: .8,
                  color: Colors.white,
                  size: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );

class PlanCards extends StatelessWidget {
  final String planName, planPrice, backgroundImg;
  final dynamic cardColor;
  final double headerSize;
  final dynamic offerCard;

  const PlanCards(
      {Key? key,
      required this.planName,
      this.backgroundImg = "",
      required this.planPrice,
      this.cardColor,
      this.offerCard,
      this.headerSize = 24.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(18)),
      child: Container(
        width: MediaQuery.of(context).size.width - 35,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImg),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextView(
                      planName,
                      size: headerSize,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                      color: Colors.white,
                    ),
                    TextView(
                      "Rs: $planPrice",
                      size: headerSize,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      textScaleFactor: .8,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                /*  scrollDirection: Axis.horizontal,
                                      physics: NeverScrollableScrollPhysics(),*/
                children: offerCard,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatTexter extends StatelessWidget {
  final double textSize;
  final String hint;
  final bool borderVisibility;
  final dynamic focusNode;
  final dynamic backgroundColor;
  final bool readOnly;
  final dynamic msgController;
  final dynamic onTap;

  const ChatTexter(
      {Key? key,
      this.textSize = 14.0,
      required this.hint,
      this.backgroundColor,
      this.focusNode,
      this.readOnly = false,
      this.borderVisibility = true,
      this.onTap,
      this.msgController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          fit: FlexFit.loose,
          child: EditText(
            controller: msgController,
            hint: hint,
            focusNode: focusNode,
            size: 16.0,
            showCursor: true,
            readOnly: readOnly,
            maxLines: 8,
            obscureText: false,
            icon: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: GlobalWidgets().iconCreator(
                    "assets/MatchBoard/Emoji.png",
                    size: FixedIconSize.MEDIUM)),
            border: true,
            textColor: Colors.white,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
