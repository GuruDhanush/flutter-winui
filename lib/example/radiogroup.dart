import 'package:example_flutter/basic/radio.dart';
import 'package:example_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RadioGroup extends StatefulWidget {
  @override
  _RadioGroupState createState() => _RadioGroupState();
}

enum Options { option1, option2, option3 }
enum RBColors { green, yellow, blue, white }

class _RadioGroupState extends State<RadioGroup> {
  final FluentTextTheme theme = FluentTextTheme();

  Options optionVal;
  RBColors backgroundColor;
  RBColors borderColor;

  void setOptionalVal(Options val) {
    setState(() {
      optionVal = val;
    });
  }

  void setBackgroundColor(RBColors bgColor) {
    setState(() {
     backgroundColor = bgColor; 
    });
  }

  void setBorderColor(RBColors brdColor) {
    setState(() {
     borderColor =  brdColor;
    });
  }

  Color getColor(RBColors color) {

    if(color == null)
      return Colors.white;

    switch (color.index) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.white;

      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'RadioButton',
            style: theme.title,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            physics: BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                  'Radio buttons allow users to select one option from a set. Each option is represented by one radio button, and users can only select one radio button in a radio button group.',
                  style: theme.body,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                  child: Text(
                      'A group of radio buttons implicitly grouped together',
                      style: theme.subtitle),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
            color: Color(0xFFE6E6E6),
            style: BorderStyle.solid,
            width: 1.0)),
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
            Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                'Options',
                style: theme.base,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0),
              child: FluentRadioButton<Options>(
                title: Text('Option 1'),
                groupValue: optionVal,
                value: Options.option1,
                onChanged: setOptionalVal,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0),
              child: FluentRadioButton<Options>(
                title: Text(
                  'Option 2',
                ),
                groupValue: optionVal,
                value: Options.option2,
                onChanged: setOptionalVal,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0),
              child: FluentRadioButton<Options>(
                title: Text(
                  'Option 3',
                ),
                groupValue: optionVal,
                value: Options.option3,
                onChanged: setOptionalVal,
              ),
            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
              child: Text(
            'You have selected: Option ${optionVal != null ? optionVal.index + 1 : ''}',
            style: theme.body,
                        )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                  child: Text(
                      'Two groups of radio buttons explicitly grouped by GroupName',
                      style: theme.subtitle),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
            color: Color(0xFFE6E6E6),
            style: BorderStyle.solid,
            width: 1.0)),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
            Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                'Background',
                style: theme.base,
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FluentRadioButton<RBColors>(
                    title: Text('Green'),
                    groupValue: backgroundColor,
                    value: RBColors.green,
                    onChanged: setBackgroundColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FluentRadioButton<RBColors>(
                    title: Text('Yellow'),
                    groupValue: backgroundColor,
                    value: RBColors.yellow,
                    onChanged: setBackgroundColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FluentRadioButton<RBColors>(
                    title: Text('Blue'),
                    groupValue: backgroundColor,
                    value: RBColors.blue,
                    onChanged: setBackgroundColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FluentRadioButton<RBColors>(
                    title: Text('White'),
                    groupValue: backgroundColor,
                    value: RBColors.white,
                    onChanged: setBackgroundColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                'Border',
                style: theme.base,
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FluentRadioButton<RBColors>(
                    title: Text('Green'),
                    groupValue: borderColor,
                    value: RBColors.green,
                    onChanged: setBorderColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FluentRadioButton<RBColors>(
                    title: Text('Yellow'),
                    groupValue: borderColor,
                    value: RBColors.yellow,
                    onChanged: setBorderColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FluentRadioButton<RBColors>(
                    title: Text('Blue'),
                    groupValue: borderColor,
                    value: RBColors.blue,
                    onChanged: setBorderColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FluentRadioButton<RBColors>(
                    title: Text('White'),
                    groupValue: borderColor,
                    value: RBColors.white,
                    //onChanged: setBorderColor,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: getColor(borderColor),
                      style: BorderStyle.solid,
                      width: 10.0),
                  color: getColor(backgroundColor)),
                  constraints: BoxConstraints.expand(
                    height: 100.0,
                  ),
            )
                        ],
                      ),
                    ],
                  ),
                ),

                

                ],
              ),
          ),
        ],
      ),
    );
  }
}
