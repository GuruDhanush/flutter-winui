import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FluentComboBox extends StatefulWidget {
  @override
  _FluentComboBoxState createState() => _FluentComboBoxState();
}

class _FluentComboBoxState extends State<FluentComboBox>
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

  void onTap() {
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 150.0,
        ),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            border: Border.fromBorderSide(BorderSide(
                color: Colors.black, style: BorderStyle.solid, width: 3.0))),
        height: 40.0,
        child: Row(
          children: <Widget>[
            Text('Select One'),
            Expanded(
              child: Container(),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.black,)
            
          ],
        )
      ),
    );
  }
}
