import 'package:flutter/material.dart';
import 'package:my_movie_list/models/comentario.dart';

class FormComentario extends StatefulWidget {
  Function(Comentario) cadastrarTarefa;
  FormComentario({required this.cadastrarTarefa});

  @override
  State<FormComentario> createState() => _FormComentarioState();
}

class _FormComentarioState extends State<FormComentario> {
  final _comentarioTitulo = TextEditingController();
  final _comentarioDescricao = TextEditingController();
  String erroTitulo = "";
  String erroDescricao = "";
  _cadastrarTarefa() {
    if (_comentarioTitulo.text.length != 0 &&
        _comentarioDescricao.text.length != 0) {
      Comentario comentario = Comentario(
          titulo: _comentarioTitulo.text, descricao: _comentarioDescricao.text);
      widget.cadastrarTarefa(comentario);
    } else {
      if (_comentarioTitulo.text.length == 0) {
        setState(() {
          erroTitulo = "titulo do comentário não pode ficar vazio";
        });
      } else {
        setState(() {
          erroTitulo = "";
        });
      }
      if (_comentarioDescricao.text.length == 0) {
        setState(() {
          erroDescricao = "descrição do comentário não pode ficar vazio";
        });
      } else {
        setState(() {
          erroDescricao = "";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _comentarioTitulo,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  floatingLabelStyle:
                      TextStyle(color: Colors.grey, fontSize: 18),
                  labelText: "Titulo",
                  filled: true,
                  prefixIcon: Icon(Icons.key),
                  prefixIconColor: Colors.grey,
                  fillColor: Colors.white),
            ),
            Text(
              erroTitulo,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _comentarioDescricao,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  floatingLabelStyle:
                      TextStyle(color: Colors.grey, fontSize: 18),
                  labelText: "Seu comentário",
                  filled: true,
                  prefixIcon: Icon(Icons.key),
                  prefixIconColor: Colors.grey,
                  fillColor: Colors.white),
              minLines: 1,
              maxLines: 10,
            ),
            Text(
              erroDescricao,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                onPressed: () => {_cadastrarTarefa()},
                child: Text(
                  "     Cadastrar comentário     ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
