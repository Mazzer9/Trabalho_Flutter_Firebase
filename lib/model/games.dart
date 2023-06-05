class Games {
  //Atributos
  final String nome;
  final String foto;
  late final String categoria;
  final String plataforma;
  final String sobre;

  Games({
    required this.nome,
    required this.foto,
    required this.categoria,
    required this.plataforma,
    required this.sobre,
  });

  Games.fromMap(Map<String, dynamic> map)
      : nome = map["nome"],
        foto = map["foto"],
        categoria = map["categoria"],
        plataforma = map["plataforma"],
        sobre = map["sobre"];

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "foto": foto,
      "categoria": categoria,
      "plataforma": plataforma,
      "sobre": sobre,
    };
  }
}