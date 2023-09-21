import 'package:flutter/material.dart';
import 'package:my_movie_list/screens/favoritos_screen.dart';
import 'package:my_movie_list/screens/filmes_screen.dart';


class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _indexSelectedScreen = 0;

  List<Widget> _screens = [MoviesScreen(), FavoritosScreen()];

  _selectScreen(int index) {
    setState(() {
      _indexSelectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text('MyMovieList')),
      body: _screens[_indexSelectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: _indexSelectedScreen,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Filmes'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
        ],
      ),
    );
  }
}