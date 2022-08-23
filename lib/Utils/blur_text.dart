import 'dart:ui';

import 'package:flutter/material.dart';

class BlurFilter extends StatelessWidget {
  final Widget child;
  final double sigmaX;
  final double sigmaY;
  final bool enable;

  BlurFilter(
      {required this.child, this.enable = true, this.sigmaX = 2.5, this.sigmaY = 2.5});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: enable ? sigmaX : 0,
              sigmaY: enable ? sigmaY : 0,
            ),
            child: Opacity(
              opacity: enable ? 0.03 : 1,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}