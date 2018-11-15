import 'package:flutter/material.dart';

import 'custom.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Container(
              width: 300,
              height: 300,
              child: CustomPaint(
                foregroundPainter:
                    MyPainter(width: 32.0, percents: [10.0, 20.0, 30.0, 10.0]),
                child: new Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: new RaisedButton(
                    color: Colors.purple,
                    splashColor: Colors.blueAccent,
                    shape: new CircleBorder(),
                    child: new Text("Click"),
                    onPressed: () {},
                  ),
                ),
              ))),
    );
  }
}
