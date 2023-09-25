import 'package:flutter/material.dart';
import 'package:my_movie_list/components/comentario_widget.dart';
import 'package:my_movie_list/components/tag_genero.dart';
import 'package:my_movie_list/models/comentario.dart';
import 'package:my_movie_list/models/filme.dart';

import '../components/form_comentario.dart';

class ComentarioScreen extends StatefulWidget {
  Filme filme;
  final Function(Filme) adicionarFavoritos;
  final Function(Filme) eFavorito;
  ComentarioScreen({
    super.key,
    required this.filme,
    required this.adicionarFavoritos,
    required this.eFavorito,
    });

  @override
  State<ComentarioScreen> createState() => _ComentarioScreenState();
}

class _ComentarioScreenState extends State<ComentarioScreen> {
  List<Comentario> listaTarefas = [];
  _cadastrarTarefa(Comentario comentario) {
    setState(() {
      listaTarefas.add(comentario);
    });
    Navigator.of(context).pop();
    print("Estou sendo chamada");
  }

  _abraTelaDeComentario() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return FormComentario(
            cadastrarTarefa: _cadastrarTarefa,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
        leadingWidth: 20,
        title: Text(widget.filme.titulo),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(widget.filme.banner, height: 300, width: 400, fit: BoxFit.fill),
              Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Image.asset('assets/icons/icone_comentario.png', height: 28),
                          // onTap: _abrirFormularioComentario(context),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          child: widget.eFavorito(widget.filme) 
                            ? Image.asset('assets/icons/icone_favorito_vermelho.png', height: 30) 
                            : Image.asset('assets/icons/icone_favorito.png', height: 28),
                          onTap: widget.adicionarFavoritos(widget.filme),
                        ),
                      ]
                    ),
                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.filme.genero.length,
                            itemBuilder: (context, index) {
                              final generoTipo = widget.filme.genero[index];
                              return Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: TagGenero(genero: generoTipo),
                              );
                            }),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.filme.descricao,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(height: 18),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Imagens",
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 200,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 18),
                      child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.filme.imagens.length,
                            itemBuilder: (context, index) {
                              final imagem = widget.filme.imagens[index];
                              return Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Image.asset(imagem),
                              );
                            }),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Comentários",
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: listaTarefas.isNotEmpty,
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
                                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                                onPressed: () => {_abraTelaDeComentario()},
                                child: Text(
                                  "     Comentar     ",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ))
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: listaTarefas.length,
                            itemBuilder: (context, index) {
                              final comentarioAtual = listaTarefas[index];
                              return Card(
                                child: Container(
                                    child:
                                        MyCommentWidget(comentario: comentarioAtual)),
                              );
                            }
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                              onPressed: () => {_abraTelaDeComentario()},
                              child: Text(
                                "     Comentar     ",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
