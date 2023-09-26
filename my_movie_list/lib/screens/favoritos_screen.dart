import 'package:flutter/material.dart';
import 'package:my_movie_list/components/filme_item.dart';
import 'package:my_movie_list/data/dados.dart';
import 'package:my_movie_list/models/filme.dart';

class FavoritosScreen extends StatefulWidget {
  final List<Filme> filmesFavoritos;

  FavoritosScreen({required this.filmesFavoritos});

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  // FavoritosScreen(this.filmesFavoritos);
  // ALTERAR PARA RECEBER FILMESFAVORITOS POR PARÂMETRO

  Future<void> _excluirFilme(int index) async {
    bool confirmacao = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 44, 44, 44),
          title: Text(
            'Confirmação',
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            'Tem certeza de que deseja remover esse filme dos favoritos?',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false); // Cancelar a exclusão
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmar a exclusão
              },
            ),
          ],
        );
      },
    );

    if (confirmacao == true) {
      setState(() {
        widget.filmesFavoritos.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.filmesFavoritos.isEmpty) {
      return const Center(child: Text('Nenhum Filme Marcado como Favorito!'));
    } else {
      return ListView.builder(
        itemCount: widget.filmesFavoritos.length,
        itemBuilder: (ctx, index) {
          final filme = widget.filmesFavoritos[index];
          return FilmeItem(
              filme: filme, deleteFavorito: () => _excluirFilme(index));
        },
      );
    }
  }
}
