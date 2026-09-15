import 'package:aplicativo_cursos/telas/cursos_tela.dart';
import 'package:aplicativo_cursos/telas/favoritos_tela.dart';
import 'package:aplicativo_cursos/telas/inicio_tela.dart';
import 'package:aplicativo_cursos/telas/perfil_tela.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.redAccent
        ),
        scaffoldBackgroundColor: Color(
          0xFFF5F3FA
        ),
        useMaterial3: true,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.red,
          indicatorColor: Colors.white24,
          iconTheme: WidgetStatePropertyAll(
            IconThemeData(
              color: Colors.white
            ),
          ),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(
              color: Colors.white
            )
          )
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int indice = 0;
  
  final telas = [
    InicioPage(),
    CursoPage(),
    PerfilPage(),
    FavoritosPage(),
  ];

  final titulos =
  [
    'Home',
    'Meus Cursos',
    'Meu Perfil',
    'Meus Favoritos',
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          titulos[indice]
        ),
      ),
      body: telas[indice],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (valor){
          setState(() {
            indice = valor;
          });
        },
        selectedIndex: indice,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home'
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            label: 'Cursos'
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            label: 'Perfil'
          ),
          NavigationDestination(
            icon: Icon(Icons.star_outline),
            label: 'Favoritos'
          ),
        ],
      ),
    );
  }
}