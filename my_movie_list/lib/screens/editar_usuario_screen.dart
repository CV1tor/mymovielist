import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_movie_list/components/image_input.dart';
import 'package:my_movie_list/utils/rotas.dart';
import 'package:provider/provider.dart';
import '../controller/usuario_controller.dart';
import '../models/usuario.dart';

class EditarUsuarioScreen extends StatefulWidget {
  @override
  _EditarUsuarioScreenState createState() => _EditarUsuarioScreenState();
}

class _EditarUsuarioScreenState extends State<EditarUsuarioScreen> {
  Future<void> _excluirUsuario() async {
    var confirmacao = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 44, 44, 44),
          title: const Text(
            'Confirmação',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text(
            'Tem certeza de que deseja EXCLUIR sua conta?\nEssa ação não poderá ser desfeita.',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false); // Cancelar a exclusão
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmar a exclusão
              },
            ),
          ],
        );
      },
    );
    if (confirmacao == Null) {
      confirmacao = false;
    }
    if (confirmacao == true) {
      // excluir
      final usuariosProvider =
          Provider.of<UsuarioController>(context, listen: false);
      usuariosProvider.removerUsuario(usuariosProvider.usuarioAtual);
      Navigator.of(context).pushNamed('/login');
    }
  }

  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();

  Usuario? _usuario;
  File? _pickedImage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final usuariosProvider =
        Provider.of<UsuarioController>(context, listen: false);
    _carregarUsuario(usuariosProvider);
    if (usuariosProvider.usuarioAtual.foto?.path != '') {
      _pickedImage = usuariosProvider.usuarioAtual.foto;
    }
  }

  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
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
    super.dispose();
  }

  void mensagemSucesso() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Perfil atualizado com sucesso.'),
    ));
  }

  void editarSemSenha(UsuarioController usuariosProvider) {
    if (nomeController.text == '' || emailController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Não é possível deixar campos em branco!'),
      ));
    } else {
      _usuario!.nome = nomeController.text;
      _usuario!.email = emailController.text;
      usuariosProvider.editarUsuario(_usuario!, _pickedImage, _usuario!.filmesFavoritos);
      mensagemSucesso();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Container(
            height: 700,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 70,
                ),
                ImageInput(this._selectImage, initialImage: _pickedImage),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Rotas.EDITAR_SENHA);
                      },
                      child: Text(
                        'Alterar Senha',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        editarSemSenha(Provider.of<UsuarioController>(context,
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
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red),
                      ),
                      onPressed: () {
                        _excluirUsuario();
                      },
                      child: Text(
                        'Excluir conta',
                        style: TextStyle(
                            color: Colors.red,
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
