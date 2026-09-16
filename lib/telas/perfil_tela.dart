import 'dart:io' show File;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final TextEditingController nomeController = TextEditingController(text: 'Lavínia');
  final TextEditingController emailController = TextEditingController(text: 'lavizsenai@gmail.com');

  final ImagePicker picker = ImagePicker();

  File? fotoPerfil;
  Uint8List? fotoBytesWeb;

  Future<void> escolherDaGaleria() async {
    final XFile? imagem = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (imagem == null) {
      return;
    }

    if (kIsWeb) {
      final bytes = await imagem.readAsBytes();
      setState(() {
        fotoBytesWeb = bytes;
      });
    } else {
      setState(() {
        fotoPerfil = File(imagem.path);
      });
    }
  }

  Future<void> tirarFoto() async {
    final XFile? imagem = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (imagem == null) {
      return;
    }

    if (kIsWeb) {
      final bytes = await imagem.readAsBytes();
      setState(() {
        fotoBytesWeb = bytes;
      });
    } else {
      setState(() {
        fotoPerfil = File(imagem.path);
      });
    }
  }

  void mostrarOpcoesFoto() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                ),
                title: const Text('Galeria'),
                onTap: () {
                  Navigator.pop(context);
                  escolherDaGaleria();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                ),
                title: const Text('Câmera'),
                onTap: () {
                  Navigator.pop(context);
                  tirarFoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<File> guardarFoto(File foto) async {
    final pasta = await getApplicationDocumentsDirectory();
    final caminho = '${pasta.path}/foto-perfil.jpg';
    return foto.copy(caminho);
  }

  Future<void> salvarPerfil() async {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();

    if (nome.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o nome e o e-mail')),
      );

      return;
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('nome', nome);
    await prefs.setString('email', email);

    if (!kIsWeb && fotoPerfil != null) {
      final fotoSalva = await guardarFoto(fotoPerfil!);
      await prefs.setString('foto', fotoSalva.path);

      if (mounted) {
        setState(() {
          fotoPerfil = fotoSalva;
        });
      }
    }

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Perfil salvo com sucesso',
        ),
      ),
    );
  }

  Future<void> carregarPerfil() async {
    final prefs = await SharedPreferences.getInstance();

    final nome = prefs.getString('nome');
    final email = prefs.getString('email');
    final caminhoFoto = prefs.getString('foto');

    if (nome != null && nome.isNotEmpty) {
      nomeController.text = nome;
    }
    if (email != null && email.isNotEmpty) {
      emailController.text = email;
    }

    if (!kIsWeb && caminhoFoto != null) {
      final arquivo = File(caminhoFoto);

      if (await arquivo.exists()) {
        setState(() {
          fotoPerfil = arquivo;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    carregarPerfil();
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? imagemProvedor;
    if (kIsWeb) {
      if (fotoBytesWeb != null) {
        imagemProvedor = MemoryImage(fotoBytesWeb!);
      }
    } else {
      if (fotoPerfil != null) {
        imagemProvedor = FileImage(fotoPerfil!);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: imagemProvedor,
                    child: imagemProvedor == null ? const Icon(Icons.person, size: 70) : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                        onPressed: mostrarOpcoesFoto,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Curso atual: Flutter',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Quantidade de cursos: 3',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Quantidade de aulas concluídas: 16',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nomeController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: salvarPerfil,
                  icon: const Icon(Icons.save, color: Colors.black),
                  label: const Text(
                    'Editar perfil',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}