import 'package:flutter/material.dart';
import 'package:rastro_genetico2/models/animal.dart';
import 'package:rastro_genetico2/models/raca.dart';
import '../dao/database.dart';
import 'package:flutter/services.dart';

class ViewAnimalDialog extends StatefulWidget {
  final int animalId;

  ViewAnimalDialog({required this.animalId});

  @override
  _ViewAnimalDialogState createState() => _ViewAnimalDialogState();
}

class _ViewAnimalDialogState extends State<ViewAnimalDialog> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController dataNascimento = TextEditingController();

  List<Raca>? allowedRacas;
  Raca? selectedRaca;
  Animal? animal;

  @override
  void initState() {
    super.initState();
    loadAllowedRacas();
    loadAnimalDetails(widget.animalId);
  }

  void updateAnimal(int idAnimal) async {
    final database = await $FloorAppDatabase.databaseBuilder('baitafome.db').build();
    final animalDao = database.animalDao;

    Animal? animal = await animalDao.findAnimalById(idAnimal);

    animal!.nome = nomeController.text;
    animal.dataNascimento = dataNascimento.text;
    animal.raca = selectedRaca?.id;

    animalDao.updateAnimal(animal);
    Navigator.of(context).pop('U');
  }

  // CARREGA TIPOS DO BANCO DE DADOS
  Future<void> loadAllowedRacas() async {
    final database = await $FloorAppDatabase.databaseBuilder('baitafome.db').build();
    final racaDao = database.racaDao;
    allowedRacas = await racaDao.findAllRaca();
    setState(() {});
  }

  Future<void> loadAnimalDetails(int animalId) async {
    final database = await $FloorAppDatabase.databaseBuilder('baitafome.db').build();
    final animalDao = database.animalDao;    

    animal = await animalDao.findAnimalById(widget.animalId);
    selectedRaca = allowedRacas?.firstWhere((raca) => raca.id == animal?.raca);

    idController.text = animal?.id.toString() ?? '';
    nomeController.text = animal?.nome ?? '';
    dataNascimento.text = animal?.dataNascimento ?? '';   

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Informação do animal"),
      content: Container(
        width: 540,
        height: 600,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    controller: idController,
                    maxLength: 5,
                    maxLines: 1,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: widget.animalId.toString(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      counter: SizedBox.shrink(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),                    
                  ),
                ),

                SizedBox(width: 10),

                Flexible(
                  flex: 4,
                  child: TextField(
                    controller: nomeController,
                    maxLength: 30,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: nomeController.toString(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      counter: SizedBox.shrink(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 20),
            TextField(
              controller: dataNascimento,
              maxLines: 2,
              maxLength: 100,
              decoration: InputDecoration(
                labelText: animal?.dataNascimento,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                counter: SizedBox.shrink(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.deny('\n'),
              ],
            ),

            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<Raca>(
                isExpanded: true,
                icon: const Icon(Icons.receipt),
                decoration: InputDecoration(
                  labelText: Text("Raça do animal").toString(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                value: selectedRaca,
                onChanged: (Raca? value) {
                  setState(() {
                    selectedRaca = value;
                  });
                },
                items: allowedRacas?.map((Raca raca) {
                  return DropdownMenuItem<Raca>(
                    value: raca,
                     child: Text(raca.nome!),
                    );
                  }).toList() ??
                [],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),

      actions: [
        TextButton(
          child: Text(
            "Deletar",
            style: TextStyle(
              color: Colors.red,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop('D');// D - Delete
          },
        ),        

        SizedBox(width: 330,),

        TextButton(
          child: Text(
            "Salvar",
            style: TextStyle(
              color: Colors.green,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            updateAnimal(widget.animalId);            
          },
        ),        

        TextButton(
          child: Text(
            "Sair",
            style: TextStyle(
              color: Colors.orange,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
      ],
    );
  }
}