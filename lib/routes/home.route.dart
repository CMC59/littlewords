import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as mylatlong;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Myappmaps(latitude: 12.4,longitude: 12.5),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_bag_outlined),
      onPressed: () {},
      ),
    );
  }
}

class Myappmaps extends StatelessWidget {
  const Myappmaps({required this.latitude, required this.longitude});

  final double latitude,longitude;
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        options: MapOptions(
          center: mylatlong.LatLng(latitude, longitude),
          zoom: 5.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
        ]
    );
  }
}