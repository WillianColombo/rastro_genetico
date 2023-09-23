import 'package:floor/floor.dart';
import 'package:rastro_genetico2/models/animal.dart';

@dao
abstract class AnimalDao {
  @Query('SELECT * FROM animal ORDER BY animal.id')
  Future<List<Animal>> findAllAnimal();

  @Query('SELECT * FROM animal WHERE id = :id')
  Future<Animal?> findAnimalById(int id);

  @Query('SELECT * FROM animal WHERE raca = :raca')
  Future<List<Animal>> findAnimalByRaca(int raca);

  @insert
  Future<void>insertAnimal(Animal animal);

  @delete
  Future<void>deleteAnimal(Animal animal);

  @update
  Future<void>updateAnimal(Animal animal);
}