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
    final database = await $FloorAppDatabase.databaseBuilder('rastrogenetico.db').build();
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
    final database = await $FloorAppDatabase.databaseBuilder('rastrogenetico.db').build();
    final racaDao = database.racaDao;
    allowedRacas = await racaDao.findAllRaca();
    setState(() {});
  }

  Future<void> loadAnimalDetails(int animalId) async {
    final database = await $FloorAppDatabase.databaseBuilder('rastrogenetico.db').build();
    final animalDao = database.animalDao;    

    animal = await animalDao.findAnimalById(widget.animalId);
    selectedRaca = allowedRacas?.firstWhere((raca) => raca.id == animal?.raca);

    idController.text = animal?.id.toString() ?? '';
    nomeController.text = animal?.nome ?? '';
    dataNascimento.text = animal?.dataNascimento ?? '';   

    setState(() {});
  }

  

  String labelRaca = "Raça do animal";
  String labelDataNascimento = "Data de nascimento";
  String labelNome = "Nome do animal";
  String labelId = "ID";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Informação do animal"),
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
                      labelText: labelId,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      counter: const SizedBox.shrink(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),                    
                  ),
                ),

                const SizedBox(width: 10),

                Flexible(
                  flex: 4,
                  child: TextField(
                    controller: nomeController,
                    maxLength: 30,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: labelNome,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      counter: const SizedBox.shrink(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            TextField(
              controller: dataNascimento,
              maxLines: 2,
              maxLength: 100,
              decoration: InputDecoration(
                labelText: labelDataNascimento,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                counter: const SizedBox.shrink(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.deny('\n'),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<Raca>(
                isExpanded: true,
                icon: const Icon(Icons.receipt),
                decoration: InputDecoration(
                  labelText: labelRaca,
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

            const SizedBox(height: 20),
          ],
        ),
      ),

      actions: [
        TextButton(
          child: const Text(
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

        const SizedBox(width: 330,),

        TextButton(
          child: const Text(
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
          child: const Text(
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