import 'package:flutter/material.dart';
import 'package:my_movie_list/models/filme.dart';
import 'package:my_movie_list/screens/comentario_screen.dart';
import 'package:my_movie_list/screens/login_screen.dart';
import 'package:my_movie_list/screens/tabs_screen.dart';
import 'package:my_movie_list/utils/rotas.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Filme> _filmesFavoritos = [];

  void _toggleFavoritos(Filme filme) {
    if (_eFavorito(filme)) {
      setState(() {
        _filmesFavoritos.remove(filme);
      });
      
    } else {
      setState(() {
        _filmesFavoritos.add(filme);
      });
      
    }
  }

  bool _eFavorito(Filme filme) {
    return _filmesFavoritos.contains(filme);
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
      initialRoute: '/login',
      routes: {
        Rotas.HOME: (ctx) => TabsScreen(filmesFavoritos: _filmesFavoritos),
        Rotas.LOGIN: (ctx) => LoginScreen(),

        //Rotas.MOVIE_DETAIL: (ctx) => MovieDetailScreen()

        Rotas.COMMENT: (ctx) => ComentarioScreen(
              toggleFavoritos: _toggleFavoritos,
              eFavorito: _eFavorito,
            ),
        
        
        //Rotas.MOVIE_DETAIL: (ctx) => PlaceDetailScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
