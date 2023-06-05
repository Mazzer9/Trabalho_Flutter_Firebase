// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/controller/jogos_controller.dart';
import '../model/games.dart';

class AdicionarJogo extends StatefulWidget {
  const AdicionarJogo({super.key});

  @override
  State<AdicionarJogo> createState() => _AdicionarJogoState();
}

class _AdicionarJogoState extends State<AdicionarJogo> {
  var txtNome = TextEditingController();
  var txtFoto = TextEditingController();
  var txtCategoria = TextEditingController();
  var txtPlataforma = TextEditingController();
  var txtSobre = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 95, 95, 95),
        title: Text('Adicionar Jogo'),
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
                controller: txtFoto,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Imagem',
                  labelStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: txtCategoria,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Categoria',
                  labelStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: txtPlataforma,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Plataformas',
                  labelStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: txtSobre,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Sobre',
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
                  if (txtNome.text.isNotEmpty && txtFoto.text.isNotEmpty && txtCategoria.text.isNotEmpty && txtPlataforma.text.isNotEmpty && txtSobre.text.isNotEmpty) {
                    Games tabela = Games(
                      nome: txtNome.text,
                      foto: txtFoto.text,
                      categoria: txtCategoria.text,
                      plataforma: txtPlataforma.text,
                      sobre: txtSobre.text,
                    );

                    // Salvar no Firestore
                    firestore.collection("jogos").doc().set(tabela.toMap());
                    mensagem(
                      'Jogo adicionado com sucesso.',
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
      ),
      duration: Duration(seconds: 2),
      backgroundColor: cor,
    ));
  }
}
