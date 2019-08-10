import 'package:example_flutter/ListTile.dart';
import 'package:example_flutter/example/checkboxgroup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../combobox.dart';

import '../comboboxroute.dart';
import '../theme.dart';


class ComboBoxGroup extends StatefulWidget {
  @override
  _ComboBoxGroupState createState() => _ComboBoxGroupState();
}



class _ComboBoxGroupState extends State<ComboBoxGroup> {


  _onTap(int item) {
    print('clicked ${item+1}');
  }

  
  @override
  Widget build(BuildContext context) {
      FluentTextTheme textTheme = FluentTextTheme();

    var items = [
      FluentListTile(
          title: Text('one', style: Theme.of(context).textTheme.subhead ),
          onTap: () => _onTap(0)
      ),
      FluentListTile(
        title: Text('two', style: Theme.of(context).textTheme.subhead),
        onTap: () => _onTap(1),
      ),
      FluentListTile(
        title: Text('three', style: Theme.of(context).textTheme.subhead),
        onTap: () => _onTap(2),
      ),
      FluentListTile(
        title: Text('four', style: Theme.of(context).textTheme.subhead),
        onTap: () => _onTap(3),
      ),
      FluentListTile(
        title: Text('five', style: Theme.of(context).textTheme.subhead),
        onTap: () => _onTap(4),
      ),
    ];

    




    return Container(
      child: Center(
        child: FluentComboBox(items: items),
      ),
    );
  }
}

