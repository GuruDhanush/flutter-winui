import 'package:example_flutter/fluenticons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/rendering/editable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

// class TextField extends StatefulWidget {
//   @override
//   _TextFieldState createState() => _TextFieldState();

//   const TextField({
//     Key key,
//     this.textEditingController,
//     this.focusNode,
//     this.placeholder,
//     this.obscureText,
//     this.enableInteractiveSelection,
//     this.onChanged,
//     this.onEditingComplete,
//     this.onSubmitted,
//     this.decoration,
//     this.padding = const EdgeInsets.all(6.0),
//   }) : super(key: key);

//   final TextEditingController textEditingController;
//   final FocusNode focusNode;
//   final String placeholder;
//   final bool obscureText;
//   final bool enableInteractiveSelection;
//   final ValueChanged<String> onChanged;
//   final VoidCallback onEditingComplete;
//   final ValueChanged<String> onSubmitted;
//   final BoxDecoration decoration;
//   final EdgeInsetsGeometry padding;
// }

// class _TextFieldState extends State<TextField>
//     with AutomaticKeepAliveClientMixin {
//   TextEditingController _controller;
//   final GlobalKey<EditableTextState> _editableTextKey = GlobalKey<EditableTextState>(); 
//   final GlobalKey _clearGlobalKey = GlobalKey();

//   //FocusNode _focusNode;
//   FocusNode get _focusNode => widget.focusNode ??  FocusNode();
//   EditableTextState get _editableText => _editableTextKey.currentState;
//   RenderEditable get _renderEditable => _editableText.renderEditable; 

//   @override
//   void initState() {
//     super.initState();
//     if (widget.textEditingController == null) {
//       _controller = TextEditingController()..addListener(updateKeepAlive);
//     }
//   } 

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     _controller?.removeListener(updateKeepAlive);
//     super.dispose();

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//             color: Colors.black, style: BorderStyle.solid, width: 1.0),
//       ),
//       child: TextSelectionGestureDetector(

//         child: EditableText(
//           key: ,
//           enableInteractiveSelection: widget.enableInteractiveSelection,
//           selectionControls: cupertinoTextSelectionControls,
//           controller: _controller,
//           showCursor: true,
//           focusNode: _focusNode,
//           style: Theme.of(context).textTheme.subhead,
//           cursorColor: Colors.black,
//           backgroundCursorColor: Colors.red,
//         ),
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => _controller?.text?.isNotEmpty == true;
// }

class WindowsTextSelectionControls extends TextSelectionControls {

  @override
  Widget buildHandle(BuildContext context, TextSelectionHandleType type, double textLineHeight) {
    // TODO: implement buildHandle
    return null;
  }

  @override
  Widget buildToolbar(BuildContext context, Rect globalEditableRegion, double textLineHeight, Offset position, List<TextSelectionPoint> endpoints, TextSelectionDelegate delegate) {
    // TODO: implement buildToolbar
    return null;
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    // TODO: implement getHandleAnchor
    return null;
  }

  @override
  Size getHandleSize(double textLineHeight) {
    // TODO: implement getHandleSize
    return null;
  }

}


// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// import 'package:flutter/gestures.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';

// import 'colors.dart';
// import 'icons.dart';
// import 'text_selection.dart';
// import 'theme.dart';

//export 'package:flutter/services.dart' show TextInputType, TextInputAction, TextCapitalization;

// Value extracted via color reader from iOS simulator.
const BorderSide _kDefaultRoundedBorderSide = BorderSide(
  color: CupertinoColors.lightBackgroundGray,
  style: BorderStyle.solid,
  width: 0.0,
);
const Border _kDefaultRoundedBorder = Border(
  top: _kDefaultRoundedBorderSide,
  bottom: _kDefaultRoundedBorderSide,
  left: _kDefaultRoundedBorderSide,
  right: _kDefaultRoundedBorderSide,
);
// Counted manually on magnified simulator.
const BoxDecoration _kDefaultRoundedBorderDecoration = BoxDecoration(
  border: _kDefaultRoundedBorder,
  borderRadius: BorderRadius.all(Radius.circular(4.0)),
);

// Value extracted via color reader from iOS simulator.
const Color _kSelectionHighlightColor = Color(0x667FAACF);
const Color _kInactiveTextColor = Color(0xFFC2C2C2);
const Color _kDisabledBackground = Color(0xFFFAFAFA);

// An eyeballed value that moves the cursor slightly left of where it is
// rendered for text on Android so it's positioning more accurately matches the
// native iOS text cursor positioning.
//
// This value is in device pixels, not logical pixels as is typically used
// throughout the codebase.
const int _iOSHorizontalCursorOffsetPixels = -2;

/// Visibility of text field overlays based on the state of the current text entry.
///
/// Used to toggle the visibility behavior of the optional decorating widgets
/// surrounding the [EditableText] such as the clear text button.
enum OverlayVisibilityMode {
  /// Overlay will never appear regardless of the text entry state.
  never,

  /// Overlay will only appear when the current text entry is not empty.
  ///
  /// This includes pre-filled text that the user did not type in manually. But
  /// does not include text in placeholders.
  editing,

  /// Overlay will only appear when the current text entry is empty.
  ///
  /// This also includes not having pre-filled text that the user did not type
  /// in manually. Texts in placeholders are ignored.
  notEditing,

  /// Always show the overlay regardless of the text entry state.
  always,
}

/// An iOS-style text field.
///
/// A text field lets the user enter text, either with a hardware keyboard or with
/// an onscreen keyboard.
///
/// This widget corresponds to both a `UITextField` and an editable `UITextView`
/// on iOS.
///
/// The text field calls the [onChanged] callback whenever the user changes the
/// text in the field. If the user indicates that they are done typing in the
/// field (e.g., by pressing a button on the soft keyboard), the text field
/// calls the [onSubmitted] callback.
///
/// To control the text that is displayed in the text field, use the
/// [controller]. For example, to set the initial value of the text field, use
/// a [controller] that already contains some text such as:
///
/// {@tool sample}
///
/// ```dart
/// class MyPrefilledText extends StatefulWidget {
///   @override
///   _MyPrefilledTextState createState() => _MyPrefilledTextState();
/// }
///
/// class _MyPrefilledTextState extends State<MyPrefilledText> {
///   TextEditingController _textController;
///
///   @override
///   void initState() {
///     super.initState();
///     _textController = TextEditingController(text: 'initial text');
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return CupertinoTextField(controller: _textController);
///   }
/// }
/// ```
/// {@end-tool}
///
/// The [controller] can also control the selection and composing region (and to
/// observe changes to the text, selection, and composing region).
///
/// The text field has an overridable [decoration] that, by default, draws a
/// rounded rectangle border around the text field. If you set the [decoration]
/// property to null, the decoration will be removed entirely.
///
/// Remember to [dispose] of the [TextEditingController] when it is no longer needed.
/// This will ensure we discard any resources used by the object.
///
/// See also:
///
///  * <https://developer.apple.com/documentation/uikit/uitextfield>
///  * [TextField], an alternative text field widget that follows the Material
///    Design UI conventions.
///  * [EditableText], which is the raw text editing control at the heart of a
///    [TextField].
///  * Learn how to use a [TextEditingController] in one of our [cookbook recipe]s.(https://flutter.dev/docs/cookbook/forms/text-field-changes#2-use-a-texteditingcontroller)
class FluentTextField extends StatefulWidget {
  /// Creates an iOS-style text field.
  ///
  /// To provide a pre-filled text entry, pass in a [TextEditingController] with
  /// an initial value to the [controller] parameter.
  ///
  /// To provide a hint placeholder text that appears when the text entry is
  /// empty, pass a [String] to the [placeholder] parameter.
  ///
  /// The [maxLines] property can be set to null to remove the restriction on
  /// the number of lines. In this mode, the intrinsic height of the widget will
  /// grow as the number of lines of text grows. By default, it is `1`, meaning
  /// this is a single-line text field and will scroll horizontally when
  /// overflown. [maxLines] must not be zero.
  ///
  /// The text cursor is not shown if [showCursor] is false or if [showCursor]
  /// is null (the default) and [readOnly] is true.
  ///
  /// See also:
  ///
  ///  * [minLines]
  ///  * [expands], to allow the widget to size itself to its parent's height.
  ///  * [maxLength], which discusses the precise meaning of "number of
  ///    characters" and how it may differ from the intuitive meaning.
  const FluentTextField({
    Key key,
    this.controller,
    this.focusNode,
    this.decoration, // = _kDefaultRoundedBorderDecoration,
    this.padding = const EdgeInsets.all(6.0),
    this.placeholder,
    this.placeholderStyle = const TextStyle(
      fontWeight: FontWeight.w300,
      color: _kInactiveTextColor
    ),
    this.prefix,
    this.prefixMode = OverlayVisibilityMode.always,
    this.suffix,
    this.suffixMode = OverlayVisibilityMode.always,
    this.clearButtonMode = OverlayVisibilityMode.editing,
    TextInputType keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 1.0,
    this.cursorRadius, // = const Radius.circular(2.0),
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection,
    this.onTap,
    this.scrollController,
    this.scrollPhysics,
  }) : assert(textAlign != null),
       assert(readOnly != null),
       assert(autofocus != null),
       assert(obscureText != null),
       assert(autocorrect != null),
       assert(maxLengthEnforced != null),
       assert(scrollPadding != null),
       assert(dragStartBehavior != null),
       assert(maxLines == null || maxLines > 0),
       assert(minLines == null || minLines > 0),
       assert(
         (maxLines == null) || (minLines == null) || (maxLines >= minLines),
         'minLines can\'t be greater than maxLines',
       ),
       assert(expands != null),
       assert(
         !expands || (maxLines == null && minLines == null),
         'minLines and maxLines must be null when expands is true.',
       ),
       assert(maxLength == null || maxLength > 0),
       assert(clearButtonMode != null),
       assert(prefixMode != null),
       assert(suffixMode != null),
       keyboardType = keyboardType ?? (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
       super(key: key);

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController controller;

  /// Controls whether this widget has keyboard focus.
  ///
  /// If null, this widget will create its own [FocusNode].
  final FocusNode focusNode;

  /// Controls the [BoxDecoration] of the box behind the text input.
  ///
  /// Defaults to having a rounded rectangle grey border and can be null to have
  /// no box decoration.
  final BoxDecoration decoration;

  /// Padding around the text entry area between the [prefix] and [suffix]
  /// or the clear button when [clearButtonMode] is not never.
  ///
  /// Defaults to a padding of 6 pixels on all sides and can be null.
  final EdgeInsetsGeometry padding;

  /// A lighter colored placeholder hint that appears on the first line of the
  /// text field when the text entry is empty.
  ///
  /// Defaults to having no placeholder text.
  ///
  /// The text style of the placeholder text matches that of the text field's
  /// main text entry except a lighter font weight and a grey font color.
  final String placeholder;

  /// The style to use for the placeholder text.
  ///
  /// The [placeholderStyle] is merged with the [style] [TextStyle] when applied
  /// to the [placeholder] text. To avoid merging with [style], specify
  /// [TextStyle.inherit] as false.
  ///
  /// Defaults to the [style] property with w300 font weight and grey color.
  ///
  /// If specifically set to null, placeholder's style will be the same as [style].
  final TextStyle placeholderStyle;

  /// An optional [Widget] to display before the text.
  final Widget prefix;

  /// Controls the visibility of the [prefix] widget based on the state of
  /// text entry when the [prefix] argument is not null.
  ///
  /// Defaults to [OverlayVisibilityMode.always] and cannot be null.
  ///
  /// Has no effect when [prefix] is null.
  final OverlayVisibilityMode prefixMode;

  /// An optional [Widget] to display after the text.
  final Widget suffix;

  /// Controls the visibility of the [suffix] widget based on the state of
  /// text entry when the [suffix] argument is not null.
  ///
  /// Defaults to [OverlayVisibilityMode.always] and cannot be null.
  ///
  /// Has no effect when [suffix] is null.
  final OverlayVisibilityMode suffixMode;

  /// Show an iOS-style clear button to clear the current text entry.
  ///
  /// Can be made to appear depending on various text states of the
  /// [TextEditingController].
  ///
  /// Will only appear if no [suffix] widget is appearing.
  ///
  /// Defaults to never appearing and cannot be null.
  final OverlayVisibilityMode clearButtonMode;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction textInputAction;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// The style to use for the text being edited.
  ///
  /// Also serves as a base for the [placeholder] text's style.
  ///
  /// Defaults to the standard iOS font style from [CupertinoTheme] if null.
  final TextStyle style;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.material.inputDecorator.textAlignVertical}
  final TextAlignVertical textAlignVertical;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool showCursor;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  final int minLines;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// The maximum number of characters (Unicode scalar values) to allow in the
  /// text field.
  ///
  /// If set, a character counter will be displayed below the
  /// field, showing how many characters have been entered and how many are
  /// allowed. After [maxLength] characters have been input, additional input
  /// is ignored, unless [maxLengthEnforced] is set to false. The TextField
  /// enforces the length with a [LengthLimitingTextInputFormatter], which is
  /// evaluated after the supplied [inputFormatters], if any.
  ///
  /// This value must be either null or greater than zero. If set to null
  /// (the default), there is no limit to the number of characters allowed.
  ///
  /// Whitespace characters (e.g. newline, space, tab) are included in the
  /// character count.
  ///
  /// ## Limitations
  ///
  /// The CupertinoTextField does not currently count Unicode grapheme clusters
  /// (i.e. characters visible to the user), it counts Unicode scalar values,
  /// which leaves out a number of useful possible characters (like many emoji
  /// and composed characters), so this will be inaccurate in the presence of
  /// those characters. If you expect to encounter these kinds of characters, be
  /// generous in the maxLength used.
  ///
  /// For instance, the character "ö" can be represented as '\u{006F}\u{0308}',
  /// which is the letter "o" followed by a composed diaeresis "¨", or it can
  /// be represented as '\u{00F6}', which is the Unicode scalar value "LATIN
  /// SMALL LETTER O WITH DIAERESIS". In the first case, the text field will
  /// count two characters, and the second case will be counted as one
  /// character, even though the user can see no difference in the input.
  ///
  /// Similarly, some emoji are represented by multiple scalar values. The
  /// Unicode "THUMBS UP SIGN + MEDIUM SKIN TONE MODIFIER", "👍🏽", should be
  /// counted as a single character, but because it is a combination of two
  /// Unicode scalar values, '\u{1F44D}\u{1F3FD}', it is counted as two
  /// characters.
  ///
  /// See also:
  ///
  ///  * [LengthLimitingTextInputFormatter] for more information on how it
  ///    counts characters, and how it may differ from the intuitive meaning.
  final int maxLength;

  /// If true, prevents the field from allowing more than [maxLength]
  /// characters.
  ///
  /// If [maxLength] is set, [maxLengthEnforced] indicates whether or not to
  /// enforce the limit, or merely provide a character counter and warning when
  /// [maxLength] is exceeded.
  final bool maxLengthEnforced;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String> onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [EditableText.onSubmitted] for an example of how to handle moving to
  ///    the next/previous field when using [TextInputAction.next] and
  ///    [TextInputAction.previous] for [textInputAction].
  final ValueChanged<String> onSubmitted;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter> inputFormatters;

  /// Disables the text field when false.
  ///
  /// Text fields in disabled states have a light grey background and don't
  /// respond to touch events including the [prefix], [suffix] and the clear
  /// button.
  final bool enabled;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius cursorRadius;

  /// The color to use when painting the cursor.
  ///
  /// Defaults to the [CupertinoThemeData.primaryColor] of the ambient theme,
  /// which itself defaults to [CupertinoColors.activeBlue] in the light theme
  /// and [CupertinoColors.activeOrange] in the dark theme.
  final Color cursorColor;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If null, defaults to [Brightness.light].
  final Brightness keyboardAppearance;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController scrollController;

  /// {@macro flutter.widgets.edtiableText.scrollPhysics}
  final ScrollPhysics scrollPhysics;

  /// {@macro flutter.rendering.editable.selectionEnabled}
  bool get selectionEnabled {
    return enableInteractiveSelection ?? !obscureText;
  }

  /// {@macro flutter.material.textfield.onTap}
  final GestureTapCallback onTap;

  @override
  _FluentTextFieldState createState() => _FluentTextFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('controller', controller, defaultValue: null));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode, defaultValue: null));
    properties.add(DiagnosticsProperty<BoxDecoration>('decoration', decoration));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding));
    properties.add(StringProperty('placeholder', placeholder));
    properties.add(DiagnosticsProperty<TextStyle>('placeholderStyle', placeholderStyle));
    properties.add(DiagnosticsProperty<OverlayVisibilityMode>('prefix', prefix == null ? null : prefixMode));
    properties.add(DiagnosticsProperty<OverlayVisibilityMode>('suffix', suffix == null ? null : suffixMode));
    properties.add(DiagnosticsProperty<OverlayVisibilityMode>('clearButtonMode', clearButtonMode));
    properties.add(DiagnosticsProperty<TextInputType>('keyboardType', keyboardType, defaultValue: TextInputType.text));
    properties.add(DiagnosticsProperty<TextStyle>('style', style, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('autofocus', autofocus, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('obscureText', obscureText, defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('autocorrect', autocorrect, defaultValue: false));
    properties.add(IntProperty('maxLines', maxLines, defaultValue: 1));
    properties.add(IntProperty('minLines', minLines, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('expands', expands, defaultValue: false));
    properties.add(IntProperty('maxLength', maxLength, defaultValue: null));
    properties.add(FlagProperty('maxLengthEnforced', value: maxLengthEnforced, ifTrue: 'max length enforced'));
    properties.add(ColorProperty('cursorColor', cursorColor, defaultValue: null));
    properties.add(FlagProperty('selectionEnabled', value: selectionEnabled, defaultValue: true, ifFalse: 'selection disabled'));
    properties.add(DiagnosticsProperty<ScrollController>('scrollController', scrollController, defaultValue: null));
    properties.add(DiagnosticsProperty<ScrollPhysics>('scrollPhysics', scrollPhysics, defaultValue: null));
    properties.add(EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: TextAlign.start));
    properties.add(DiagnosticsProperty<TextAlignVertical>('textAlignVertical', textAlignVertical, defaultValue: null));
  }
}

class _FluentTextFieldState extends State<FluentTextField> with AutomaticKeepAliveClientMixin {
  final GlobalKey _clearGlobalKey = GlobalKey();
  final GlobalKey<EditableTextState> _editableTextKey = GlobalKey<EditableTextState>();

  TextEditingController _controller;
  TextEditingController get _effectiveController => widget.controller ?? _controller;

  FocusNode _focusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());
  

  // The selection overlay should only be shown when the user is interacting
  // through a touch screen (via either a finger or a stylus). A mouse shouldn't
  // trigger the selection overlay.
  // For backwards-compatibility, we treat a null kind the same as touch.
  bool _shouldShowSelectionToolbar = true;

  bool _showSelectionHandles = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController()
            ..addListener(updateKeepAlive);
    }
  }

  @override
  void didUpdateWidget(FluentTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _controller = TextEditingController.fromValue(oldWidget.controller.value);
      _controller.addListener(updateKeepAlive);
    } else if (widget.controller != null && oldWidget.controller == null) {
      _controller = null;
    }
    final bool isEnabled = widget.enabled ?? true;
    final bool wasEnabled = oldWidget.enabled ?? true;
    if (wasEnabled && !isEnabled) {
      _effectiveFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _controller?.removeListener(updateKeepAlive);
    super.dispose();
  }

  EditableTextState get _editableText => _editableTextKey.currentState;

  void _requestKeyboard() {
    _editableText?.requestKeyboard();
  }

  RenderEditable get _renderEditable => _editableText.renderEditable;

  void _handleTapDown(TapDownDetails details) {
    _renderEditable.handleTapDown(details);

    // The selection overlay should only be shown when the user is interacting
    // through a touch screen (via either a finger or a stylus). A mouse shouldn't
    // trigger the selection overlay.
    // For backwards-compatibility, we treat a null kind the same as touch.
    final PointerDeviceKind kind = details.kind;
    _shouldShowSelectionToolbar = 
        kind == null ||
        kind == PointerDeviceKind.touch ||
        kind == PointerDeviceKind.stylus ||
        kind == PointerDeviceKind.mouse;
    ///TODO: Id the selection change
  }

  void _handleForcePressStarted(ForcePressDetails details) {
    if (widget.selectionEnabled) {
      _renderEditable.selectWordsInRange(
        from: details.globalPosition,
        cause: SelectionChangedCause.forcePress,
      );
    }
  }

  void _handleForcePressEnded(ForcePressDetails details) {
    _renderEditable.selectWordsInRange(
      from: details.globalPosition,
      cause: SelectionChangedCause.forcePress,
    );
    if (_shouldShowSelectionToolbar)
      _editableText.showToolbar();
  }

  void _handleSingleTapUp(TapUpDetails details) {
    // Because TextSelectionGestureDetector listens to taps that happen on
    // widgets in front of it, tapping the clear button will also trigger
    // this handler. If the the clear button widget recognizes the up event,
    // then do not handle it.
    if (_clearGlobalKey.currentContext != null) {
      final RenderBox renderBox = _clearGlobalKey.currentContext.findRenderObject();
      final Offset localOffset = renderBox.globalToLocal(details.globalPosition);
      if(renderBox.hitTest(BoxHitTestResult(), position: localOffset)) {
        return;
      }
    }

    if (widget.selectionEnabled) {
      _renderEditable.selectPosition(cause: SelectionChangedCause.tap);
    }
    _requestKeyboard();
    if (widget.onTap != null) {
      widget.onTap();
    }
  }

  void _handleSingleLongTapStart(LongPressStartDetails details) {
    if (widget.selectionEnabled) {
      _renderEditable.selectPositionAt(
        from: details.globalPosition,
        cause: SelectionChangedCause.longPress,
      );
    }
  }

  void _handleSingleLongTapMoveUpdate(LongPressMoveUpdateDetails details) {
    if (widget.selectionEnabled) {
      _renderEditable.selectPositionAt(
        from: details.globalPosition,
        cause: SelectionChangedCause.longPress,
      );
    }
  }

  void _handleSingleLongTapEnd(LongPressEndDetails details) {
    if (_shouldShowSelectionToolbar)
      _editableText.showToolbar();
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    if (widget.selectionEnabled) {
      _renderEditable.selectWord(cause: SelectionChangedCause.tap);
      if (_shouldShowSelectionToolbar)
        _editableText.showToolbar();
    }
  }

  bool _shouldShowSelectionHandles(SelectionChangedCause cause) {
    // When the text field is activated by something that doesn't trigger the
    // selection overlay, we shouldn't show the handles either.
    if (!_shouldShowSelectionToolbar)
      return false;

    // On iOS, we don't show handles when the selection is collapsed.
    if (_effectiveController.selection.isCollapsed)
      return false;

    if (cause == SelectionChangedCause.keyboard)
      return false;

    if (_effectiveController.text.isNotEmpty)
      return true;

    return false;
  }

  void _handleMouseDragSelectionStart(DragStartDetails details) {
    _renderEditable.selectPositionAt(
      from: details.globalPosition,
      cause: SelectionChangedCause.drag,
    );
  }

  void _handleMouseDragSelectionUpdate(
      DragStartDetails startDetails,
      DragUpdateDetails updateDetails,
  ) {
    _renderEditable.selectPositionAt(
      from: startDetails.globalPosition,
      to: updateDetails.globalPosition,
      cause: SelectionChangedCause.drag,
    );
  }

  void _handleMouseDragSelectionEnd(DragEndDetails details) {
    _requestKeyboard();
  }

  void _handleSelectionChanged(TextSelection selection, SelectionChangedCause cause) {
    if (cause == SelectionChangedCause.longPress) {
      _editableText?.bringIntoView(selection.base);
    }
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }
  }

  @override
  bool get wantKeepAlive => _controller?.text?.isNotEmpty == true;

  bool _shouldShowAttachment({
    OverlayVisibilityMode attachment,
    bool hasText,
  }) {
    switch (attachment) {
      case OverlayVisibilityMode.never:
        return false;
      case OverlayVisibilityMode.always:
        return true;
      case OverlayVisibilityMode.editing:
        return hasText;
      case OverlayVisibilityMode.notEditing:
        return !hasText;
    }
    assert(false);
    return null;
  }

  bool _showPrefixWidget(TextEditingValue text) {
    return widget.prefix != null && _shouldShowAttachment(
      attachment: widget.prefixMode,
      hasText: text.text.isNotEmpty,
    );
  }

  bool _showSuffixWidget(TextEditingValue text) {
    return widget.suffix != null && _shouldShowAttachment(
      attachment: widget.suffixMode,
      hasText: text.text.isNotEmpty,
    );
  }

  bool _showClearButton(TextEditingValue text) {
    return _shouldShowAttachment(
      attachment: widget.clearButtonMode,
      hasText: text.text.isNotEmpty,
    );
  }

  // True if any surrounding decoration widgets will be shown.
  bool get _hasDecoration {
    return widget.placeholder != null ||
      widget.clearButtonMode != OverlayVisibilityMode.never ||
      widget.prefix != null ||
      widget.suffix != null;
  }

  // Provide default behavior if widget.textAlignVertical is not set.
  // CupertinoTextField has top alignment by default, unless it has decoration
  // like a prefix or suffix, in which case it's aligned to the center.
  TextAlignVertical get _textAlignVertical {
    if (widget.textAlignVertical != null) {
      return widget.textAlignVertical;
    }
    return _hasDecoration ? TextAlignVertical.center : TextAlignVertical.top;
  }

  Widget _addTextDependentAttachments(Widget editableText, TextStyle textStyle, TextStyle placeholderStyle) {
    assert(editableText != null);
    assert(textStyle != null);
    assert(placeholderStyle != null);
    // If there are no surrounding widgets, just return the core editable text
    // part.
    if (!_hasDecoration) {
      return editableText;
    }

    // Otherwise, listen to the current state of the text entry.
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _effectiveController,
      child: editableText,
      builder: (BuildContext context, TextEditingValue text, Widget child) {
        final List<Widget> rowChildren = <Widget>[];

        // Insert a prefix at the front if the prefix visibility mode matches
        // the current text state.
        if (_showPrefixWidget(text)) {
          rowChildren.add(widget.prefix);
        }

        final List<Widget> stackChildren = <Widget>[];

        // In the middle part, stack the placeholder on top of the main EditableText
        // if needed.
        if (widget.placeholder != null && text.text.isEmpty) {
          stackChildren.add(
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: widget.padding,
                child: Text(
                  widget.placeholder,
                  maxLines: widget.maxLines,
                  overflow: TextOverflow.ellipsis,
                  style: placeholderStyle,
                  textAlign: widget.textAlign,
                ),
              ),
            ),
          );
        }

        rowChildren.add(Expanded(child: Stack(children: stackChildren..add(child))));

        // First add the explicit suffix if the suffix visibility mode matches.
        if (_showSuffixWidget(text)) {
          rowChildren.add(widget.suffix);
        // Otherwise, try to show a clear button if its visibility mode matches.
        } else if (_showClearButton(text)) {
          rowChildren.add(
            GestureDetector(
              key: _clearGlobalKey,
              onTap: widget.enabled ?? true ? () {
                // Special handle onChanged for ClearButton
                // Also call onChanged when the clear button is tapped.
                final bool textChanged = _effectiveController.text.isNotEmpty;
                _effectiveController.clear();
                if (widget.onChanged != null && textChanged)
                  widget.onChanged(_effectiveController.text);
              } : null,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Icon(
                  FluentIcons.cancel,
                  size: 18.0,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          );
        }

        return Row(children: rowChildren);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    assert(debugCheckHasDirectionality(context));
    final TextEditingController controller = _effectiveController;
    final List<TextInputFormatter> formatters = widget.inputFormatters ?? <TextInputFormatter>[];
    final bool enabled = widget.enabled ?? true;
    final Offset cursorOffset = Offset(_iOSHorizontalCursorOffsetPixels / MediaQuery.of(context).devicePixelRatio, 0);
    if (widget.maxLength != null && widget.maxLengthEnforced) {
      formatters.add(LengthLimitingTextInputFormatter(widget.maxLength));
    }
    final ThemeData themeData = Theme.of(context);
    final TextStyle textStyle = themeData.textTheme.subhead.merge(widget.style);
    final TextStyle placeholderStyle = textStyle.merge(widget.placeholderStyle);
    //final Brightness keyboardAppearance = widget.keyboardAppearance ?? themeData.brightness;
    final Color cursorColor = widget.cursorColor ?? Color(0xFF000000);
    final Color disabledColor = CupertinoTheme.of(context).brightness == Brightness.light
      ? _kDisabledBackground
      : CupertinoColors.darkBackgroundGray;
    
    final boxDecoration = BoxDecoration(
      border: Border.all(
        color: Theme.of(context).accentColor,
        style: BorderStyle.solid,
        width: 3.0
      ),

    );

    final BoxDecoration effectiveDecoration = enabled
      ? (widget.decoration ?? boxDecoration)
      : widget.decoration?.copyWith(color: widget.decoration?.color ?? disabledColor);

    final Widget paddedEditable = Padding(
      padding: widget.padding,
      child: RepaintBoundary(
        child: EditableText(
          key: _editableTextKey,
          controller: controller,
          readOnly: widget.readOnly,
          showCursor: widget.showCursor,
          showSelectionHandles: _showSelectionHandles,
          focusNode: _effectiveFocusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          style: textStyle,
          strutStyle: widget.strutStyle,
          textAlign: widget.textAlign,
          autofocus: widget.autofocus,
          obscureText: widget.obscureText,
          autocorrect: widget.autocorrect,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          expands: widget.expands,
          selectionColor: Theme.of(context).accentColor,
          selectionControls: widget.selectionEnabled
            ? materialTextSelectionControls : null,
          onChanged: widget.onChanged,
          onSelectionChanged: _handleSelectionChanged,
          onEditingComplete: widget.onEditingComplete,
          onSubmitted: widget.onSubmitted,
          inputFormatters: formatters,
          rendererIgnoresPointer: true,
          cursorWidth: widget.cursorWidth,
          cursorRadius: null,
          cursorColor: cursorColor,
          cursorOpacityAnimates: true,
          cursorOffset: cursorOffset,
          paintCursorAboveText: true,
          backgroundCursorColor: CupertinoColors.inactiveGray,
          scrollPadding: widget.scrollPadding,
          keyboardAppearance: Brightness.light,
          dragStartBehavior: widget.dragStartBehavior,
          scrollController: widget.scrollController,
          scrollPhysics: widget.scrollPhysics,
          enableInteractiveSelection: widget.enableInteractiveSelection,
        ),
      ),
    );

    return Semantics(
      onTap: () {
        if (!controller.selection.isValid) {
          controller.selection = TextSelection.collapsed(offset: controller.text.length);
        }
        _requestKeyboard();
      },
      child: IgnorePointer(
        ignoring: !enabled,
        child: Container(
          decoration: effectiveDecoration,
          child: TextSelectionGestureDetector(
            onTapDown: _handleTapDown,
            onForcePressStart: _handleForcePressStarted,
            onForcePressEnd: _handleForcePressEnded,
            onSingleTapUp: _handleSingleTapUp,
            onSingleLongTapStart: _handleSingleLongTapStart,
            onSingleLongTapMoveUpdate: _handleSingleLongTapMoveUpdate,
            onSingleLongTapEnd: _handleSingleLongTapEnd,
            onDoubleTapDown: _handleDoubleTapDown,
            onDragSelectionStart: _handleMouseDragSelectionStart,
            onDragSelectionUpdate: _handleMouseDragSelectionUpdate,
            onDragSelectionEnd: _handleMouseDragSelectionEnd,
            behavior: HitTestBehavior.translucent,
            child: Align(
              alignment: Alignment(-1.0, _textAlignVertical.y),
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: _addTextDependentAttachments(paddedEditable, textStyle, placeholderStyle),
            ),
          ),
        ),
      ),
    );
  }
}
