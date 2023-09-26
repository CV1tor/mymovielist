import 'package:flutter/material.dart';
import 'package:my_movie_list/components/comentario_widget.dart';
import 'package:my_movie_list/components/tag_genero.dart';
import 'package:my_movie_list/models/comentario.dart';
import 'package:my_movie_list/models/filme.dart';

import '../components/form_comentario.dart';

class ComentarioScreen extends StatefulWidget {
  final Function(Filme) toggleFavoritos;
  final Function(Filme) eFavorito;
  ComentarioScreen({
    super.key,
    required this.toggleFavoritos,
    required this.eFavorito,
  });

  @override
  State<ComentarioScreen> createState() => _ComentarioScreenState();
}

class _ComentarioScreenState extends State<ComentarioScreen> {
  List<Comentario> listaComentarios = [];
  _cadastrarComentario(Comentario comentario) {
    setState(() {
      listaComentarios.add(comentario);
    });
    Navigator.of(context).pop();
  }

  _abraTelaDeComentario() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return FormComentario(
            cadastrarComentario: _cadastrarComentario,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final filme = ModalRoute.of(context)!.settings.arguments as Filme;
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
            Image.asset(filme.banner,
                height: 300, width: 400, fit: BoxFit.contain),
            Container(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    InkWell(
                      child: IconButton(
                        icon: Icon(
                          Icons.mode_comment_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: _abraTelaDeComentario,
                      ),

                      // onTap: _abrirFormularioComentario(context),
                    ),
                    InkWell(
                      child: widget.eFavorito(filme)
                          ? IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 28,
                              ),
                              onPressed: () => widget.toggleFavoritos(filme),
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.favorite_outline,
                                color: Colors.white,
                                size: 28,
                              ),
                              onPressed: () => widget.toggleFavoritos(filme)),
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
                              padding: EdgeInsets.only(right: 15),
                              child: TagGenero(genero: generoTipo),
                            );
                          }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    filme.descricao,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        color: Color.fromRGBO(255, 255, 255, 0.1),
                        child: Text(
                          "Imagens",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.all(7),
                      )),
                    ],
                  ),
                  SizedBox(
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
                            padding: EdgeInsets.only(right: 15),
                            child: Image.asset(imagem),
                          );
                        }),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        color: Color.fromRGBO(255, 255, 255, 0.1),
                        child: Text(
                          "Comentários",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.all(7),
                      )),
                    ],
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: listaComentarios.isNotEmpty,
                    replacement: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Nenhum comentário",
                            style: TextStyle(color: Colors.blue),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(15)),
                              onPressed: () => {_abraTelaDeComentario()},
                              child: Text(
                                "Comentar",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ))
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: listaComentarios.length,
                            itemBuilder: (context, index) {
                              final comentarioAtual = listaComentarios[index];
                              return Card(
                                child: Container(
                                    child: MyCommentWidget(
                                        comentario: comentarioAtual)),
                              );
                            }),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(15)),
                            onPressed: () => {_abraTelaDeComentario()},
                            child: Text(
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
  }
}
