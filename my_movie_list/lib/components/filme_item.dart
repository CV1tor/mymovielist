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
          Rotas.LOGIN, //ARRUMAR A ROTA PARA ENTRAR NOS DETALHES DO FILME
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    filme.imagem,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Add some spacing between the top of the card and the title
                        SizedBox(height: 10),
                        // Add a title widget
                        Text(
                          filme.titulo,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        // Add some spacing between the title and the text
                        SizedBox(height: 5),
                        // Add a text widget to display some text
                        Text(filme.descricao,
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white)),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.end, // Alinhamento à direita
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
            ],
          ),
        ),
      ),
    );
  }
}
