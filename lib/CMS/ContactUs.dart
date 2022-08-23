import 'package:coupled/Utils/coupled_strings.dart';
import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:coupled/models/common_response_model.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:rxdart/subjects.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  var dropdownValue;
  final _streamcontroller = BehaviorSubject<String>();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _feedBackController = TextEditingController();
  var address1;
  var address2;
  var contact;
  var email;
  var instagram;
  var facebook;
  var twitter;

  @override
  void initState() {
    print(GlobalData.cmsModel.response);

    GlobalData.cmsModel.response.forEach((element) {
      switch (element.cmsPageItem) {
        case 'address1':
          address1 = parse('<p style="color:White;">${element.cmsContent}</p>');
          break;
        case 'address2':
          address2 = parse('<p style="color:White;">${element.cmsContent}</p>');
          break;
        case 'contact':
          contact = parse('<p style="color:White;">${element.cmsContent}</p>');
          break;
        case 'email':
          email = parse('<p style="color:White;">${element.cmsContent}</p>');
          break;
        case 'facebook':
          facebook = element.cmsContent;
          break;
        case 'instagram':
          instagram = element.cmsContent;
          break;
        case 'twitter':
          twitter = element.cmsContent;
          break;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CoupledTheme().backgroundColor,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
          backgroundColor: CoupledTheme().backgroundColor,
          title: Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextView(
              "Contact Us",
              size: 22,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextView(
                        "Reg. Office",
                        size: 16,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Html(data: address1?.outerHtml ?? ""),
                            Html(data: address2?.outerHtml ?? ""),
                            //  TextView("Kasturba Road, Bengaluru, Karnataka"),
                            // TextView("PIN: 560001"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: CoupledTheme().inactiveColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () {
                              // GlobalWidgets().launchURL(
                              //     url: 'tel:${CoupledStrings.cmsPhone}');
                            },
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    flex: 8,
                                    child: Html(
                                      data: contact.outerHtml ?? "",
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () {
                              GlobalWidgets().launchURL(
                                  url: 'mailto:${email}?subject=AboutCoupled');
                            },
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    flex: 8,
                                    child: Html(data: email?.outerHtml ?? "")),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: CoupledTheme().inactiveColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                GlobalWidgets().launchURL(url: facebook ?? '');
                              },
                              child: Container(
                                  child: Image.asset(
                                "assets/facebook.png",
                                width: 25,
                                height: 25,
                              )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                GlobalWidgets().launchURL(url: instagram ?? '');
                              },
                              child: Container(
                                  child: Image.asset(
                                "assets/instagram.png",
                                width: 25,
                                height: 25,
                              )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                GlobalWidgets().launchURL(url: twitter ?? '');
                              },
                              child: Container(
                                  child: Image.asset(
                                "assets/twitter.png",
                                width: 25,
                                height: 25,
                              )),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: CoupledTheme().inactiveColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextView(
                        "Feedback/Enquiry",
                        size: 16,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 12, bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  width: 1.0,
                                  color: CoupledTheme().inactiveColor,
                                ),
                              ),
                              width: double.infinity,
                              child: Theme(
                                data: ThemeData(
                                  canvasColor: CoupledTheme().backgroundColor,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'Subject',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      value: dropdownValue,
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                      iconSize: 24,
                                      elevation: 16,
                                      onChanged: (String? value) {
                                        setState(() {
                                          dropdownValue = value;
                                        });
                                      },
                                      items: <String>[
                                        'User Account',
                                        'Plans & Payments',
                                        'Complaint',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: TextView(
                                            value,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                            size: 14,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            /*EditTextBordered(
                              textInputAction: TextInputAction.go,
                              controller: _subjectController,
                              hint: "Subject",
                              textAlign: TextAlign.left,
                              color: Colors.white,
                              hintColor: Colors.white,
                              size: 16.0,
                              height: 16,
                            ),
                            SizedBox(
                              height: 15,
                            ),*/
                            EditTextBordered(
                              textInputAction: TextInputAction.go,
                              controller: _feedBackController,
                              hint: "Feedback",
                              textAlign: TextAlign.left,
                              color: Colors.white,
                              hintColor: Colors.white,
                              size: 16.0,
                              maxLines: 6,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: StreamBuilder(
                                  stream: _streamcontroller,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data == "") {
                                      return GlobalWidgets()
                                          .showCircleProgress();
                                    } else {
                                      return CustomButton(
                                        width: 80.0,
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                        gradient: LinearGradient(colors: [
                                          CoupledTheme().primaryPinkDark,
                                          CoupledTheme().primaryPink
                                        ]),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: TextView(
                                            "Send",
                                            size: 16,
                                            color: Colors.white,
                                            decoration: TextDecoration.none,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_feedBackController.text.length >=
                                              1) {
                                            _streamcontroller.add("");

                                            Future<CommonResponseModel> res =
                                                Repository().doAction({
                                              'memcode': GlobalData
                                                  .myProfile.membershipCode,
                                              'subject': dropdownValue,
                                              'feedback':
                                                  _feedBackController.text
                                            }, "enquiry");

                                            res.then((onValue) {
                                              _streamcontroller
                                                  .add(onValue.code.toString());
                                              if (onValue.code == 200) {
                                                setState(() {
                                                  _feedBackController.clear();
                                                  _showDialogSendFeedback();
                                                });

                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            super.widget));
                                              } else {
                                                GlobalWidgets().showToast(
                                                    msg: onValue.response?.msg);
                                              }
                                            }, onError: (err) {
                                              GlobalWidgets().showToast(
                                                  msg: CoupledStrings.errorMsg);
                                            });
                                          } else {
                                            GlobalWidgets().showToast(
                                                msg: "All fields are required");
                                          }
                                        },
                                      );
                                    }
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialogSendFeedback() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            content: Container(
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextView(
                    "Thank you! Your message has been sent successfully",
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
