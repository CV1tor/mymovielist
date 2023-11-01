class Comentario {
  final String id;
  final String titulo;
  final String descricao;
  final String idUsuario;
  final String nomeUsuario;
  DateTime data = DateTime.now();

  Comentario(
      {required this.id, required this.titulo, required this.descricao, required this.idUsuario, required this.nomeUsuario, required this.data});

  factory Comentario.fromJson(Map<String, dynamic> json, String id) {
    final titulo = json['titulo'];
    final descricao = json['descricao'];
    final idUsuario = json['idUsuario'];
    final nomeUsuario = json['nomeUsuario'];
    final data = DateTime.parse(json['data'] as String);

    return Comentario(
      id: id,
      titulo: titulo,
      descricao: descricao,
      idUsuario: idUsuario,
      nomeUsuario: nomeUsuario,
      data: data,
    );
  }
}
