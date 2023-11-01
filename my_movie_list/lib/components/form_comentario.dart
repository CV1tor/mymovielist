import 'package:flutter/material.dart';
import 'package:my_movie_list/controller/filme_controller.dart';
import 'package:my_movie_list/models/comentario.dart';
import 'package:my_movie_list/models/filme.dart';
import 'package:provider/provider.dart';

class FormComentario extends StatefulWidget {
  Filme filmeModel;
  Comentario? comentario;
  FormComentario({super.key, required this.filmeModel, this.comentario});

  @override
  State<FormComentario> createState() => _FormComentarioState();
}

class _FormComentarioState extends State<FormComentario> {
  var _comentarioTitulo = TextEditingController();
  var _comentarioDescricao = TextEditingController();
  String erroTitulo = "";
  String erroDescricao = "";
  _finalizarForm(FilmeController filme, bool editarComentario) {
    if (_comentarioTitulo.text.isNotEmpty &&
        _comentarioDescricao.text.isNotEmpty) {
      Comentario comentario = Comentario(
          id: editarComentario ? widget.comentario!.id : '',
          titulo: _comentarioTitulo.text,
          descricao: _comentarioDescricao.text,
          idUsuario: '1',
          data: DateTime.now());
      editarComentario
          ? filme.editarComentario(comentario, widget.filmeModel.id)
          : filme.adicionarComentario(comentario, widget.filmeModel.id);
      Navigator.of(context).pop();
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
  void initState() {
    super.initState();
    if (widget.comentario?.idUsuario != null) {
      _comentarioTitulo.text = widget.comentario!.titulo;
      _comentarioDescricao.text = widget.comentario!.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filmes = Provider.of<FilmeController>(
      context,
      listen: false,
    );

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
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
              onPressed: () => {
                    _finalizarForm(filmes, widget.comentario?.idUsuario != null)
                  },
              child: Text(
                widget.comentario?.idUsuario != null
                    ? 'Editar comentário'
                    : "Cadastrar comentário",
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
