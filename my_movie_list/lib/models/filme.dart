import './comentario.dart';

class Filme {
  String titulo;
  String imagem; // caminho da imagem nos arquivos
  String descricao;

  List<String> genero;
  List<Comentario>? comentarios; // não necessariamente precisa ter comentários, por isso nullable

  Filme({required this.titulo, required this.imagem, required this.descricao, required this.genero});
}
