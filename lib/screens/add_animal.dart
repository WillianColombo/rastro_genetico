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

  // CARREGA TYPE DO BANCO DE DADOS
  Future<void> loadAllowedRacas() async {
    final database = await $FloorAppDatabase.databaseBuilder('rastrogenetico.db').build();
    final racaDao = database.racaDao;
    allowedRacas = await racaDao.findAllRaca();
    setState(() {});
  }

  //GRAVAR A RECEITA NO BANCO DE DADOS
  void saveAnimal() async{
    final database = await $FloorAppDatabase.databaseBuilder('rastrogenetico.db').build();
    final AnimalDao = database.animalDao;

    final animal = Animal(nome: nomeController.text, dataNascimento: dataNascimentoController.text,  raca: selectedRaca?.id);
    await AnimalDao.insertAnimal(animal);
  }

  // VALIDAR SE A RECEITA TEM AS INFORMAÇÕES NECESSÁRIAS
  void validateAnimal(){
    if (selectedRaca != null && dataNascimentoController.text.isNotEmpty && nomeController.text.isNotEmpty) { 
      saveAnimal();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Animal adicionado!"),
          backgroundColor: Colors.green,
        ),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Algo deu errado, não fopi possível adicionar o animal!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  } 

  @override
  Widget build(BuildContext context) {
    if (allowedRacas == null) {
      return CircularProgressIndicator();
    }

    return AlertDialog(
      title: Text("Insira as informações do animal:"),
      content:  Container(
        width: 540, 
        height: 600, 
        child: Column(
        children: [

          TextField(
            controller: nomeController,
            maxLength: 30,          
            maxLines: 1,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always, 
              counter: SizedBox.shrink(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),

          SizedBox(height: 20),

          TextField(
            controller: dataNascimentoController,
            maxLines: 2,
            maxLength: 100,           
            decoration: InputDecoration(            
              floatingLabelBehavior: FloatingLabelBehavior.always, // Mantém o rótulo fixo na parte superior
              counter: SizedBox.shrink(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),              
            ),
            inputFormatters: [
              FilteringTextInputFormatter.deny('\n'), // Bloqueia a entrada da tecla "Enter"
            ],
          ),

          SizedBox(height: 20),
      
          SizedBox(
            width: double.infinity,            
            child: DropdownButtonFormField<Raca>(
              isExpanded: true, 
              icon: const Icon(Icons.receipt),
              hint: Text("Escolha a raça do animal:"),
              decoration: InputDecoration(
                label: Text("Raça do animal"),
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

          SizedBox(height: 20),
        ],
      ),
      ),
      actions: [        
        TextButton(
          child: Text("Salvar",
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
          child: Text("Sair",
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