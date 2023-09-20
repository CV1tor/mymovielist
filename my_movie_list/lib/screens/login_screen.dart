import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: Row(
          children: [
            Text(
              "MyMovieList",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
            ),
            TextField(decoration: InputDecoration(hintText: "Usuário"),),
            TextField(decoration: InputDecoration(hintText: "Senha" ),)
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ))
      ]),
    );
  }
}
