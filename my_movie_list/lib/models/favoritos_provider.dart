import 'package:flutter/material.dart';
import 'package:my_movie_list/models/filme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

import '../context/usuario_controller.dart';

class FavoritoProviderModel extends ChangeNotifier {
  final _baseUrl = 'https://projeto-un2-mobile-default-rtdb.firebaseio.com/';
  List<Filme> filmesFavoritos = [];

  Future<List<Filme>> carregarFilmesFavoritos(String usuarioId) async {
    filmesFavoritos = [];
    final response = await http.get(
      Uri.parse('$_baseUrl/filmesFavoritos/$usuarioId.json'),
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      Map<String, dynamic> body = json.decode(response.body);

      body.forEach((id, element) {
        print('element');
        print(element);
        final novoUsuario = Filme.fromJson(element, id as int);
        filmesFavoritos.add(novoUsuario);
      });
      return filmesFavoritos;
    } else {
      throw Exception('Erro ao carregar usuários!');
    }
  }

  Future<void> adicionarFilmeFavorito(Filme filme) async {
    var request = jsonEncode({
      "banner": filme.banner,
      "titulo": filme.titulo,
      "comentarios": filme.comentarios,
      "descricao": filme.descricao,
      "genero": filme.genero,
      "imagens": filme.imagens,
    });

    final response = await http.post(Uri.parse('$_baseUrl/usuarios.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: request);

    if (response.statusCode == 200) {
      final id = jsonDecode(response.body)['name'];
      print(jsonDecode(response.body));
      filmesFavoritos.add(Filme(
          banner: filme.banner,
          titulo: filme.titulo,
          comentarios: filme.comentarios,
          descricao: filme.descricao,
          genero: filme.genero,
          imagens: filme.imagens,
          id: id));
      notifyListeners();
    } else {
      throw Exception('Erro ao adicionar filme');
    }
  }

  void toggleFavoritos(Filme filme) {
    if (eFavorito(filme)) {
      adicionarFilmeFavorito(filme);
    } else {
      filmesFavoritos.remove(filme);
    }
    notifyListeners();
  }

  bool eFavorito(Filme filme) {
    return filmesFavoritos.contains(filme);
  }
}
