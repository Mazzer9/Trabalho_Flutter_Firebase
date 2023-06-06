class Comentar {

  final String nome;
  final String comentario;

  Comentar({
    required this.nome,
    required this.comentario,
  });

   Comentar.fromMap(Map<String, dynamic> map)
      : nome = map["nome"],
        comentario = map["comentario"];

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "comentario": comentario,
    };
  }
}
