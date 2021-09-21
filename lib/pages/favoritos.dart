import 'package:flutter/material.dart';

class Favoritos extends StatefulWidget {
  const Favoritos({Key? key}) : super(key: key);

  @override
  State<Favoritos> createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
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
      ),
    );
  }
}
