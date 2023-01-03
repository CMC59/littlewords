import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as mylatlong;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

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
        body: Myappmaps(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_bag_outlined),
      onPressed: () {showDialog(context: context, builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Ma liste de mots"),
          content: new Text("Mot"),
        );
      });
      },
      ),
    );
  }
}

class Myappmaps extends StatelessWidget {

  final _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
          zoom: 14,
          onMapReady: () async{
            final LocationData? locationData = await _getDeviceLocation();

            if(locationData == null) return;

            _mapController.move(LatLng(locationData.latitude!, locationData.longitude!), _mapController.zoom);
          }),
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

Future<LocationData?> _getDeviceLocation() async {
  Location location = Location();


  bool serviceEnabled = await location.serviceEnabled();
  if(!serviceEnabled){
    serviceEnabled = await location.requestService();
    if(!serviceEnabled){
      return Future.value(null);
    }
  }

  // On verifier que la perm
  PermissionStatus permissionGranted = await location.hasPermission();
  if(permissionGranted == PermissionStatus.denied){
    permissionGranted = await location.requestPermission();
    if(permissionGranted != PermissionStatus.denied){
      return Future.value(null);
    }
  }

  return location.getLocation();

}
