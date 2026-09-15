import 'package:flutter/material.dart';

class FavoritosPage extends StatelessWidget{
  const FavoritosPage({super.key});

  @override
  Widget build(BuildContext context){
    final cursos = [
      'Flutter Básico',
      'Dart Essencial',
      'Interface Mobile',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: ListView.builder(
        itemCount: cursos.length,
        itemBuilder: (context, indice) => Card(
          child: ListTile(
            title: Text(cursos[indice]),
            leading: CircleAvatar(
              child: Icon(Icons.play_arrow),
            ),
            subtitle: Text(
              'Toque para continuar'
            ),
            trailing: Icon(
              Icons.chevron_right
            ),
          ),
        ),
      ),
    );
  }
}