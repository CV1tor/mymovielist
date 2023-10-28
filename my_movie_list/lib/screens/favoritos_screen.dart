import 'package:flutter/material.dart';
import 'package:my_movie_list/components/filme_item.dart';
import 'package:my_movie_list/data/dados.dart';
import 'package:my_movie_list/models/favoritos_provider.dart';
import 'package:my_movie_list/models/filme.dart';
import 'package:provider/provider.dart';

class FavoritosScreen extends StatefulWidget {
  final List<Filme> filmesFavoritos;

  const FavoritosScreen({super.key, required this.filmesFavoritos});

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  Future<void> _excluirFilme(int index) async {
    bool confirmacao = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 44, 44, 44),
          title: const Text(
            'Confirmação',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text(
            'Tem certeza de que deseja remover esse filme dos favoritos?',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false); // Cancelar a exclusão
              },
            ),
            TextButton(
              child: const Text('Excluir'),
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
    return Consumer<FavoritoProviderModel>(
      builder: (context, favoritos, child) {
        if (favoritos.filmesFavoritos.isEmpty) {
          return const Center(
              child: Text('Nenhum Filme Marcado como Favorito!'));
        } else {
          return ListView.builder(
            itemCount: favoritos.filmesFavoritos.length,
            itemBuilder: (ctx, index) {
              final filme = favoritos.filmesFavoritos[index];
              return FilmeItem(
                  filme: filme,
                  deleteFavorito: () => favoritos.toggleFavoritos(filme));
            },
          );
        }
      },
    );
  }
}
