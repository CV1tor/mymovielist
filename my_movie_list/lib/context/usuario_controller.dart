import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_movie_list/models/usuario.dart';

import 'package:http/http.dart' as http;

class UsuarioController extends ChangeNotifier {
  final _baseUrl = 'https://projeto-un2-mobile-default-rtdb.firebaseio.com/';
  List<Usuario> _usuariosCadastrados = [];

  List<Usuario> get dados => _usuariosCadastrados;

  Future<List<Usuario>> carregarUsuarios() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/usuarios.json'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      for (var index = 0; index < body.length; index++) {
        final novoUsuario = Usuario.fromJson(body[index]);
        _usuariosCadastrados.add(novoUsuario);
      }

      return _usuariosCadastrados;

    } else {
      throw Exception('Erro ao carregar usuários!');
    }
  }

  Future<void> adicionarUsuario(
      Usuario usuario) async {
    var request = jsonEncode({
      "nome": usuario.nome,
      "email": usuario.email,
      "senha": usuario.senha,
      "foto": usuario.foto,
      "listaFavoritos": usuario.listaFavoritos
    });

    final response = await http.post(
        Uri.parse('$_baseUrl/usuarios.json'),
        body: request);

    if (response.statusCode == 200) {
      _usuariosCadastrados.add(usuario);
    } else {
      throw Exception('Erro ao adicionar usuario');
    }
  }

}
