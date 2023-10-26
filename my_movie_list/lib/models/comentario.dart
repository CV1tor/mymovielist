class Comentario {
  final String titulo;
  final String descricao;
  DateTime data = DateTime.now();

  Comentario(
      {required this.titulo, required this.descricao, required this.data});

  factory Comentario.fromJson(Map<String, dynamic> json) {
    final titulo = json['titulo'];
    final descricao = json['descricao'];
    final dataString = json['data'] as String;
    final data = DateTime.parse(dataString);

    return Comentario(
      titulo: titulo,
      descricao: descricao,
      data: data,
    );
  }
}
