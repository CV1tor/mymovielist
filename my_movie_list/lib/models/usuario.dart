import 'filme.dart';

class Usuario {
  final String nome;
  final String senha;
  final List<Filme> listaFavoritos = [];

  Usuario({required this.nome, required this.senha});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    final nome = json['nome'];
    final senha = json['senha'];
    final favoritosJson = json['listaFavoritos'] as List<dynamic>;
    final listaFavoritos = favoritosJson
        .map((favoritoJson) => Filme.fromJson(favoritoJson, 1))
        .toList();

    return Usuario(
      nome: nome,
      senha: senha,
    )..listaFavoritos.addAll(listaFavoritos);
  }
}
