import 'package:flutter/material.dart';

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