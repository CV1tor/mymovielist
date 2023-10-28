import 'filme.dart';

class Usuario {
  String nome;
  String email;
  String senha;
  String foto;
  List<Filme> listaFavoritos = [];

  Usuario({required this.nome, required this.email, required this.senha, this.foto = ''});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    final nome = json['nome'];
    final email = json['email'];
    final senha = json['senha'];
    final foto = json['foto'];
    final favoritosJson = json['listaFavoritos'] as List<dynamic>;
    final listaFavoritos = favoritosJson
        .map((favoritoJson) => Filme.fromJson(favoritoJson, 1))
        .toList();

    return Usuario(
      nome: nome,
      senha: senha,
      email: email,
      foto: foto,
    )..listaFavoritos.addAll(listaFavoritos);
  }
}
