// Copyright 2018 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:example_flutter/example/checkboxgroup.dart' as prefix0;
import 'package:example_flutter/example/radiogroup.dart';
import 'package:example_flutter/example/uwptyperamp.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'splitpane.dart';

void main() {
  // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      title: 'Flutters Demos',
      theme: ThemeData(
        accentColor: Colors.yellow,
        backgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.copyWith(
          button: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 16.0,
            fontWeight: FontWeight.w400
          ),
          subhead: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          )
        ),
        // See https://github.com/flutter/flutter/wiki/Desktop-shells#fonts
        fontFamily: 'Segoe',
      ),
      home: MyHomePage(title: 'Flutter Demo Home Pages'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  @override
  Widget build(BuildContext context) {

    final mqData = MediaQuery.of(context);
    //print(mqData.devicePixelRatio);
    return Material(
      child: Scaffold(
        body: MediaQuery(
          data: mqData.copyWith(
            textScaleFactor: mqData.textScaleFactor * 1.25,
            //devicePixelRatio: mqData.devicePixelRatio * 0.75
          ),
          child: SplitPane()
          //child: RadioGroup(),
        ),
        //body: UWPTypeRamp(),
        //body: SplitPane(),
      ),
    );
  }
}
 