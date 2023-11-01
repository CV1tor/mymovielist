
class Favoritos {
  String id;

  Favoritos({required this.id});

  factory Favoritos.fromJson(String id, Map<String, dynamic> json) {
    final id = json['id'];

    return Favoritos(id: id);
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //   };
  // }
}