import 'package:flutter/material.dart';
import 'package:my_movie_list/models/filme.dart';
import 'package:my_movie_list/models/usuario.dart';
import 'package:my_movie_list/screens/editar_usuario_screen.dart';
import 'package:my_movie_list/screens/favoritos_screen.dart';
import 'package:my_movie_list/screens/filmes_screen.dart';
import 'package:provider/provider.dart';

import '../controller/usuario_controller.dart';

class TabsScreen extends StatefulWidget {
  final List<Filme> filmesFavoritos;

  TabsScreen({required this.filmesFavoritos});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _indexSelectedScreen = 1;

  _logout(BuildContext context) {
    Navigator.of(context).pop();
  }

  late List<Widget> _screens;
  @override
  void initState() {
    super.initState();
    _screens = [
      EditarUsuarioScreen(),
      FilmesScreen(),
      FavoritosScreen(filmesFavoritos: widget.filmesFavoritos),
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _indexSelectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => _logout(context),
        ),
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
        title: Text("MyMovieList"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      body: _screens[_indexSelectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.935),
        onTap: _selectScreen,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        elevation: 0,
        selectedIconTheme: IconThemeData(size: 27),
        currentIndex: _indexSelectedScreen,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Configurações'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Favoritos')
        ],
      ),
    );
  }
}
