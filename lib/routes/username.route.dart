import 'package:flutter/material.dart';

class UsernameRoute extends StatelessWidget{
  const UsernameRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center                                                                              ,
        children: [
          const Text('Veuillez choisir votre username.'),
          const TextField(),
          ElevatedButton(onPressed: (){}, child: const Text('Valider'))
        ],
      ),
    );
  }
}