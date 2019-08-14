import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp(
    model: CounterModel(),
  ));
}

class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final CounterModel model;

  const MyApp({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
      model: model,
      child: MaterialApp(
        title: 'Scoped Model Demo',
        home: CountPage(),
      ),
    );
  }
}

class CountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('counter page rebuild');
    return Scaffold(
      appBar: AppBar(
        title: Text('Scoped Model'),
        actions: <Widget>[
          IconButton(
            tooltip: 'to result',
            icon: Icon(Icons.home),
            onPressed: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => ResultPage()));
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('你都点击'),
            ScopedModelDescendant<CounterModel>(
              builder: (context, child, model) {
                print('test重建了');
                return WidgetA(model);
              },
            ),
            WidgetB()
          ],
        ),
      ),
      floatingActionButton: ScopedModelDescendant<CounterModel>(
        builder: (context, child, model) {
          return FloatingActionButton(
            onPressed: model.increment,
            tooltip: 'add',
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}

class WidgetA extends StatelessWidget {
  CounterModel model;
  WidgetA(this.model);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${model.counter.toString()} 次了',
      style: TextStyle(
        color: Colors.red,
        fontSize: 33.0,
      ),
    );
  }
}

class WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('WidgetB build');
    return Text('WidgetB');
  }
}
