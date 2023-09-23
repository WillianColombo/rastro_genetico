import 'dart:async';

import 'package:floor/floor.dart';
import 'package:rastro_genetico2/dao/animal_dao.dart';
import 'package:rastro_genetico2/dao/raca_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:rastro_genetico2/models/animal.dart';
import 'package:rastro_genetico2/models/raca.dart';


part 'database.g.dart'; //Generated code here

@Database(version: 1, entities: [Raca, Animal])
abstract class AppDatabase extends FloorDatabase {
  RacaDao get racaDao;
  AnimalDao get animalDao;
}