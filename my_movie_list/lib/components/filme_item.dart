import 'package:flutter/material.dart';
import 'package:my_movie_list/models/filme.dart';
import 'package:my_movie_list/utils/rotas.dart';

class FilmeItem extends StatelessWidget {
  final Filme filme;
  final VoidCallback deleteFavorito;

  const FilmeItem({
    required this.filme,
    required this.deleteFavorito,
  });

  void _selecionarFilme(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
          Rotas.MOVIE_DETAIL,
          arguments:
              filme,
        )
        .then((value) => {
              if (value == null) {} else {print(value)}
            });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => _selecionarFilme(context),
        child: Container(
          height: 167,
          child: Card(
            color: const Color.fromARGB(255, 44, 44, 44),
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  filme.banner,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Text(
                        filme.titulo,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Text(
                          filme.descricao,
                          style: const TextStyle(color: Colors.white),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              deleteFavorito();
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      );
  }
}
