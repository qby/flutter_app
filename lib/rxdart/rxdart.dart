import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(MaterialApp(
    home: MyWidget(),
  ));
}

// ignore: must_be_immutable
class MyWidget extends StatefulWidget {
  int _counter = 0;

  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

class _MyState extends State<MyWidget> {
  final PublishSubject<int> controller = PublishSubject<int>();

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: controller.stream,
          initialData: widget._counter,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Text("${snapshot.data}");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            controller.sink.add(++widget._counter);
          }),
    );
  }
}
