class Usuarios {
  final String uid;
  final String nome;

  Usuarios(this.uid, this.nome);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'nome': nome
    };
  }

  factory Usuarios.fromJson(Map<String, dynamic> json) {
    return Usuarios(
      json['uid'],
      json['nome']
    );
  }
}