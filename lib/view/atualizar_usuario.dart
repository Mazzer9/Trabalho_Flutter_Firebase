// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto/controller/login_controller.dart';
import 'package:projeto/model/usuario.dart';

class AtualizarUsuario extends StatefulWidget {
  const AtualizarUsuario({super.key});

  @override
  State<AtualizarUsuario> createState() => _AtualizarUsuarioState();
}

class _AtualizarUsuarioState extends State<AtualizarUsuario> {
  var txtNome = TextEditingController();

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
        title: Text('Atualizar nome'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: LoginController().listar().snapshots(),
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
                    itemCount: dados.size,
                    itemBuilder: (context, index) {
                      String id = dados.docs[index].id;
                      dynamic item = dados.docs[index].data();
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.account_circle_rounded,
                            size: 35,
                          ),
                          title: Text(item['nome']),
                          onTap: () {
                            txtNome.text = item['nome'];

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
          title: Text("Atualizar nome"),
          content: SizedBox(
            height: 70,
            width: 300,
            child: Column(
              children: [
                TextField(
                  controller: txtNome,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(
                      Icons.account_circle_rounded,
                      size: 25,
                    ),
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
                txtNome.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("salvar"),
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 95, 95, 95),
              ),
              onPressed: () {
                var u = Usuarios(
                  LoginController().idUsuario(),
                  txtNome.text,
                );
                txtNome.clear();
                LoginController().atualizar(context, docId, u);
              },
            ),
          ],
        );
      },
    );
  }
}
