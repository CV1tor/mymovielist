import 'dart:io';

import 'filme.dart';

class Usuario {
  String id;
  String nome;
  String email;
  String senha;
  File? foto;

  Usuario(
      {required this.nome,
      required this.email,
      required this.senha,
      required this.id,
      this.foto});

  factory Usuario.fromJson(String id, Map<String, dynamic> json) {
    final nome = json['nome'];
    final email = json['email'];
    final senha = json['senha'];
    final fotoPath = json['foto'];

    File foto = File(fotoPath);

    return Usuario(
      id: id,
      nome: nome,
      senha: senha,
      email: email,
      foto: foto,
    );
  }
}
