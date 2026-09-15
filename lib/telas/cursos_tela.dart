import 'package:flutter/material.dart';

class CursoPage extends StatefulWidget {
  const CursoPage({super.key});

  @override
  State<CursoPage> createState() => _CursoPageState();
}

class _CursoPageState extends State<CursoPage> {
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
    'Curso de API eba\nConexão API\n12 aulas\nIniciar curso',
    'Curso pra conectar a API eba\nConexão API\n12 aulas\nIniciar curso',
  ];

  String resultado = '';

  @override
  Widget build(BuildContext context) {
    final cursosFiltrados = cursos.where((curso) {
      return curso.toLowerCase().contains(resultado.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar curso...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
              ),
            ),
            onChanged: (value) {
              setState(() {
                resultado = value;
              });
            },
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: cursosFiltrados.length,
              itemBuilder: (context, indice) {
                final indiceOriginal = cursos.indexOf(cursosFiltrados[indice]);
                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.flutter_dash_outlined),
                        SizedBox(width: 4,),
                        Text(cursosFiltrados[indice]),
                      ],
                    ),
                    leading: CircleAvatar(
                      child: Icon(Icons.play_arrow),
                    ),
                    subtitle: Text(descricao[indiceOriginal]),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
