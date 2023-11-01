import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_movie_list/models/comentario.dart';
import 'package:my_movie_list/models/filme.dart';

import 'package:http/http.dart' as http;

class FilmeController extends ChangeNotifier {
  final _baseUrl = 'https://projeto-un2-mobile-default-rtdb.firebaseio.com/';
  List<Filme> _dados = [];

  List<Filme> get dados => _dados;

  Filme retornarFilme(Filme filme) {
    var index = _dados.indexOf(filme);

    return _dados.elementAt(index);
  }

  Future<List<Filme>> carregarFilmes() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/filmes.json'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      for (var index = 0; index < body.length; index++) {
        final filme = Filme.fromJson(body[index], index);

        _dados.add(filme);
      }

      notifyListeners();
      return _dados;
    } else {
      throw Exception('Failed to load filmes');
    }
  }

  Future<void> adicionarComentario(
      Comentario comentario, String idFilme) async {
    var request = jsonEncode({
      "titulo": comentario.titulo,
      "descricao": comentario.descricao,
      "data": comentario.data.toString(),
      "idUsuario": comentario.idUsuario,
      "nomeUsuario": comentario.nomeUsuario,
    });

    final response = await http.post(
        Uri.parse('$_baseUrl/filmes/$idFilme/comentarios.json'),
        body: request);
    if (response.statusCode == 200) {
      final idComentario = jsonDecode(response.body)['name'];
      Comentario novoComentario = Comentario(
          id: idComentario,
          titulo: comentario.titulo,
          descricao: comentario.descricao,
          idUsuario: comentario.idUsuario,
          nomeUsuario: comentario.nomeUsuario,
          data: comentario.data);

      _dados[int.parse(idFilme)].comentarios.add(novoComentario);
      notifyListeners();
    } else {
      throw Exception('Erro ao adicionar comentário');
    }
  }

  Future<void> editarComentario(Comentario comentario, String idFilme) async {
    final idComentario = comentario.id;
    var request = jsonEncode({
      "titulo": comentario.titulo,
      "descricao": comentario.descricao,
      "data": comentario.data.toString(),
      "idUsuario": comentario.idUsuario,
      "nomeUsuario": comentario.nomeUsuario,
    });

    final response = await http.put(
        Uri.parse('$_baseUrl/filmes/$idFilme/comentarios/$idComentario.json'),
        body: request);

    if (response.statusCode == 200) {
      final indexComentario = _dados[int.parse(idFilme)]
          .comentarios
          .indexWhere((element) => element.id == comentario.id);
      _dados[int.parse(idFilme)].comentarios[indexComentario] = comentario;
      notifyListeners();
    } else {
      throw Exception('Erro ao editar comentário');
    }
  }

  Future<void> removerComentario(Comentario comentario, String idFilme) async {
    final idComentario = comentario.id;
    final response = await http.delete(
        Uri.parse('$_baseUrl/filmes/$idFilme/comentarios/$idComentario.json'));

    if (response.statusCode == 200) {
      _dados[int.parse(idFilme)].comentarios.remove(comentario);
      notifyListeners();
    } else {
      throw Exception('Erro ao remover comentário');
    }
  }
}
