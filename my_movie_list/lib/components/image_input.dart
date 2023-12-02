import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  final File? initialImage;

  ImageInput(this.onSelectImage, {this.initialImage});

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  //Capturando Imagem
  File? _storedImage;

  @override
  void initState() {
    super.initState();
    _storedImage = widget.initialImage;
  }

  _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    //pegar pasta que posso salvar documentos
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy(
      '${appDir.path}/$fileName',
    );
    widget.onSelectImage(savedImage);
  }

  _choosePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    ) as XFile;

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    //pegar pasta que posso salvar documentos
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy(
      '${appDir.path}/$fileName',
    );
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: CircleAvatar(
            radius: 70,
            child: _storedImage != null
                ? Image.file(
                    _storedImage!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/spiderverse/spiderverse3.jpg',
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        SizedBox(width: 10),
        Column(
          children: [
            TextButton.icon(
              icon: Icon(Icons.camera),
              label: Text('Tirar foto'),
              onPressed: _takePicture,
            ),
            SizedBox(width: 3),
            TextButton.icon(
              icon: Icon(Icons.folder),
              label: Text('Galeria'),
              onPressed: _choosePicture,
            ),
          ],
        ),
      ],
    );
  }
}
