// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto/controller/documentos_controller.dart';
import 'package:projeto/model/games.dart';
import 'package:projeto/repositories/games_repository.dart';

class AtualizarJogos extends StatefulWidget {
  const AtualizarJogos({super.key});

  @override
  State<AtualizarJogos> createState() => _AtualizarJogosState();
}

class _AtualizarJogosState extends State<AtualizarJogos> {
  String txtNome = '';
  String txtFoto = '';
  String txtCategoria = '';
  String txtPlataforma = '';
  String txtSobre = '';

  var txtNome2 = TextEditingController();
  var txtFoto2 = TextEditingController();
  var txtCategoria2 = TextEditingController();
  var txtPlataforma2 = TextEditingController();
  var txtSobre2 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabela = GamesRepository.tabela;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 95, 95, 95),
        title: Text('Editar Jogos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: DocumentosController().listarJogos().snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Text('Não foi possível conectar.'),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                final dados = snapshot.requireData;
                if (dados.size > 0) {
                  return ListView.builder(
                    itemCount: tabela.length,
                    itemBuilder: (context, index) {
                      String id = dados.docs[index].id;
                      dynamic item = dados.docs[index].data();
                      return Card(
                        child: ListTile(
                          title: Text(item['nome']),
                          onTap: () {
                            txtNome2.text = item['nome'];
                            txtNome = tabela[index].nome;
                            txtFoto = tabela[index].foto;
                            txtFoto2.text = item['foto'];
                            txtCategoria = tabela[index].categoria;
                            txtCategoria2.text = item['categoria'];
                            txtPlataforma = tabela[index].plataforma;
                            txtPlataforma2.text = item['plataforma'];
                            txtSobre = tabela[index].sobre;
                            txtSobre2.text = item['sobre'];

                            salvarNome(context, docId: id);
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Nenhum jogo encontrado.'),
                  );
                }
            }
          },
        ),
      ),
    );
  }

  void salvarNome(context, {docId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Jogo"),
          content: SizedBox(
            height: 320,
            width: 300,
            child: Column(
              children: [
                TextField(
                  onChanged: (text) {
                    txtNome = text;
                  },
                  controller: txtNome2,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (text) {
                    txtFoto = text;
                  },
                  controller: txtFoto2,
                  decoration: InputDecoration(
                    labelText: 'Imagem',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (text) {
                    txtCategoria = text;
                  },
                  controller: txtCategoria2,
                  decoration: InputDecoration(
                    labelText: 'Categoria',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (text) {
                    txtPlataforma = text;
                  },
                  controller: txtPlataforma2,
                  decoration: InputDecoration(
                    labelText: 'Plataformas',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (text) {
                    txtSobre = text;
                  },
                  controller: txtSobre2,
                  decoration: InputDecoration(
                    labelText: 'Sobre',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          actions: [
            TextButton(
              child: Text("fechar"),
              style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 255, 255, 255),
                backgroundColor: Color.fromARGB(255, 95, 95, 95),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("salvar"),
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 95, 95, 95),
              ),
              onPressed: () {
                var g = Games(
                  nome: txtNome,
                  foto: txtFoto,
                  categoria: txtCategoria,
                  plataforma: txtPlataforma,
                  sobre: txtSobre,
                );

                DocumentosController().atualizarJogos(context, docId, g);
              },
            ),
          ],
        );
      },
    );
  }
  
}
