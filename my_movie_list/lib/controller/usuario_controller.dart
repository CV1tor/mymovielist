import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_movie_list/models/usuario.dart';

import 'package:http/http.dart' as http;

class UsuarioController extends ChangeNotifier {
  final _baseUrl = 'https://projeto-un2-mobile-default-rtdb.firebaseio.com/';
  List<Usuario> _usuariosCadastrados = [];
  late Usuario usuarioAtual =
      Usuario(nome: '0', email: '0', senha: '0', id: '0');

  List<Usuario> get usuarios => _usuariosCadastrados;

  Future<void> setUsuarioAtual(String nome) async {
    Usuario usuario;
    usuario =
        _usuariosCadastrados.firstWhere((element) => element.nome == nome);

    usuarioAtual = usuario;
  }

  Usuario? getUsuarioAtual() {
    return usuarioAtual;
  }

  Future<List<Usuario>> carregarUsuarios() async {
    _usuariosCadastrados = [];

    final response = await http.get(
      Uri.parse('$_baseUrl/usuarios.json'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);

      body.forEach((id, element) {
        final novoUsuario = Usuario.fromJson(id, element);
        _usuariosCadastrados.add(novoUsuario);
      });

      return _usuariosCadastrados;
    } else {
      throw Exception('Erro ao carregar usuários!');
    }
  }

  Future<void> adicionarUsuario(Usuario usuario) async {
    var request = jsonEncode({
      "nome": usuario.nome,
      "email": usuario.email,
      "senha": usuario.senha,
      "foto": '',
    });

    final response = await http.post(Uri.parse('$_baseUrl/usuarios.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: request);

    if (response.statusCode == 200) {
      final id = jsonDecode(response.body)['name'];
      _usuariosCadastrados.add(Usuario(
          nome: usuario.nome,
          email: usuario.email,
          senha: usuario.senha,
          id: id));
      notifyListeners();
    } else {
      throw Exception('Erro ao adicionar usuario');
    }
  }

  Future<void> editarUsuario(Usuario usuario, File foto) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/usuarios/${usuario.id}.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nome': usuario.nome,
        'email': usuario.email,
        'senha': usuario.senha,
        'foto': foto.path,
      }),
    );
    await carregarUsuarios();
    setUsuarioAtual(usuario.nome);
    notifyListeners();
  }

  Future<void> editarSenha(Usuario usuario) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/usuarios/${usuario.id}.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'senha': usuario.senha,
      }),
    );
    await carregarUsuarios();
    setUsuarioAtual(usuario.nome);
    notifyListeners();
  }

  Future<void> removerUsuario(Usuario usuario) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/usuarios/${usuario.id}.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    _usuariosCadastrados.remove(usuario);
    usuarioAtual = Usuario(nome: '0', email: '0', senha: '0', id: '0');
    notifyListeners();
  }
}
