import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_movie_list/controller/usuario_controller.dart';
import 'package:my_movie_list/models/usuario.dart';
import 'package:my_movie_list/utils/rotas.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usuarioNome = TextEditingController();
  final _usuarioSenha = TextEditingController();

  String _erro = "";

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  _autenticacao(BuildContext context) async {
    bool resposta = false;

    final usuariosProvider =
        Provider.of<UsuarioController>(context, listen: false);
    late final usuariosCadastrados = usuariosProvider.carregarUsuarios();

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
      setState(() {
        _erro = "";
      });
      Navigator.of(context).pushNamed('/');
    } else {
      setState(() {
        _erro = "Usuário ou senha incorretos!";
      });
    }
  }

  Future<void> _autenticacaoBiometrica() async {
    final usuariosProvider =
        Provider.of<UsuarioController>(context, listen: false);
    
    try {
      // Verifica se o dispositivo suporta autenticação biométrica
      bool isBiometricAvailable = await _localAuthentication.canCheckBiometrics;
      
      if (isBiometricAvailable) {
        // Autentica usando o sensor biométrico
        bool isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'Toque no sensor biométrico para autenticar',
        );

        if (isAuthenticated) {
          if (usuariosProvider.usuarioAtual.nome != '0') {
            Navigator.pushNamed(context, Rotas.HOME);
          } else {
            setState(() {
              _erro = "Login necessário para prosseguir.";
            });
          }
        }
      } else {
        // O dispositivo não suporta autenticação biométrica
        setState(() {
          _erro = "O dispositivo não suporta autenticação biométrica.";
        });
      }
    } catch (e) {
      print(e);
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
                        onPressed: () async {
                          _login(context);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                        onPressed: _autenticacaoBiometrica,
                        child: Text(
                          "Biometria",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
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
                          )),
                    ),
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
