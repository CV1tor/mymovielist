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
}
