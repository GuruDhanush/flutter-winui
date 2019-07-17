import 'package:example_flutter/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


final _textTheme = FluentTextTheme();

class FluentRadioButton<T> extends StatefulWidget {
  @override
  _FluentRadioButtonState<T> createState() => _FluentRadioButtonState<T>();

  const FluentRadioButton({
    Key key,
    this.title,
    this.value,
    this.groupValue,
    this.activeColor,
    this.onChanged,
  }) : super(key: key);

  final Widget title;
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Color activeColor;
}

///
///Values are from 'https://docs.microsoft.com/en-us/windows/uwp/design/controls-and-patterns/images/radiobutton-redlines.png'
///
///
class _FluentRadioButtonState<T> extends State<FluentRadioButton<T>> {

  bool get _enabled => widget.onChanged != null;
  
  bool _hovering = false;
  bool get _selected => widget.value == widget.groupValue; 
  /// when user clicks and holds the radio button, shows the effect of disabled 
  bool _touchDown = false;


  void _onHover(hovering) {
    setState(() {
      _hovering = hovering;
    });
  }

  void _onPointerEnter(PointerEnterEvent event) {
    if (_hovering) 
      return;
    _onHover(true);
  }

  void _onPointerExit(PointerExitEvent event) {
    if (!_hovering) 
      return;
    _onHover(false);
  }

  void _onTouchDown(touchDown) {
    setState(() {
     _touchDown = touchDown; 
    });
  }

  void _onPointerDown(PointerDownEvent event) {
    if(_touchDown) 
      return;
    _onTouchDown(true);
  }

  void _onPointerUp(PointerUpEvent event) {
    if(!_touchDown)
      return;
    _onTouchDown(false);

  }

  ///handles the onchange of click
  void _onClick() {
    if(widget.onChanged == null) 
      return;
    if(widget.value == widget.groupValue) 
      context.findRenderObject().markNeedsPaint();
    widget.onChanged(widget.value);    
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
                    painter: FluentRadioPainter(
                        selected: _selected, hovering: _hovering, disabled: !_enabled, touchDown: _touchDown),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                ),
                //widget.title
                DefaultTextStyle(
                  child: widget.title,
                  //TODO: disabled color
                  style: _enabled ? _textTheme.body.copyWith( color: Color(0xFF000000)) : _textTheme.body.copyWith( color: Color(0x66000000)),
                  textAlign: TextAlign.left,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ));
  }
}

class FluentRadioPainter extends CustomPainter {
  FluentRadioPainter({
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

  @override
  void paint(Canvas canvas, Size size) {
    //print('rebuilding ${canvas.hashCode} selected: $selected, hovering: $hovering, touchdown:: $touchDown, disabled: $disabled');
    const offsetX = 12.0;
    final offsetY = size.height/2;
    const outerRadius = 11.0;
    const innerRadius = 6.0;

    final outerPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
    final innerPaint = Paint()
        ..style = PaintingStyle.fill;
    
    if(disabled | touchDown) {
      //TODO: BaseMediumLow - light - disabled
      outerPaint.color = Color(0x66000000);
      canvas.drawCircle(Offset(offsetX, offsetY), outerRadius, outerPaint);
      if(selected) {
        //TODO: BaseMediumLow - light - disabled
        innerPaint.color = Color(0x66000000);
        canvas.drawCircle(Offset(offsetX, offsetY), innerRadius, innerPaint);
      }
    }
    else if(selected) {
      outerPaint.color = _textTheme.accentColor;
      if(hovering) {
        innerPaint.color = Colors.black;
      } else {
        //TODO: BaseMediumHigh - light - rest
        innerPaint.color = Color(0xCC000000);
      }

      canvas
        ..drawCircle(Offset(offsetX, offsetY), outerRadius, outerPaint)
        ..drawCircle(Offset(offsetX, offsetY), innerRadius, innerPaint);

    }
    else {
      if(hovering) {
        outerPaint.color = Color(0xFF000000);
      }
      else {
        //TODO: BaseMedium - light -- eyeballed
        outerPaint.color = Color(0x99000000);
      }
      canvas.drawCircle(Offset(offsetX, offsetY), outerRadius, outerPaint);
    }    
  }

  @override
  bool shouldRepaint(FluentRadioPainter oldDelegate) {
    return oldDelegate.selected != selected 
        || oldDelegate.hovering != hovering
        || oldDelegate.disabled != disabled
        || oldDelegate.touchDown != touchDown;
  }
}
