import 'package:flutter/material.dart';

class ComplexionSliderBuilder extends CustomPainter {
  final double sliderPosition;
  final double sliderPercent;
  final Color color;
  SliderController _sliderController;

  ComplexionSliderBuilder({
    required sliderPosition,
    required this.sliderPercent,
    required this.color,
    required SliderController sliderController,
  })  : this.sliderPosition = sliderPosition == 0.0 ? 75.0 / 2 : sliderPosition,
        _sliderController =
            sliderController == null ? SliderController() : sliderController;

  @override
  void paint(Canvas canvas, Size size) {
//    _paintAchors(canvas, size);
    _paintBar(canvas, size);
    _paintHandler(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  final Gradient gradient = LinearGradient(
    colors: <Color>[
      Color(0xfff3c6a5),
      Color(0xffedb98a),
      Color(0xffcb8061),
      Color(0xffb06f51),
      Color(0xff975b43),
      Color(0xff825035),
    ],
    stops: [
      0.0,
      0.30,
      0.60,
      0.80,
      0.90,
      1.0,
    ],
  );

  Rect _barSize = Rect.fromLTRB(0.0, 0.0, 350.0, 50);

  Shader handlePainterUpdater(double currentPosition, Size size) {
    int basePosition = (size.width / 4).round();

    if (currentPosition <= basePosition) {
      final Gradient gradient = LinearGradient(
        colors: <Color>[
//          Colors.amber,
//          Colors.amberAccent
          Color(0xfff3c6a5),
          Color(0xffedb98a),
        ],
        stops: [
          0.0,
          1.0,
        ],
      );
      return gradient.createShader(_barSize);
    } else if (currentPosition > basePosition &&
        currentPosition <= basePosition * 3) {
      final Gradient gradient = LinearGradient(
        colors: <Color>[
          Color(0xffcb8061),
          Color(0xffb06f51),
        ],
        stops: [
          0.0,
          1.0,
        ],
      );

      return gradient.createShader(_barSize);
    } else if (currentPosition >= basePosition * 3 ||
        currentPosition <= basePosition * 4) {
      final Gradient gradient = LinearGradient(
        colors: <Color>[
          Color(0xff975b43),
          Color(0xff825035),
        ],
        stops: [
          0.0,
          1.0,
        ],
      );

      return gradient.createShader(_barSize);
    } else {
      return gradient.createShader(Rect.fromLTRB(0.0, 0.0, 350.0, 50));
    }
  }

  void _paintBar(Canvas canvas, Size size) {
    print("Size ${size.width}");
    Path path = Path();
    path.moveTo(0.0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..shader = gradient.createShader(_barSize)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10);
  }

  void _paintHandler(Canvas canvas, Size size) {
    double centerPoint = sliderPosition - _sliderController.width / 2;
    centerPoint = (centerPoint > size.width) ? size.width : centerPoint;

    Rect backRect = Offset(centerPoint, (size.height / 2) - 10) &
        Size(_sliderController.width, _sliderController.height);
    RRect backRRect = RRect.fromRectAndRadius(backRect, Radius.circular(50.0));
    canvas.drawRRect(
        backRRect,
        Paint()
          ..color = Colors.black54
          ..style = PaintingStyle.fill);

//    Rect frontRect =  Rect.fromLTRB(0.0+centerPoint, (size.height / 2) - 10 , _sliderController.width+centerPoint, _sliderController.height);
    Rect frontRect = Offset(centerPoint, (size.height / 2) - 12) &
        Size(_sliderController.width, _sliderController.height);
    RRect frontRRect =
        RRect.fromRectAndRadius(frontRect, Radius.circular(50.0));
    canvas.drawRRect(
      frontRRect,
      Paint()
        ..color = color
        ..shader = handlePainterUpdater(centerPoint, size)
        ..style = PaintingStyle.fill,
    );
  }
}

class SliderController {
  final double height = 25.0;
  final double width = 75.0;
}
