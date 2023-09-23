import 'package:floor/floor.dart';

@entity
class Animal {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? nome;
  String? dataNascimento;
  int? raca;
  int? numeroMae;
  int? numeroPai;

  Animal(
      {this.id,
      this.nome,
      this.dataNascimento,
      this.raca,
      this.numeroMae,
      this.numeroPai});
}
