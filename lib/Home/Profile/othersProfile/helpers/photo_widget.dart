import 'package:coupled/REST/RestAPI.dart';

import 'package:coupled/models/profile.dart';
import 'package:flutter/material.dart';

Widget photoWidget(Dp photo) {
  return Container(
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.network(
          APis().imageApi(
            photo.photoName,
          ),
          // fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              gradient: LinearGradient(
                  colors: [
                    Colors.black26,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black87,
                  ],
                  stops: [
                    0.02,
                    0.12,
                    0.50,
                    0.75,
                    1.0
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter)),
        ),
      ],
    ),
  );
}
