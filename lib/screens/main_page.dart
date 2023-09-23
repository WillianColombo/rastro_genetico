import 'package:flutter/material.dart';
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
        backgroundColor: const Color.fromRGBO(31, 158, 73, 1),        
        title: const Text(
          "Rastro Genético",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        centerTitle: true,
      ),
      body: Opcoes(),
      backgroundColor: const Color.fromRGBO(235, 230, 210, 1),
    );
  }
}