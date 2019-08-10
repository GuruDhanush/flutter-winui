import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';


@immutable
class FluentTheme {



  
}



const TextStyle _kbase = TextStyle(
    fontFamily: 'Segoe',
    fontWeight: FontWeight.w700,
    fontSize: 14.0,
);

const TextStyle _kheader = TextStyle(
    fontFamily: 'Segoe',
    fontWeight: FontWeight.w200,
    fontSize: 46.0,
);

const TextStyle _ksubheader = TextStyle(
    fontFamily: 'Segoe',
    fontWeight: FontWeight.w200,
    fontSize: 34.0,
);

const TextStyle _ktitle = TextStyle(
    fontFamily: 'Segoe',
    fontWeight: FontWeight.w300,
    fontSize: 24.0,
);

const TextStyle _ksubtitle = TextStyle(
    fontFamily: 'Segoe',
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
);

const TextStyle _kbody = TextStyle(
    fontFamily: 'Segoe',
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
);

const TextStyle _kcaption = TextStyle(
    fontFamily: 'Segoe',
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
);






///Follows the XAML type ramp 
/// Header
/// Subheader
/// Title
/// Subtitle
/// Base
/// Body
/// Caption
@immutable
class FluentTextTheme {

  const FluentTextTheme({
    Color accentColor,
    Brightness brightness,
    TextStyle header,
    TextStyle subheader,
    TextStyle title,
    TextStyle subtitle,
    TextStyle base,
    TextStyle body,
    TextStyle caption
  }) : _accentColor = accentColor,
       _brightness = brightness,
       _header = header,
       _subheader = subheader,
       _title = title,
       _subtitle  = subtitle,
       _base = base,
       _body  = body,
       _caption = caption;

  final Color _accentColor;
  Color get accentColor => _accentColor ?? Color(0xFFFFA500);

  final Brightness _brightness;
  bool get isLight => _brightness != Brightness.light;

  final TextStyle _header;
  TextStyle get header => _header ?? _kheader;

  final TextStyle _subheader;
  TextStyle get subheader => _subheader ?? _ksubheader;

  final TextStyle _title;
  TextStyle get title => _title ?? _ktitle;

  final TextStyle _subtitle;
  TextStyle get subtitle => _subtitle ?? _ksubtitle;

  final TextStyle _base;
  TextStyle get base => _base ?? _kbase;

  final TextStyle _body;
  TextStyle get body => _body ?? _kbody;
  
  final TextStyle _caption;
  TextStyle get caption => _caption ?? _kcaption;


}


class ListTheme {

  static Color ListLow = Color(0x19000000);
  static Color ListMedium = Color(0x33000000);
}

class ThemeColor {

  static Color baseLow = Color(0x33000000);

  ///disabled UI
  static Color baseMediumLow = Color(0x66000000);

  ///secondary text
  static Color baseMedium = Color(0x99000000);
  static Color baseMediumHigh = Color(0xCC000000);

  ///primary text
  static Color baseHigh = Color(0xFF000000);
}