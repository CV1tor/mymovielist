import 'package:flutter/material.dart';
import 'package:my_movie_list/models/filme.dart';

class FilmeCard extends StatelessWidget {
  final Filme filme;

  const FilmeCard(this.filme);

  _detalheFilme(BuildContext context) {
    Navigator.of(context).pushNamed('/comments', arguments: filme);
    // implementar a tela de detalhes do filme
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => _detalheFilme(context),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Image(
              image: AssetImage(filme.imagem),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            filme.titulo,
            style:
                TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis),
            softWrap: true,
            textAlign: TextAlign.center,
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
          ),
        ],
      ),
    );
  }
}
