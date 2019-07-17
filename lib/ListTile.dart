import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';


class FluentListTile extends StatefulWidget {
  @override
  _FluentListTileState createState() => _FluentListTileState();

  Key key;
  FluentListTile({
    this.key,
    @required this.title,
    this.leading,
    this.onTap,
    this.onLongPress,
    this.hover
  }): super(key: key);

  Widget leading;
  Widget title;
  GestureTapCallback onTap;
  GestureLongPressCallback onLongPress;
  bool hover = false;
  bool isHover = false;

}

class _FluentListTileState extends State<FluentListTile> {


  bool _isHover = false; 


  void onPointerEnter(PointerEnterEvent event) {
    if(_isHover)
      return;
    setState(() {
     _isHover = true; 
    });
  }

  void onPointerExit(PointerExitEvent event) {
    if(!_isHover)
      return;
    setState(() {
    _isHover = false; 
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Listener(
        onPointerEnter: onPointerEnter,
        onPointerExit: onPointerExit,
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 13.0),
        color: _isHover ? Color(0xFFCFCFCF) : Color(0xFFF2F2F2),
        child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                widget.leading != null ? widget.leading : Container(height: 0, width: 0,),
                Padding(padding: EdgeInsets.all(5.0),),
                widget.title,
              ],
            ),
          ),
      ),
      
    );
  }
}