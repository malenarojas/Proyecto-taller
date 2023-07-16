import 'dart:convert';
class Estamento {
  int idEstamento;
  String nombre;
  int codigo;
  String foto;

  Estamento({
    required this.idEstamento,
    required this.nombre,
    required this.codigo,
    required this.foto,
  });

  factory Estamento.fromJson(String str) =>
      Estamento.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Estamento.fromMap(Map<String, dynamic> json) => Estamento(
        idEstamento: json["idEstamento"],
        nombre: json["nombre"],
        codigo: json["codigo"],
        foto: json["foto"],
      );

  Map<String, dynamic> toMap() => {
        "idEstamento": idEstamento,
        "nombre": nombre,
        "codigo": codigo,
        "foto": foto,
      };

  bool get isEmpty => idEstamento == 0 && nombre.isEmpty && codigo == 0;

  static List<Estamento> parseEstamentos(String jsonString) {
    final Map<String, dynamic> parsedJson = json.decode(jsonString);
    final List<dynamic>? estamentosListJson = parsedJson['estamentos'];
    if (estamentosListJson != null) {
      return estamentosListJson
          .map((estamento) => Estamento.fromMap(estamento))
          .toList();
    } else {
      return [];
    }
  }
}
