class Comentario {
  final String titulo;
  final String descricao;

  final DateTime data = DateTime.now();

  Comentario({required this.titulo, required this.descricao});
}
