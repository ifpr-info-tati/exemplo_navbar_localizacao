import 'package:flutter/material.dart';

import 'favoritos.dart';
import 'home.dart';
import 'localizacao.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  //indice que indica qual página está selecionada
  var _index = 0;

  //lista que armazena as páginas que serão utilizadas.
  //O número de páginas e a ordem na lista devem corresponder ao número de icones na barra de
  //navegação.
  final pages = [
    Home(),
    Favoritos(),
    Localizacao(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Utilizamos o IndexdStack caso seja necessário salvar o estado das páginas
      //mesmo após trocar páginas.
      body: IndexedStack(
        index: _index,
        children: pages,
      ),
      //componente responsável por controlar as trocas de páginas
      bottomNavigationBar: BottomNavigationBar(
        //propriedade que indica a página selecionada
        currentIndex: _index,
        //utilizado para registrar a troca de páginas
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        //itens que compõem a barra
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin),
            label: 'Localização',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
            backgroundColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
