import 'package:flutter/material.dart';
import 'package:my_movie_list/components/comentario_widget.dart';
import 'package:my_movie_list/models/comentario.dart';

import '../components/form_comentario.dart';

class ComentarioScreen extends StatefulWidget {
  ComentarioScreen({super.key});

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
    if (listaTarefas.length != 0) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(17),
          child: Column(
            children: [
              Container(
                height: 500,
                child: ListView.builder(
                    itemCount: listaTarefas.length,
                    itemBuilder: (context, index) {
                      final comentarioAtual = listaTarefas[index];
                      return Card(
                        child: Container(
                            child:
                                MyCommentWidget(comentario: comentarioAtual)),
                      );
                    }),
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
      );
    } else {
      return Scaffold(
          body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
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
      ));
    }
  }
}
