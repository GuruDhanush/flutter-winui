import 'package:example_flutter/example/checkboxgroup.dart';
import 'package:example_flutter/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../fluenticons.dart';

///The pane display mode in Navigation view
enum PaneDisplayMode {
  ///Shows the navigation in the top bar. This can show 5 or fewer top level items and the rest
  ///end up in an dropdown overflow menu. They are considered less important. This is **not an adaptive
  ///option**, see [PaneDisplayMode.adaptiveTopToLeft] for similar use. Icons won't show up in the nav item.
  top,

  ///This expands the pane and is positioned to the left of the content. This may contain 5-10 important
  ///top level nav items. This will make navigation look prominent and takes up the space from the content.
  ///This is **not an adaptive option**.
  left,

  ///The pane shows only icons until it is expanded. It is positioned left to the content. This occupies less
  ///space compared to left. This is **not an adaptive option**.
  leftCompact,

  ///The pane shows only the hamburger menu until its opened. Widely used in smaller screens. The hamburger
  ///is positioned to the top left of the screen. This is **not an adaptive option**.
  leftMinimal,

  ///In adaptiveAuto, the view moves from leftMinimal when the screen is narrow to leftCompact in medium size
  ///and left finally as the screen gets wider.
  adaptiveAuto,

  /// The pane shows up in the top when in large and medium size screens and transforms to leftMinimal when in
  /// small. This is **an adaptive option**.
  adaptiveTopToLeft,

  /// The pane shows only the hamburger menu button on both small and medium screens and  an expanded
  /// left pane in wider screen. This is **an adaptive option**.
  adaptiveMinimal,

  /// The pane shows expanded left on wider screens and swithes to icon only left compact when in
  /// medium and small screens. This is **an adaptive option**.
  adaptiveCompact,
}

class AdaptiveTrigger<T> {
  Trigger<T> large;
  Trigger<T> medium;
  Trigger<T> small;

  AdaptiveTrigger({this.large, this.medium, this.small});

  AdaptiveTrigger.constVal(T val)
      : this(
            large: Trigger.large(val),
            medium: Trigger.medium(val),
            small: Trigger.small(val));

  AdaptiveTrigger.fromVals(T large, T medium, T small)
      : this(
            large: Trigger.large(large),
            medium: Trigger.medium(medium),
            small: Trigger.small(small));

  T value(double width) {
    if (large.isInRange(width)) return large.value;
    if (medium.isInRange(width)) return medium.value;
    if (small.isInRange(width)) return small.value;
    return large.value;
  }
}

class Trigger<T> {
  double min;
  double max;
  T value;

  Trigger({this.min, this.max, this.value});

  Trigger.small(T val)
      : this(min: double.negativeInfinity, max: 640, value: val);
  Trigger.medium(T val) : this(min: 641, max: 1007, value: val);
  Trigger.large(T val) : this(min: 1008, max: double.infinity, value: val);

  bool isInRange(double width) => width >= min && width <= max;
}

// class NavigationView extends StatefulWidget {
//   @override
//   _NavigationViewState createState() => _NavigationViewState();

//   final PaneDisplayMode paneDisplayMode;
//   final List<Widget> navItems;
//   final Widget autoSuggestBox;
//   final List<Widget> footer;
//   final Widget title;
//   final VoidCallback onClickedNav;
//   final AdaptiveTrigger<PaneDisplayMode> adaptiveTrigger;
// }

// class _NavigationViewState extends State<NavigationView> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ,

//     );
//   }
// }

const double _kLeftPaneExpandedWidth = 320;
const double _kLeftPaneCompactWidth = 40;
const Size _kSelectedLeftPillSize = Size(6, 24);
const Size _kSelectedTopPillSize = Size(20, 2);
const Size _kDefaultNavItemIconSize = Size.square(16);
const double _kDefaultNavItemSize = 50.0;

class NavListTile extends StatefulWidget {
  @override
  _NavListTileState createState() => _NavListTileState();

  NavListTile({
    @required Key key,
    this.leading,
    @required this.title,
    this.onClicked,
    this.selected = false,
    this.horizantal = false,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  VoidCallback onClicked;
  final bool selected;
  final bool horizantal;
}

class _NavListTileState extends State<NavListTile> {
  bool _hovering = false;
  bool _selected = false;
  bool get _disabled => widget.onClicked != null;

  void _onHover(bool hovering) {
    setState(() {
      _hovering = hovering;
    });
  }

  void onPointerEnter(PointerEnterEvent event) {
    if (_hovering) return;
    _onHover(true);
  }

  void onPointerExit(PointerExitEvent event) {
    if (!_hovering) return;
    _selected = false;
    _onHover(false);
  }

  void onTapDown(TapDownDetails event) {
    if (_selected) return;
    onSelected(true);
  }

  void onTapUp(TapUpDetails event) {
    if (!_selected) return;
    onSelected(false);
  }

  onSelected(bool selected) {
    setState(() {
      _selected = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _leading = widget.leading is Icon
        ? Padding(
            padding: EdgeInsets.all(12),
            child: widget.leading,
          )
        : widget.leading;

    var textStyle = DefaultTextStyle.of(context).style.copyWith(
          color: _disabled
              ? ThemeColor.baseMediumLow
              : widget.selected && widget.horizantal
                  ? ThemeColor.baseHigh
                  : ThemeColor.baseMedium,
        );

    Color itemColor = Colors.transparent;
    if (_hovering) itemColor = ListTheme.ListLow;
    if (_selected) itemColor = ListTheme.ListMedium;

    return Listener(
      onPointerEnter: onPointerEnter,
      onPointerExit: onPointerExit,
      child: GestureDetector(
        onTapDown: onTapDown,
        onTapUp: onTapUp,
        onTap: widget.onClicked,
        child: Container(
          color: itemColor,
          height: _kDefaultNavItemSize,
          child: DefaultTextStyle(
            style: textStyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[_leading, widget.title],
            ),
          ),
        ),
      ),
    );
  }
}

class Pane extends StatefulWidget {
  @override
  _PaneState createState() => _PaneState();

  final Widget autoSuggestBox;
  final List<Widget> navViewItems;
  final List<Widget> footer;
  final Widget title;
  final VoidCallback onClickedNavItem;
  final PaneDisplayMode paneDisplayMode;

  Pane(
      {this.navViewItems,
      this.autoSuggestBox,
      this.footer,
      this.title,
      this.onClickedNavItem,
      this.paneDisplayMode});
}

class _PaneState extends State<Pane> with SingleTickerProviderStateMixin {
  AnimationController controller;
  GlobalKey _listItemKey = GlobalKey();
  bool _reverse = false;
 
    @override
    void initState() {
    //super.initState();
    navViewItems = <Widget>[
      NavListTile(
          key: GlobalKey(),
          leading: Icon(FluentIcons.megaphone),
          title: Text('Item 1'),
          onClicked: () => onSelectedItem(1), 
          horizantal: _horizantal, 
          selected: _selected == 1,),
      NavListTile(
          key: GlobalKey(),
          leading: Icon(FluentIcons.megaphone),
          title: Text('Item 2'),
          onClicked: () => onSelectedItem(2),
          horizantal: _horizantal,
          selected: _selected == 2,),
      NavListTile(
          key: GlobalKey(),
          leading: Icon(FluentIcons.megaphone),
          title: Text('Item 3'),
          onClicked: () => onSelectedItem(3),
          horizantal: _horizantal,
          selected: _selected == 3,)];
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    // widget.navViewItems.forEach((item) {
    //   var _item = item as NavListTile;
    //   _item.onClicked = () => onSelectedItem;
    // });
  }

  PaneDisplayMode paneOrientation(AdaptiveTrigger<PaneDisplayMode> trigger) {
    var width = MediaQuery.of(context).size.width;
    var mode = trigger.value(width);

    return mode;
  }
 
  @override
  void dispose() {
    controller.dispose(); 
    super.dispose();
  }

  List<Widget> navViewItems = [];

  Animation<Offset> startAnim;
  Animation<Offset> endAnim;

  Offset _startPoint = Offset.zero;
  Offset _endPoint = Offset.zero.translate(0, 30);
  bool get _horizantal => true;
  int _selected;

  void onSelectedItem(int selected) {
    print('selected $selected');
    //already in the same item
    if (selected == _selected) return;

    startAnim = endAnim = null;
    RenderBox box = (navViewItems[selected].key as GlobalKey)
        .currentContext
        .findRenderObject();

    var size = box.size;
    var pos = box.localToGlobal(Offset.zero,
        ancestor: _listItemKey.currentContext.findRenderObject());

    _reverse = selected < _selected;

    if (!_reverse) {
      Offset endStart;
      Offset endEnd;

      if (_horizantal) {
        endStart = Offset(pos.dx, 0);
        endEnd = Offset(pos.dx + size.width, 0);
      } else {
        endStart = Offset(0, pos.dy);
        endEnd = Offset(0, pos.dy + size.height);
      }

      startAnim = Tween<Offset>(begin: _endPoint, end: endEnd).animate(
          CurvedAnimation(
              parent: controller,
              curve: Interval(0.0, 0.5, curve: Curves.ease)))
        ..addListener(() {
          setState(() {
            _endPoint = startAnim.value;
          });
        });

      endAnim = Tween<Offset>(begin: _startPoint, end: endStart).animate(
          CurvedAnimation(
              parent: controller,
              curve: Interval(0.5, 1.0, curve: Curves.ease)))
        ..addListener(() {
          setState(() {
            _startPoint = endAnim.value;
          });
        });
    } else {
      Offset endStart;
      Offset endEnd;
      if (_horizantal) {
        endStart = Offset(pos.dx, 0);
        endEnd = Offset(pos.dx + size.width, 0);
      } else {
        endStart = Offset(0, pos.dy);
        endEnd = Offset(0, pos.dy + size.height);
      }

      startAnim = Tween<Offset>(begin: _startPoint, end: endStart).animate(
          CurvedAnimation(
              parent: controller,
              curve: Interval(0.0, 0.5, curve: Curves.ease)))
        ..addListener(() {
          setState(() {
            _startPoint = startAnim.value;
          });
        });

      endAnim = Tween<Offset>(begin: _endPoint, end: endEnd).animate(
          CurvedAnimation(
              parent: controller,
              curve: Interval(0.5, 1.0, curve: Curves.ease)))
        ..addListener(() {
          setState(() {
            _endPoint = endAnim.value;
          });
        });
    }

    controller.forward(from: 0);
    _selected = selected;
  }

  @override
  Widget build(BuildContext context) {
    
    var _horizantal = true;
     if (MediaQuery.of(context).size.width > 800) {
      _horizantal = true;
    } else {
      _horizantal = false;
    }
    navViewItems = <Widget>[
      NavListTile(
          key: GlobalKey(),
          leading: Icon(FluentIcons.megaphone),
          title: Text('Item 1'),
          onClicked: () => onSelectedItem(1), 
          horizantal: _horizantal, 
          selected: _selected == 1,),
      NavListTile(
          key: GlobalKey(),
          leading: Icon(FluentIcons.megaphone),
          title: Text('Item 2'),
          onClicked: () => onSelectedItem(2),
          horizantal: _horizantal,
          selected: _selected == 2,), 
      NavListTile(
          key: GlobalKey(),
          leading: Icon(FluentIcons.megaphone),
          title: Text('Item 3'),
          onClicked: () => onSelectedItem(3),
          horizantal: _horizantal,
          selected: _selected == 3,)];
    
    return Container(
      child: CustomPaint(
          key: _listItemKey,
          foregroundPainter: NavPill(
              left: _startPoint, right: _endPoint, horizantal: _horizantal),
          child: MediaQuery.of(context).size.width > 800
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: navViewItems)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: navViewItems,
                )),
    );
  }
}

class NavPill extends CustomPainter {
  NavPill({this.left, this.right, this.horizantal});

  //bool horizantal;
  final Offset left;
  final Offset right;
  final bool horizantal;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = theme.accentColor
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    var _left = left;
    var _right = right;

    if (horizantal) {
      _left = _left.translate(0, size.height);
      _right = _right.translate(0, size.height);
    }

    canvas.drawLine(_left, _right, paint);
  }

  @override
  bool shouldRepaint(NavPill oldDelegate) {
    return oldDelegate.left != left || oldDelegate.right != right;
  }
}
