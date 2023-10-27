import 'package:flutter/material.dart';
import 'package:my_movie_list/components/filme_card.dart';
import 'package:my_movie_list/data/dados.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/filme.dart';

class FilmesScreen extends StatelessWidget {
  Future<List<Filme>> carregarFilmes() async {
    final response = await http.get(
      Uri.parse(
          'https://projeto-un2-mobile-default-rtdb.firebaseio.com/filmes.json'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      final List<Filme> filmes = [];

      body.forEach((value) {
        final filme = Filme.fromJson(value);
        filmes.add(filme);
      });

      return filmes;
    } else {
      throw Exception('Failed to load filmes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Filme>>(
        future: carregarFilmes(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
             print(snapshot.error);
            return Text('Erro ao carregar os filmes: ${snapshot.error}');
          } else {
            final filmes = snapshot.data;
            print('snapshot\n ${filmes?.first.titulo}');

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.93,
              child: GridView(
                padding: EdgeInsets.fromLTRB(25, 80, 25, 5),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 5,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: filmes?.map((filme) {
                      return FilmeCard(filme);
                    }).toList() ??
                    [],
              ),
            );
          }
        },
      ),
    );
  }
}
