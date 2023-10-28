import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_movie_list/models/comentario.dart';
import 'package:my_movie_list/models/filme.dart';

import 'package:http/http.dart' as http;

class FilmeContext extends ChangeNotifier {
  final _baseUrl = 'https://projeto-un2-mobile-default-rtdb.firebaseio.com/';
  List<Filme> _dados = [];

  List<Filme> get dados => _dados;

  Future<List<Filme>> carregarFilmes() async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/filmes.json'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      for(var index=0; index<body.length; index++) {
        final filme = Filme.fromJson(body[index], index);
        _dados.add(filme);
      }

      return _dados;
    } else {
      throw Exception('Failed to load filmes');
    }
  }

  Future<void> adicionarComentario(Comentario comentario, String idFilme) async {
    var request = jsonEncode({
      "titulo": comentario.titulo,
      "descricao": comentario.descricao,
      "data": comentario.data.toString(),
      "idUsuario": comentario.idUsuario,
    });

    final response = await http.post(Uri.parse('$_baseUrl/filmes/$idFilme/comentarios.json'), body: request);

    if (response.statusCode == 200) {
      _dados[0].comentarios.add(comentario);
    } else {
      throw Exception('Erro ao adicionar comentário');
    }
  }

  Future<void> editarComentario(Comentario comentario, String idFilme, String idComentario) async {
    // var request = jsonEncode({
    //   "titulo": comentario.titulo,
    //   "descricao": comentario.descricao,
    //   "data": comentario.data.toString(),
    //   "idUsuario": comentario.idUsuario,
    // });

    // final response = await http.post(Uri.parse('$_baseUrl/filmes/$idFilme/comentarios/$idComentario.json'), body: request);

    // if (response.statusCode == 200) {
    //   _dados[0].comentarios[idComentario] = comentario;
    // } else {
    //   throw Exception('Erro ao adicionar comentário');
    // }
  }
}