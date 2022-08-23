import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileItemCard extends StatelessWidget {
  final String img, title;
  final Color color;

  ProfileItemCard({this.img = "", this.title = '', this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: CoupledTheme().tabColor1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Visibility(
              visible: img != "",
              child: GlobalWidgets()
                  .iconCreator(img, size: FixedIconSize.LARGE_30, color: color),
            ),
            SizedBox(
              width: 5,
            ),
            TextView(
              title ?? '',
              maxLines: 10,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
              size: 12,
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
          ],
        ),
      ),
    );
  }
}
