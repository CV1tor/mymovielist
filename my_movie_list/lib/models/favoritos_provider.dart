import 'package:flutter/material.dart';
import 'package:my_movie_list/models/filme.dart';

class FavoritoProviderModel extends ChangeNotifier {
  List<Filme> filmesFavoritos = [];

  void toggleFavoritos(Filme filme) {
    if (eFavorito(filme)) {
      filmesFavoritos.remove(filme);
    } else {
      filmesFavoritos.add(filme);
    }
    notifyListeners();
  }

  bool eFavorito(Filme filme) {
    return filmesFavoritos.contains(filme);
  }
}
