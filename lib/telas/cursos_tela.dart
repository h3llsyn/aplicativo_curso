import 'package:flutter/material.dart';

class CursoPage extends StatefulWidget{
  const CursoPage({super.key});

  @override
  State<CursoPage> createState() => _CursoPageState();
}

class _CursoPageState extends State<CursoPage> {
  @override
  Widget build(BuildContext context){
    final cursos = [
      'Flutter Básico',
      'Dart Essencial',
      'Interface Mobile',
      'Conexão API',
      'Banco de Dados',
      'Desenvolvimento Mobile',
    ];

    final descricao = [
      'Curso introdutório sobre desenvolvimento mobile utilizando Flutter\n12 aulas\nContinuar curso',
      'Curso essencial sobre os fundamentos de lógica de programção em Dart\nDart Essencial\n12 aulas\nContinuar curso',
      'Venha aprender UI/UX em um curso introdutório ao assunto\nInterface Mobile\n12 aulas\nContinuar curso',
      'Venha aprender a conectar o seu backend com seu frontend nesse curso de Java\nConexão API\n12 aulas\nIniciar curso',
      ' \nConexão API\n12 aulas\nIniciar curso',
      ' \nConexão API\n12 aulas\nIniciar curso',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Procurar curso...'
            ),
          ),
          SizedBox(height: 12,),
          ListView.builder(
            itemCount: cursos.length,
            itemBuilder: (context, indice) => Card(
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.flutter_dash),
                    SizedBox(width: 4,),
                    Text(cursos[indice]),
                  ],
                ),
                leading: CircleAvatar(
                  child: Icon(Icons.play_arrow),
                ),
                subtitle: Text(
                  descricao[indice]
                ),
                trailing: Icon(
                  Icons.chevron_right
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}