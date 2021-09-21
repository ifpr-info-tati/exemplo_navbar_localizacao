import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _counter = 0;

  incrementa() {
    setState(() {
      _counter += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Text('Clicou $_counter vezes...'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: incrementa,
          child: Icon(Icons.add),
        ));
  }
}
