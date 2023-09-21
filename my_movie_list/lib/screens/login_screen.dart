// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_movie_list/data/dados.dart';
import 'package:my_movie_list/models/usuario.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usuarioNome = TextEditingController();
  final _usuarioSenha = TextEditingController();
  String _erro = "";

  _novoUsuario() {
    Usuario novoUsuario =
        Usuario(nome: _usuarioNome.text, senha: _usuarioSenha.text);

    return novoUsuario;
  }

  _autenticacao() {
    bool resposta = false;

    USUARIOS_CADASTRADOS.forEach((usuario) {
      if (usuario.nome == _novoUsuario().nome &&
          usuario.senha == _novoUsuario().senha) {
        resposta = true;
      }
    });

    return resposta;
  }

  _login(BuildContext context) {
    if (_autenticacao()) {
      Navigator.of(context).pushNamed('/');
    }
    else {
      setState(() {
      _erro = "Usuário ou senha incorretos!";
    });
    }

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Column(
              children: [
                Text(
                  'MyMovieList',
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _usuarioNome,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      floatingLabelStyle:
                          TextStyle(color: Colors.grey, fontSize: 18),
                      labelText: "Usuário",
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                      prefixIconColor: Colors.grey,
                      fillColor: Colors.white),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _usuarioSenha,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      floatingLabelStyle:
                          TextStyle(color: Colors.grey, fontSize: 18),
                      labelText: "Senha",
                      filled: true,
                      prefixIcon: Icon(Icons.key),
                      prefixIconColor: Colors.grey,
                      fillColor: Colors.white),
                ),
                
                SizedBox(height: 10),
                Text(_erro, style: TextStyle(color: Colors.red[700]),),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                            onPressed: () => _login(context),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
