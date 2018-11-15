import 'dart:math';
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

  List<Color> _colors;
  final _random = new Random();
  int _radioValue = 0;

  _MyHomePageState() {
    _init();
  }

  void _init() {
    _colors = List<Color>.generate(count, (_) => _randomColor());
    _values = List.filled(count, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    widgets.addAll([
      Row(
        children: <Widget>[
          Radio(
              value: 0,
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange),
          Text("Round corner"),
          Radio(
              value: 1,
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange),
          Text("Square corner")
        ],
      ),
    ]);

    widgets.add(Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
            width: 300,
            height: 300,
            child: CustomPaint(
              foregroundPainter: MyPainter(_colors, _values, 32.0,
                  _radioValue == 0 ? StrokeCap.round : StrokeCap.butt),
              child: new Padding(
                padding: const EdgeInsets.all(40.0),
                child: new RaisedButton(
                  color: Colors.purple,
                  splashColor: Colors.blueAccent,
                  shape: new CircleBorder(),
                  child: new Text("Reset"),
                  onPressed: () {
                    setState(() {
                      _init();
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
            child: Container(
                width: 40,
                height: 16,
                child: Text("${item.toStringAsFixed(1)}%")))
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

  Color _randomColor() {
    var a = 255; // alpha = 0..255
    var r = _random.nextInt(256); // red = 0..255
    var g = _random.nextInt(256); // green = 0..255
    var b = _random.nextInt(256); // blue = 0..255
    return Color.fromARGB(a, r, g, b);
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }
}
