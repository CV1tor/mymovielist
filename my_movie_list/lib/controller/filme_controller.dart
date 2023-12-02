import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_movie_list/models/comentario.dart';
import 'package:my_movie_list/models/filme.dart';

import 'package:http/http.dart' as http;
import 'package:my_movie_list/utils/database.dart';

class FilmeController extends ChangeNotifier {
  final _baseUrl = 'https://projeto-un2-mobile-default-rtdb.firebaseio.com/';
  List<Filme> _dados = [];

  List<Filme> get dados => _dados;

  Filme retornarFilme(Filme filme) {
    var index = _dados.indexOf(filme);

    return _dados.elementAt(index);
  }

  Future<List<Filme>> carregarFilmes() async {
    
    final conectadoInternet = await InternetConnectionChecker().hasConnection;
    _dados = [];
    print(" \n RODANDO LOAD \N");
        if (!conectadoInternet) {
          print("\N SEM INTERNET! \N");
      final bancoFilmesSqlite = await Database.getData('filme');
      final bancoImagensSqlite = await Database.getData('imagem');
      final bancoGeneroSqlite = await Database.getData('genero');
      print('hello\n');
      for (int i = 0; i < bancoFilmesSqlite.length; i++) {
        final generosFilmeData = await Database.getDataGeneroOuImagem('genero', bancoFilmesSqlite[i]['id']);
        List<String> generos = generosFilmeData.map((genero) => genero['titulo'].toString()).toList();

        final imagensFilmeData = await Database.getDataGeneroOuImagem('imagem', bancoFilmesSqlite[i]['id']);
        List<String> imagens = imagensFilmeData.map((imagem) => imagem['url'].toString()).toList();

        _dados.add(Filme(id: bancoFilmesSqlite[i]['id'].toString(), titulo: bancoFilmesSqlite[i]['titulo'], banner: bancoFilmesSqlite[i]['banner'], descricao: bancoFilmesSqlite[i]['descricao'], genero: generos, imagens: imagens, comentarios: []));
      }

      print(_dados);
       return _dados;
    }
    
    final response = await http.get(
      Uri.parse('$_baseUrl/filmes.json'),
    );


    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      for (var index = 0; index < body.length; index++) {
        final filme = Filme.fromJson(body[index], index);

        _dados.add(filme);
      }

      await atualizarSqlite(_dados);
      notifyListeners();
      return _dados;
    } else {
      throw Exception('Failed to load filmes');
    }
  }

  Future<void> adicionarComentario(
      Comentario comentario, String idFilme) async {
    var request = jsonEncode({
      "titulo": comentario.titulo,
      "descricao": comentario.descricao,
      "data": comentario.data.toString(),
      "idUsuario": comentario.idUsuario,
      "nomeUsuario": comentario.nomeUsuario,
    });

    final response = await http.post(
        Uri.parse('$_baseUrl/filmes/$idFilme/comentarios.json'),
        body: request);
    if (response.statusCode == 200) {
      final idComentario = jsonDecode(response.body)['name'];
      Comentario novoComentario = Comentario(
          id: idComentario,
          titulo: comentario.titulo,
          descricao: comentario.descricao,
          idUsuario: comentario.idUsuario,
          nomeUsuario: comentario.nomeUsuario,
          data: comentario.data);

      _dados[int.parse(idFilme)].comentarios.add(novoComentario);
      notifyListeners();
    } else {
      throw Exception('Erro ao adicionar comentário');
    }
  }

  Future<void> editarComentario(Comentario comentario, String idFilme) async {
    final idComentario = comentario.id;
    var request = jsonEncode({
      "titulo": comentario.titulo,
      "descricao": comentario.descricao,
      "data": comentario.data.toString(),
      "idUsuario": comentario.idUsuario,
      "nomeUsuario": comentario.nomeUsuario,
    });

    final response = await http.put(
        Uri.parse('$_baseUrl/filmes/$idFilme/comentarios/$idComentario.json'),
        body: request);

    if (response.statusCode == 200) {
      final indexComentario = _dados[int.parse(idFilme)]
          .comentarios
          .indexWhere((element) => element.id == comentario.id);
      _dados[int.parse(idFilme)].comentarios[indexComentario] = comentario;
      notifyListeners();
    } else {
      throw Exception('Erro ao editar comentário');
    }
  }

  Future<void> removerComentario(Comentario comentario, String idFilme) async {
    final idComentario = comentario.id;
    final response = await http.delete(
        Uri.parse('$_baseUrl/filmes/$idFilme/comentarios/$idComentario.json'));

    if (response.statusCode == 200) {
      _dados[int.parse(idFilme)].comentarios.remove(comentario);
      notifyListeners();
    } else {
      throw Exception('Erro ao remover comentário');
    }
  }

  Future<void> atualizarSqlite(List<Filme> filmes) async {
    final filmesUltimos = filmes;
    filmesUltimos.sort((a, b) =>
        b.id.compareTo(a.id)); // ordena a lista para os adicionados por último

    final bancoFilmesSqlite = await Database.getData('filme');
    final bancoImagensSqlite = await Database.getData('imagem');
    final bancoGeneroSqlite = await Database.getData('genero');

    if (bancoFilmesSqlite.length == 5) {
      print('\n BANCO LOCAL LOTADO! CHECANDO SE É NECESSÁRIA ATUALIZAÇÃO... \n');
      for (int i = 0; i < 5; i++) {
        bool contemFilme = bancoFilmesSqlite
            .any((filme) => filme['id'].toString() == filmesUltimos[i].id);

        if (!contemFilme) {
          print('\n BANCO NECESSITANDO ATUALIZAÇÃO! NÃO POSSUI ${filmesUltimos[i].titulo} \n');
          Database.deleteFilme(bancoFilmesSqlite[0]['id']);
          adicionarFilmeSqlite(filmesUltimos[i]);
        }
      }
      print('\n BANCO ATUALIZADO! \n');
    } else {
      for (int i = 0; i < 5; i++) {
        print('\n BANCO LOCAL SENDO POPULADO PELO FIREBASE! \n');
        adicionarFilmeSqlite(filmesUltimos[i]);
      }
    }
  }

  void adicionarFilmeSqlite(Filme filme) async {
    print('\n ADICIONANDO FILME! \n');
    await Database.insert('filme',
        {'id': filme.id, 'titulo': filme.titulo, 'banner': filme.banner, 'descricao': filme.descricao});

    for (int i = 0; i < filme.imagens.length; i++) {
      await Database.insert('imagem', {
        'id': DateTime.now().microsecondsSinceEpoch,
        'url': filme.imagens[i],
        'filme_id': filme.id
      });
    }

    for (int j = 0; j < filme.genero.length; j++) {
      await Database.insert('genero', {
        'id': DateTime.now().microsecondsSinceEpoch,
        'titulo': filme.genero[j],
        'filme_id': filme.id
      });
    }

    print('\n FILME ADICIONADO! \n');
  }

  
}
