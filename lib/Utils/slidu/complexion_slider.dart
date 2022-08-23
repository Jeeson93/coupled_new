import 'package:coupled/Utils/global_widgets.dart';
import 'package:coupled/Utils/slidu/complexion_slider_builder.dart';
import 'package:coupled/models/base_settings_model.dart';
import 'package:flutter/material.dart';

class ComplexionSlider extends StatefulWidget {
  final dynamic width;
  final dynamic height;
  final Color color;
  final bool enabled;
  final Color handleColor;
  final List<BaseSettings> texts;
  final dynamic initialSlideValue;
  final dynamic onChanged;
  final dynamic onChangeStart;
  final dynamic onChangeEnd;

  const ComplexionSlider(
      {Key? key,
      this.width,
      this.height,
      this.initialSlideValue,
      this.enabled = true,
      this.color = Colors.pink,
      this.onChanged,
      this.onChangeStart,
      this.onChangeEnd,
      this.handleColor = Colors.pink,
      required this.texts});

  @override
  _ComplexionSliderState createState() => _ComplexionSliderState();
}

class _ComplexionSliderState extends State<ComplexionSlider>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  double _dragPercentage = 0.0;
  Offset _updateVal = Offset(0.0, 0.0);
  double _width = 0.0;
  SliderController sliderController = SliderController();
  Rect rect = Rect.fromCircle(
    center: Offset(165.0, 55.0),
    radius: 180.0,
  );

  dynamic testColor;
  dynamic _startValue;

  @override
  void didChangeDependencies() {
    print('widget.initialSlideValue---');
    print(widget.initialSlideValue);
    _startValue = sliderController.width / 3;
    _dragPosition = widget.initialSlideValue != null
        ? (MediaQuery.of(context).size.width /
                (widget.initialSlideValue == 3
                    ? MediaQuery.of(context).size.width * .016
                    : widget.initialSlideValue)) -
            (sliderController.width / 2)
        : sliderController.width / 3;
    testColor = widget.color;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  double val = 0.0;

  @override
  Widget build(BuildContext context) {
    print("_dragPosition $_startValue");
//    _dragPosition = sliderController.width * 4
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 75.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(widget.texts.length, (i) {
                  return TextView(
                    widget.texts[i].value ?? '',
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    size: 12,
                    textAlign: TextAlign.center,
                    textScaleFactor: .8,
                  );
                }),
              ),
              /*CustomSlider(
                value: val,
                min: 0.0,
                max: 2.0,
                thumbShape: CustomSliderThumbRect(),
                onChanged: (c) {
                  setState(() {
                    val = c;
                  });
                },
              ),*/
              GestureDetector(
                child: Container(
                  width: widget.width != null
                      ? _width = widget.width
                      : _width = constraints.biggest.width,
                  height: widget.height != null ? widget.height : 60.0,
                  child: CustomPaint(
                    painter: ComplexionSliderBuilder(
                      sliderPosition: _dragPosition,
                      color: testColor,
                      sliderPercent: _dragPercentage,
                      sliderController: SliderController(),
                    ),
                  ),
                ),
                onHorizontalDragUpdate: (DragUpdateDetails update) {
                  if (widget.enabled) _onDragUpdate(context, update);
                },
                onHorizontalDragStart: (DragStartDetails start) {
                  if (widget.enabled) _onDragStart(context, start);
                },
                onHorizontalDragEnd: (DragEndDetails end) {
                  if (widget.enabled) _onDragEnd(context, end);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset offset = box.globalToLocal(update.globalPosition);
    _updateDragPosition(offset);
  }

  _onDragStart(BuildContext context, DragStartDetails start) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset offset = box.globalToLocal(start.globalPosition);
    _updateDragPosition(offset);
  }

  _onDragEnd(BuildContext context, DragEndDetails end) {
    _endDragPosition(_updateVal);
  }

  @override
  void dispose() {
    super.dispose();
//    _slideController.dispose();
  }

  void _updateDragPosition(Offset val) {
    _updateVal = val;
    double dragPosition = _startValue;
    if (val.dx <= 0.0) {
      dragPosition = _startValue;
    } else if (val.dx >= _width) {
      dragPosition = _width - _startValue;
    } else {
      dragPosition = val.dx;
    }
    setState(() {
      _dragPosition = dragPosition;
      _dragPercentage = _dragPosition / _width;
    });
  }

  void _endDragPosition(Offset val) {
    double dragPosition = _startValue;
    double quarterPart = _width / 4;
    if (val.dx <= quarterPart * 0 ||
        val.dx >= quarterPart * 0 && val.dx <= quarterPart * 1) {
      dragPosition = _startValue;
    } else if (val.dx >= quarterPart * 1 && val.dx <= quarterPart * 2 ||
        val.dx >= quarterPart * 2 && val.dx <= quarterPart * 3) {
      dragPosition = _width / 2;
    } else if (val.dx >= quarterPart * 3 && val.dx <= quarterPart * 4 ||
        val.dx >= quarterPart * 4) {
      dragPosition = _width - _startValue;
    }

    setState(() {
      _dragPosition = dragPosition;
      print("DragPOsition : $_dragPosition");
      _dragPercentage = _dragPosition / _width;
      _handleChangeEnd(_dragPercentage);
    });
  }

  _handleChangeEnd(double val) {
    assert(widget.onChangeEnd != null);
    print(val.round());
    if (val > 0 && val < 0.5) {
      widget.onChangeEnd(widget.texts[0]);
    } else if (val >= 0.5 && val < .7) {
      widget.onChangeEnd(widget.texts[1]);
    } else if (val > 0.7) {
      widget.onChangeEnd(widget.texts[2]);
    }
  }
}

class CustomSliderThumbRect extends SliderComponentShape {
  final dynamic thumbRadius;
  final thumbHeight;
  final dynamic min;
  final dynamic max;

  const CustomSliderThumbRect({
    this.thumbRadius,
    this.thumbHeight,
    this.min,
    this.max,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  String getValue(double value) {
    return ((max) * (value)).round().toString();
  }

  @override
  void paint(PaintingContext context, Offset center,
      {dynamic activationAnimation,
      dynamic enableAnimation,
      dynamic isDiscrete,
      dynamic labelPainter,
      dynamic parentBox,
      dynamic sliderTheme,
      dynamic textDirection,
      dynamic value,
      dynamic textScaleFactor,
      dynamic sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, width: thumbHeight * 1.2, height: thumbHeight * .6),
      Radius.circular(thumbRadius * .4),
    );

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
        style: new TextStyle(
            fontSize: thumbHeight * .3,
            fontWeight: FontWeight.w700,
            color: sliderTheme.thumbColor,
            height: 0.9),
        text: '${getValue(value)}');
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(rRect, paint);
    tp.paint(canvas, textCenter);
  }
}
