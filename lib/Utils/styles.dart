import 'package:flutter/material.dart';

class CoupledTheme {
  final Color backgroundColor = Color(0xFF34374b);
  final Color inactiveColor = Color(0xff717483);
  final Color linkedInColor = Color(0xff0077B5);

//  final Color navIconInactColor = Color(0xffc6c6c6);
  final Color yellowShortList = Color(0xffeefd00);
  final Color tabSelectedColor = Color(0xff555766);
  final Color dashboardCardColor = Color(0xff555766);
  final Color tabActiveTextColor = Color(0xfff9dbb6);
  final Color verticalTabBgColor = Color(0xffb3b3b3);
  final Color primaryPinkDark = Color(0xffbc1c86);
  final Color primaryPink = Color(0xffed2c92);
  final Color primaryBlue = Color(0xff2fa3dc);
  final Color primaryBlueDark = Color(0xff0a83b4);
  final Color primaryBlueVerification = Color(0xff0073ff);
  final Color planCardBackground = Color(0xff485369);
  final Color backgroundHighlight = Color(0xff4D5467);
  final Color greenOnline = Color(0xff0eed12);
  final Color tabColor1 = Color(0xff6f7494);
  final Color tabColor2 = Color(0xff4b5076);
  final Color tabColor3 = Color(0xff404461);
  final Color thirdSelectionColor = Color(0xffc2c2c2);
  final Color ashSelectedColor = Color(0xff9d9d9d);
  final Color ashUnSelectedColor = Color(0xffd6d8d6);
  final Color cardBackgroundColor = Color(0xff6b7181);
  final Color myPlanCardBackgroundColor = Color(0xff4d5467);
  final Color patnerChatColor = Color(0xff303143);
  final Color myChatColor = Color(0xff4a4b5d);
  final Color fairColor = Color(0xffedb98a);
  final Color wheatColor = Color(0xffb06f51);
  final Color darkColor = Color(0xff825035);
  final Color newcoupledColor = Color(0xff58595e);

  //Dimensions
  final double smallIcon = 16.0;
  final double mediumIcon = 20.0;
  final double largeIcon = 25.0;

  ThemeData coupledTheme() {
    return ThemeData(
      fontFamily: 'Bariol',
      accentColor: Color(0xFF35374C),
      primaryColor: primaryPink,
      backgroundColor: Color(0xFF35374C),
      canvasColor: Colors.white,
      hintColor: Colors.white,
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xffbc1b87),
      ),

/*      SliderThemeData.fromPrimaryColors(
		    primaryColor: Colors.amberAccent,
		    primaryColorDark: Colors.red,
		    primaryColorLight: Colors.yellow,
		    valueIndicatorTextStyle: TextStyle(color: activeColor,)),*/
      /*     sliderTheme: SliderThemeData(
          activeTrackColor: primaryPink,
          inactiveTrackColor: inactiveColor,
          trackHeight: 2.0,
          trackShape: RectangularSliderTrackShape(),
          tickMarkShape: RoundSliderTickMarkShape(),
          overlayShape: RoundSliderThumbShape(),
          thumbShape: RoundSliderThumbShape(),
          valueIndicatorShape: RoundSliderOverlayShape(),
          showValueIndicator: ShowValueIndicator.always,
          valueIndicatorTextStyle: TextStyle(color: Colors.black)),*/
    );
  }

  ThemeData coupledTheme2() {
    return ThemeData(
      fontFamily: 'Bariol',
      accentColor: Color(0xFF35374C),
      primaryColor: primaryBlue,
      backgroundColor: Color(0xFF35374C),
      canvasColor: Colors.transparent,
      hintColor: Colors.white,
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xffbc1b87),
      ),
/*      SliderThemeData.fromPrimaryColors(
          primaryColor: Colors.amberAccent,
          primaryColorDark: Colors.red,
          primaryColorLight: Colors.yellow,
          valueIndicatorTextStyle: TextStyle(color: activeColor,)),*/
      sliderTheme: SliderThemeData(
          activeTrackColor: primaryPink,
          inactiveTrackColor: inactiveColor,
          trackHeight: 2.0,
          trackShape: RectangularSliderTrackShape(),
          tickMarkShape: RoundSliderTickMarkShape(),
          overlayShape: RoundSliderThumbShape(),
          thumbShape: RoundSliderThumbShape(),
          valueIndicatorShape: RoundSliderOverlayShape(),
          showValueIndicator: ShowValueIndicator.never,
          valueIndicatorTextStyle: TextStyle(color: Colors.black)),
    );
  }

  defaultTextStyle(
          {required Color color,
          required double lineSpacing,
          required TextOverflow overflow,
          required FontWeight fontWeight,
          required TextAlign textAlign,
          required TextDecoration decoration}) =>
      TextStyle(
        letterSpacing: 0.5,
        decoration: decoration,
        height: lineSpacing,
        color: color != null ? color : Colors.white,
        textBaseline: TextBaseline.alphabetic,
        fontWeight: fontWeight != null ? fontWeight : FontWeight.bold,
        fontFamily: 'Bariol',
        fontSize: 14,
      );
}
