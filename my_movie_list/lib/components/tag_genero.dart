import 'package:flutter/material.dart';

class TagGenero extends StatelessWidget {
  String genero;

  TagGenero({super.key, required this.genero});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.white
        ),
        borderRadius: BorderRadius.circular(50)
      ),
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Text(genero, style: const TextStyle(color: Colors.white, fontSize: 15)),
    );
  }
}