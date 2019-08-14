import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Scaffold(
    body: MyWidget(),
  ));
}

class MyWidget extends StatefulWidget {
  int _counter = 0;

  // ignore: close_sinks
  final StreamController<int> controller = StreamController();

  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

class _MyState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: widget.controller.stream,
        initialData: widget._counter,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Text("${snapshot.data}");
        },
      ),
    );
  }
}

