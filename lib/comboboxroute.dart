import 'package:example_flutter/ListTile.dart';
import 'package:example_flutter/basic/button.dart';
import 'package:example_flutter/fluenticons.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ComboBoxRoute extends PopupRoute {
  ComboBoxRoute({this.position, this.size, this.routeSettings})
      : super(settings: routeSettings);

  final Offset position;
  final Size size;
  final RouteSettings routeSettings;

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
      
    //print(context.);
    return Stack(
      children: <Widget>[
        Positioned(
          top: position.dy,
          left: position.dx,
          width: size.width,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              FluentListTile(title: Text('one', style: Theme.of(context).textTheme.subhead)),
              FluentListTile(title: Text('two', style: Theme.of(context).textTheme.subhead)),
              FluentListTile(title: Text('three', style: Theme.of(context).textTheme.subhead)),
              FluentListTile(title: Text('four', style: Theme.of(context).textTheme.subhead)),
              FluentListTile(title: Text('five', style: Theme.of(context).textTheme.subhead)),
              
            ],
          ),
        
        ),
      ],
    );
  }
}
