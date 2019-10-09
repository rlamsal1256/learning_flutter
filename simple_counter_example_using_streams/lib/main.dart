import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(Counter());

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;
  final StreamController<int> _streamController = StreamController<int>();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter using streams',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Counter using streams'),
        ),
        body: Center(
          child: StreamBuilder<int>(
            initialData: _counter,
            stream: _streamController.stream,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text('clicked ${snapshot.data} times');
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _streamController.sink.add(++_counter);
          },
        ),
      ),
    );
  }
}
