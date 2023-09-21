import 'package:flutter/material.dart';
import 'package:my_movie_list/screens/login_screen.dart';
import 'package:my_movie_list/screens/tabs_screen.dart';
import 'package:my_movie_list/utils/rotas.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        Rotas.HOME: (ctx) => TabsScreen(),
        Rotas.LOGIN: (ctx) => LoginScreen(),
        //Rotas.MOVIE_DETAIL: (ctx) => PlaceDetailScreen()
      
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
