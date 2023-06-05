import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/model/games.dart';
import 'package:projeto/repositories/games_repository.dart';

class JogosController{
  acrescentarJogo(nome, foto, categoria, plataforma, sobre){
    FirebaseFirestore.instance.collection('jogos').add({
        'nome': nome,
        'foto': foto,
        'categoria': categoria,
        'plataforma': plataforma,
        'sobre': sobre,
      });
  }
  /*refresh() async {
    var tabela = GamesRepository.tabela;
    tabela.clear();

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("jogos").get();

    for (var doc in snapshot.docs) {
      tabela.add(Games.fromMap(doc.data()));
    }
  }*/
}