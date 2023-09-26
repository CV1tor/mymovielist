import 'package:flutter/material.dart';
import 'package:my_movie_list/models/filme.dart';
import 'package:my_movie_list/utils/rotas.dart';

class FilmeItem extends StatelessWidget {
  final Filme filme;
  final VoidCallback deleteFavorito;

  const FilmeItem({
    required this.filme,
    required this.deleteFavorito,
  });

  void _selecionarFilme(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
          Rotas.COMMENT, //ARRUMAR A ROTA PARA ENTRAR NOS DETALHES DO FILME
          arguments:
              filme, //passar um map com chave valor para passar mais de um argumento
        )
        .then((value) => {
              if (value == null) {} else {print(value)}
            });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => _selecionarFilme(context),
        child: Container(
          height: 167,
          child: Card(
            color: Color.fromARGB(255, 44, 44, 44),
            margin: EdgeInsets.only(top: 15, left: 15, right: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  filme.banner,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        filme.titulo,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: Text(
                          filme.descricao,
                          style: TextStyle(color: Colors.white),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              deleteFavorito();
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
