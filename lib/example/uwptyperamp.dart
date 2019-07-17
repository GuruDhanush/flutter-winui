import 'package:example_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UWPTypeRamp extends StatelessWidget {
  FluentTextTheme textTheme = FluentTextTheme();
  @override
  Widget build(BuildContext context) {
    var mqData = MediaQuery.of(context); 
    //print(textScaleFactor);

    return MediaQuery(
      data: mqData.copyWith(textScaleFactor: mqData.textScaleFactor * 1.25),
      child: Container(
          child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Text(
            'Header',
            style: textTheme.header,
          ),
          Text(
            'Subheader',
            style: textTheme.subheader,
          ),
          Text(
            'Title',
            style: textTheme.title,
          ),
          Text(
            'Subtitle',
            style: textTheme.subtitle,
          ),
          Text(
            'Base',
            style: textTheme.base,
          ),
          Text(
            'Body',
            style: textTheme.body,
          ),
          Text(
            'Caption',
            style: textTheme.caption,
          )
        ],
      )),
    );
  }
}
