import 'dart:convert';

import './comentario.dart';

class Filme {
  final String titulo;
  final String banner;
  final String descricao;
  final List<String> genero;
  final List<String> imagens;
  List<Comentario> comentarios;

  Filme(
      {required this.titulo,
      required this.banner,
      required this.descricao,
      required this.genero,
      required this.imagens,
      required this.comentarios});

  factory Filme.fromJson(Map<String, dynamic> json) {
    List<Comentario> comentariosFormatados = [];

    if (json['comentarios'].toString().isNotEmpty) {
      Map<String, dynamic> comentarios = json['comentarios'];
      
      comentarios.forEach((key, comentario) {
        comentariosFormatados.add(Comentario.fromJson(comentario));
      });
    }
   
    return Filme(
      titulo: json['titulo'],
      banner: json['banner'],
      descricao: json['descricao'],
      genero: List<String>.from(json['genero']),
      imagens: List<String>.from(json['imagens']),
      comentarios: comentariosFormatados,
    );
  }
}
