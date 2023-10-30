import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_movie_list/models/usuario.dart';

import 'package:http/http.dart' as http;

class UsuarioController extends ChangeNotifier {
  final _baseUrl = 'https://projeto-un2-mobile-default-rtdb.firebaseio.com/';
  List<Usuario> _usuariosCadastrados = [];

  List<Usuario> get usuarios => _usuariosCadastrados;

  Future<List<Usuario>> carregarUsuarios() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/usuarios.json'),
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      Map<String, dynamic> body = json.decode(response.body);

      body.values.forEach((element) {
        print(element);
        final novoUsuario = Usuario.fromJson(element);
        _usuariosCadastrados.add(novoUsuario);
      });

      print(_usuariosCadastrados);
      return _usuariosCadastrados;
    } else {
      throw Exception('Erro ao carregar usuários!');
    }
  }

  Future<void> adicionarUsuario(Usuario usuario) async {
    var request = jsonEncode({
      "id": usuario.id,
      "nome": usuario.nome,
      "email": usuario.email,
      "senha": usuario.senha,
      "foto": usuario.foto,
    });

    final response = await http.post(Uri.parse('$_baseUrl/usuarios.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: request);

    if (response.statusCode == 200) {
      _usuariosCadastrados.add(usuario);
      notifyListeners();
    } else {
      throw Exception('Erro ao adicionar usuario');
    }
  }
}
