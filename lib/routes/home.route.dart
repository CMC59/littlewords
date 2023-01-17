import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:littlewords/bagScreen.dart';
import 'package:latlong2/latlong.dart' as mylatlong;
import 'package:latlong2/latlong.dart';
import 'package:littlewords/providers/wordsAroundMarkerLayer.dart';
import 'package:location/location.dart';
import 'package:path/path.dart';


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
      floatingActionButton: Wrap( //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              margin:EdgeInsets.all(10),
              child: FloatingActionButton(
                child: Icon(Icons.add_circle),
                onPressed: (){
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Ajouter un mot'),
                      content: TextField(
                        decoration: InputDecoration(hintText: "Entre ton mot ici"),
                      ),
                      actions: [
                        TextButton(
                          child: Text('Ajouter'),
                          onPressed: (){
                            
                          },
                        ),
                      ],

                    );
                  });
                }
              )
          ), // button second
        Container(
          margin:EdgeInsets.all(10),
          child: FloatingActionButton(
          child: Icon(Icons.shopping_bag_outlined),
          onPressed: () {showDialog(context: context, builder: (BuildContext context) {
            return showBag();
          });
          },
        ), )
    // Add more buttons here
        ],
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
        WordsAroundMarkerLayer()
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


