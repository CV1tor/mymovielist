import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_movie_list/components/image_input.dart';
import 'package:provider/provider.dart';
import '../controller/usuario_controller.dart';
import '../models/usuario.dart';

class EditarUsuarioScreen extends StatefulWidget {
  @override
  _EditarUsuarioScreenState createState() => _EditarUsuarioScreenState();
}

class _EditarUsuarioScreenState extends State<EditarUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final senhaAtualController = TextEditingController();
  final novaSenhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  Usuario? _usuario;

  @override
  void initState() {
    super.initState();
    final usuariosProvider =
        Provider.of<UsuarioController>(context, listen: false);
    _carregarUsuario(usuariosProvider);
  }

  Future<void> _carregarUsuario(UsuarioController usuariosProvider) async {
    final usuario = await usuariosProvider.getUsuarioAtual();
    if (mounted) {
      setState(() {
        _usuario = usuario;
      });
    }
  }

  void mensagemSucesso() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Perfil atualizado com sucesso.'),
    ));
  }

  void autenticacao(UsuarioController usuariosProvider) async {
    if (senhaAtualController.text == _usuario?.senha) {
      if (novaSenhaController.text.isEmpty ||
          confirmarSenhaController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Adicione uma nova senha e faça sua confirmação.'),
        ));
      } else if (novaSenhaController.text == confirmarSenhaController.text) {
        if (_usuario != null) {
          _usuario!.senha = novaSenhaController.text;
          usuariosProvider.editarSenha(_usuario!);
          mensagemSucesso();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('A nova senha e a confirmação não coincidem.'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Senha atual incorreta.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 70,
                ),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: senhaAtualController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha Atual',
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: novaSenhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Nova Senha',
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: confirmarSenhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirmar Nova Senha',
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        autenticacao(Provider.of<UsuarioController>(context,
                            listen: false));
                      },
                      child: const Text(
                        'Salvar Alterações',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
