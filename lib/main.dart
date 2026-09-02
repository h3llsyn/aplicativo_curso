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
          backgroundColor: Colors.redAccent,
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
  ];

  final titulos =
  [
    'Home',
    'Meus Cursos',
    'Meu Perfil'
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
        ],
      ),
    );
  }
}

class InicioPage extends StatelessWidget{
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context){
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Text(
          'Olá, estudante!',
          style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 8,),

        Text(
          'Continue aprendendo e evoluindo'
        ),

        SizedBox(height: 24,),

        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.redAccent,
                Colors.pinkAccent
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5)
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.flutter_dash,
                color: Colors.white,
                size: 46,
              ),
              Text(
                'Flutter Básico',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '8 de 12 aulas concluídas',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          )
        )
      ],
    );
  }
}

class CursoPage extends StatelessWidget{
  const CursoPage({super.key});

  @override
  Widget build(BuildContext context){
    final cursos = [
      'Flutter Básico',
      'Dart Essencial',
      'Interface Mobile',
      'Conexão API',
    ];

    return ListView.builder(
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
    );
  }
}

class PerfilPage extends StatelessWidget{
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 46,
            child: Icon(
              Icons.person_outlined,
              size: 52,
            ),
          ),
          SizedBox(height: 16,),
          Text(
            'Aluno Flutter',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      )
    );
  }
}