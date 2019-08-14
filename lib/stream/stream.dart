import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:flutter/material.dart';

void main() {

  runApp(MaterialApp(
    home: StreamWidget(),
  ));

}

class StreamWidget extends StatefulWidget {
  @override
  StreamWidgetState createState() => new StreamWidgetState();
}

class StreamWidgetState extends State<StreamWidget> {
  final StreamController<int> controller = StreamController();

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream version of the Counter App')),
      body: Center(
        child: StreamBuilder<int>(
            stream: controller.stream,
            initialData: _counter,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              debugPrint('我重建了');
              return Text('You hit me: ${snapshot.data} times');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          controller.sink.add(++_counter);
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}
