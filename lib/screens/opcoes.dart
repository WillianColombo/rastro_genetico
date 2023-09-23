import 'package:flutter/material.dart';
import 'package:rastro_genetico2/screens/add_animal.dart';
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
          const Card(
            elevation: 0,
            color: Color.fromRGBO(235, 230, 210, 1),
          ),
          GestureDetector(
            onTap: null,
            child: const Card(
              elevation: 0,
              color: Color.fromRGBO(235, 230, 210, 1),
            ),
          ),
          GestureDetector(
            onTap: null,
            child: const Card(
              elevation: 0,
              color: Color.fromRGBO(235, 230, 210, 1),
            ),
          ),
          GestureDetector(
            onTap: null,
            child: const Card(
              elevation: 0,
              color: Color.fromRGBO(235, 230, 210, 1),
            ),
          ),
          GestureDetector(
            onTap: null,
            child: const Card(
              elevation: 0,
              color: Color.fromRGBO(235, 230, 210, 1),
            ),
          ),
          const Card(
            elevation: 0,
            color: Color.fromRGBO(235, 230, 210, 1),
          ),
          const Card(
            elevation: 0,
            color: Color.fromRGBO(235, 230, 210, 1),
          ),
          GestureDetector(
            onTap: null,
            child: const Card(
              elevation: 0,
              color: Color.fromRGBO(235, 230, 210, 1),
            ),
          ),
          GestureDetector(
            onTap: () {
              addAnimal(context);
            },
            child: Card(
                elevation: 0,
                color: const Color.fromRGBO(31, 158, 73, 1),
                child: Column(
                  children: [
                    Expanded(child: Image.asset('assets/images/bovino.png')),
                    const Text(
                      'Cadastro dos animais',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            20.0, // Defina o tamanho de fonte desejado aqui
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const AnimalPage(racaId: 0),));
            },
            child: Card(
                elevation: 0,
                color: const Color.fromRGBO(31, 158, 73, 1),
                child: Column(
                  children: [
                    Expanded(child: Image.asset('assets/images/lista.png')),
                    const Text(
                      'Inventário dos animais',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            20.0, // Defina o tamanho de fonte desejado aqui
                        color: Color.fromARGB(255, 255, 255, 255)
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
          ),
          const Card(
            elevation: 0,
            color: Color.fromRGBO(235, 230, 210, 1),
          ),
        ],
      ),
    );
  }
}