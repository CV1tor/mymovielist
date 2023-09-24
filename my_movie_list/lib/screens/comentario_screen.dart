import 'package:flutter/material.dart';
import 'package:my_movie_list/components/comentario_widget.dart';
import 'package:my_movie_list/components/tag_genero.dart';
import 'package:my_movie_list/models/comentario.dart';

import '../components/form_comentario.dart';

class ComentarioScreen extends StatefulWidget {
  List<String> generos;
  ComentarioScreen({super.key, required this.generos});

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
        title: Text('Guardiões das Galáxias vol. 3'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/guardians.jpg', height: 300, width: 400, fit: BoxFit.fill),
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
                        Image.asset('assets/icons/icone_favorito.png', height: 28),
                      ]
                    ),
                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(top: 10),
                      child: Expanded(
                        child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.generos.length,
                              itemBuilder: (context, index) {
                                final generoTipo = widget.generos[index];
                                return Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: TagGenero(genero: generoTipo),
                                );
                              }),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Super Hero partners Scott Lang and Hope Van Dyne return to continue their adventures as Ant-Man and The Wasp. Together, with Hope’s parents Hank Pym and Janet Van Dyne, the family finds themselves exploring the Quantum Realm, interacting with strange new creatures, and embarking on an adventure that will push them beyond the limits of what they thought was possible.",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
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
