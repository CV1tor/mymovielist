import 'package:flutter/material.dart';
import 'package:my_movie_list/models/comentario.dart';

class FormComentario extends StatefulWidget {
  Function(Comentario) cadastrarComentario;
  FormComentario({super.key, required this.cadastrarComentario});

  @override
  State<FormComentario> createState() => _FormComentarioState();
}

class _FormComentarioState extends State<FormComentario> {
  final _comentarioTitulo = TextEditingController();
  final _comentarioDescricao = TextEditingController();
  String erroTitulo = "";
  String erroDescricao = "";
  _cadastrarComentario() {
    if (_comentarioTitulo.text.isNotEmpty &&
        _comentarioDescricao.text.isNotEmpty) {
      Comentario comentario = Comentario(
          titulo: _comentarioTitulo.text,
          descricao: _comentarioDescricao.text,
          data: DateTime.now());
      widget.cadastrarComentario(comentario);
    } else {
      if (_comentarioTitulo.text.isEmpty) {
        setState(() {
          erroTitulo = "Titulo do comentário não pode ficar vazio";
        });
      } else {
        setState(() {
          erroTitulo = "";
        });
      }
      if (_comentarioDescricao.text.isEmpty) {
        setState(() {
          erroDescricao = "Descrição do comentário não pode ficar vazio";
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
      padding: EdgeInsets.fromLTRB(
          15, 15, 15, MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _comentarioTitulo,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                floatingLabelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                labelText: "Titulo",
                filled: true,
                fillColor: Colors.white),
          ),
          Text(
            erroTitulo,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _comentarioDescricao,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                floatingLabelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                labelText: "Seu comentário",
                filled: true,
                fillColor: Colors.white),
            minLines: 1,
            maxLines: 10,
          ),
          Text(
            erroDescricao,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15)),
              onPressed: () => {_cadastrarComentario()},
              child: const Text(
                "     Cadastrar comentário     ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
