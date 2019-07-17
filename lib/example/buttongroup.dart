import 'package:example_flutter/basic/button.dart';
import 'package:example_flutter/example/checkboxgroup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ButtonGroup extends StatefulWidget {
  @override
  _ButtonGroupState createState() => _ButtonGroupState();
}




class _ButtonGroupState extends State<ButtonGroup> {


  String _buttonTxt = '';
  final _longText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse nibh sapien, aliquet quis sollicitudin sit amet, lacinia sed massa. Proin fermentum neque vel urna rhoncus, ut pulvinar erat interdum. Donec eu arcu ut nibh commodo molestie. Etiam ex quam, viverra at aliquam ac, pretium sit amet elit. Ut tempor diam et eleifend imperdiet. Duis ut nisl at orci hendrerit vulputate a at magna. Duis lacinia vestibulum libero. Phasellus enim enim, ultricies in rhoncus eget, tempor a neque. Quisque vitae pellentesque mi. Nullam nibh nisi, consequat sit amet elementum hendrerit, gravida eget velit. Quisque vulputate fermentum pretium. Sed id feugiat nisl. Donec dolor libero, hendrerit at pretium eu, fermentum vitae nibh. Suspendisse at varius leo, at efficitur mauris.';
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Playing with buttons', style:  theme.subheader,),
        Padding(padding: EdgeInsets.all(10.0),),
        FittedBox(
          fit: BoxFit.contain,
                  child: FluentButton(
            child: Text('Button 1'),
            onPressed: () {
              setState(() {
               _buttonTxt = 'Button 1';
              });
            },
          ),
        ),
        Padding(padding: EdgeInsets.all(10.0),),
        Text('You have clicked $_buttonTxt', style: theme.body,),

        Padding(padding: EdgeInsets.all(10.0),),
        FittedBox(
          fit: BoxFit.contain,
                  child: FluentButton(
                    buttonType: FluentButtonType.repeat,
                    //delay: Duration(seconds: 2),
                    //interval: Duration(seconds: 1),
            child: Text('Click and hold'),
            onPressed: () {
              setState(() {
                _count++;
              });
            },
          ),
        ),
        Padding(padding: EdgeInsets.all(10.0),),
        Text('You have clicked $_count times', style: theme.body,)
      ],
    );
  } 
}


