
import 'package:rastro_genetico2/models/raca.dart';
import 'package:rastro_genetico2/dao/database.dart';

class Utils {
 generatedRaca() {
 }
}

void generatedRaca() async {
  final database = await $FloorAppDatabase.databaseBuilder('rastrogenetico.db').build();
  final racaDao = database.racaDao;
  final raca1 = Raca(id: 1, nome: 'Nelore');
  final raca2 = Raca(id: 2, nome: 'Angus');
  final raca3 = Raca(id: 3, nome: 'Gil');
  final raca4 = Raca(id: 4, nome: 'Jersey');
  final raca5 = Raca(id: 5, nome: 'Pantaneira');

  await racaDao.insertRaca(raca1);
  await racaDao.insertRaca(raca2);
  await racaDao.insertRaca(raca3);
  await racaDao.insertRaca(raca4);
  await racaDao.insertRaca(raca5);
}