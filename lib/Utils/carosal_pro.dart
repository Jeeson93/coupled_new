import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Carousel extends StatefulWidget {
  ///All the images on this Carousel.
  final List<Widget> widget;

  ///To customize the dots
  final DotsDecorator dotsDecorator;

  ///The transition animation timing curve. Default is [Curves.ease]
  final Curve animationCurve;

  ///The transition animation duration. Default is 300ms.
  final Duration animationDuration;

  ///Enable or Disable the indicator (dots). Default is true
  final bool showIndicator;

  ///Move the Indicator From the Bottom
  final double moveIndicatorFromBottom;

  ///Enable/Disable the auto play of the slider. Default true
  final StreamController<bool> carouselController;

  ///Duration of the Auto play slider by seconds. Default 6 seconds
  final Duration autoplayDuration;

  final PageController controller;
  final Function(int) onPageChaged;

  Timer timer = Timer(Duration(milliseconds: 1500), () {});

  Carousel(
      {required this.widget,
      this.animationCurve = Curves.ease,
      this.animationDuration = const Duration(milliseconds: 1000),
      this.showIndicator = true,
      this.moveIndicatorFromBottom = 0.0,
      required this.controller,
      required this.onPageChaged,
      required this.dotsDecorator,
      this.autoplayDuration = const Duration(seconds: 6),
      required this.carouselController})
      : assert(widget != null),
        assert(animationCurve != null),
        assert(animationDuration != null);

  @override
  State createState() => CarouselState();
}

class CarouselState extends State<Carousel> {
  late PageController _controller;
  int currentPage = 0;
  late Timer timer;

  @override
  void initState() {
    _controller = widget.controller;
    pageAutoScroll(true);
    if (widget.carouselController != null)
      widget.carouselController.stream.listen((onData) {
        pageAutoScroll(onData);
      });
    super.initState();
  }

  void pageAutoScroll(bool autoPlay) {
    if (autoPlay) {
      timer = Timer.periodic(
          widget.autoplayDuration,
          (Timer timer) => widget.controller.nextPage(
                duration: widget.animationDuration,
                curve: widget.animationCurve,
              ));
    } else {
      print("Calling $timer");
      timer.cancel();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Builder(
          builder: (context) => PageView.builder(
            itemBuilder: (context, index) {
              return widget.widget[index % widget.widget.length];
            },
            physics: AlwaysScrollableScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentPage = index % widget.widget.length;
                if (widget.onPageChaged != null)
                  widget.onPageChaged(currentPage);
              });
            },
          ),
        ),
        widget.showIndicator
            ? Container(
                margin: EdgeInsets.only(bottom: widget.moveIndicatorFromBottom),
                child: Align(
                  alignment: Alignment(0, 1),
                  child: DotsIndicator(
                    dotsCount: widget.widget.length,
                    position: currentPage.roundToDouble(),
                    decorator: widget.dotsDecorator,
                  ),
                ),
              )
            : Container()

        /*   LimitedBox(
          maxWidth: 300.0,
          maxHeight: 150.0,
          child: PageView.builder(
            itemBuilder: (context, index) => widget.widget[index],
            physics: AlwaysScrollableScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {},
          ),
        ),
        widget.showIndicator
            ? Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.dotBgColor == null ? Colors.transparent : widget.dotBgColor,
                    borderRadius: widget.borderRadius
                        ? (widget.noRadiusForIndicator
                            ? null
                            : BorderRadius.only(
                                bottomLeft: widget.radius != null ? widget.radius : Radius.circular(8.0),
                                bottomRight: widget.radius != null ? widget.radius : Radius.circular(8.0)))
                        : null,
                  ),
                  padding: EdgeInsets.all(widget.indicatorBgPadding),
                  child: Center(
                    child: DotsIndicator(
                      controller: _controller,
                      itemCount: widget.widget.length,
                      color: widget.dotColor,
                      dotSize: widget.dotSize,
                      dotSpacing: widget.dotSpacing,
                      dotIncreaseSize: widget.dotIncreaseSize,
                      onPageSelected: (int page) {
                        _controller.animateToPage(
                          page,
                          duration: widget.animationDuration,
                          curve: widget.animationCurve,
                        );
                      },
                    ),
                  ),
                ),
              )
            : Container(),*/
      ],
    );
  }
}
