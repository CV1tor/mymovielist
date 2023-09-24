import 'package:flutter/material.dart';
import 'package:my_movie_list/models/filme.dart';
import 'package:my_movie_list/screens/comentario_screen.dart';
import 'package:my_movie_list/screens/login_screen.dart';
import 'package:my_movie_list/screens/tabs_screen.dart';
import 'package:my_movie_list/utils/rotas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Filme _filmeExemplo = Filme(
      titulo: 'Guardiões das Galáxias vol. 3',
      imagem: 'assets/images/guardians.jpg',
      descricao: 'Super Hero partners Scott Lang and Hope Van Dyne return to continue their adventures as Ant-Man and The Wasp. Together, with Hope’s parents Hank Pym and Janet Van Dyne, the family finds themselves exploring the Quantum Realm, interacting with strange new creatures, and embarking on an adventure that will push them beyond the limits of what they thought was possible.',
      genero: ['Aventura', 'Ação', 'Comédia', 'ficção científica']);

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
          filme: _filmeExemplo,
          adicionarFavoritos: _adicionarFavoritos,
          eFavorito: _eFavorito,
        ),
        //Rotas.MOVIE_DETAIL: (ctx) => PlaceDetailScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
