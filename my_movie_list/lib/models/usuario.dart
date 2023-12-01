import 'filme.dart';

class Usuario {
  String id;
  String nome;
  String email;
  String senha;
  String foto;

  Usuario(
      {required this.nome,
      required this.email,
      required this.senha,
      this.foto = 'a',
      required this.id});

  factory Usuario.fromJson(String id, Map<String, dynamic> json) {
    final nome = json['nome'];
    final email = json['email'];
    final senha = json['senha'];
    final foto = json['foto'];

    return Usuario(
      id: id,
      nome: nome,
      senha: senha,
      email: email,
      foto: foto,
    );
  }
}
