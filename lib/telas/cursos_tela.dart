import 'package:flutter/material.dart';

class CursoPage extends StatefulWidget {
  final List<String> cursos;
  final List<String> descricao;
  final List<bool> favoritos;
  final Function(int) onFavoritoChanged;

  const CursoPage({
    super.key,
    required this.cursos,
    required this.descricao,
    required this.favoritos,
    required this.onFavoritoChanged,
  });

  @override
  State<CursoPage> createState() => _CursoPageState();
}

class _CursoPageState extends State<CursoPage> {
  String resultado = '';

  @override
  Widget build(BuildContext context) {
    final cursosFiltrados = widget.cursos.where((curso) {
      return curso.toLowerCase().contains(resultado.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar curso...',
              prefixIcon: const Icon(Icons.search),
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
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: cursosFiltrados.length,
              itemBuilder: (context, indice) {
                final indiceOriginal = widget.cursos.indexOf(cursosFiltrados[indice]);
                return Card(
                  child: Stack(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            const Icon(Icons.flutter_dash_outlined),
                            const SizedBox(width: 4),
                            Text(cursosFiltrados[indice]),
                          ],
                        ),
                        leading: const CircleAvatar(
                          child: Icon(Icons.play_arrow),
                        ),
                        subtitle: Text(widget.descricao[indiceOriginal]),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: IconButton(
                          icon: Icon(
                            widget.favoritos[indiceOriginal] ? Icons.favorite : Icons.favorite_outline,
                            size: 24,
                            color: widget.favoritos[indiceOriginal] ? Colors.red : Colors.black,
                          ),
                          onPressed: () {
                            widget.onFavoritoChanged(indiceOriginal);
                          },
                        ),
                      ),
                    ],
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