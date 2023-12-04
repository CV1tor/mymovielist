import 'dart:io';

import 'filme.dart';

class Usuario {
  String id;
  String nome;
  String email;
  String senha;
  File? foto;
  List<String> filmesFavoritos;

  Usuario(
      {required this.nome,
      required this.email,
      required this.senha,
      required this.id,
      this.foto,
      required this.filmesFavoritos});

  factory Usuario.fromJson(String id, Map<String, dynamic> json) {
    final nome = json['nome'];
    final email = json['email'];
    final senha = json['senha'];
    final fotoPath = json['foto'];
    final filmesFavoritos = (json['filmesFavoritos'] ?? []) as List<dynamic>;

    var filmesFavoritosFormatado = filmesFavoritos.isNotEmpty ? filmesFavoritos.map((e) => e.toString()).toList() : [''];
    File foto = fotoPath != null ? File(fotoPath) : File('assets/images/spiderverse/spiderverse3.jpg');

    return Usuario(
      id: id,
      nome: nome,
      senha: senha,
      email: email,
      foto: foto,
      filmesFavoritos: filmesFavoritosFormatado,
    );
  }
}
