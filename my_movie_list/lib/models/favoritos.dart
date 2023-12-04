import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_movie_list/controller/usuario_controller.dart';
import 'package:my_movie_list/models/filme.dart';

class FavoritosModel extends ChangeNotifier {

  Future<void> adicionarFilmeFavorito(UsuarioController usuario, Filme filme, List<String> filmesFavoritos) async {
    List<String> id = [];

    if (filmesFavoritos.firstOrNull == null || filmesFavoritos.first.isEmpty) {
      id.add(filme.id);
    } else {
      id = filmesFavoritos;
      id.add(filme.id);
    }

    var file =  usuario.usuarioAtual.foto as File;
    
    await usuario.editarUsuario(usuario.usuarioAtual, file, id);
  }

  Future<void> removerFilmeFavorito(UsuarioController usuario, Filme filme, List<String> filmesFavoritos) async {
    var id = filmesFavoritos;
    id.remove(filme.id);
    var file =  usuario.usuarioAtual.foto as File;
    
    await usuario.editarUsuario(usuario.usuarioAtual, file, id);
  }

  void toggleFavoritos(Filme filme, UsuarioController usuario, List<String> idFilmesFavoritos) {
    if (!eFavorito(filme, idFilmesFavoritos)) {
      adicionarFilmeFavorito(usuario, filme, idFilmesFavoritos);
    } else {
      removerFilmeFavorito(usuario, filme, idFilmesFavoritos);
    } 
    notifyListeners();
  }

  bool eFavorito(Filme filme, List<String> idFilmesFavoritos) {
    return idFilmesFavoritos.contains(filme.id);
  }
}
