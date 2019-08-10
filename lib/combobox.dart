import 'package:example_flutter/ListTile.dart';
import 'package:example_flutter/comboboxroute.dart';
import 'package:example_flutter/fluenticons.dart';
import 'package:example_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FluentComboBox extends StatefulWidget {
  FluentComboBox({
    Key key,
    this.items
  }) : super(key: key);


  final List<Widget> items;


  @override
  _FluentComboBoxState createState() => _FluentComboBoxState();
}

class _FluentComboBoxState extends State<FluentComboBox>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final GlobalKey _key = GlobalKey();

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

  void onTap() async {
    RenderBox renderBox = context.findRenderObject();
    var pos = renderBox.localToGlobal(renderBox.size.topLeft(Offset.zero));

    List<Widget> updatedItems = [];
    for(var i = 0; i < widget.items.length; i++) {
      FluentListTile tempItem = widget.items[i];
      VoidCallback callFunc = tempItem.onTap;
      updatedItems.add(
        FluentListTile(title: tempItem.title, leading: tempItem.leading, onTap: () {
          _onTap(i);
          callFunc();
        },)
      ); 
    }
       
    double translated = 0;
    if(_selected != null && _selected > 0) translated = -(_selected) * 50.0; 
    var result = Navigator.push(context,
        ComboBoxRoute(position: pos.translate(0, translated) , size: context.size, items: updatedItems));
    _selected = (await result) as int;
    setState(() {

    });
  }

  int _selected;

  _onTap(int selected) {
    Navigator.pop(context, selected);
  }


  String _selectedText(int selected) {

    if(selected == null) return 'Select one';
    if(widget.items.length > selected && selected >= 0) {
      return ((widget.items[selected] as FluentListTile).title as Text).data;
    }
    return 'Select one';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
          constraints:
              BoxConstraints(maxWidth: 400.0, minWidth: 296.0, minHeight: 28.0),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              border: Border.fromBorderSide(BorderSide(
                  color: ThemeColor.baseMediumLow,
                  style: BorderStyle.solid,
                  width: 3.0))),
          child: Row(
            children: <Widget>[
              Text(_selectedText(_selected)),
              Expanded(
                child: Container(),
              ),
              
              Icon(
                FluentIcons.chevrondown,
                color: Colors.black,
                size: 15.0,
              )
            ],
          )),
    );
  }
}
