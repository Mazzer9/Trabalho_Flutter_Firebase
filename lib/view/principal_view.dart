// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/controller/login_controller.dart';
import 'package:projeto/repositories/games_repository.dart';
import 'package:projeto/view/games_detalhes.dart';
import '../model/games.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("jogos")
        .snapshots()
        .listen((snapshot) {
      setState(() {
        var tabela = GamesRepository.tabela;
        tabela.clear();
        for (var doc in snapshot.docs) {
          tabela.add(Games.fromMap(doc.data()));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabela = GamesRepository.tabela;

    mostrarDetalhes(Games games) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => GamesDetalhes(games: games),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 95, 95, 95),
        child: ListView(children: [
          FutureBuilder<String>(
              future: LoginController().usuarioLogado(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: UserAccountsDrawerHeader(
                      accountName: Text(snapshot.data.toString()),
                      accountEmail: Text(''),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: AssetImage("lib/images/icon.png"),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 50, 50, 50),
                      ),
                    ),
                  );
                }
                return Text('');
              }),
          ListTile(
            title: Text(
              'Categorias',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            title: Text(
              'Ação',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, 't5').then((_) => setState(() {}));
            },
          ),
          ListTile(
            title: Text(
              'Corrida',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, 't6').then((_) => setState(() {}));
            },
          ),
          ListTile(
            title: Text(
              'Estratégia',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, 't7').then((_) => setState(() {}));
            },
          ),
          ListTile(
            title: Text(
              'RPG',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, 't4').then((_) => setState(() {}));
            },
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            title: Text(
              'Adicionar Jogo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, 't2').then((_) => setState(() {}));
            },
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            title: Text(
              'Comentar Jogo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, 't3').then((_) => setState(() {}));
            },
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            title: Text(
              'Favoritos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, 't8').then((_) => setState(() {}));
            },
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            title: Text(
              'Atualizar Nome',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, 't10').then((_) => setState(() {}));
            },
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            title: Text(
              'Sobre',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, 't9').then((_) => setState(() {}));
            },
          ),
          Divider(
            color: Colors.white,
          ),
        ]),
      ),
      appBar: AppBar(
        title: Text('Jogos'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 95, 95, 95),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 11),
            ),
            onPressed: () {
              LoginController().logout();
              Navigator.pushReplacementNamed(context, 't0');
            },
            icon: Icon(Icons.exit_to_app, size: 13),
            label: Text('Logout'),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int games) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  tabela[games].nome,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () => mostrarDetalhes(tabela[games]),
                  child: Image.asset(
                    tabela[games].foto,
                    width: MediaQuery.of(context).size.width * 0.80,
                    height: MediaQuery.of(context).size.height * 0.40,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: tabela.length,
      ),
    );
  }
}
