import 'package:my_movie_list/models/favoritos.dart';

import 'filme.dart';

class Usuario {
  String id;
  String nome;
  String email;
  String senha;
  String foto;
  List<Favoritos>? listaFavoritos;

  Usuario({
    required this.nome,
    required this.email,
    required this.senha,
    this.foto = 'a',
    required this.id,
    required this.listaFavoritos
  });

  factory Usuario.fromJson(String id, Map<String, dynamic> json) {
    print('listaFavoritos');
    // print(json['listaFavoritos'][0]);
    final nome = json['nome'];
    final email = json['email'];
    final senha = json['senha'];
    final foto = json['foto'];
    // final listaFavoritos = json['listaFavoritos'];
    final listaFavoritos = null;

    //final favoritosJson = json['listaFavoritos'] as List<dynamic>;
    // final listaFavoritos = favoritosJson
    //     .map((favoritoJson) => Filme.fromJson(favoritoJson, 1))
    //     .toList();

    return Usuario(
      id: id,
      nome: nome,
      senha: senha,
      email: email,
      foto: foto,
      listaFavoritos: listaFavoritos,
    ); //..listaFavoritos.addAll(listaFavoritos);
  }
}
