import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:flutter/material.dart';

Widget couplingScore(List<dynamic> freeCoupling) {
  return ListView.builder(
    itemCount: freeCoupling != null ? freeCoupling.length : 0,
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        width: 320,
        child: getCouplingScoreCard(freeCoupling, index),
      );
    },
  );
}

getCouplingScoreCard(freeCoupling, index) {
  List img = [
    "assets/Profile/Coupling-Score-2.png",
    "assets/Profile/Coupling-Score-3.png",
    "assets/Profile/Coupling-Score-5.png",
  ];
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 2,
    color: CoupledTheme().tabColor3,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.asset(
              freeCoupling[index].score == 1
                  ? img[1]
                  : freeCoupling[index].score == 0.5 ||
                          freeCoupling[index].score == 0.66
                      ? img[2]
                      : img[0],
              height: 50,
              width: 50,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextView(
                  freeCoupling[index].question,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  size: 16,
                  color: CoupledTheme().primaryBlue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.left,
                  textScaleFactor: .9,
                ),
                SizedBox(
                  height: 5,
                ),
                TextView(
                  freeCoupling[index].message,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.left,
                  textScaleFactor: .8,
                  size: 12,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
