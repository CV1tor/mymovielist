import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../context/usuario_controller.dart';
import '../models/usuario.dart';

class EditarUsuarioScreen extends StatefulWidget {
  @override
  _EditarUsuarioScreenState createState() => _EditarUsuarioScreenState();
}

class _EditarUsuarioScreenState extends State<EditarUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
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
        nomeController.text = _usuario?.nome ?? '';
        emailController.text = _usuario?.email ?? '';
      });
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaAtualController.dispose();
    novaSenhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
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
          _usuario!.nome = nomeController.text;
          _usuario!.email = emailController.text;
          _usuario!.senha = novaSenhaController.text;
          usuariosProvider.editarUsuario(_usuario!);
          mensagemSucesso();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('A nova senha e a confirmação não coincidem.'),
        ));
      }
    } else {
      if (senhaAtualController.text.isEmpty) {
        editarSemSenha(usuariosProvider);
      } else
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Senha atual incorreta.'),
        ));
    }
  }

  void editarSemSenha(UsuarioController usuariosProvider) {
    _usuario!.nome = nomeController.text;
    _usuario!.email = emailController.text;
    usuariosProvider.editarUsuario(_usuario!);
    mensagemSucesso();
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
                CircleAvatar(
                  backgroundImage:
                      const AssetImage('assets/images/spiderverse.jpg'),
                  radius: 60,
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                ElevatedButton(
                  onPressed: () {
                    if (senhaAtualController.text == '' || _usuario == null) {
                      autenticacao(Provider.of<UsuarioController>(context,
                          listen: false));
                    } else {
                      autenticacao(Provider.of<UsuarioController>(context,
                          listen: false));
                    }
                  },
                  child: const Text('Salvar Alterações'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}