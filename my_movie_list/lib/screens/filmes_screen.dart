import 'package:flutter/material.dart';
import 'package:my_movie_list/components/filme_card.dart';
import 'package:my_movie_list/data/dados.dart';

class FilmesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.93,
                child: GridView(
                      padding: EdgeInsets.fromLTRB(25, 80, 25, 5),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3/5,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      children: FILMES.map((filme) {
                        return FilmeCard(filme);
                      }).toList(),
                    ),
              ),
            
        
        
      
        
        
      
    );
  }
}
