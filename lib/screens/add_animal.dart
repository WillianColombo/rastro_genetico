import 'package:rastro_genetico2/models/animal.dart';
import 'package:flutter/material.dart';
import 'package:rastro_genetico2/models/raca.dart';
import '../dao/database.dart';
import 'package:flutter/services.dart';

class AddAnimalDialog extends StatefulWidget {
  @override
  _AddAnimalDialogState createState() => _AddAnimalDialogState();
}

void addAnimal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddAnimalDialog();
    },
  );
}

class _AddAnimalDialogState extends State<AddAnimalDialog> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController dataNascimentoController = TextEditingController();

  List<Raca>? allowedRacas;
  Raca? selectedRaca;

  @override
  void initState() {
    super.initState();
    loadAllowedRacas();
  }

  Future<void> loadAllowedRacas() async {
    final database = await $FloorAppDatabase.databaseBuilder('rastrogenetico.db').build();
    final racaDao = database.racaDao;
    allowedRacas = await racaDao.findAllRaca();
    setState(() {});
  }

  void saveAnimal() async{
    final database = await $FloorAppDatabase.databaseBuilder('rastrogenetico.db').build();
    final AnimalDao = database.animalDao;

    final animal = Animal(nome: nomeController.text, dataNascimento: dataNascimentoController.text,  raca: selectedRaca?.id);
    await AnimalDao.insertAnimal(animal);
  }

  void validateAnimal(){
    if (selectedRaca != null && dataNascimentoController.text.isNotEmpty && nomeController.text.isNotEmpty) { 
      saveAnimal();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Animal adicionado!"),
          backgroundColor: Colors.green,
        ),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Algo deu errado, não fopi possível adicionar o animal!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  } 

  final String _labelNome = "Nome do animal";
  final String _labelDataNascimento = "Data de nascimento";

  @override
  Widget build(BuildContext context) {
    if (allowedRacas == null) {
      return const CircularProgressIndicator();
    }

    return AlertDialog(
      title: const Text("Insira as informações do animal:"),
      content: Container(
        width: 540, 
        height: 600, 
        child: Column(
        children: [

          TextField(
            controller: nomeController,
            maxLength: 30,          
            maxLines: 1,
            decoration: InputDecoration(
              labelText:_labelNome,
              floatingLabelBehavior: FloatingLabelBehavior.always, 
              counter: const SizedBox.shrink(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: dataNascimentoController,
            maxLines: 2,
            maxLength: 100,           
            decoration: InputDecoration(
              labelText: _labelDataNascimento,            
              floatingLabelBehavior: FloatingLabelBehavior.always, // Mantém o rótulo fixo na parte superior
              counter: const SizedBox.shrink(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),              
            ),
            inputFormatters: [
              FilteringTextInputFormatter.deny('\n'), // Bloqueia a entrada da tecla "Enter"
            ],
          ),

          const SizedBox(height: 20),
      
          SizedBox(
            width: double.infinity,            
            child: DropdownButtonFormField<Raca>(
              isExpanded: true, 
              icon: const Icon(Icons.receipt),
              hint: const Text("Escolha a raça do animal:"),
              decoration: InputDecoration(
                label: const Text("Raça do animal"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                )
              ),
              value: selectedRaca,
              onChanged: (Raca? value) {
                setState(() {
                  selectedRaca = value;
                });
              },
              items: allowedRacas!.map((Raca raca) {
                return DropdownMenuItem<Raca>(
                  value: raca,
                  child: Text(raca.nome.toString()),
                );
              }).toList(),                
            )
          ),

          const SizedBox(height: 20),
        ],
      ),
      ),
      actions: [        
        TextButton(
          child: const Text("Salvar",
            style: TextStyle(
              color: Colors.green,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            validateAnimal();
            Navigator.of(context).pop();
          },
        ),        

        TextButton(
          child: const Text("Sair",
            style: TextStyle(
              color: Colors.orange,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}