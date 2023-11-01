import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_movie_list/models/favoritos.dart';
import 'package:my_movie_list/models/filme.dart';
import 'package:my_movie_list/models/usuario.dart';

import 'package:http/http.dart' as http;

class UsuarioController extends ChangeNotifier {
  final _baseUrl = 'https://projeto-un2-mobile-default-rtdb.firebaseio.com/';
  List<Usuario> _usuariosCadastrados = [];
  List<Favoritos> _filmesFavoritos = [];
  late Usuario usuarioAtual;

  List<Usuario> get usuarios => _usuariosCadastrados;
  List<Favoritos> get filmesFavoritos => _filmesFavoritos;

  Future<void> setUsuarioAtual(String nome) async {
    Usuario usuario;
    usuario =
        _usuariosCadastrados.firstWhere((element) => element.nome == nome);

    usuarioAtual = usuario;
  }

  Future<Usuario> getUsuarioAtual() async {
    return usuarioAtual;
  }

  Future<List<Usuario>> carregarUsuarios() async {

    _usuariosCadastrados = [];

    print("Carregando usuarios...\n\n");
    final response = await http.get(
      Uri.parse('$_baseUrl/usuarios.json'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);

      body.forEach((id, element) {
        final novoUsuario = Usuario.fromJson(id, element);
        print(novoUsuario);
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
      "foto": usuario.foto,
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
          id: id,
          listaFavoritos: []
          ));
      notifyListeners();
    } else {
      throw Exception('Erro ao adicionar usuario');
    }
  }

  Future<void> editarUsuario(Usuario usuario) async {
    print('entrou');
    var listaFavoritos = usuario.listaFavoritos!.map((favoritos) => jsonEncode({'id': favoritos.id}));
    print(listaFavoritos.first);

    final response = await http.put(
      Uri.parse('$_baseUrl/usuarios/${usuario.id}.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nome': usuario.nome,
        'email': usuario.email,
        'senha': usuario.senha,
        'foto': usuario.foto,
        'listaFavoritos': listaFavoritos,
      }),
    );

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
    notifyListeners();
  }

  Future<void> favoritarFilme(Usuario usuario, String id) async {
    List<Favoritos>? novaListaFavoritos;

    if (usuario.listaFavoritos != null) {
      novaListaFavoritos = usuario.listaFavoritos;
      novaListaFavoritos!.add(Favoritos(id: id));
    } else {
      novaListaFavoritos = [Favoritos(id: id)];
    }
    print('novaListaFavoritos');
    print(novaListaFavoritos.first.id);

    final usuarioEditado = Usuario(
      nome: usuario.nome,
      email: usuario.email,
      senha: usuario.senha,
      id: usuario.id,
      listaFavoritos: novaListaFavoritos
    );
    await editarUsuario(usuarioEditado);
  }
}
