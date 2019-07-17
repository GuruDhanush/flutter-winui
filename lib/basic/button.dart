import 'dart:async';

import 'package:example_flutter/example/checkboxgroup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///An fluent style button
class HyperLinkButton extends StatefulWidget {
  /// creates an fluent button
  const HyperLinkButton({
    Key key,
    @required this.child,
    @required this.onPressed,
  });

  final Widget child;

  final VoidCallback onPressed;

  @override
  _HyperLinkButtonState createState() => _HyperLinkButtonState();
}

class _HyperLinkButtonState extends State<HyperLinkButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _handleTapDown(TapDownDetails event) {}

  void _handleTapUP(TapUpDetails event) {}

  void _handleTapCancel() {}

  void _animate() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Semantics(
        button: true,
        child: ConstrainedBox(),
      ),
    );
  }
}

class FluentButton extends StatefulWidget {
  const FluentButton({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.backgroundColor,
    this.delay =const Duration(milliseconds: 500),
    this.interval = const Duration(milliseconds: 100),
    this.buttonType = FluentButtonType.normal
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;
  /// An inital period of wait after which the button starts to repeat clicks
  final Duration delay;
  /// The time between each of the repetetive clicks 
  final Duration interval;
  final FluentButtonType buttonType;

  @override
  _FluentButtonState createState() => _FluentButtonState();
}


enum FluentButtonType {
  /// Normal button
  normal,
  /// A repeat button where the click event occurs continously while the user clicks the button
  repeat,
}

class _FluentButtonState extends State<FluentButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  bool _hovering = false;
  bool get _disabled => widget.onPressed == null;
  bool _pressed = false;

  bool repeatedMode = false;
  Timer repeatTimer;
  Timer initTimer;

  Color get _btnColor =>
      widget.backgroundColor ??
      (_pressed ? Color(0x66000000) : Color(0x33000000));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, value: 1.0)
      ..addStatusListener((d) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onTap() {
    if (_disabled) 
      return;
    if(widget.buttonType != FluentButtonType.repeat || !repeatedMode)
      widget.onPressed();
  }

  void onTapUp(TapUpDetails event) {
    if(widget.buttonType == FluentButtonType.repeat) {
      repeatTimer?.cancel();
      initTimer?.cancel();
      repeatedMode = false;
    }
    _pressed = false;
    _controller.animateTo(1.0, duration: Duration(milliseconds: 100));
  }

  void onTapDown(TapDownDetails event)  {
    _pressed = true;
    _controller.animateBack(0.98, duration: Duration(milliseconds: 100));
    if(widget.buttonType == FluentButtonType.repeat) {
    // the delay mode 
      initTimer = Timer(widget.delay, (){
        //gets called after the delay
        repeatedMode = true;
        widget.onPressed();
         repeatTimer = Timer(widget.interval, _repeatClick);
      });
    }
  }

  void _repeatClick() {
    if(repeatedMode) {
      widget.onPressed();
      repeatTimer = Timer(widget.interval, _repeatClick);
    }
  }

  void _hover(bool hovering) {
    setState(() {
      _hovering = hovering;
    });
  }

  void _onPointerEnter(PointerEnterEvent event) {
    if (_hovering) return;
    _hover(true);
  }

  void _onPointerExit(PointerExitEvent event) {
    if (!_hovering) return;
    _hover(false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTap: onTap,
      child: Transform.scale(
        scale: _controller.value,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 60.0, minHeight: 40.0),
          child: Listener(
            onPointerEnter: _onPointerEnter,
            onPointerExit: _onPointerExit,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: _btnColor,
                border: Border.all(
                    color: _hovering ? Color(0x66000000) : Color(0x00000000),
                    style: BorderStyle.solid,
                    width: 2.0),
              ),
              child: DefaultTextStyle(
                style: theme.body.copyWith(
                    color: _disabled ? Color(0x66000000) : Color(0xFF000000)),
                child: Center(
                  heightFactor: 1.0,
                  widthFactor: 1.0,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


///TODO: think of an extension
class RepeatButton extends StatelessWidget {

  const RepeatButton({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.backgroundColor,
    this.delay,
    this.interval
  });

  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;

  ///Waits for the specified time before starting the action
  final Duration delay;
  ///Specifies the time between repetitions of a click.
  final Duration interval;

  void _onStartTap() {
    var t = Timer(delay, _onTap);
  }

  void _onTap() {


    //Timer t = Timer(, callback)


  }

  @override
  Widget build(BuildContext context) {
    return FluentButton(
      child: child,
      onPressed: _onTap,
      backgroundColor: backgroundColor,
      key: key,
    );
  }

}
