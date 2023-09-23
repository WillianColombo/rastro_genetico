import 'package:flutter/material.dart';
import 'package:rastro_genetico2/screens/inventario.dart';

class Opcoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        padding: const EdgeInsets.all(40),
        crossAxisSpacing: 40,
        mainAxisSpacing: 40,
        crossAxisCount: 6,
        childAspectRatio: 1.13,
        children: [
          Card(
            elevation: 0,
            color: Color.fromRGBO(121, 204, 104, 1),
          ),
          GestureDetector(
            onTap: null,
            child: Card(
              elevation: 0,
              color: Color.fromRGBO(121, 204, 104, 1),
            ),
          ),
          GestureDetector(
            onTap: null,
            child: Card(
              elevation: 0,
              color: Color.fromRGBO(121, 204, 104, 1),
            ),
          ),
          GestureDetector(
            onTap: null,
            child: Card(
              elevation: 0,
              color: Color.fromRGBO(121, 204, 104, 1),
            ),
          ),
          GestureDetector(
            onTap: null,
            child: Card(
              elevation: 0,
              color: Color.fromRGBO(121, 204, 104, 1),
            ),
          ),
          Card(
            elevation: 0,
            color: Color.fromRGBO(121, 204, 104, 1),
          ),
          Card(
            elevation: 0,
            color: Color.fromRGBO(121, 204, 104, 1),
          ),
          GestureDetector(
            onTap: null,
            child: Card(
              elevation: 0,
              color: Color.fromRGBO(121, 204, 104, 1),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimalPage(racaId: 6),
                ),
              );
            },
            child: Card(
                elevation: 0,
                color: Color.fromRGBO(121, 204, 104, 1),
                child: Column(
                  children: [
                    Expanded(child: Image.asset('assets/images/bovino.png')),
                    Text(
                      'Cadastro de Bovinos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            20.0, // Defina o tamanho de fonte desejado aqui
                      ),
                    ),
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimalPage(racaId: 7),
                ),
              );
            },
            child: Card(
                elevation: 0,
                color: Color.fromRGBO(121, 204, 104, 1),
                child: Column(
                  children: [
                    Expanded(child: Image.asset('assets/images/arvore.png')),
                    Text(
                      'Árvore Genealógica',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            20.0, // Defina o tamanho de fonte desejado aqui
                      ),
                    ),
                  ],
                )),
          ),
          Card(
            elevation: 0,
            color: Color.fromRGBO(121, 204, 104, 1),
          ),
        ],
      ),
    );
  }
}