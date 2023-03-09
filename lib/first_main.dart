import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hello Flutter!',
      home: OrangeContainer(text: 'Lesson 10'),
      //home: Counter(),
    );
  }
}

class OrangeContainer extends StatelessWidget {

  final String text;

  const OrangeContainer({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar(
          title: Text(text),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: <Widget>[
                    Container(
                        margin:
                        const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 10, bottom: 0
                        ),
                        color: const Color(0xFF67FF50),
                        constraints: const BoxConstraints(
                            maxHeight: 300.0,
                            maxWidth: 200.0,
                            minWidth: 150.0,
                            minHeight: 150.0
                        )
                    ),
                    Container(
                        margin:
                        const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 0, bottom: 0
                        ),
                        color: const Color(0xFFFF7F50),
                        constraints: const BoxConstraints(
                            maxHeight: 300.0,
                            maxWidth: 200.0,
                            minWidth: 150.0,
                            minHeight: 150.0
                        )
                    ),
                    Container(
                        margin:
                        const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 0, bottom: 10
                        ),
                        color: const Color(0xFFFF7F50),
                        constraints: const BoxConstraints(
                            maxHeight: 300.0,
                            maxWidth: 200.0,
                            minWidth: 150.0,
                            minHeight: 150.0
                        )
                    ),
                    const Text(
                        'prova'
                    )
                ]
              )
            )
        )
    );
  }
}

class CounterState extends State<Counter> {

  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StatefulWidget'),
      ),
      body: Center(
          child: Text(
            '$_counter',
            style: const TextStyle(fontSize: 30),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}


class Counter extends StatefulWidget {
  const Counter({super.key});
  @override
  CounterState createState() => CounterState();

}