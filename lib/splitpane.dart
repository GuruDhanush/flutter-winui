import 'dart:ui';

import 'package:example_flutter/ListTile.dart';
import 'package:example_flutter/basic/button.dart';
import 'package:example_flutter/comboboxroute.dart';
import 'package:example_flutter/example/buttongroup.dart';
import 'package:example_flutter/example/checkboxgroup.dart';
import 'package:example_flutter/example/comboboxgroup.dart';
import 'package:example_flutter/example/radiogroup.dart';
import 'package:example_flutter/example/uwptyperamp.dart';
import 'package:example_flutter/fluenticons.dart';
import 'package:example_flutter/flyout.dart';
import 'package:example_flutter/progressindicator.dart' as prefix0;
import 'package:example_flutter/basic/radio.dart';
import 'package:example_flutter/scrollbar.dart';
import 'package:example_flutter/textfield.dart' as prefix1;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SplitPane extends StatefulWidget {
  @override
  _SplitPaneState createState() => _SplitPaneState();
}

enum PaneType {
  Overlay,
  Inline,
  CompactOverlay,
  CompactInline,
}

class _SplitPaneState extends State<SplitPane>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  bool isOpen = true;
  PaneType paneType = PaneType.Inline;
  Animation<Offset> fadeTrans;

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //     vsync: this, duration: const Duration(milliseconds: 400));
    // fadeTrans = Tween<Offset>(begin: Offset(-1, -1), end: Offset.zero)
    //     .animate(_controller)
    //       ..addListener(() {
    //         setState(() {
    //           print('upda ${fadeTrans.value.dx} , ${fadeTrans.value.dy}');
    //         });
    //       });
    //_controller.reset();
    //_controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget childPane(BuildContext context, Widget innerChild, Widget outerChild) {
    final leftPane = Container(
      color: Color(0xFFF2F2F2),
      width: isOpen ? 320 : 50,
      child: innerChild,
    );
    final rightPane = Container(
      color: Colors.white,
      child: outerChild,
    );

    if (paneType == PaneType.Inline) {
      return Row(
        children: <Widget>[leftPane, Expanded(child: rightPane)],
      );
    } else if (paneType == PaneType.Overlay) {
      return Stack(
        children: <Widget>[rightPane, leftPane],
      );
    }
  }

  double val = 0.4;
  String dropVal = 'One';
  final GlobalKey _comboKey = GlobalKey();
  final GlobalKey _flyoutKey = GlobalKey();
  final FocusNode focusNode = FocusNode();

  int pageNum = 5;

  void _changePage(int page) {
    //times =  0;
    if (pageNum == page) return;

    setState(() {
      pageNum = page;
    });
  }

  int times = 0;

  Widget _getPage(int pageNum) {
    // print(_controller.value);
    // //_controller.stop(canceled: false);
    // if(_controller.value == 1 && times < 1) {
    //   times++;
    //   _controller.reset();
    // }
    // else if(_controller.value == 0) {
    //   _controller.animateTo(1);
    //  // _controller.forward(from: , );
    // }
    // _controller
    //   //..reset()
    //   ..forward();
    switch (pageNum) {
      case 1:
        return UWPTypeRamp();
      case 2:
        return CheckBoxRadioGroup();
      case 3:
        return RadioGroup();
      case 4:
        return ButtonGroup();
      case 5:
        return ComboBoxGroup();
      default:
        return Center(
          child: Text(
            'Default page',
            style: theme.header,
          ),
        );
    }
  }

  Widget get currentPage => _getPage(pageNum);

  @override
  Widget build(BuildContext context) {
    Widget innerChild = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FittedBox(
          fit: BoxFit.contain,
          child: FluentButton(
            child: Icon(FluentIcons.globalnavigationbutton),
            onPressed: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
          ),
        ),
        Expanded(
          child: FluentScrollbar(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                FluentListTile(
                  title: Text(
                    'UWP type ramp',
                    style: theme.body,
                  ),
                  leading: Icon(FluentIcons.megaphone),
                  onTap: () => _changePage(1),
                ),
                FluentListTile(
                  title: Text(
                    'Checkbox',
                    style: theme.body,
                  ),
                  leading: Icon(FluentIcons.checkboxcomposite),
                  onTap: () => _changePage(2),
                ),
                FluentListTile(
                  title: Text(
                    'Radio Button',
                    style: theme.body,
                  ),
                  leading: Icon(FluentIcons.radiobtnon),
                  onTap: () => _changePage(3),
                ),
                FluentListTile(
                  title: Text(
                    'Buttons',
                    style: theme.body,
                  ),
                  leading: Icon(FluentIcons.megaphone),
                  onTap: () => _changePage(4),
                ),
                FluentListTile(
                  title: Text(
                    'Combo Box',
                    style: theme.body,
                  ),
                  leading: Icon(FluentIcons.megaphone),
                  onTap: () => _changePage(5),
                )
              ],
            ),
          ),
        ),
        //Text('Hello World', style: Theme.of(context).textTheme.subhead,),
        FluentListTile(
          leading: Icon(FluentIcons.settings),
          title: Text(
            'Settings',
            style: Theme.of(context).textTheme.body1,
          ),
          onTap: () => _changePage(5),
          hover: true,
        )
      ],
    );

    //_controller.forward();
    Widget outerChild = Container(
        color: Colors.white, margin: EdgeInsets.all(20.0), 
        child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 50,
                    ),
                    child: currentPage
                  ))
    );
    // Center(
    //   child: new Column(
    //     children: <Widget>[

    //       // FittedBox(
    //       //   fit: BoxFit.contain,
    //       //                 child: Container(
    //       //     color: Colors.red,
    //       //     child: FluentRadioButton(
    //       //       title: 'Mango',
    //       //       selected: false,
    //       //     ),
    //       //   ),
    //       // ),

    //       //LinearProgressIndicator(value: null),
    //       //LinearProgressIndicator(value: 0.5,),
    //       //prefix0.LinearProgressIndicator(value: val),
    //       // Padding(
    //       //   padding: EdgeInsets.all(20.0),
    //       // ),
    //       // FluentButton(
    //       //   child: Text('Increase'),
    //       //   onPressed: () {
    //       //     setState(() {
    //       //       val += 0.01;
    //       //       if (val > 1.0) val = 0.0;
    //       //     });
    //       //   },
    //       // ),
    //       // Padding(
    //       //   padding: EdgeInsets.all(20.0),
    //       // ),
    //       // //prefix0.LinearProgressIndicator(),
    //       // Padding(
    //       //   padding: EdgeInsets.all(20.0),
    //       // ),
    //       //CircularProgressIndicator(value:val,),
    //       // FluentButton(
    //       //   child: Text('Open'),
    //       //   onPressed: () {
    //       //     setState(() {
    //       //       isOpen = !isOpen;
    //       //     });
    //       //   },
    //       // ),
    //       // Padding(
    //       //   padding: EdgeInsets.all(10.0),
    //       // ),
    //       // FluentButton(
    //       //   child: Text(
    //       //     paneType.toString(),
    //       //   ),
    //       //   onPressed: () {
    //       //     if (paneType == PaneType.Inline)
    //       //       paneType = PaneType.Overlay;
    //       //     else
    //       //       paneType = PaneType.Inline;

    //       //     setState(() {});
    //       //   },
    //       // ),
    //       // Padding(
    //       //   padding: EdgeInsets.all(5.0),
    //       // ),
    //       // FluentListTile(
    //       //   leading: Icon(FluentIcons.megaphone),
    //       //   title: Text(
    //       //     'hello title',
    //       //     style: Theme.of(context).textTheme.subhead,
    //       //     overflow: TextOverflow.clip,
    //       //   ),
    //       //   hover: true,
    //       // ),

    //       // FluentButton(
    //       //   key: _comboKey,
    //       //   child: Text('Combo box'),
    //       //   onPressed: () {
    //       //     final RenderBox renderBox =
    //       //         _comboKey.currentContext.findRenderObject();
    //       //     final position = renderBox.localToGlobal(Offset.zero);
    //       //     final size = renderBox.size;
    //       //     Navigator.push(
    //       //         context, ComboBoxRoute(position: position, size: size));
    //       //   },
    //       // ),
    //       // Padding(
    //       //   padding: EdgeInsets.all(5.0),
    //       // ),
    //       // FluentButton(
    //       //   key: _flyoutKey,
    //       //   child: Text('Empty Cart'),
    //       //   onPressed: () {
    //       //     final child = Container(
    //       //       color: Color(0xFFF2F2F2),
    //       //       padding:
    //       //           EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    //       //       child: Column(
    //       //         crossAxisAlignment: CrossAxisAlignment.start,
    //       //         children: <Widget>[
    //       //           Text(
    //       //             'All items will be removed. Do you want to continue?',
    //       //             style: Theme.of(context)
    //       //                 .textTheme
    //       //                 .subhead
    //       //                 .copyWith(fontWeight: FontWeight.bold),
    //       //           ),
    //       //           Padding(
    //       //             padding: EdgeInsets.all(5.0),
    //       //           ),
    //       //           FluentButton(
    //       //             child: Text('Yes, empty my cart'),
    //       //             onPressed: () {
    //       //               Navigator.pop(context);
    //       //             },
    //       //           )
    //       //         ],
    //       //       ),
    //       //     );
    //       //     Flyout.open(_flyoutKey, child, context);
    //       //   },
    //       // ),
    //       TextField(
    //         decoration: InputDecoration(
    //           border: OutlineInputBorder(),
    //           labelText: 'Name',
    //         ),
    //       ),
    //       CupertinoTextField(
    //         enableInteractiveSelection: true,
    //       ),
    //       prefix1.FluentTextField(),
    //       // DropdownButton<String>(
    //       //   value: dropVal,
    //       //   onChanged: (newVal) {
    //       //     setState(() {
    //       //      dropVal = newVal;
    //       //     });
    //       //   },
    //       //   items: <String>["One", "Two", "Three", "Four"]
    //       //         .map<DropdownMenuItem<String>>((val){
    //       //           return DropdownMenuItem<String>(
    //       //             value: val,
    //       //             child: Text(val),
    //       //           );
    //       //         }).toList(),
    //       // ),
    //     ],
    //   ),
    // ));

    return Container(
      child: childPane(context, innerChild, outerChild),
    );
  }
}

class ListDivider extends StatelessWidget {
  Color _themeColor = Color(0xFFB8B8B8);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      color: _themeColor,
    );
  }
}
