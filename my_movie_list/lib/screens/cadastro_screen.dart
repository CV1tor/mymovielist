import 'package:flutter/material.dart';
import 'package:my_movie_list/controller/usuario_controller.dart';
import 'package:my_movie_list/models/usuario.dart';
import 'package:provider/provider.dart';

class CadastroScreen extends StatefulWidget {
  @override
  State<CadastroScreen> createState() => _cadastroScreenState();
}

class _cadastroScreenState extends State<CadastroScreen> {
  final _usuarioNome = TextEditingController();
  final _usuarioEmail = TextEditingController();
  final _usuarioSenha = TextEditingController();
  final _usuarioSenhaConfirmacao = TextEditingController();
  bool validacaoVazioUsuario = false;
  bool validacaoVazioEmail = false;
  bool validacaoVazioSenha = false;
  bool validacaoSenhas = false;
  bool validacaoEmail = false;

  final String _erroSenhas = 'As senhas devem ser iguais!';
  final String _erroEmail = 'Esse email já pertence a um usuário!';
  final String _erroVazio = 'Esse campo deve ser preenchido!';

  _criarNovoUsuario() {
    Usuario novoUsuario = Usuario(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        nome: _usuarioNome.text,
        email: _usuarioEmail.text,
        senha: _usuarioSenha.text,
        listaFavoritos: []
      );

    return novoUsuario;
  }

  _validacao(BuildContext context) {
    if (_usuarioNome.text.isEmpty) {
      setState(() {
        validacaoVazioUsuario = true;
      });
    } else {
      setState(() {
        validacaoVazioUsuario = false;
      });
    }

    if (_usuarioEmail.text.isEmpty) {
      setState(() {
        validacaoVazioEmail = true;
      });
    } else {
      setState(() {
        validacaoVazioEmail = false;
      });
    }

    if (_usuarioSenha.text.isEmpty) {
      setState(() {
        validacaoVazioSenha = true;
      });
    } else {
      setState(() {
        validacaoVazioSenha = false;
      });
    }

    if (_usuarioSenha.text != _usuarioSenhaConfirmacao.text) {
      setState(() {
        validacaoSenhas = true;
      });
    }
    else {
      setState(() {
        validacaoSenhas = false;
      });
    }

    final usuariosProvider =
        Provider.of<UsuarioController>(context, listen: false);


    bool jaCadastrado = false;
    usuariosProvider.usuarios.forEach((usuario) {
      if (usuario.email == _usuarioEmail.text) {
        jaCadastrado = true;
        setState(() {
          validacaoEmail = true;
        });
      } 
      
    });

    if (!jaCadastrado) {
      setState(() {
        validacaoEmail = false;
      });
    }

    

    if (validacaoEmail ||
        validacaoSenhas ||
        validacaoVazioEmail ||
        validacaoVazioSenha ||
        validacaoVazioUsuario) {
      return;
    }

    usuariosProvider.adicionarUsuario(_criarNovoUsuario());

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Usuário cadastrado com sucesso!', textAlign: TextAlign.center,),
      duration: const Duration(milliseconds: 2000),
      width: 280.0, 
      padding: EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Text(
              "Novo usuário",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
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
                  labelText: "Nome de usuário",
                  errorText: validacaoVazioUsuario ? _erroVazio : null,
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                  prefixIconColor: Colors.grey,
                  fillColor: Colors.white),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _usuarioEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  floatingLabelStyle:
                      TextStyle(color: Colors.grey, fontSize: 18),
                  labelText: "Email",
                  errorText: validacaoVazioEmail
                      ? _erroVazio
                      : validacaoEmail
                          ? _erroEmail
                          : null,
                  filled: true,
                  prefixIcon: Icon(Icons.email),
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
                  errorText: validacaoVazioSenha
                      ? _erroVazio
                      : validacaoSenhas
                          ? _erroSenhas
                          : null,
                  filled: true,
                  prefixIcon: Icon(Icons.key),
                  prefixIconColor: Colors.grey,
                  fillColor: Colors.white),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _usuarioSenhaConfirmacao,
              obscureText: true,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  floatingLabelStyle:
                      TextStyle(color: Colors.grey, fontSize: 18),
                  labelText: "Confirmar senha",
                  errorText: validacaoSenhas ? _erroSenhas : null,
                  filled: true,
                  prefixIcon: Icon(Icons.key),
                  prefixIconColor: Colors.grey,
                  fillColor: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15)),
                        onPressed: () => _validacao(context),
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ))),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              Expanded(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          side: BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Cancelar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ))),
            ])
          ],
        ),
      )),
    ));
  }
}
