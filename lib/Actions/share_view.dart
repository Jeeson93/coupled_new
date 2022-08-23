import 'package:coupled/models/profile.dart';
import 'package:coupled/resources/repository.dart';
import 'package:coupled/src/coupled_global.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProfileBtn extends StatefulWidget {
  final String? membershipCode;
  final dynamic membership;

  const ShareProfileBtn({Key? key, this.membershipCode, this.membership})
      : super(key: key);

  @override
  _ShareProfileBtnState createState() => _ShareProfileBtnState();
}

class _ShareProfileBtnState extends State<ShareProfileBtn> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (GlobalData.myProfile.membership!.share ?? 0) == 1,
      child: IgnorePointer(
        ignoring: isPressed,
        child: InkWell(
          radius: 50.0,
          splashColor: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(50.0),
          onTap: () {
            setState(() {
              isPressed = true;
            });
            Repository().shareProfile(widget.membershipCode).then((onValue) {
              print(onValue.response?.msg);
              Share.share((onValue.response?.msg).toString());
              setState(() {
                isPressed = false;
              });
            });
          },
          child: Icon(
            Icons.share,
            color: Color(0xff10eee5),
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
