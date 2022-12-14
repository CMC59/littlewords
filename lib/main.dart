import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlewords/routes/username.route.dart';
import 'package:littlewords/routes/home.route.dart';
import 'package:littlewords/routes/error.route.dart';
import 'package:littlewords/routes/loading.route.dart';
import 'package:littlewords/shared_pref.provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
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
      return UsernameRoute();
    }
    return  const MyHomePage(title: 'LittleWords');
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



