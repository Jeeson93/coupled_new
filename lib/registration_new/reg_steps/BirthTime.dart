import 'package:coupled/Utils/global_widgets.dart';
import 'package:flutter/material.dart';

class BirthTime extends StatefulWidget {
  final String hour, minute, format;
  final dynamic getTime;

  BirthTime(this.hour, this.minute, this.format, {this.getTime});

  @override
  State<StatefulWidget> createState() {
    return BirthTimeScreen(hour, minute, format, getTime);
  }

/*  String getTime() {
    return "$hour : $minute $format";
  }

  void _setTime(BirthTime birthtime) {
    BirthTime(birthtime.hour, birthtime.minute, birthtime.format);
  }*/
}

class BirthTimeScreen extends State<BirthTime> {
  String hour = '', minute = '', format = '';
  dynamic getTime;
  dynamic textEditingController;

  BirthTimeScreen(this.hour, this.minute, this.format, this.getTime);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  if (int.tryParse(hour)! < 12)
                    hour = ("${int.tryParse(hour)! + 1}").padLeft(2, '0');
                  else
                    hour = "1".padLeft(2, '0');
                  getTime("$hour : $minute $format");
                });
              },
              child: Container(
                  padding: EdgeInsets.all(5.0),
                  color: Colors.transparent,
                  child: Icon(Icons.expand_less, color: Colors.grey)),
            ),
            TextView(
              hour,
              color: Colors.black,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              size: 12,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (int.tryParse(hour)! > 1)
                    hour = ("${int.tryParse(hour)! - 1}");
                  else
                    hour = "12";
                  getTime("$hour : $minute $format");
                });
              },
              child: Container(
                  padding: EdgeInsets.all(5.0),
                  color: Colors.transparent,
                  child: Icon(Icons.expand_more, color: Colors.grey)),
            ),
          ],
        ),
        TextView(
          ":",
          color: Colors.black,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.visible,
          size: 12,
          textAlign: TextAlign.center,
          textScaleFactor: .8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  if (int.tryParse(minute)! < 59)
                    minute = ("${int.tryParse(minute)! + 1}").padLeft(2, '0');
                  else
                    minute = "0".padLeft(2, '0');
                  getTime("$hour : $minute $format");
                });
              },
              child: Container(
                  padding: EdgeInsets.all(5.0),
                  color: Colors.transparent,
                  child: Icon(Icons.expand_less, color: Colors.grey)),
            ),
            TextView(
              minute,
              color: Colors.black,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              size: 12,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (int.tryParse(minute)! > 00)
                    minute = ("${int.tryParse(minute)! - 1}").padLeft(2, '0');
                  else
                    minute = "59".padLeft(2, '0');
                  getTime("$hour : $minute $format");
                });
              },
              child: Container(
                  padding: EdgeInsets.all(5.0),
                  color: Colors.transparent,
                  child: Icon(Icons.expand_more, color: Colors.grey)),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  format = "PM";
                  getTime("$hour : $minute $format");
                });
              },
              child: Container(
                  padding: EdgeInsets.all(5.0),
                  color: Colors.transparent,
                  child: Icon(
                    Icons.expand_less,
                    color: Colors.grey,
                  )),
            ),
            TextView(
              format,
              color: Colors.black,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.visible,
              size: 12,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  format = "AM";
                  getTime("$hour : $minute $format");
                });
              },
              child: Container(
                  padding: EdgeInsets.all(5.0),
                  color: Colors.transparent,
                  child: Icon(Icons.expand_more, color: Colors.grey)),
            ),
          ],
        ),
      ],
    );
  }
}
