import 'package:example_flutter/basic/checkbox.dart';
import 'package:example_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CheckBoxRadioGroup extends StatefulWidget {
  @override
  _CheckBoxRadioGroupState createState() => _CheckBoxRadioGroupState();
}

final FluentTextTheme theme = FluentTextTheme();

class _CheckBoxRadioGroupState extends State<CheckBoxRadioGroup> {
  bool _twoStateCheckBox = false;
  bool _threeStateCheckBox = null;

  bool _selectedAll = false;
  bool _option1 = false;
  bool _option2 = false;
  bool _option3 = false;

  void updateAll(){
    if(_option1 && _option2 && _option3) 
      _selectedAll = true;
    else if(_option1 || _option2 || _option3) 
      _selectedAll = null;
    else 
      _selectedAll = false;
    setState(() {
      
    });
  }
  void onChange2State(bool selection) {
    setState(() {
      _twoStateCheckBox = selection;
    });
  }

  void onChange3State(bool selection) {

    setState(() {
     _threeStateCheckBox = selection; 
    });

  }

  String printData(bool sel) {
    if (sel != null) {
      return sel ? 'Selected' : 'not selected';
    }
    return 'indeterminate';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'CheckBox',
              style: theme.title,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'A control that allows user to select or clear the choice',
                    style: theme.body,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                    child: Text('A 2-State CheckBox', style: theme.subtitle),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFE6E6E6),
                            style: BorderStyle.solid,
                            width: 1.0),
                        //color: Colors.red
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          FluentCheckbox(
                            selected: _twoStateCheckBox,
                            title: Text('Two-state CheckBox'),
                            onChanged: onChange2State,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                          Text(
                            'you have ${printData(_twoStateCheckBox)} the box',
                            style: theme.body,
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                    child: Text('A 3-State CheckBox', style: theme.subtitle),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFE6E6E6),
                            style: BorderStyle.solid,
                            width: 1.0),
                        //color: Colors.red
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          FluentCheckbox(
                            selected: _threeStateCheckBox,
                            title: Text('Three-state CheckBox'),
                            onChanged: onChange3State,
                            triState: true,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                          Text(
                            'you have ${printData(_threeStateCheckBox)} the box',
                            style: theme.body,
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                    child:
                        Text('Using a 3-State CheckBox', style: theme.subtitle),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFE6E6E6),
                            style: BorderStyle.solid,
                            width: 1.0),
                        //color: Colors.red
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: FluentCheckbox(
                              selected: _selectedAll,
                              title: Text('Select all'),
                              triState: true,
                              onChanged: (val) {
                                if(val == null) 
                                  _selectedAll = _option1 = _option2 = _option3 = false;
                                else if(val) 
                                 _selectedAll = _option1 = _option2 = _option3 = true;
                                else 
                                 _selectedAll = _option1 = _option2 = _option3 = false;

                                setState(() {
                                  
                                });  
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 0.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7.0),
                                  child: FluentCheckbox(
                                    title: Text('Option 1'),
                                    selected: _option1,
                                    onChanged: (val) {
                                      _option1 = val;
                                      updateAll();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7.0),
                                  child: FluentCheckbox(
                                    title: Text('Option 2'),
                                    selected: _option2,
                                    onChanged: (val) {
                                      _option2 = val;
                                      updateAll();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7.0),
                                  child: FluentCheckbox(
                                    title: Text('Option 3'),
                                    selected: _option3,
                                    onChanged: (val) {
                                      _option3 = val;
                                      updateAll();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ]),
    );
  }
}
