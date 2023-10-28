class Comentario {
  final String titulo;
  final String descricao;
  final String idUsuario;
  DateTime data = DateTime.now();

  Comentario(
      {required this.titulo, required this.descricao, required this.idUsuario, required this.data});

  factory Comentario.fromJson(Map<String, dynamic> json) {
    final titulo = json['titulo'];
    final descricao = json['descricao'];
    final idUsuario = '1';
    // final idUsuario = json['idUsuario'].toString().isEmpty ? '1' : json['idUsuario'];
    final data = DateTime.parse(json['data'] as String);

    return Comentario(
      titulo: titulo,
      descricao: descricao,
      idUsuario: idUsuario,
      data: data,
    );
  }
}
