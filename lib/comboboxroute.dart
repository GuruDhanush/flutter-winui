import 'package:example_flutter/ListTile.dart';
import 'package:example_flutter/basic/button.dart';
import 'package:example_flutter/example/checkboxgroup.dart';
import 'package:example_flutter/fluenticons.dart';
import 'package:example_flutter/scrollbar.dart';
import 'package:example_flutter/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ComboBoxRoute<T> extends PopupRoute {
  ComboBoxRoute({this.position, this.size, this.routeSettings, this.items})
      : super(settings: routeSettings);

  final Offset position;
  final Size size;
  final RouteSettings routeSettings;
  final List<Widget> items;

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'combo box list';

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: position.dy,
          left: position.dx,
          width: size.width,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                width: 1,
                color: ThemeColor.baseLow
              ),
              boxShadow: [  
              BoxShadow(blurRadius: 15, color: ThemeColor.baseLow, spreadRadius: 5)
            ]),
            child: Container(
                          child: ListView(
                shrinkWrap: true,
                children: this.items,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
