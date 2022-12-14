import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart' as mylatlong;
import 'package:littlewords/shared_pref.provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp2()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'LittleWords',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ref.watch(usernameProvider).when(data: _data, error: _error, loading: _loading),
    );
  }

  Widget? _data(String? data) {
    if(null == data){
      return Usernameroute();
    }
    return const HomeRoute();
  }
  Widget? _error(error, stack) {
    return ErrorRoute();

  }
  Widget? _loading() {
    return LoadingRoute();
  }

}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LittleWords',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
      body: Myappmaps()
    );
  }
}

class Myappmaps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        options: MapOptions(
      center: mylatlong.LatLng(51.5, -0.09),
      zoom: 13.0,
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

