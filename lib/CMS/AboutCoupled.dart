import 'package:coupled/REST/RestAPI.dart';

import 'package:coupled/Utils/coupled_strings.dart';

import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutCoupled extends StatefulWidget {
  @override
  _AboutCoupledState createState() => _AboutCoupledState();
}

class _AboutCoupledState extends State<AboutCoupled> {
  var about;

  @override
  void initState() {
    // GlobalData?.cmsModel?.response?.forEach((element) {
    //   switch (element.cmsPageType) {
    //     case 'about_us':
    //       about = parse('<p style="color:Red;">${element.cmsContent}</p>');
    //       break;
    //   }
    // });
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextView(
                  "About Coupled",
                  size: 22,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  color: CoupledTheme().planCardBackground,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    child: TextView(
                      CoupledStrings.cmsAboutUs,
                      size: 15,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.justify,
                      textScaleFactor: .8,
                      maxLines: 50,
                    ),
                    // Html(data: about.outerHtml),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    //debugPrint('APis.cmsTerms--------');
                    // debugPrint(APis.cmsPrivacyPolicy);
                    GlobalWidgets().launchURL(url: APis.cmsPrivacyPolicy);
                  },
                  child: Card(
                    color: CoupledTheme().planCardBackground,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextView(
                            "Privacy Policy",
                            size: 18,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    //debugPrint('APis.cmsTerms--------');
                    debugPrint(APis.cmsRefundPolicy);
                    GlobalWidgets().launchURL(url: APis.cmsRefundPolicy);
                  },
                  child: Card(
                    color: CoupledTheme().planCardBackground,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextView(
                            "Refund Policy",
                            size: 18,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint('APis.cmsTerms--------');
                    debugPrint(APis.cmsTerms);
                    GlobalWidgets().launchURL(url: APis.cmsTerms);
                  },
                  child: Card(
                    color: CoupledTheme().planCardBackground,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextView(
                            "Terms & Conditions",
                            size: 18,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    GlobalWidgets().launchURL(url: APis.cmsSuccessStories);
                  },
                  child: Card(
                    color: CoupledTheme().planCardBackground,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextView(
                            "Success Stories",
                            size: 18,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            textScaleFactor: .8,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
