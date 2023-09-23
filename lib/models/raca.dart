import 'package:floor/floor.dart';

@entity
class Raca {
  @PrimaryKey()
  int? id;
  String? nome;


  Raca({
    required this.id,
    required this.nome,
  });

}