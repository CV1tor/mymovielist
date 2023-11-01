import 'package:flutter/material.dart';
import 'package:my_movie_list/components/filme_card.dart';
import 'package:my_movie_list/controller/filme_controller.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../models/filme.dart';

class FilmesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final filmes = Provider.of<FilmeController>(
      context,
      listen: false,
    );

    return Scaffold(
      body: FutureBuilder<List<Filme>>(
        future: filmes.carregarFilmes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Erro ao carregar os filmes: ${snapshot.error}');
          } else {
            final filmes = snapshot.data;
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
