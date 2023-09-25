import 'package:flutter/material.dart';
import 'package:my_movie_list/models/filme.dart';
import 'package:my_movie_list/screens/comentario_screen.dart';
import 'package:my_movie_list/screens/login_screen.dart';
import 'package:my_movie_list/screens/tabs_screen.dart';
import 'package:my_movie_list/utils/rotas.dart';
import 'package:my_movie_list/data/dados.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void _adicionarFavoritos(Filme filme) {}

  bool _eFavorito(Filme filme) {
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyMovieList',
      theme: ThemeData(
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(primary: Colors.red, secondary: Colors.white),
        fontFamily: 'Raleway',
        canvasColor: Colors.black,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      //home: CountriesScreen(),
      initialRoute: '/comments',
      routes: {
        Rotas.HOME: (ctx) => TabsScreen(),
        Rotas.LOGIN: (ctx) => LoginScreen(),
        Rotas.COMMENT: (ctx) => ComentarioScreen(
          filme: FILMES[4],
          adicionarFavoritos: _adicionarFavoritos,
          eFavorito: _eFavorito,
        ),
        //Rotas.MOVIE_DETAIL: (ctx) => PlaceDetailScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
