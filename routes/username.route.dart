import 'package:flutter/material.dart';

class LoadingRoute extends StatelessWidget{
  const LoadingRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Veuillez choisir votre username.'),
          const TextField(),
          ElevatedButton(onPressed: onPressed (){}, child: const Text('Valider'))
        ],
      ),
    );
  }
}