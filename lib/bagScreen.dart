import 'package:flutter/material.dart';

AlertDialog showBag()  {
  return new AlertDialog(
    title: new Text("Ma liste de mots"),
    content: Column(
      children: [
        new Text("Mot"),
      ],
    ),
  );

}