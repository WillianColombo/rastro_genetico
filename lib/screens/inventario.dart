import 'package:flutter/material.dart';
import 'package:rastro_genetico2/models/animal.dart';
import '../dao/database.dart';
import 'package:rastro_genetico2/screens/view_animal.dart';

class AnimalPage extends StatefulWidget {
  final int racaId;
  const AnimalPage({super.key, required this.racaId});
  
  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  List<Animal> animalList = [];

  @override
  void initState(){
    super.initState();
    loadAllowedAnimals(widget.racaId);
  }

  void viewAnimal(BuildContext context, int animalId) async {
    String? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ViewAnimalDialog(animalId: animalId);
      },    
    );

    if (result == 'D'){
      deleteAnimal(animalId);      
    }
    else if (result == 'U'){
      await loadAllowedAnimals(widget.racaId);
    }
  }

  void deleteAnimal(int idAnimal) async {
    final database = await $FloorAppDatabase.databaseBuilder('baitafome.db').build();
    final animalDao = database.animalDao;

    Animal? animal = await animalDao.findAnimalById(idAnimal);
    animalDao.deleteAnimal(animal!);

    await loadAllowedAnimals(widget.racaId);
  }

  // CARREGA AS RECEITAS DO BANCO DE DADOS
  Future<void> loadAllowedAnimals(int animalId) async {
    final database = await $FloorAppDatabase.databaseBuilder('baitafome.db').build();
    final animalDao = database.animalDao;

    final animals;
    if (animalId == 0){
      animals = await animalDao.findAllAnimal();
    }
    else{
      animals = await animalDao.findAnimalByRaca(animalId);
    }

    animalList = []; 
    setState((){
      animalList = animals;      
    });
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(223, 138, 84, 1),                        
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(
              context,               
            );
          },
          color: Color.fromRGBO(83, 85, 82, 1),
        ),
        title: Text("Animais",
          style: TextStyle(
            color: Color.fromRGBO(83, 85, 82, 1),
          ),
        ),
        centerTitle: true,
      ),

      body: ListView.builder(
        padding:  EdgeInsets.all(16.0),
        itemCount: animalList.length,
        itemBuilder: (BuildContext context, int index){
          Animal animal = animalList[index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 180.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  viewAnimal(context, animal.id!); 
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SizedBox(
                    height: 100.0,
                    child: ListTile(
                      leading: IconTheme(
                        data: IconThemeData(
                          size: 60.0,
                        ),
                        child: Icon(Icons.receipt_long),
                      ),
                      title: Text(
                        animal.nome ?? '',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        animal.dataNascimento ?? '',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),

      backgroundColor: Color.fromRGBO(235, 230, 210, 1),      
    );
  }
}