import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/model/comentarios.dart';
import 'package:projeto/model/games.dart';
import 'package:projeto/view/util.dart';

class DocumentosController{
void atualizarComentario(context, id, Comentar c) {
    FirebaseFirestore.instance
        .collection('comentarios')
        .doc(id)
        .update(c.toMap())
        .then((value) => sucesso(context, 'Comentário editado com sucesso'))
        .catchError(
            (e) => erro(context, 'Não foi possível editar o comentário.'))
        .whenComplete(() => Navigator.pop(context));
  }
  listarComentario() {
    return FirebaseFirestore.instance
        .collection('comentarios');
  }

  void atualizarJogos(context, id, Games g) {
    FirebaseFirestore.instance
        .collection('jogos')
        .doc(id)
        .update(g.toMap())
        .then((value) => sucesso(context, 'Jogo editado com sucesso'))
        .catchError(
            (e) => erro(context, 'Não foi possível editar o jogo.'))
        .whenComplete(() => Navigator.pop(context));
  }
  listarJogos() {
    return FirebaseFirestore.instance
        .collection('jogos');
  }

}