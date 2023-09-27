import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:my_movie_list/models/comentario.dart';
import 'package:intl/intl.dart';

class MyCommentWidget extends StatefulWidget {
  final Comentario comentario;
  const MyCommentWidget({super.key, required this.comentario});

  @override
  State<MyCommentWidget> createState() => _MyCommentWidgetState();
}

class _MyCommentWidgetState extends State<MyCommentWidget> {
  @override
  Widget build(BuildContext context) {
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
                  "  -  ${DateFormat("dd/MM/yy").format(widget.comentario.data)}",
                  style: const TextStyle(
                    color: Colors.grey,
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
          ],
        ),
      ),
    );
  }
}
