// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/comentarios.dart';
import 'package:projeto/repositories/games_repository.dart';

class ComentarJogo extends StatefulWidget {
  const ComentarJogo({super.key});

  @override
  State<ComentarJogo> createState() => _ComentarJogoState();
}

class _ComentarJogoState extends State<ComentarJogo> {
  var txtNome = TextEditingController();
  var txtComentario = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabelacomentario = ComentariosRepository.tabelacomentario;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 95, 95, 95),
        title: Text('Comentar Jogo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: txtNome,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Nome do Jogo',
                  labelStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: txtComentario,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Comentário',
                  labelStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 95, 95, 95),
                ),
                onPressed: () {
                  //EVENTO DE PRESSIONAMENTO DO BOTÃO
                  if (txtNome.text.isNotEmpty &&
                      txtComentario.text.isNotEmpty) {
                    Comentar tabelacomentario = Comentar(
                      nome: txtNome.text,
                      comentario: txtComentario.text,
                    );
                    FirebaseFirestore.instance
                        .collection("comentarios")
                        .doc()
                        .set(tabelacomentario.toMap());
                    mensagem(
                      'Jogo comentado com sucesso.',
                      Colors.blueAccent.shade100,
                    );
                  } else {
                    mensagem(
                      'Os campos não podem ser vazios.',
                      Colors.redAccent.shade100,
                    );
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  mensagem(msg, cor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        //: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: cor,
    ));
  }
}
