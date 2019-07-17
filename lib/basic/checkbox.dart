import 'package:example_flutter/example/checkboxgroup.dart';
import 'package:example_flutter/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final _textTheme = FluentTextTheme();

class FluentCheckbox extends StatefulWidget {
  @override
  _FluentCheckboxState createState() => _FluentCheckboxState();

  const FluentCheckbox({
    Key key,
    this.title,
    this.selected = false,
    this.activeColor,
    this.tickColor,
    this.onChanged,
    this.triState = false,
  }) : super(key: key);

  final Widget title;
  final bool selected;
  final bool triState;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color tickColor;
}

///
///Values are from 'https://docs.microsoft.com/en-us/windows/uwp/design/controls-and-patterns/images/radiobutton-redlines.png'
///
///
class _FluentCheckboxState extends State<FluentCheckbox> {
  bool get _enabled => widget.onChanged != null;

  bool _hovering = false;
  bool _selected;
  bool get selected => widget.selected; // ?? _selected;

  /// when user clicks and holds the radio button, shows the effect of disabled
  bool _touchDown = false;

  @override
  void initState() {
    super.initState();
    if(widget.triState == null || widget.triState == false) {
      _selected = widget.selected ?? false;
    }
  }

  void _onHover(hovering) {
    setState(() {
      _hovering = hovering;
    });
  }

  void _onPointerEnter(PointerEnterEvent event) {
    if (_hovering) return;
    _onHover(true);
  }

  void _onPointerExit(PointerExitEvent event) {
    if (!_hovering) return;
    _onHover(false);
  }

  void _onTouchDown(touchDown) {
    setState(() {
      _touchDown = touchDown;
    });
  }

  void _onPointerDown(PointerDownEvent event) {
    if (_touchDown) return;
    _onTouchDown(true);
  }

  void _onPointerUp(PointerUpEvent event) {
    if (!_touchDown) return;
    _onTouchDown(false);
  }

  ///handles the onchange of click
  void _onClick() {
    _selected = widget.selected;
    if (widget.onChanged == null) return;
    if(!widget.triState) {
      assert(_selected != null);
      _selected = !_selected;
    }
    else {
      if(_selected == null) _selected = false;
      else if(!_selected) _selected = true;
      else _selected = null;
    }
    context.findRenderObject().markNeedsPaint();
    widget.onChanged(_selected);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerEnter: _onPointerEnter,
        onPointerExit: _onPointerExit,
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        child: GestureDetector(
          onTap: _onClick,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 32, minWidth: 120),
            child: Row(
              children: <Widget>[
                SizedBox.fromSize(
                  size: Size.fromRadius(13.0),
                  child: CustomPaint(
                    painter: FluentCheckboxPainter(
                        selected: widget.selected,
                        hovering: _hovering,
                        disabled: !_enabled,
                        touchDown: _touchDown),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                ),
                //widget.title
                DefaultTextStyle(
                  child: widget.title,
                  //TODO: disabled color
                  style: _enabled
                      ? _textTheme.body.copyWith(color: Color(0xFF000000))
                      : _textTheme.body.copyWith(color: Color(0x66000000)),
                  textAlign: TextAlign.left,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ));
  }
}

class FluentCheckboxPainter extends CustomPainter {
  FluentCheckboxPainter({
    this.selected = false,
    this.hovering = false,
    this.touchDown = false,
    this.disabled = false,
  }); // : super(repaint: repaint);

  bool selected;
  bool hovering;

  /// touch down is invoked when users holds the checkbox down, this shows the effect of checkbox
  /// being disabled.
  bool touchDown;
  bool disabled;

  //TODO: Check the calculations for good
  void drawTick(Canvas canvas, Size size, {Color tickColor}) {
    var paint = Paint()
      ..color = tickColor ?? Colors.white //TODO: Check the tick color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    var path = Path()
      ..moveTo(3, size.height / 2) //from (0, 0) to (0, half height)
      ..lineTo(size.width / 2 - 3,
          size.height - 6.0) //from (0, half height) to bottom center ()
      ..lineTo(size.width - 6, 6); // from bottom center to top right

    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    const offsetX = 12.0;
    final offsetY = size.height / 2;
    const outerRadius = 11.0;
    const innerRadius = outerRadius - 1.0;
    const disabledColor = Color(0x66000000);
    const disablingRadius = 6.0;
    const touchDownColor = Color(0x99000000);
    const normalColor = Color(0xCC000000);

    final outerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    final innerPaint = Paint()..style = PaintingStyle.fill;

    if (disabled) {
      outerPaint.color = disabledColor;
      innerPaint.color = disabledColor;
      canvas.drawRect(
          Rect.fromCircle(
              center: Offset(offsetX, offsetY), radius: outerRadius),
          outerPaint);
      if (selected == null) {
        canvas.drawRect(
            Rect.fromCircle(
                center: Offset(offsetX, offsetY), radius: disablingRadius),
            innerPaint);
      } else if (selected) {
        drawTick(canvas, size, tickColor: disabledColor);
      }
    }
    //tristate
    else if (selected == null) {
      outerPaint.color = theme.accentColor;

      if (hovering) {
        innerPaint.color = Color(0xFF000000);
      } else if (touchDown) {
        outerPaint.color = touchDownColor;
        innerPaint.color = touchDownColor;
      } else {
        innerPaint.color = normalColor;
      }
      canvas
          ..drawRect(Rect.fromCircle(center: Offset(offsetX, offsetY), radius: outerRadius),outerPaint)
          ..drawRect(Rect.fromCircle(center: Offset(offsetX, offsetY), radius: disablingRadius),innerPaint);
      
    } else if (selected) {
      if (hovering) {
        outerPaint.color = Color(0xFF000000);
        innerPaint.color = theme.accentColor;
      } else if (touchDown) {
        outerPaint.color = touchDownColor;
        innerPaint.color = touchDownColor;
      } else {
        outerPaint.color = theme.accentColor;
        innerPaint.color = theme.accentColor;
      }

      canvas
        ..drawRect(
            Rect.fromCircle(
                center: Offset(offsetX, offsetY), radius: innerRadius),
            innerPaint)
        ..drawRect(
            Rect.fromCircle(
                center: Offset(offsetX, offsetY), radius: outerRadius),
            outerPaint);
      drawTick(canvas, size);
    } 
    else {
      if (hovering) {
        outerPaint.color = Color(0xFF000000);
      } else if (touchDown) {
        outerPaint.color = touchDownColor;
        innerPaint.color = touchDownColor;
        canvas.drawRect(
            Rect.fromCircle(
                center: Offset(offsetX, offsetY), radius: innerRadius),
            innerPaint);
      } else {
        outerPaint.color = Color(0xCC000000);
      }

      canvas.drawRect(
          Rect.fromCircle(
              center: Offset(offsetX, offsetY), radius: outerRadius),
          outerPaint);
    }
  }

  @override
  bool shouldRepaint(FluentCheckboxPainter oldDelegate) {
    return oldDelegate.selected != selected ||
        oldDelegate.hovering != hovering ||
        oldDelegate.disabled != disabled ||
        oldDelegate.touchDown != touchDown;
  }
}
