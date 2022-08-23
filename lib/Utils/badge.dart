import 'package:flutter/material.dart';

class Badge extends StatefulWidget {
  final Widget badgeContent;
  final Color badgeColor;
  final Widget child;
  final double elevation;
  final bool toAnimate;
  final EdgeInsets padding;
  final Duration animationDuration;
  final double borderRadius;
  final bool showBadge;

  Badge({
    Key? key,
    required this.badgeContent,
    required this.child,
    this.badgeColor = Colors.red,
    this.elevation = 2,
    this.toAnimate = true,
    this.padding = const EdgeInsets.all(5.0),
    this.animationDuration = const Duration(milliseconds: 500),
    this.borderRadius = 0.0,
    this.showBadge = true,
  }) : super(key: key);

  @override
  BadgeState createState() {
    return BadgeState();
  }
}

class BadgeState extends State<Badge> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final Tween<double> _scaleTween = Tween<double>(begin: 0.1, end: 1);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    /*if (widget.animationType == BadgeAnimationType.slide) {
      _animation = CurvedAnimation(
          parent: _animationController, curve: Curves.elasticOut);
    } else if (widget.animationType == BadgeAnimationType.scale) {
      _animation = _scaleTween.animate(_animationController);
    } else if (widget.animationType == BadgeAnimationType.fade) {
      _animation =
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    }*/

    _animation = _scaleTween.animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.child == null) {
      return _getBadge();
    } else {
      return Stack(
        // overflow: Overflow.visible,
        children: [
          widget.child,
          /*BadgePositioned(
            position: widget.position,
            child: _getBadge(),
          ),*/

          Positioned(
              top: -8,
              right: -10,
              /* bottom: position.bottom,
            left: -10,*/

              child: _getBadge())
        ],
      );
    }
  }

  ///badge
  Widget _getBadge() {
    RoundedRectangleBorder? border = MaterialType.circle == MaterialType.circle
        ? null
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0));

    Widget badgeView() {
      return AnimatedOpacity(
        child: Material(
          shape: border,
          type: MaterialType.circle,
          elevation: widget.elevation,
          color: widget.badgeColor,
          child: Padding(
            padding: widget.padding,
            child: widget.badgeContent,
          ),
        ),
        opacity: widget.showBadge ? 1 : 0,
        duration: Duration(milliseconds: 200),
      );
    }

    ScaleTransition(
      scale: _animation,
      child: badgeView(),
    );

    return badgeView();
  }

  @override
  void didUpdateWidget(Badge oldWidget) {
    if (widget.badgeContent is Text && oldWidget.badgeContent is Text) {
      Text newText = widget.badgeContent as Text;
      Text oldText = oldWidget.badgeContent as Text;
      if (newText.data != oldText.data) {
        _animationController.reset();
        _animationController.forward();
      }
    }

    if (widget.badgeContent is Icon && oldWidget.badgeContent is Icon) {
      Icon newIcon = widget.badgeContent as Icon;
      Icon oldIcon = oldWidget.badgeContent as Icon;
      if (newIcon.icon != oldIcon.icon) {
        _animationController.reset();
        _animationController.forward();
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
