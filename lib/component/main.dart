import 'package:flutter/material.dart';

import 'custom.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Circular View'),
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

  static var count = 6;
  List<double> _values = List.filled(count, 0.0);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    widgets.add(Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
            width: 300,
            height: 300,
            child: CustomPaint(
              foregroundPainter: MyPainter(width: 32.0, percents: _values),
              child: new Padding(
                padding: const EdgeInsets.all(40.0),
                child: new RaisedButton(
                  color: Colors.purple,
                  splashColor: Colors.blueAccent,
                  shape: new CircleBorder(),
                  child: new Text("Reset"),
                  onPressed: () {
                    setState(() {
                      _values = List.filled(count, 0.0);
                    });
                  },
                ),
              ),
            )),
      ),
    ));
    _values.asMap().forEach((index, item) {
      widgets.add(Row(children: <Widget>[
        Expanded(
          child: Slider(
            value: item,
            onChanged: (value) {
              setState(() {
                _values[index] = value;
              });
            },
            min: 0,
            max: item + _leftValue(),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${item.toStringAsFixed(1)}%"))
      ]));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: widgets),
    );
  }

  double _leftValue() {
    var amount = 0.0;
    _values.forEach((value) {
      amount += value;
    });
    return 100 - amount;
  }
}
