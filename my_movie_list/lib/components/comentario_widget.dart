import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:my_movie_list/models/comentario.dart';
import 'package:intl/intl.dart';

class MyCommentWidget extends StatefulWidget {
  final Comentario comentario;
  MyCommentWidget({required this.comentario});

  @override
  State<MyCommentWidget> createState() => _MyCommentWidgetState();
}

class _MyCommentWidgetState extends State<MyCommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(30, 30, 30, 1),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  widget.comentario.titulo,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                ),
                Text(
                  "  -  ${DateFormat("dd/MM/yy").format(widget.comentario.data)}",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              widget.comentario.descricao,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
