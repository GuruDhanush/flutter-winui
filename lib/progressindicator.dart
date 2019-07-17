import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class LinearProgressIndicator extends StatefulWidget {


  const LinearProgressIndicator({
    Key key,
    this.value,
    this.valueColor,
    this.backgroundColor
  }) : super(key: key);


  final double value;
  final Color backgroundColor;
  final Color valueColor;


  @override
  _LinearProgressIndicatorState createState() => _LinearProgressIndicatorState();

}

class _LinearProgressIndicatorState extends State<LinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation( parent: _controller, curve: Curves.fastOutSlowIn)
    );
    if(widget.value == null) {
      //TODO: Potentially bad, use an animated builder
      _controller.addListener((){
        setState(() {
          
        });
      });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  
  @override
  void didUpdateWidget(LinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating)
      _controller.repeat();
    else if (widget.value != null && _controller.isAnimating)
      _controller.stop();
  }

  @override
  Widget build(BuildContext context) {
    final _backgroundColor = widget.backgroundColor != null ? widget.backgroundColor : Color(0xFFCCCCCC);
    final _valueColor = widget.valueColor != null ? widget.valueColor : Theme.of(context).accentColor; 
    return Container(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: 5.0
      ),
      child: CustomPaint(
        painter: _linearProgressPainter(
          backgroundColor: _backgroundColor,
          value: widget.value,
          valueColor: _valueColor,
          animatedValue: _controller.value,
        ),
      ),
    );
  }
}

class _linearProgressPainter extends CustomPainter {

  const _linearProgressPainter({
    this.value,
    this.backgroundColor,
    this.valueColor,
    this.animatedValue
  });

  final Color backgroundColor;
  final Color valueColor;
  final double value;
  final double animatedValue;



  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    if(value != null) {
      canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paint);
      if(value <= 0)
        return;
      
      paint.color = valueColor;
      canvas.drawRect(Rect.fromLTRB(0, 0, value.clamp(0.0, 1.0) * size.width, size.height), paint);
    }
    else {
      var radius = 3.0;

      paint.color = valueColor;

      canvas 
          ..drawCircle(Offset(size.width/2 * animatedValue, size.height/2), radius, paint)
          ..drawCircle(Offset((size.width/2 - 10) * animatedValue, size.height/2), radius, paint)
          ..drawCircle(Offset((size.width/2 - 20) * animatedValue, size.height/2), radius, paint)
          ..drawCircle(Offset((size.width/2 - 30) * animatedValue, size.height/2), radius, paint)
          ..drawCircle(Offset((size.width/2 - 40) * animatedValue, size.height/2), radius, paint);
    }

  }

  @override
  bool shouldRepaint(_linearProgressPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor
        || oldPainter.value != value
        || oldPainter.valueColor != valueColor
        || oldPainter.animatedValue != animatedValue;
  }

}
