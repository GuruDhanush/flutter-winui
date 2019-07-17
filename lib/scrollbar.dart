import 'dart:async';

import 'package:flutter/widgets.dart';

const Duration _kScrollbarFadeDuration = Duration(milliseconds: 500);
const Duration _kScrollbarTimeToFade = Duration(seconds: 1);
const double _kScrollbarThickness = 4.0;
const double _kScrollbarMinLength = 36.0;
const double _kScrollbarMinOverscrollLength = 8.0;


class FluentScrollbar extends StatefulWidget {
  const FluentScrollbar({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _FluentScrollbarState createState() => _FluentScrollbarState();
}

class _FluentScrollbarState extends State<FluentScrollbar>
    with TickerProviderStateMixin {
  AnimationController _fadeoutAnimationController;
  Animation<double> _fadeoutOpacityAnimation;
  Timer _fadeoutTimer;
  ScrollbarPainter _scrollbarPainter;
  Color _themeColor;

  @override
  void initState() {
    super.initState();
    _fadeoutAnimationController = AnimationController(
      vsync: this,
      duration: _kScrollbarFadeDuration,
    );
    _fadeoutOpacityAnimation = CurvedAnimation(
      parent: _fadeoutAnimationController,
      curve: Curves.fastOutSlowIn,
    );
    _themeColor = Color(0xFF858585);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollbarPainter = _buildScrollbarPainter();
  } 

  ScrollbarPainter _buildScrollbarPainter() {
    return ScrollbarPainter(
      color: _themeColor,
      textDirection: TextDirection.ltr,
      thickness: _kScrollbarThickness,
      padding: MediaQuery.of(context).padding,
      fadeoutOpacityAnimation: _fadeoutOpacityAnimation,
      minLength: _kScrollbarMinLength,
      minOverscrollLength: _kScrollbarMinOverscrollLength
    );
  }

  @override
  void dispose() {
    _fadeoutAnimationController.dispose();
    _fadeoutTimer?.cancel();
    _scrollbarPainter?.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollNotification ||
        notification is OverscrollNotification) {
      if (_fadeoutAnimationController.status != AnimationStatus.forward) {
        _fadeoutAnimationController.forward();
      }

      _scrollbarPainter.update(
          notification.metrics, notification.metrics.axisDirection);
      _fadeoutTimer?.cancel();
      _fadeoutTimer = Timer(_kScrollbarTimeToFade, () {
        _fadeoutAnimationController.reverse();
        _fadeoutTimer = null;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: RepaintBoundary(
        child: CustomPaint(
          foregroundPainter: _scrollbarPainter,
          child: RepaintBoundary(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
