import 'package:flutter/material.dart';
import 'package:rastro_genetico2/screens/add_animal.dart';
import 'package:rastro_genetico2/screens/inventario.dart';

import 'opcoes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(223, 138, 84, 1),        
        title: Text(
          "Rastro Genético",
          style: TextStyle(
            color: Color.fromRGBO(83, 85, 82, 1),
          ),
        ),
        centerTitle: true,

        actions: <Widget>[          
          PopupMenuButton(
            color: Color.fromRGBO(246, 247, 241, 1),
            icon: Icon(Icons.list_alt, color: Colors.black),
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Listar todos os animais"),              
                ),
              ];
            },
            offset: Offset(0, 64),
            onSelected: (value){
              if (value == 0) {
                Navigator.push(context,MaterialPageRoute(builder: (context) => AnimalPage(racaId: 0),),);
              }
            },
          )
        ],

        
      ),
      body: Opcoes(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addAnimal(context);
        },
        backgroundColor: Color.fromRGBO(223, 138, 84, 1),
        child: Icon(
          Icons.add,
        ),
      ),
      backgroundColor: Color.fromRGBO(235, 230, 210, 1),
    );
  }
}