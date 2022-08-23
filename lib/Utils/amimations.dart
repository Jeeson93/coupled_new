import 'package:flutter/material.dart';

class CustomAnimation {
  fadeIn(AnimationController controller) =>
      Tween(begin: 0.5, end: 1.0).animate(controller);

  fadeOut(AnimationController controller) =>
      Tween(begin: 1.0, end: 0.5).animate(controller);
}
