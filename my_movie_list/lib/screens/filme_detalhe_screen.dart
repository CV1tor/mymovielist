import 'package:flutter/material.dart';
import 'package:my_movie_list/components/comentario_widget.dart';
import 'package:my_movie_list/components/tag_genero.dart';
import 'package:my_movie_list/controller/filme_controller.dart';
import 'package:my_movie_list/models/comentario.dart';
import 'package:my_movie_list/models/favoritos_provider.dart';
import 'package:my_movie_list/models/filme.dart';
import 'package:provider/provider.dart';

import '../components/form_comentario.dart';

class FilmeDetalheScreen extends StatefulWidget {
  final Function(Filme) toggleFavoritos;
  final Function(Filme) eFavorito;
  const FilmeDetalheScreen({
    super.key,
    required this.toggleFavoritos,
    required this.eFavorito,
  });

  @override
  State<FilmeDetalheScreen> createState() => _FilmeDetalheScreenState();
}

class _FilmeDetalheScreenState extends State<FilmeDetalheScreen> {
  _abraTelaDeComentario(Filme filme) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return FormComentario(
            filmeModel: filme,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final filmeModalRoute = ModalRoute.of(context)!.settings.arguments as Filme;

    return Consumer<FilmeController>(builder: (context, filmeContext, child) {
      final filme = filmeContext.retornarFilme(filmeModalRoute);

    
      return Scaffold(
        appBar: AppBar(
          leadingWidth: 20,
          title: Text(filme.titulo),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.network(filme.banner,
                  height: 300, width: 400, fit: BoxFit.contain),
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      InkWell(
                        child: IconButton(
                          icon: const Icon(
                            Icons.mode_comment_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () => _abraTelaDeComentario(filme),
                        ),
                      ),
                      InkWell(
                        child: Provider.of<FavoritoProviderModel>(context)
                                .eFavorito(filme)
                            ? IconButton(
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 28,
                                ),
                                onPressed: () =>
                                    Provider.of<FavoritoProviderModel>(context,
                                            listen: false)
                                        .adicionarFilmeFavorito(filme),
                              )
                            : IconButton(
                                icon: const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                onPressed: () =>
                                    Provider.of<FavoritoProviderModel>(context,
                                            listen: false)
                                        .toggleFavoritos(filme)),
                      ),
                    ]),
                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(top: 10),
                      child: Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: filme.genero.length,
                            itemBuilder: (context, index) {
                              final generoTipo = filme.genero[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: TagGenero(genero: generoTipo),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      filme.descricao,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          color: const Color.fromRGBO(255, 255, 255, 0.1),
                          padding: const EdgeInsets.all(7),
                          child: const Text(
                            "Imagens",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 18),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: filme.imagens.length,
                          itemBuilder: (context, index) {
                            final imagem = filme.imagens[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Image.network(imagem),
                            );
                          }),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          color: const Color.fromRGBO(255, 255, 255, 0.1),
                          padding: const EdgeInsets.all(7),
                          child: const Text(
                            "Comentários",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: filme.comentarios.isNotEmpty,
                      replacement: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Nenhum comentário",
                              style: TextStyle(color: Colors.blue),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(15)),
                                onPressed: () => _abraTelaDeComentario(filme),
                                child: const Text(
                                  "Comentar",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ))
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filme.comentarios.length,
                              itemBuilder: (context, index) {
                                final comentarioAtual =
                                    filme.comentarios[index];
                                return Card(
                                  child: Container(
                                      child: MyCommentWidget(
                                    comentario: comentarioAtual,
                                    filmeModels: filme,
                                  )),
                                );
                              }),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(15)),
                              onPressed: () => _abraTelaDeComentario(filme),
                              child: const Text(
                                "Comentar",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
