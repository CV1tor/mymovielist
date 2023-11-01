import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_movie_list/components/form_comentario.dart';
import 'package:my_movie_list/controller/filme_controller.dart';
import 'package:my_movie_list/controller/usuario_controller.dart';

import 'package:my_movie_list/models/comentario.dart';
import 'package:intl/intl.dart';
import 'package:my_movie_list/models/filme.dart';
import 'package:provider/provider.dart';

class MyCommentWidget extends StatefulWidget {
  final Comentario comentario;
  final Filme filmeModels;
  const MyCommentWidget(
      {super.key, required this.comentario, required this.filmeModels});

  @override
  State<MyCommentWidget> createState() => _MyCommentWidgetState();
}

_deletarComentario(Comentario comentario, BuildContext context,
    FilmeController filme, Filme filmeModels) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 44, 44, 44),
        title: const Text(
          'Confirmação',
          style: TextStyle(color: Colors.red),
        ),
        content: const Text(
          'Tem certeza de que deseja remover esse comentário?',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop(); // Cancelar a exclusão
            },
          ),
          TextButton(
            child: const Text('Remover'),
            onPressed: () {
              filme.removerComentario(comentario, filmeModels.id);
              Navigator.of(context).pop(); // Confirmar a exclusão
            },
          ),
        ],
      );
    },
  );
}

_editarComentario(
    Comentario comentario, BuildContext context, Filme filmeModels) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return FormComentario(
          filmeModel: filmeModels,
          comentario: comentario,
        );
      });
}

class _MyCommentWidgetState extends State<MyCommentWidget> {
  @override
  Widget build(BuildContext context) {
    final filme = Provider.of<FilmeController>(
      context,
      listen: false,
    );

    final usuario = Provider.of<UsuarioController>(
      context,
      listen: false,
    );

    var podeEditRemovComentario = usuario.usuarioAtual.id == widget.comentario.idUsuario;

    return Container(
      color: const Color.fromRGBO(30, 30, 30, 1),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  widget.comentario.titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                ),
                Text(
                  "  - @${widget.comentario.nomeUsuario}  -  ${DateFormat("dd/MM/yy").format(widget.comentario.data)}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.comentario.descricao,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Visibility(
              visible: podeEditRemovComentario,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      padding: EdgeInsets.only(right: 10),
                      constraints: BoxConstraints(),
                      color: Colors.white,
                      onPressed: () => _deletarComentario(
                          widget.comentario, context, filme, widget.filmeModels),
                      icon: Icon(Icons.delete_outline)),
                  IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      color: Colors.white,
                      onPressed: () => _editarComentario(
                          widget.comentario, context, widget.filmeModels),
                      icon: Icon(Icons.edit_outlined))
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
