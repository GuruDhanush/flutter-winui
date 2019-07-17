import 'package:flutter/widgets.dart';


class Flyout extends PopupRoute {

  static open(GlobalKey key, Widget child, BuildContext context) async {

      final RenderBox renderBox = key.currentContext.findRenderObject();
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      final result = await Navigator.push(context, Flyout(child: child, position: position, size: size));
  }

  Flyout({
    @required this.child,
    this.position,
    this.size,
    RouteSettings routeSettings,
  }) : super(settings: routeSettings);
    
  final Offset position;
  final Widget child;
  final Size size;

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Duration get transitionDuration => Duration(milliseconds: 10);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: position.dy + size.height + 10,
          left: position.dx,
          child: Container(
            child: child,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFBDBDBD),
                style: BorderStyle.solid,
                width: 1.0
              ),
              boxShadow: [
                 BoxShadow(
                color: Color(0xFFD5D5D5),
                blurRadius: 8.0,
                spreadRadius: 5.0,
              ),
              ],
            ),
          ) ,
        )
      ],
    );
  }

  
}