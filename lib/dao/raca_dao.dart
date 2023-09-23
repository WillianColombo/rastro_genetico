import 'package:floor/floor.dart';
import 'package:rastro_genetico2/models/raca.dart';


@dao
abstract class RacaDao {
  @Query('SELECT * FROM Raca')
  Future<List<Raca>> findAllRaca();

  @Query('SELECT nome FROM Raca WHERE id = :id')
  Future<List<String>> findAllNomeRaca(int id);

  @Query('SELECT * FROM Raca WHERE id = :id')
  Future<Raca?> findRacaById(int id);

  @insert
  Future<void> insertRaca(Raca raca);
}