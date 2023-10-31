// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_movie_list/context/usuario_controller.dart';
import 'package:my_movie_list/data/dados.dart';
import 'package:my_movie_list/models/usuario.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usuarioNome = TextEditingController();
  final _usuarioSenha = TextEditingController();
  late Future<List<Usuario>> usuariosCadastrados;

  String _erro = "";

  @override
  void initState() {
    super.initState();
    final usuariosProvider =
        Provider.of<UsuarioController>(context, listen: false);

    usuariosCadastrados = usuariosProvider.carregarUsuarios();
  }

  _autenticacao(BuildContext context) async {
    bool resposta = false;

    await usuariosCadastrados.then((response) => response.forEach((usuario) {
          if (usuario.nome == _usuarioNome.text &&
              usuario.senha == _usuarioSenha.text) {
            resposta = true;
            usuariosProvider.setUsuarioAtual(usuario.nome);
          }
        }));

    return resposta;
  }

  _login(BuildContext context) async {
    if (await _autenticacao(context)) {
      Navigator.of(context).pushNamed('/');
    } else {
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
                Text(
                  _erro,
                  style: TextStyle(color: Colors.red[700]),
                ),
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
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                side: BorderSide(color: Colors.red),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)))),
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/cadastro'),
                            child: Text(
                              "Cadastro",
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
