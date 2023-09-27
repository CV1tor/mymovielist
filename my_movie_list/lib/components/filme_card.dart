import 'package:flutter/material.dart';
import 'package:my_movie_list/models/filme.dart';
import 'package:my_movie_list/utils/rotas.dart';

class FilmeCard extends StatelessWidget {
  final Filme filme;

  const FilmeCard(this.filme, {super.key});

  _detalheFilme(BuildContext context) {
    Navigator.of(context).pushNamed(Rotas.MOVIE_DETAIL, arguments: filme);
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => _detalheFilme(context),
      child: Column(
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Image(
              image: AssetImage(filme.banner),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            filme.titulo,
            style:
                const TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis),
            softWrap: true,
            textAlign: TextAlign.center,
            textHeightBehavior:
                const TextHeightBehavior(applyHeightToFirstAscent: false),
          ),
        ],
      ),
    );
  }
}
