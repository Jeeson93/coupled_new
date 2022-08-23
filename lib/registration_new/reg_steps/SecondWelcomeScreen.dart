import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';

import 'package:coupled/registration_new/helpers/get_section_data.dart';
import 'package:flutter/material.dart';

import '../get_bottom_button.dart';

class SecondWelcomeScreen extends StatefulWidget {
  static String route = 'SecondWelcomeScreen';
  @override
  _SecondWelcomeScreenState createState() => _SecondWelcomeScreenState();
}

class _SecondWelcomeScreenState extends State<SecondWelcomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoupledTheme().backgroundColor,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        alignment: FractionalOffset.topCenter,
                        image: AssetImage('assets/Love-Banner.png'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextView(
                        "It was interesting to know you thus far!",
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
                        "It's time to explore\nwhat you are looking for in a life partner. Coupled is"
                        " designed to match & map your personality on Physical and Psycological"
                        " aspects with a partner. Our researched and carefully selected set of"
                        " Q&As give you compelling insights about a match.",
                        size: 16.0,
                        lineSpacing: 1.5,
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.visible,
                        textScaleFactor: .8,
                        maxLines: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          getBottomNavigationButtons(step: 16, params: getSectionEleven())
        ],
      ),
    );
  }
}
