// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors, prefer_interpolation_to_compose_strings, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/controller/documentos_controller.dart';
import '../model/comentarios.dart';
import '../model/games.dart';
import 'package:projeto/repositories/games_repository.dart';

class ComentariosJogo extends StatefulWidget {
  //Comentar comentar;
  Games games1;
  ComentariosJogo({Key? key, required this.games1}) : super(key: key);

  @override
  State<ComentariosJogo> createState() => _ComentariosJogoState();
}

List<Comentar> visualizar = [];

class _ComentariosJogoState extends State<ComentariosJogo> {
  String txtNome = '';
  String txtComentario = '';
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("comentarios")
        .snapshots()
        .listen((snapshot) {
      setState(() {
        var tabelacomentario = ComentariosRepository.tabelacomentario;
        tabelacomentario.clear();
        for (var doc in snapshot.docs) {
          tabelacomentario.add(Comentar.fromMap(doc.data()));
        }
      });
    });
    super.initState();
  }
  var txtComentario2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final tabelacomentario = ComentariosRepository.tabelacomentario;

    visualizar.clear();
    for (var i = 0; i < tabelacomentario.length; i++) {
      if (tabelacomentario[i].nome == widget.games1.nome) {
        visualizar.add(Comentar(
          nome: tabelacomentario[i].nome,
          comentario: tabelacomentario[i].comentario,
        ));
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 95, 95, 95),
        title: Text(widget.games1.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: DocumentosController().listarComentario().snapshots(),
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
                    itemCount: visualizar.length,
                    itemBuilder: (context, index) {
                      String id = dados.docs[index].id;
                      dynamic item = dados.docs[index].data();
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.account_circle_rounded,
                            size: 35,
                          ),
                          title: Text(visualizar[index].comentario),
                          onTap: () {
                            txtComentario2.text = item['comentario'];
                            txtNome = visualizar[index].nome;
                            txtComentario = visualizar[index].comentario;

                            salvarNome(context, docId: id);
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Nenhum nome encontrado.'),
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
          title: Text("Editar Comentário"),
          content: SizedBox(
            height: 70,
            width: 300,
            child: Column(
              children: [
                TextField(
                  onChanged: (text) {
                    txtComentario = text;
                  },
                  controller: txtComentario2,
                  decoration: InputDecoration(
                    labelText: 'Comentário',
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
                txtComentario2.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("salvar"),
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 95, 95, 95),
              ),
              onPressed: () {
                var c = Comentar(
                  nome: txtNome,
                  comentario: txtComentario,
                );

                txtComentario2.clear();
                DocumentosController().atualizarComentario(context, docId, c);
              },
            ),
          ],
        );
      },
    );
  }
}
